#!/usr/bin/env python
# -*- coding: utf-8 -*-

import ESMF
import iris
from iris.exceptions import CoordinateNotFoundError
from ._mapping import ref_to_dims_index, get_empty_data, map_slices
import numpy as np

ESMF_MANAGER = ESMF.Manager(debug=False)

ESMF_LON, ESMF_LAT = 0, 1

ESMF_REGRID_METHODS = {
    'linear': ESMF.RegridMethod.BILINEAR,
    'area_weighted': ESMF.RegridMethod.CONSERVE,
    'nearest': ESMF.RegridMethod.NEAREST_STOD,
}


# ESMF_REGRID_METHODS = {
#     'bilinear': ESMF.RegridMethod.BILINEAR,
#     'patch': ESMF.RegridMethod.PATCH,
#     'conserve': ESMF.RegridMethod.CONSERVE,
#     'nearest_stod': ESMF.RegridMethod.NEAREST_STOD,
#     'nearest_dtos': ESMF.RegridMethod.NEAREST_DTOS,
# }


def coords_iris_to_esmpy(lat, lon, circular):
    dim = len(lat.shape)
    assert(dim == len(lon.shape))
    if dim == 1:
        for c in [lat, lon]:
            if not c.has_bounds():
                c.guess_bounds()
        esmpy_lat, esmpy_lon = np.meshgrid(lat.points, lon.points)
        lat_corners = np.concatenate([lat.bounds[:, 0], lat.bounds[-1:, 1]])
        if circular:
            lon_corners = lon.bounds[:, 0]
        else:
            lon_corners = np.concatenate([lon.bounds[:, 0],
                                          lon.bounds[-1:, 1]])
        esmpy_lat_corners, esmpy_lon_corners = np.meshgrid(lat_corners,
                                                           lon_corners)
    elif dim == 2:
        esmpy_lat, esmpy_lon = lat.points.T.copy(), lon.points.T.copy()
        if circular:
            lat_corners = np.concatenate([lat.bounds[:, :, 0],
                                          lat.bounds[-1:, :, 1]])
            lon_corners = np.concatenate([lon.bounds[:, :, 0],
                                          lon.bounds[-1:, :, 1]])
        else:
            lat_corners = np.concatenate([lat.bounds[:, :, 0],
                                          lat.bounds[-1:, :, 1]])
            lon_corners = np.concatenate([lon.bounds[:, :, 0],
                                          lon.bounds[-1:, :, 1]])
        esmpy_lat_corners = lat_corners.T
        esmpy_lon_corners = lon_corners.T
    else:
        raise RuntimeError('Coord dimension is {}. Expected 1 or 2.'
                           ''.format(dim))
    return esmpy_lat, esmpy_lon, esmpy_lat_corners, esmpy_lon_corners


def get_grid(esmpy_lat, esmpy_lon,
             esmpy_lat_corners, esmpy_lon_corners, circular):
    if circular:
        num_peri_dims = 1
    else:
        num_peri_dims = 0
    grid = ESMF.Grid(np.array(esmpy_lat.shape), num_peri_dims=num_peri_dims,
                     staggerloc=[ESMF.StaggerLoc.CENTER])
    grid.get_coords(ESMF_LON)[...] = esmpy_lon
    grid.get_coords(ESMF_LAT)[...] = esmpy_lat
    grid.add_coords([ESMF.StaggerLoc.CORNER])
    grid_lon_corners = grid.get_coords(ESMF_LON,
                                       staggerloc=ESMF.StaggerLoc.CORNER)
    grid_lat_corners = grid.get_coords(ESMF_LAT,
                                       staggerloc=ESMF.StaggerLoc.CORNER)
    grid_lon_corners[...] = esmpy_lon_corners
    grid_lat_corners[...] = esmpy_lat_corners
    if grid.mask[0] is None:
        grid.add_item(ESMF.GridItem.MASK, ESMF.StaggerLoc.CENTER)
    return grid


def get_empty_field(cube, grid, remove_mask=False):
    field = ESMF.Field(grid, name=cube.long_name,
                       staggerloc=ESMF.StaggerLoc.CENTER)
    center_mask = grid.get_item(ESMF.GridItem.MASK, ESMF.StaggerLoc.CENTER)
    if np.ma.isMaskedArray(cube.data):
        field.data[...] = cube.data.data.T
        if remove_mask:
            center_mask[...] = 0
        else:
            center_mask[...] = cube.data.mask.T
    else:
        field.data[...] = cube.data.T
        center_mask[...] = 0
    return field


def is_lon_circular(lat, lon):
    if isinstance(lon, iris.coords.DimCoord):
        circular = lon.circular
    elif isinstance(lon, iris.coords.AuxCoord):
        if len(lon.shape) == 1:
            seam = lon.bounds[-1, 1] - lon.bounds[0, 0]
        elif len(lon.shape) == 2:
            n_to_s = lat.points[0, 0] > lat.points[-1, 0]
            if n_to_s:
                seam = (lon.bounds[1:-1, -1, (0, 1)]
                        - lon.bounds[1:-1, 0, (3, 2)])
            else:
                seam = (lon.bounds[1:-1, -1, (1, 2)]
                        - lon.bounds[1:-1, 0, (0, 3)])
        else:
            raise RuntimeError('AuxCoord longitude is higher dimensional'
                               'than 2d. Giving up.')
        circular = np.alltrue(abs(seam) % 360. < 1.e-3)
    else:
        raise RuntimeError('longitude is neither DimCoord nor AuxCoord.'
                           'Giving up.')
    return circular


