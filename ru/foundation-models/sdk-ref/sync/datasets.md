---
sourcePath: en/_sdk-ref/sdk-ref/sync/datasets.md
---
# Datasets domain

## *class* yandex\_cloud\_ml\_sdk.\_datasets.domain.**Datasets**{#yandex_cloud_ml_sdk._datasets.domain.Datasets}

**get**(*dataset\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._datasets.domain.Datasets.get}

#|
|| Parameters | 

- **dataset\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*Dataset*](#yandex_cloud_ml_sdk._datasets.dataset.Dataset) ||
|#

**list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *status=Undefined*, *name\_pattern=Undefined*, *task\_type=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._datasets.domain.Datasets.list}

#|
|| Parameters | 

- **status** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)* \| *[*DatasetStatus*](../types/datasets.md#yandex_cloud_ml_sdk._datasets.status.DatasetStatus)* \| *[*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*DatasetStatus*](../types/datasets.md#yandex_cloud_ml_sdk._datasets.status.DatasetStatus)*]*)
- **name\_pattern** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **task\_type** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)* \| *[*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*)
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*Iterator*](https://docs.python.org/3/library/typing.html#typing.Iterator)[[*Dataset*](#yandex_cloud_ml_sdk._datasets.dataset.Dataset)] ||
|#

**list\_upload\_formats**(*task\_type*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._datasets.domain.Datasets.list_upload_formats}

#|
|| Parameters | 

- **task\_type** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str), …] ||
|#

**list\_upload\_schemas**(*task\_type*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._datasets.domain.Datasets.list_upload_schemas}

#|
|| Parameters | 

- **task\_type** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[*DatasetUploadSchema*](../types/datasets.md#yandex_cloud_ml_sdk._datasets.schema.DatasetUploadSchema), …] ||
|#

**completions**{#yandex_cloud_ml_sdk._datasets.domain.Datasets.completions}

**draft\_from\_path**(*path*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *task\_type=Undefined*, *upload\_format=Undefined*, *name=Undefined*, *description=Undefined*, *metadata=Undefined*, *labels=Undefined*, *allow\_data\_logging=Undefined*){#yandex_cloud_ml_sdk._datasets.domain.Datasets.draft_from_path}

#|
|| Parameters | 

- **path** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*PathLike*](https://docs.python.org/3/library/os.html#os.PathLike))
- **task\_type** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **upload\_format** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **metadata** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*, *[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] **\| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **allow\_data\_logging** ([*bool*](https://docs.python.org/3/library/functions.html#bool)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) ||
|| Return type | [*DatasetDraftT*](../types/other.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraftT) ||
|#

**text\_classifiers\_binary**{#yandex_cloud_ml_sdk._datasets.domain.Datasets.text_classifiers_binary}

**text\_classifiers\_multiclass**{#yandex_cloud_ml_sdk._datasets.domain.Datasets.text_classifiers_multiclass}

**text\_classifiers\_multilabel**{#yandex_cloud_ml_sdk._datasets.domain.Datasets.text_classifiers_multilabel}

**text\_embeddings\_pair**{#yandex_cloud_ml_sdk._datasets.domain.Datasets.text_embeddings_pair}

**text\_embeddings\_triplet**{#yandex_cloud_ml_sdk._datasets.domain.Datasets.text_embeddings_triplet}

## *class* yandex\_cloud\_ml\_sdk.\_datasets.dataset.**Dataset**{#yandex_cloud_ml_sdk._datasets.dataset.Dataset}

**update**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._datasets.dataset.Dataset.update}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*, *[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] **\| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**delete**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._datasets.dataset.Dataset.delete}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | None ||
|#

**list\_upload\_formats**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._datasets.dataset.Dataset.list_upload_formats}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str), …] ||
|#

**download**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *download\_path*, *timeout=60*, *exist\_ok=False*){#yandex_cloud_ml_sdk._datasets.dataset.Dataset.download}

#|
|| Parameters | 

- **download\_path** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*PathLike*](https://docs.python.org/3/library/os.html#os.PathLike))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **exist\_ok** ([*bool*](https://docs.python.org/3/library/functions.html#bool)) ||
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
- **batch\_size** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Number of records to load to memory in one chunk. When UNDEFINED (default), uses backend’s optimal chunk size (typically corresponds to distinct Parquet files storage layout). ||
|| Yields | Dictionary representing single record with field-value pairs ||
|| Return type | [*Iterator*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterator)[[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[*Any*](https://docs.python.org/3/library/typing.html#typing.Any), [*Any*](https://docs.python.org/3/library/typing.html#typing.Any)]] ||
|#

**folder\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.folder_id}

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.name}

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.description}

**metadata**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.metadata}

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.created_by}

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.created_at}

**updated\_at**\: *datetime*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.updated_at}

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.labels}

**allow\_data\_logging**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.allow_data_logging}

**status**\: *[DatasetStatus](../types/datasets.md#yandex_cloud_ml_sdk._datasets.status.DatasetStatus)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.status}

**task\_type**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.task_type}

**rows**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.rows}

**size\_bytes**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.size_bytes}

**validation\_errors**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[ValidationErrorInfo](../types/datasets.md#yandex_cloud_ml_sdk._datasets.dataset.ValidationErrorInfo)*]... ,{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.validation_errors}

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.Dataset.id}

## *class* yandex\_cloud\_ml\_sdk.\_datasets.draft.**DatasetDraft**{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft}

**upload\_deferred**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *upload\_timeout=360*, *raise\_on\_validation\_failure=True*, *chunk\_size=104857600*, *parallelism=None*){#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.upload_deferred}

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **upload\_timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **raise\_on\_validation\_failure** ([*bool*](https://docs.python.org/3/library/functions.html#bool))
- **chunk\_size** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **parallelism** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| **None*) ||
|| Return type | [*Operation*](../types/operation.md#yandex_cloud_ml_sdk._types.operation.Operation)[[*Dataset*](#yandex_cloud_ml_sdk._datasets.dataset.Dataset)] ||
|#

**upload**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *upload\_timeout=360*, *raise\_on\_validation\_failure=True*, *poll\_timeout=21600*, *poll\_interval=60*, *chunk\_size=104857600*, *parallelism=None*){#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.upload}

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **upload\_timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **raise\_on\_validation\_failure** ([*bool*](https://docs.python.org/3/library/functions.html#bool))
- **poll\_timeout** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **poll\_interval** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **chunk\_size** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **parallelism** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| **None*) ||
|#

**allow\_data\_logging**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.allow_data_logging}

**configure**(*\*\*kwargs*){#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.configure}

#|
|| Parameters | **kwargs** ([*Any*](https://docs.python.org/3/library/typing.html#typing.Any)) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.description}

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.labels}

**metadata**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.metadata}

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.name}

**path**\: *[PathLike](../types/other.md#yandex_cloud_ml_sdk._types.misc.PathLike) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.path}

**task\_type**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.task_type}

**upload\_format**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.upload_format}

**validate**(){#yandex_cloud_ml_sdk._datasets.draft.DatasetDraft.validate}

#|
|| Return type | None ||
|#