"""Script to download cds-satellite-albedo from the Climate Data Store(CDS)"""

from esmvaltool.cmorizers.data.downloaders.cds import CDSDownloader
from esmvaltool.cmorizers.data.utilities import unpack_files_in_folder


def download_dataset(config, dataset, _, __, overwrite):
    """Download dataset cds-satellite-albedo."""
    downloader = CDSDownloader(
        product_name='satellite-methane',
        request_dictionary={
            'format': 'tgz',
            'processing_level': 'level_3',
            'variable': 'xch4',
            'sensor_and_algorithm': 'merged_obs4mips',
            'version': '4.1',
        },
        config=config,
        dataset=dataset,
        overwrite=overwrite,
    )
    downloader.download_request("CDS-XCH4.tar")
    unpack_files_in_folder(downloader.local_folder)