def cube_to_empty_field(cube, circular_lon=None, remove_mask=False):
    lat = cube.coord('latitude')
    lon = cube.coord('longitude')
    if circular_lon is None:
        circular = is_lon_circular(lat, lon)
    else:
        circular = circular_lon
    esmpy_coords = coords_iris_to_esmpy(lat, lon, circular)
    grid = get_grid(*esmpy_coords, circular)
    field = get_empty_field(cube, grid, remove_mask)
    return field


def get_representant(cube, ref_to_slice):
    slice_dims = ref_to_dims_index(cube, ref_to_slice)
    rep_ind = [0]*cube.ndim
    for d in slice_dims:
        rep_ind[d] = slice(None, None)
    rep_ind = tuple(rep_ind)
    return cube[rep_ind]


def build_regridder(src_rep, dst_rep, method):
    regrid_method = ESMF_REGRID_METHODS[method]
    dst_field = cube_to_empty_field(dst_rep[0], remove_mask=True)
    if src_rep.ndim == 2:
        src_fields = [cube_to_empty_field(src_rep)]
        esmf_regridders = [
            ESMF.Regrid(src_fields[0], dst_field,
                        regrid_method=regrid_method,
                        src_mask_values=np.array([1]),
                        unmapped_action=ESMF.UnmappedAction.IGNORE,
                        ignore_degenerate=True)
        ]
    elif src_rep.ndim == 3:
        src_fields = []
        esmf_regridders = []
        no_levels = src_rep.shape[0]
        for level in range(no_levels):
            field = cube_to_empty_field(src_rep[level])
            src_fields.append(field)
            esmf_regridders.append(
                ESMF.Regrid(field, dst_field,
                            regrid_method=regrid_method,
                            src_mask_values=np.array([1]),
                            unmapped_action=ESMF.UnmappedAction.IGNORE,
                            ignore_degenerate=True)
            )
    dst_shape = dst_rep.shape

    def regridder(src):
        res_data = np.empty(dst_shape)
        res_mask = np.empty(dst_shape, dtype=bool)
        res = np.ma.masked_array(res_data, res_mask)
        for i, (src_field, esmf_regridder) in enumerate(zip(src_fields, esmf_regridders)):
            src_field.data[...] = src[i].data.data.T
            regr_field = esmf_regridder(src_field, dst_field)
            res.data[i, ...] = regr_field.data[...].T
            res.mask[i, ...] = res.data[i, ...] == 0.
        return res
    return regridder


def correct_metadata(cube):
    pass


def get_grid_representant(cube, horizontal_only=False):
    horizontal_slice = ['latitude', 'longitude']
    if horizontal_only:
        ref_to_slice = horizontal_slice
    else:
        try:
            cube_z_coord = cube.coord(axis='Z')
            ref_to_slice = [cube_z_coord] + horizontal_slice
        except CoordinateNotFoundError:
            ref_to_slice = horizontal_slice
    return get_representant(cube, ref_to_slice)


def get_grid_representants(src, dst):
    src_rep = get_grid_representant(src)
    dst_horiz_rep = get_grid_representant(dst, horizontal_only=True)
    dst_shape = (src_rep.shape[0],) + dst_horiz_rep.shape
    dim_coords = [src_rep.coord(dimensions=[0], dim_coords=True)]
    dim_coords += dst_horiz_rep.coords(dim_coords=True)
    dim_coords_and_dims = [(c, i) for i, c in enumerate(dim_coords)]
    dst_rep = iris.cube.Cube(
        data=get_empty_data(dst_shape),
        standard_name=src.standard_name,
        long_name=src.long_name,
        var_name=src.var_name,
        units=src.units,
        attributes=src.attributes,
        cell_methods=src.cell_methods,
        dim_coords_and_dims=dim_coords_and_dims,
    )
    return src_rep, dst_rep


def regrid(src, dst, method='linear'):
    """
    Regrids src_cube to the grid defined by dst_cube.

    Regrids the data in src_cube onto the grid defined by dst_cube.

    Args:

    * src_cube (:class:`iris.cube.Cube`)
        Source data. Must have latitude and longitude coords.
        These can be 1d or 2d and should have bounds.

    * dst_cube (:class:`iris.cube.Cube`)
        Defines the target grid.

    * regrid_method
        Selects the regridding method.
        Can be 'linear', 'area_weighted',
        or 'nearest'. See ESMPy_

    .. _ESMPy:
    http://www.earthsystemmodeling.org/esmf_releases/non_public/ESMF_7_0_0/
    esmpy_doc/html/RegridMethod.html#ESMF.api.constants.RegridMethod

    """
    src_rep, dst_rep = get_grid_representants(src, dst)
    regridder = build_regridder(src_rep, dst_rep, method)
    res = map_slices(src, regridder, src_rep, dst_rep)
    correct_metadata(res)
    return res
