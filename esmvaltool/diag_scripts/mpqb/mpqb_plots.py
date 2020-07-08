"""A collection of plotting functions used in the MPQB diagnostics."""

import datetime
import os

import iris
import matplotlib
import matplotlib.pyplot as plt
from matplotlib.colors import from_levels_and_colors
from matplotlib.ticker import MaxNLocator
import numpy as np
import yaml


def read_mpqb_cfg():
    """Read from mpqb_cfg.yml file."""
    cfg_filename = os.path.join(os.path.split(__file__)[0], 'mpqb_cfg.yml')
    with open(cfg_filename, 'r') as handle:
        mpqb_cfg = yaml.safe_load(handle)
    return mpqb_cfg


def _parse_cmap(plotkwargs):
    # replace the cmap key with the cmap object,
    # and add grey shading for masked values
    cmapname = plotkwargs.pop('cmap')
    cmap = matplotlib.cm.get_cmap(cmapname)
    cmap.set_bad("grey", 0.1)

    if np.abs(plotkwargs['vmin']) == np.abs(plotkwargs['vmax']):
        # Diverging colorbar centred around zero
        discrete = True
        n_colors = 11  # number of colors
        if discrete:
            color_list = cmap(np.linspace(0, 1, n_colors))
            cmap_name = cmap.name + str(n_colors)
            cmap = cmap.from_list(cmap_name, color_list, n_colors)

        levels = MaxNLocator(nbins=cmap.N - 1, symmetric=True).tick_values(
            plotkwargs['vmin'], plotkwargs['vmax'])

        # Remove zero from levels
        levels = np.delete(levels, len(levels) / 2)

        color_list = list(color_list)

        color_under = color_list.pop(0)
        color_over = color_list.pop(-1)

        cmap, norm = from_levels_and_colors(levels, color_list)
        cmap.set_bad("grey", 0.1)
        cmap.set_under(color_under)
        cmap.set_over(color_over)

        plotkwargs['norm'] = norm

    plotkwargs['cmap'] = cmap
    return plotkwargs


def mpqb_mapplot(cube, dataset_cfg, filename, **plotkwargs):
    """Plot maps."""
    fig = plt.figure(dpi=200)
    fig.add_subplot(projection=iris.plot.default_projection(cube))

    datasetnames = read_mpqb_cfg()['datasetnames']
    plottitle = datasetnames[plotkwargs.pop('title')]

    plotkwargs = _parse_cmap(plotkwargs)

    plotkwargs['rasterized'] = True

    pcols = iris.plot.pcolormesh(cube, **plotkwargs)
    # Take out small grid lines like this
    pcols.set_edgecolor('face')
    plt.gca().coastlines()

    # Colorbar
    colorbar = plt.colorbar(pcols, orientation='horizontal', extend='both')
    colorbar.set_label(cube.units)
    colorbar.ax.tick_params(labelsize=8)

    # Add timeperiod to plot title
    timeperiod = f"{dataset_cfg['start_year']}-{dataset_cfg['end_year']}"
    plt.title(f"{plottitle} {timeperiod}")
    fig.savefig(filename, bbox_inches='tight')
    plt.close(fig)