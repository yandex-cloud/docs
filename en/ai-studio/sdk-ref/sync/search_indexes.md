---
sourcePath: en/_sdk-ref/sdk-ref/sync/search_indexes.md
---
# Search indexes domain

## *class* yandex\_ai\_studio\_sdk.\_search\_indexes.domain.**SearchIndexes**{#yandex_ai_studio_sdk._search_indexes.domain.SearchIndexes}

A class for search indexes. It is a part of Assistants API and it provides the foundation for creating and managing search indexes.

**create\_deferred**(*files*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *index\_type=Undefined*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *ttl\_days=Undefined*, *expiration\_policy=Undefined*, *timeout=60*){#yandex_ai_studio_sdk._search_indexes.domain.SearchIndexes.create_deferred}

Create a deferred search index.

It returns an operation that can be used to track the creation process.

#|
|| Parameters | 

- **files** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseFile*](../internals/bases.md#yandex_ai_studio_sdk._files.file.BaseFile) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*BaseFile*](../internals/bases.md#yandex_ai_studio_sdk._files.file.BaseFile)*] \|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – the files to be indexed.
- **index\_type** ([*BaseSearchIndexType*](../types/search_indexes.md#yandex_ai_studio_sdk._search_indexes.index_type.BaseSearchIndexType) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – the type of the search index.
- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – the name of the search index.
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – a description for the search index.
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – a set of labels for the search index.
- **ttl\_days** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – time-to-live in days for the search index.
- **expiration\_policy** ([*ExpirationPolicy*](../types/assistants.md#yandex_ai_studio_sdk._types.expiration.ExpirationPolicy) *\|* [*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[1, 2] \| ~typing.Literal['STATIC', 'SINCE\_LAST\_ACTIVE'] \| ~typing.Literal['static', 'since\_last\_active'] \| ~yandex\_ai\_studio\_sdk.\_types.misc.Undefined*) – expiration policy for the file. Assepts for passing **static** or **since\_last\_active** strings. Should be defined if **ttl\_days** has been defined, otherwise both parameters should be undefined.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the time to wait for the operation to complete. Defaults to 60 seconds. ||
|| Return type | [*Operation*](../types/operation.md#yandex_ai_studio_sdk._types.operation.Operation)[[*SearchIndex*](#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex)] ||
|#

**get**(*search\_index\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_ai_studio_sdk._search_indexes.domain.SearchIndexes.get}

Retrieve a search index by its id.

This method fetches an already created search index using its unique identifier.

#|
|| Parameters | 

- **search\_index\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the unique identifier of the search index to retrieve.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the time to wait for the operation to complete. Defaults to 60 seconds. ||
|| Return type | [*SearchIndex*](#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex) ||
|#

**list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page\_size=Undefined*, *timeout=60*){#yandex_ai_studio_sdk._search_indexes.domain.SearchIndexes.list}

List search indexes in the specified folder.

This method retrieves a list of search indexes. It continues to fetch search indexes until there are no more available.

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – the maximum number of search indexes to return per page.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the time to wait for the operation to complete. Defaults to 60 seconds. ||
|| Return type | [*Iterator*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterator)[[*SearchIndex*](#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex)] ||
|#

## *class* yandex\_ai\_studio\_sdk.\_search\_indexes.search\_index.**SearchIndex**{#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex}

**update**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *ttl\_days=Undefined*, *expiration\_policy=Undefined*, *timeout=60*){#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.update}

Updates the search index with the provided parameters.

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – the name of the search index.
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – a description for the search index.
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – a set of labels for the search index.
- **ttl\_days** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – time-to-live in days for the search index.
- **expiration\_policy** ([*ExpirationPolicy*](../types/assistants.md#yandex_ai_studio_sdk._types.expiration.ExpirationPolicy) *\|* [*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[1, 2] \| ~typing.Literal['STATIC', 'SINCE\_LAST\_ACTIVE'] \| ~typing.Literal['static', 'since\_last\_active'] \| ~yandex\_ai\_studio\_sdk.\_types.misc.Undefined*) – expiration policy for the search index.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the time to wait for the update request. Defaults to 60 seconds. ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**delete**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.delete}

Deletes the search index.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the time to wait for the delete request. Defaults to 60 seconds. ||
|| Return type | None ||
|#

**get\_file**(*file\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.get_file}

#|
|| Parameters | 

- **file\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*SearchIndexFile*](../types/search_indexes.md#yandex_ai_studio_sdk._search_indexes.file.SearchIndexFile) ||
|#

**list\_files**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page\_size=Undefined*, *timeout=60*){#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.list_files}

Lists all files associated with the search index.

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – the number of files to retrieve per page.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the time to wait for the list request. Defaults to 60 seconds. ||
|| Return type | [*Iterator*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterator)[[*SearchIndexFile*](../types/search_indexes.md#yandex_ai_studio_sdk._search_indexes.file.SearchIndexFile)] ||
|#

**add\_files\_deferred**(*files*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.add_files_deferred}

Adds files to the search index in a deferred manner.

#|
|| Parameters | 

- **files** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseFile*](../internals/bases.md#yandex_ai_studio_sdk._files.file.BaseFile) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*BaseFile*](../internals/bases.md#yandex_ai_studio_sdk._files.file.BaseFile)*] \|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – the files to add to the search index.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the time to wait for the add files request. Defaults to 60 seconds. ||
|| Return type | [*Operation*](../types/operation.md#yandex_ai_studio_sdk._types.operation.Operation)[[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[*SearchIndexFile*](../types/search_indexes.md#yandex_ai_studio_sdk._search_indexes.file.SearchIndexFile), …]] ||
|#

**folder\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.folder_id}

the ID of the folder

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.name}

the new name for the search index

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.description}

the new description for the search index

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.created_by}

the user who created the search index

**created\_at**\: *datetime*{#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.created_at}

the timestamp when the search index was created

**updated\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.updated_by}

the user who last updated the search index

**updated\_at**\: *datetime*{#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.updated_at}

the timestamp when the search index was last updated

**expires\_at**\: *datetime*{#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.expires_at}

the expiration date and time of the search index

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.labels}

a dictionary of labels to associate with the search index

**index\_type**\: *[BaseSearchIndexType](../types/search_indexes.md#yandex_ai_studio_sdk._search_indexes.index_type.BaseSearchIndexType)*{#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.index_type}

the type of the search index

**expiration\_config**\: *[ExpirationConfig](../types/assistants.md#yandex_ai_studio_sdk._types.expiration.ExpirationConfig)*{#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.expiration_config}

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex.id}