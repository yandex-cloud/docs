---
sourcePath: en/_sdk-ref/sdk-ref/async/files.md
---
# Files domain

## *class* yandex\_cloud\_ml\_sdk.\_files.domain.**AsyncFiles**{#yandex_cloud_ml_sdk._files.domain.AsyncFiles}

Files domain, which contains API for working with files.

Files is a part of [Assistants API](https://yandex.cloud/ru/docs/foundation-models/concepts/assistant), which is the only place you could use it. Provides upload, get and list methods that allow you to work with remote file objects you created earlier.

*async* **upload\_bytes**(*data*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *name=Undefined*, *description=Undefined*, *mime\_type=Undefined*, *labels=Undefined*, *ttl\_days=Undefined*, *expiration\_policy=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._files.domain.AsyncFiles.upload_bytes}

Uploads a byte array as a file.

#|
|| Parameters | 

- **data** ([*bytes*](https://docs.python.org/3/library/stdtypes.html#bytes)) – The byte data to upload.
- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – The name of the file on the server.
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – A description of the file.
- **mime\_type** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – The MIME type of the file. By default (i.e. when UNDEFINED) the server will try to auto-detect mime-type and you could override this file.
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Labels associated with the file.
- **ttl\_days** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Time-to-live in days for the file.
- **expiration\_policy** ([*ExpirationPolicy*](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.ExpirationPolicy) *\|* [*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[1, 2] \| ~typing.Literal['STATIC', 'SINCE\_LAST\_ACTIVE'] \| ~typing.Literal['static', 'since\_last\_active'] \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) – Expiration policy for the file. Assepts for passing **static** or :**since\_last\_active** strings. Should be defined if **ttl\_days** has been defined, otherwise both parameters should be undefined.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout for the operation in seconds. Defaults to 60 seconds. ||
|| Return type | [*AsyncFile*](#yandex_cloud_ml_sdk._files.file.AsyncFile) ||
|#

*async* **upload**(*path*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *name=Undefined*, *description=Undefined*, *mime\_type=Undefined*, *labels=Undefined*, *ttl\_days=Undefined*, *expiration\_policy=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._files.domain.AsyncFiles.upload}

Uploads a file from a specified path.

#|
|| Parameters | 

- **path** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*PathLike*](https://docs.python.org/3/library/os.html#os.PathLike)) – The path of the file to upload.
- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – The name of the file on the server.
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – A description of the file.
- **mime\_type** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – The MIME type of the file. By default (i.e. when UNDEFINED) the server will try to auto-detect mime-type and you could override this file.
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Labels associated with the file.
- **ttl\_days** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Time-to-live in days for the file.
- **expiration\_policy** ([*ExpirationPolicy*](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.ExpirationPolicy) *\|* [*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[1, 2] \| ~typing.Literal['STATIC', 'SINCE\_LAST\_ACTIVE'] \| ~typing.Literal['static', 'since\_last\_active'] \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) – Expiration policy for the file. Assepts for passing **static** or **since\_last\_active** strings.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout for the operation in seconds. Defaults to 60. ||
|| Return type | [*AsyncFile*](#yandex_cloud_ml_sdk._files.file.AsyncFile) ||
|#

*async* **get**(*file\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._files.domain.AsyncFiles.get}

Retrieves a file by its ID.

#|
|| Parameters | 

- **file\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – The unique identifier of the file to retrieve.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout for the operation in seconds. Defaults to 60. ||
|| Return type | [*AsyncFile*](#yandex_cloud_ml_sdk._files.file.AsyncFile) ||
|#

*async* **list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page\_size=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._files.domain.AsyncFiles.list}

Lists Files in the SDK folder.

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – The maximum number of files to return per page.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout for the operation in seconds. Defaults to 60. ||
|| Return type | [*AsyncIterator*](https://docs.python.org/3/library/typing.html#typing.AsyncIterator)[[*AsyncFile*](#yandex_cloud_ml_sdk._files.file.AsyncFile)] ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_files.file.**AsyncFile**{#yandex_cloud_ml_sdk._files.file.AsyncFile}

*async* **get\_url**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._files.file.AsyncFile.get_url}

Retrieve the URL for the file.

This method constructs a request to get the temporary URL for downloading the file and returns it.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Returns | The URL of the file given as a string. ||
|| Return type | [str](https://docs.python.org/3/library/stdtypes.html#str) ||
|#

*async* **update**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *ttl\_days=Undefined*, *expiration\_policy=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._files.file.AsyncFile.update}

Update the properties of the file.

This method allows updating various properties of the file, such as its name, description, labels, TTL (time-to-live) days, and expiration policy. Note that only the fields explicitly passed will be updated. You can also pass None, which will reset it. Keep in mind that the method is mutating and modifies the file object in-place.

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – The new name for the updated file.
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – The new description for the file.
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – A dictionary of labels to associate with the file.
- **ttl\_days** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – The new TTL (time-to-live) for the file in days.
- **expiration\_policy** ([*ExpirationPolicy*](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.ExpirationPolicy) *\|* [*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[1, 2] \| ~typing.Literal['STATIC', 'SINCE\_LAST\_ACTIVE'] \| ~typing.Literal['static', 'since\_last\_active'] \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) – The new expiration policy for the file. Assepts for passing **static** or **since\_last\_active** strings.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Returns | The updated instance of the file. ||
|| Return type | [*AsyncFile*](#yandex_cloud_ml_sdk._files.file.AsyncFile) ||
|#

*async* **delete**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._files.file.AsyncFile.delete}

Delete the file.

This method constructs and executes a request to delete the file associated with the current instance.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | None ||
|#

*async* **download\_as\_bytes**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *chunk\_size=32768*, *timeout=60*){#yandex_cloud_ml_sdk._files.file.AsyncFile.download_as_bytes}

Download the file as bytes.

This method retrieves the file’s URL and streams the file’s content as whole (this may overflow the user’s memory), returning it as a byte string.

#|
|| Parameters | 

- **chunk\_size** ([*int*](https://docs.python.org/3/library/functions.html#int)) – The size of each chunk to read from the stream in bytes.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Returns | The file contents as bytes. ||
|| Return type | [bytes](https://docs.python.org/3/library/stdtypes.html#bytes) ||
|#

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._files.file.AsyncFile.name}

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._files.file.AsyncFile.description}

**mime\_type**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._files.file.AsyncFile.mime_type}

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._files.file.AsyncFile.created_by}

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._files.file.AsyncFile.created_at}

**updated\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._files.file.AsyncFile.updated_by}

**updated\_at**\: *datetime*{#yandex_cloud_ml_sdk._files.file.AsyncFile.updated_at}

**expires\_at**\: *datetime*{#yandex_cloud_ml_sdk._files.file.AsyncFile.expires_at}

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._files.file.AsyncFile.labels}

**expiration\_config**\: *[ExpirationConfig](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig)*{#yandex_cloud_ml_sdk._files.file.AsyncFile.expiration_config}

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._files.file.AsyncFile.id}