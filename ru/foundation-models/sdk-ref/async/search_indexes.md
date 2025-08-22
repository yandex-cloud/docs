---
sourcePath: en/_sdk-ref/sdk-ref/async/search_indexes.md
---
# Search indexes domain

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.domain.**AsyncSearchIndexes**{#yandex_cloud_ml_sdk._search_indexes.domain.AsyncSearchIndexes}

*async* **create\_deferred**(*files*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *index\_type=Undefined*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *ttl\_days=Undefined*, *expiration\_policy=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._search_indexes.domain.AsyncSearchIndexes.create_deferred}

#|
|| Parameters | 

- **files** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseFile*](../internals/bases.md#yandex_cloud_ml_sdk._files.file.BaseFile)* \| *[*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*BaseFile*](../internals/bases.md#yandex_cloud_ml_sdk._files.file.BaseFile)*] **\| *[*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*)
- **index\_type** ([*BaseSearchIndexType*](../types/search_indexes.md#yandex_cloud_ml_sdk._search_indexes.index_type.BaseSearchIndexType)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*, *[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] **\| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **ttl\_days** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **expiration\_policy** ([*ExpirationPolicy*](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.ExpirationPolicy)* \| *[*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[**1**, **2**] **\| **~typing.Literal**[**'STATIC'**, **'SINCE\_LAST\_ACTIVE'**] **\| **~typing.Literal**[**'static'**, **'since\_last\_active'**] **\| **~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*)
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AsyncOperation*](../types/operation.md#yandex_cloud_ml_sdk._types.operation.AsyncOperation)[[*AsyncSearchIndex*](#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex)] ||
|#

*async* **get**(*search\_index\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._search_indexes.domain.AsyncSearchIndexes.get}

#|
|| Parameters | 

- **search\_index\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AsyncSearchIndex*](#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex) ||
|#

*async* **list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page\_size=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._search_indexes.domain.AsyncSearchIndexes.list}

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AsyncIterator*](https://docs.python.org/3/library/typing.html#typing.AsyncIterator)[[*AsyncSearchIndex*](#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex)] ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.search\_index.**AsyncSearchIndex**{#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex}

*async* **update**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *ttl\_days=Undefined*, *expiration\_policy=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.update}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*, *[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] **\| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **ttl\_days** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **expiration\_policy** ([*ExpirationPolicy*](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.ExpirationPolicy)* \| *[*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[**1**, **2**] **\| **~typing.Literal**[**'STATIC'**, **'SINCE\_LAST\_ACTIVE'**] **\| **~typing.Literal**[**'static'**, **'since\_last\_active'**] **\| **~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*)
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*async* **delete**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.delete}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | None ||
|#

*async* **get\_file**(*file\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.get_file}

#|
|| Parameters | 

- **file\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*SearchIndexFile*](../types/search_indexes.md#yandex_cloud_ml_sdk._search_indexes.file.SearchIndexFile) ||
|#

*async* **list\_files**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page\_size=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.list_files}

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AsyncIterator*](https://docs.python.org/3/library/typing.html#typing.AsyncIterator)[[*SearchIndexFile*](../types/search_indexes.md#yandex_cloud_ml_sdk._search_indexes.file.SearchIndexFile)] ||
|#

*async* **add\_files\_deferred**(*files*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.add_files_deferred}

#|
|| Parameters | 

- **files** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseFile*](../internals/bases.md#yandex_cloud_ml_sdk._files.file.BaseFile)* \| *[*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*BaseFile*](../internals/bases.md#yandex_cloud_ml_sdk._files.file.BaseFile)*] **\| *[*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*)
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AsyncOperation*](../types/operation.md#yandex_cloud_ml_sdk._types.operation.AsyncOperation)[[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[*SearchIndexFile*](../types/search_indexes.md#yandex_cloud_ml_sdk._search_indexes.file.SearchIndexFile), …]] ||
|#

**folder\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.folder_id}

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.name}

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.description}

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.created_by}

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.created_at}

**updated\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.updated_by}

**updated\_at**\: *datetime*{#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.updated_at}

**expires\_at**\: *datetime*{#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.expires_at}

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.labels}

**index\_type**\: *[BaseSearchIndexType](../types/search_indexes.md#yandex_cloud_ml_sdk._search_indexes.index_type.BaseSearchIndexType)*{#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.index_type}

**expiration\_config**\: *[ExpirationConfig](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig)*{#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.expiration_config}

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex.id}