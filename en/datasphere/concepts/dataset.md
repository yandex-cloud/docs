# Datasets in {{ ml-platform-name }}

A _dataset in {{ ml-platform-name }}_ is an information storage mechanism providing quick access to large amounts of data. Datasets can store up to 4 TB of data, giving faster access to data than to the main project storage.

{% note tip %}

The larger is the [disk](../../compute/concepts/disk.md) allocated for the dataset, the higher is the data read speed.

{% endnote %}

A dataset is created and populated during initialization. Once initialized, you can't change a dataset, it becomes read-only. If you want to add files to a dataset, create it once again.

Datasets aren't included in the main project storage and are [rated](../pricing.md#prices-datasets) separately.

To use your data in multiple projects, you can [share](../operations/data/dataset.md#share) your datasets within your community, like any other resources.

When activated in the project, a disk with a dataset is mounted to the project storage. You can read the files of your activated dataset as local files in your project storage, at the path: `/home/jupyter/mnt/datasets/<dataset_name>`.

Up to three datasets can be activated in a project at the same time. You can activate and deactivate datasets in your projects during your work, without having to restart them. For a complete list of {{ ml-platform-name }} restrictions, see [{#T}](limits.md).

## Information about a dataset as a resource {#info}

The following information is stored about each dataset:

* Name.
* Status of its connection to the project.
* Name of the user who created the dataset.
* Dataset creation date in [UTC]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Всемирное_координированное_время){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Coordinated_Universal_Time){% endif %} format, such as `July 18, 2022, 14:23`.

To view dataset details, click its name in the project's dataset list. On the dataset's **Overview** tab, you can see:

* The [availability zone](../../overview/concepts/geo-scope.md) that the dataset is stored in.
* Size.
* Initialization code.

#### See also {#see-also}

* [{#T}](../operations/data/dataset.md)
