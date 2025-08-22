---
sourcePath: en/_sdk-ref/sdk-ref/async/threads.md
---
# Threads domain

## *class* yandex\_cloud\_ml\_sdk.\_threads.domain.**AsyncThreads**{#yandex_cloud_ml_sdk._threads.domain.AsyncThreads}

A class for managing threads. It is a part of Assistants API.

This class provides methods to create, retrieve, and list threads.

*async* **create**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *ttl\_days=Undefined*, *expiration\_policy=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._threads.domain.AsyncThreads.create}

Create a new thread.

This method creates a new thread with the specified parameters.

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the name of the thread.
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a description for the thread.
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*, *[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] **\| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a set of labels for the thread.
- **ttl\_days** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – time-to-live in days for the thread.
- **expiration\_policy** ([*ExpirationPolicy*](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.ExpirationPolicy)* \| *[*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[**1**, **2**] **\| **~typing.Literal**[**'STATIC'**, **'SINCE\_LAST\_ACTIVE'**] **\| **~typing.Literal**[**'static'**, **'since\_last\_active'**] **\| **~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) – expiration policy for the file. Assepts for passing **static** or **since\_last\_active** strings. Should be defined if **ttl\_days** has been defined, otherwise both parameters should be undefined.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – timeout for the service call in seconds. Defaults to 60 seconds. ||
|| Return type | [*AsyncThread*](#yandex_cloud_ml_sdk._threads.thread.AsyncThread) ||
|#

*async* **get**(*thread\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._threads.domain.AsyncThreads.get}

Retrieve a thread by its id.

This method fetches an already created thread using its unique identifier.

#|
|| Parameters | 

- **thread\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the unique identifier of the thread to retrieve.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – timeout for the service call in seconds. Defaults to 60 seconds. ||
|| Return type | [*AsyncThread*](#yandex_cloud_ml_sdk._threads.thread.AsyncThread) ||
|#

*async* **list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page\_size=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._threads.domain.AsyncThreads.list}

List threads in the specified folder.

This method retrieves a list of threads. It continues to fetch threads until there are no more available.

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the maximum number of threads to return per page.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – timeout for the service call in seconds. Defaults to 60 seconds. ||
|| Return type | [*AsyncIterator*](https://docs.python.org/3/library/typing.html#typing.AsyncIterator)[[*AsyncThread*](#yandex_cloud_ml_sdk._threads.thread.AsyncThread)] ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_threads.thread.**AsyncThread**{#yandex_cloud_ml_sdk._threads.thread.AsyncThread}

*async* **update**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *ttl\_days=Undefined*, *expiration\_policy=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._threads.thread.AsyncThread.update}

Update the thread’s properties, including the name, the description, labels, ttl days, and the expiration policy of the thread.

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the new name of the thread.
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the new description for the thread.
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*, *[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] **\| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a set of new labels for the thread.
- **ttl\_days** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the updated time-to-live in days for the thread.
- **expiration\_policy** ([*ExpirationPolicy*](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.ExpirationPolicy)* \| *[*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[**1**, **2**] **\| **~typing.Literal**[**'STATIC'**, **'SINCE\_LAST\_ACTIVE'**] **\| **~typing.Literal**[**'static'**, **'since\_last\_active'**] **\| **~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) – an updated expiration policy for the file.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – timeout for the operation in seconds. Defaults to 60 seconds. ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*async* **delete**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._threads.thread.AsyncThread.delete}

Delete the thread.

This method deletes the thread and marks it as deleted. Raises an exception if the deletion fails.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – timeout for the operation. Defaults to 60 seconds. ||
|| Return type | None ||
|#

*async* **write**(*message*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *labels=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._threads.thread.AsyncThread.write}

Write a message to the thread.

This method allows sending a message to the thread with optional labels.

#|
|| Parameters | 

- **message** ([*TextMessage*](../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage)* \| *[*TextMessageDict*](../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict)* \| *[*TextMessageProtocol*](../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol)* \| *[*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the message to be sent to the thread. Could be a string, a dictionary, or a result object. Read more about other possible message types in the [documentation](https://yandex.cloud/docs/foundation-models/sdk/#usage).
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*, *[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] **\| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – optional labels for the message.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – timeout for the operation. Defaults to 60 seconds. ||
|| Return type | [*Message*](../types/message.md#yandex_cloud_ml_sdk._messages.message.Message) ||
|#

*async* **read**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._threads.thread.AsyncThread.read}

Read messages from the thread.

This method allows iterating over messages in the thread.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – timeout for the operation. Defaults to 60 seconds. ||
|| Return type | [*AsyncIterator*](https://docs.python.org/3/library/typing.html#typing.AsyncIterator)[[*Message*](../types/message.md#yandex_cloud_ml_sdk._messages.message.Message)] ||
|#

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._threads.thread.AsyncThread.name}

the name of the thread

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._threads.thread.AsyncThread.description}

the description of the thread

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._threads.thread.AsyncThread.created_by}

the identifier of the user who created the thread

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._threads.thread.AsyncThread.created_at}

the timestamp when the thread was created

**updated\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._threads.thread.AsyncThread.updated_by}

the identifier of the user who last updated the thread

**updated\_at**\: *datetime*{#yandex_cloud_ml_sdk._threads.thread.AsyncThread.updated_at}

the timestamp when the thread was last updated

**expires\_at**\: *datetime*{#yandex_cloud_ml_sdk._threads.thread.AsyncThread.expires_at}

the timestamp when the thread will expire

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._threads.thread.AsyncThread.labels}

additional labels associated with the thread

**expiration\_config**\: *[ExpirationConfig](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig)*{#yandex_cloud_ml_sdk._threads.thread.AsyncThread.expiration_config}

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._threads.thread.AsyncThread.id}