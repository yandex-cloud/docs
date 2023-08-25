# Datasets in {{ ml-platform-name }}

A _dataset in {{ ml-platform-name }}_ is a way to store information that provides quick access to large amounts of data. Datasets can store up to 4 TB of data, giving faster access to data than to the main project storage.

{% note tip %}

The larger is the [disk](../../compute/concepts/disk.md) allocated for the dataset, the higher is the data read speed.

{% endnote %}

A dataset is [created and populated](../operations/data/dataset.md#create) during initialization. Once initialized, you cannot change a dataset, as it becomes read-only. If you want to add files to a dataset, create it once again.

Datasets are not included in the main project storage and are [priced](../pricing.md#prices-datasets) separately.

To use your data in multiple projects, you can [share](../operations/data/dataset.md#share) your datasets within your community, just like any other resources.

When activated in the project, a disk with a dataset is mounted to the project storage. You can read the files of your activated dataset as local files in your project storage, at the following path: `/home/jupyter/mnt/datasets/<dataset_name>`.

Up to three datasets can be activated in a project at the same time. You can activate and deactivate datasets in your projects during your work, without having to restart them. For a complete list of {{ ml-platform-name }} restrictions, see [{#T}](limits.md).

## Information about a dataset as a resource {#info}

The following information is stored about each dataset:

* Name.
* Status of its connection to the project.
* Name of the user who created the dataset.
* Dataset creation date in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format, such as `July 18, 2022, 14:23`.

To view dataset details, click its name in the project's dataset list. On the dataset's **{{ ui-key.yc-ui-datasphere.common.overview }}** tab, you can see:

* [Availability zone](../../overview/concepts/geo-scope.md) the dataset is stored in.
* Size.
* Initialization code.

#### See also {#see-also}

* [{#T}](../operations/data/dataset.md)
