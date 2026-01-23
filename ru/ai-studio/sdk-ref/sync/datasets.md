---
sourcePath: en/_sdk-ref/sdk-ref/sync/datasets.md
---
# Datasets domain

## *class* yandex\_cloud\_ml\_sdk.\_datasets.domain.**Datasets**{#yandex_cloud_ml_sdk._datasets.domain.Datasets}

This class provides methods to create and manage datasets of a specific type.

**get**(*dataset\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._datasets.domain.Datasets.get}

Fetch a dataset from the server using its ID.

#|
|| Parameters | 

- **dataset\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the unique identifier of the dataset to fetch.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the time to wait for the request. Defaults to 60 seconds. ||
|| Return type | [*Dataset*](#yandex_cloud_ml_sdk._datasets.dataset.Dataset) ||
|#

**list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *status=Undefined*, *name\_pattern=Undefined*, *task\_type=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._datasets.domain.Datasets.list}

Fetch a list of datasets based on specified filters.

#|
|| Parameters | 

- **status** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\|* [*DatasetStatus*](../types/datasets.md#yandex_cloud_ml_sdk._datasets.status.DatasetStatus) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*DatasetStatus*](../types/datasets.md#yandex_cloud_ml_sdk._datasets.status.DatasetStatus)*]*) – the status filter for datasets; can be a single status or an iterable of statuses.
- **name\_pattern** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a pattern to filter dataset names.
- **task\_type** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – the type of task associated with the datasets; can be a single task type or an iterable of task types.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the time to wait for the request. Defaults to 60 seconds. ||
|| Return type | [*Iterator*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterator)[[*Dataset*](#yandex_cloud_ml_sdk._datasets.dataset.Dataset)] ||
|#

**list\_upload\_formats**(*task\_type*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._datasets.domain.Datasets.list_upload_formats}

Fetch available upload formats for a specified task type.

#|
|| Parameters | 

- **task\_type** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the type of task for which to fetch upload formats.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the time to wait for the request in seconds. Defaults to 60 seconds. ||
|| Return type | [tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str), …] ||
|#

**list\_upload\_schemas**(*task\_type*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._datasets.domain.Datasets.list_upload_schemas}

Fetch available upload schemas for a specified task type.

#|
|| Parameters | 

- **task\_type** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the type of task for which to fetch upload schemas.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the time to wait for the request in seconds. Defaults to 60 seconds. ||
|| Return type | [tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[*DatasetUploadSchema*](../types/datasets.md#yandex_cloud_ml_sdk._datasets.schema.DatasetUploadSchema), …] ||
|#

**completions**{#yandex_cloud_ml_sdk._datasets.domain.Datasets.completions}

a helper for autocompletion text-to-text generation tasks

**draft\_from\_path**(*path*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *task\_type=Undefined*, *upload\_format=Undefined*, *name=Undefined*, *description=Undefined*, *metadata=Undefined*, *labels=Undefined*, *allow\_data\_logging=Undefined*){#yandex_cloud_ml_sdk._datasets.domain.Datasets.draft_from_path}

Create a new dataset draft from a specified path.

#|
|| Parameters | 

- **path** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*PathLike*](https://docs.python.org/3/library/os.html#os.PathLike)) – the path to the data file or directory.
- **task\_type** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the type of task for the dataset.
- **upload\_format** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the format in which the data should be uploaded.
- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the name of the dataset.
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a description of the dataset.
- **metadata** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – metadata associated with the dataset.
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a set of labels for the dataset.
- **allow\_data\_logging** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a flag indicating if data logging is allowed. ||
|| Return type | [*DatasetDraftT*](../types/other.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraftT) ||
|#

**text\_classifiers\_binary**{#yandex_cloud_ml_sdk._datasets.domain.Datasets.text_classifiers_binary}

a helper for autocompletion binary text classification tasks

**text\_classifiers\_multiclass**{#yandex_cloud_ml_sdk._datasets.domain.Datasets.text_classifiers_multiclass}

a helper for autocompletion multiclass text classification tasks

**text\_classifiers\_multilabel**{#yandex_cloud_ml_sdk._datasets.domain.Datasets.text_classifiers_multilabel}

a helper for autocompletion multilabel text classification tasks

**text\_embeddings\_pair**{#yandex_cloud_ml_sdk._datasets.domain.Datasets.text_embeddings_pair}

a helper for autocompletion pairwise text embeddings tasks

**text\_embeddings\_triplet**{#yandex_cloud_ml_sdk._datasets.domain.Datasets.text_embeddings_triplet}

a helper for autocompletion triplet text embeddings tasks

## *class* yandex\_cloud\_ml\_sdk.\_datasets.dataset.**Dataset**{#yandex_cloud_ml_sdk._datasets.dataset.Dataset}

**update**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._datasets.dataset.Dataset.update}

Updates the dataset with the provided parameters.

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the name for the dataset.
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the description for the dataset.
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a set of labels for the dataset.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or the maximum time to wait for the update request. Defaults to 60 seconds. ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**delete**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._datasets.dataset.Dataset.delete}

Deletes the dataset.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or maximum time to wait for the delete request. Defaults to 60 seconds. ||
|| Return type | None ||
|#

**list\_upload\_formats**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._datasets.dataset.Dataset.list_upload_formats}

Retrieve a list of upload formats for the dataset.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the maximum time to wait for the operation to complete. Defaults to 60 seconds. ||
|| Return type | [tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str), …] ||
|#

**download**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *download\_path*, *timeout=60*, *exist\_ok=False*){#yandex_cloud_ml_sdk._datasets.dataset.Dataset.download}

Download a dataset to the specified path.

#|
|| Parameters | 

- **download\_path** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*PathLike*](https://docs.python.org/3/library/os.html#os.PathLike)) – the path where the dataset will be downloaded.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or maximum time to wait for the download. Defaults to 60 seconds.
- **exist\_ok** ([*bool*](https://docs.python.org/3/library/functions.html#bool)) – if **True**, do not raise an error if files already exist. Defaults to False.
- **max\_parallel\_downloads** – the maximum number of concurrent downloads. ||
|| Return type | [tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path), …] ||
|#

**read**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *batch\_size=Undefined*){#yandex_cloud_ml_sdk._datasets.dataset.Dataset.read}

Reads the dataset from backend and yields it records one by one.

This method lazily loads records by chunks, minimizing memory usage for large datasets. The iterator yields dictionaries where keys are field names and values are parsed data.

{% note info  %}

This method creates temporary files in the system’s default temporary directory during operation. To control the location of temporary files, refer to Python’s [**tempfile.gettempdir()**](https://docs.python.org/3/library/tempfile.html#tempfile.gettempdir) documentation. Temporary files are automatically cleaned up after use.

{% endnote %}

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Maximum time in seconds for both gRPC and HTTP operations. Includes connection establishment, data transfer, and processing time. Defaults to 60 seconds.
- **batch\_size** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Number of records to load to memory in one chunk. When UNDEFINED (default), uses backend’s optimal chunk size (typically corresponds to distinct Parquet files storage layout). ||
|| Yields | Dictionary representing single record with field-value pairs ||
|| Return type | [*Iterator*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterator)[[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[*Any*](https://docs.python.org/3/library/typing.html#typing.Any), [*Any*](https://docs.python.org/3/library/typing.html#typing.Any)]] ||
|#

**folder\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.folder_id}

the ID of the folder which contains the dataset

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.name}

the name of the dataset

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.description}

a description of the dataset

**metadata**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.metadata}

metadata associated with the dataset

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.created_by}

the user who created the dataset

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.created_at}

the timestamp when the dataset was created

**updated\_at**\: *datetime*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.updated_at}

the timestamp when the dataset was last updated

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.labels}

a dictionary of labels associated with the dataset

**allow\_data\_logging**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.allow_data_logging}

indicates if data logging is allowed for this dataset

**status**\: *[DatasetStatus](../types/datasets.md#yandex_cloud_ml_sdk._datasets.status.DatasetStatus)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.status}

the current status of the dataset

**task\_type**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.task_type}

the type of task associated with the dataset

**rows**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.rows}

the number of rows in the dataset

**size\_bytes**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.size_bytes}

the size of the dataset in bytes

**validation\_errors**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[ValidationErrorInfo](../types/datasets.md#yandex_cloud_ml_sdk._datasets.dataset.ValidationErrorInfo)*]... ,{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.validation_errors}

a tuple of validation errors associated with the dataset

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.id}

## *class* yandex\_cloud\_ml\_sdk.\_datasets.draft.**DatasetDraft**{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft}

This class allows users to create a draft representation of a dataset without immediately interacting with the server. This draft serves as a structure for storing configuration settings, enabling users to edit the dataset’s properties before finalizing the upload.

**upload\_deferred**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *upload\_timeout=360*, *raise\_on\_validation\_failure=True*, *chunk\_size=104857600*, *parallelism=None*){#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.upload_deferred}

Creates a dataset object on the server, uploads data to S3, triggers validation of the created dataset, and waits for its completion.

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the time to wait for the dataset creation operation. Defaults to 60 seconds.
- **upload\_timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the time to wait for the upload operation. Defaults to 360 seconds.
- **raise\_on\_validation\_failure** ([*bool*](https://docs.python.org/3/library/functions.html#bool)) – a flag indicating whether to raise an error if validation fails after the upload. Default is True.
- **chunk\_size** ([*int*](https://docs.python.org/3/library/functions.html#int)) – the size of chunks to use when uploading data. Default is defined by DEFAULT\_CHUNK\_SIZE.
- **parallelism** ([*int*](https://docs.python.org/3/library/functions.html#int) *\| None*) – the level of parallelism for the upload. Default is None, which means no limit. ||
|| Return type | [*Operation*](../types/operation.md#yandex_cloud_ml_sdk._types.operation.Operation)[[*Dataset*](#yandex_cloud_ml_sdk._datasets.dataset.Dataset)] ||
|#

**upload**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *upload\_timeout=360*, *raise\_on\_validation\_failure=True*, *poll\_timeout=21600*, *poll\_interval=60*, *chunk\_size=104857600*, *parallelism=None*){#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.upload}

This method also performs the upload operation, but unlike **\_upload\_deferred** function, which returns an operation object, it directly returns the result of the completed operation.

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the time to wait for the upload operation. Defaults to 60 seconds.
- **poll\_timeout** ([*int*](https://docs.python.org/3/library/functions.html#int)) – the time to wait for polling the operation status. Default is defined by DEFAULT\_OPERATION\_POLL\_TIMEOUT.
- **poll\_interval** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the interval at which to poll for operation status Defaults to 60 seconds).
- **kwargs** – additional keyword arguments passed to **\_upload\_deferred**.
- **upload\_timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **raise\_on\_validation\_failure** ([*bool*](https://docs.python.org/3/library/functions.html#bool))
- **chunk\_size** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **parallelism** ([*int*](https://docs.python.org/3/library/functions.html#int) *\| None*) ||
|#

**allow\_data\_logging**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.allow_data_logging}

a flag indicating if iyt is allowed to use the dataset to improve the models quality. Default false.

**configure**(*\*\*kwargs*){#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.configure}

#|
|| Parameters | **kwargs** ([*Any*](https://docs.python.org/3/library/typing.html#typing.Any)) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.description}

a description of the dataset

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.labels}

labels for categorizing the dataset

**metadata**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.metadata}

metadata associated with the dataset

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.name}

the name of the dataset

**path**\: *[PathLike](../types/other.md#yandex_cloud_ml_sdk._types.misc.PathLike) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.path}

the file path to the dataset

**task\_type**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.task_type}

the type of task associated with the dataset

**upload\_format**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.upload_format}

the format in which the dataset will be uploaded

**validate**(){#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.validate}

#|
|| Return type | None ||
|#