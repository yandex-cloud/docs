# File storages

_File storage_ is a way to store information that provides quick access to large amounts of data. With file storages, you can store up to 8 TB of data and access it from your {{ ml-platform-name }} notebooks. You can upload datasets, fine-tuning results, [models](models/index.md), logs, and any other files to your file storage.

File storages are not included in the main project storage and are [billed](../pricing.md) separately.

To use your file storages in multiple projects, you can [share](../operations/data/filestores.md#share) your datasets within your community, just like any other resources. To access your file storage from a notebook, remember to first [activate](../operations/data/filestores.md#activate) the storage in the project.

{% include [filestore-upload-warning](../../_includes/datasphere/filestore-upload-warning.md) %}

## Information about a file storage as a resource {#info}

For each file storage, the following information is retained:

* Name.
* Unique resource ID.
* Storage volume.
* Name when connecting.
* Name of the user who created the file storage.
* File storage creation date in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format, e.g., `March 27, 2025, 13:45`.

To view file storage details, click its name in the list of project file storages.

#### See also {#see-also}

* [{#T}](../operations/data/filestores.md)