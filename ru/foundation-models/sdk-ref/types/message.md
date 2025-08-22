---
sourcePath: en/_sdk-ref/sdk-ref/types/message.md
---
# Messages

## Assistant-related message types

### *class* yandex\_cloud\_ml\_sdk.\_messages.message.**Message**{#yandex_cloud_ml_sdk._messages.message.Message}

Message(id: ‘str’, \_sdk: ‘BaseSDK’, parts: ‘tuple[Any, …]’, thread\_id: ‘str’, created\_by: ‘str’, created\_at: ‘datetime’, labels: ‘dict[str, str] | None’, author: ‘Author’, citations: ‘tuple[Citation, …]’, status: ‘MessageStatus’)

**thread\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._messages.message.Message.thread_id}

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._messages.message.Message.created_by}

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._messages.message.Message.created_at}

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._messages.message.Message.labels}

**author**\: *[Author](#yandex_cloud_ml_sdk._messages.message.Author)*{#yandex_cloud_ml_sdk._messages.message.Message.author}

**citations**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Citation](#yandex_cloud_ml_sdk._messages.citations.Citation)*]... ,{#yandex_cloud_ml_sdk._messages.message.Message.citations}

**status**\: *[MessageStatus](#yandex_cloud_ml_sdk._messages.message.MessageStatus)*{#yandex_cloud_ml_sdk._messages.message.Message.status}

*property* **role**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._messages.message.Message.role}

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._messages.message.Message.text}

**parts**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[Any*]... ,{#yandex_cloud_ml_sdk._messages.message.Message.parts}

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._messages.message.Message.id}

### *class* yandex\_cloud\_ml\_sdk.\_messages.message.**PartialMessage**{#yandex_cloud_ml_sdk._messages.message.PartialMessage}

PartialMessage(id: ‘str’, \_sdk: ‘BaseSDK’, parts: ‘tuple[Any, …]’)

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._messages.message.PartialMessage.text}

**parts**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[Any*]... ,{#yandex_cloud_ml_sdk._messages.message.PartialMessage.parts}

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._messages.message.PartialMessage.id}

### *class* yandex\_cloud\_ml\_sdk.\_messages.message.**Author**{#yandex_cloud_ml_sdk._messages.message.Author}

Author(id: ‘str’, role: ‘str’)

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._messages.message.Author.id}

**role**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._messages.message.Author.role}

### *class* yandex\_cloud\_ml\_sdk.\_messages.message.**MessageStatus**{#yandex_cloud_ml_sdk._messages.message.MessageStatus}

**MESSAGE\_STATUS\_UNSPECIFIED** = *0*{#yandex_cloud_ml_sdk._messages.message.MessageStatus.MESSAGE_STATUS_UNSPECIFIED}

**COMPLETED** = *1*{#yandex_cloud_ml_sdk._messages.message.MessageStatus.COMPLETED}

**TRUNCATED** = *2*{#yandex_cloud_ml_sdk._messages.message.MessageStatus.TRUNCATED}

**FILTERED\_CONTENT** = *3*{#yandex_cloud_ml_sdk._messages.message.MessageStatus.FILTERED_CONTENT}

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._messages.message.MessageStatus.__new__i}

### *class* yandex\_cloud\_ml\_sdk.\_messages.citations.**Citation**{#yandex_cloud_ml_sdk._messages.citations.Citation}

Citation(sources: ‘tuple[Source, …]’)

**sources**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Source](#yandex_cloud_ml_sdk._messages.citations.Source)*]... ,{#yandex_cloud_ml_sdk._messages.citations.Citation.sources}

### *class* yandex\_cloud\_ml\_sdk.\_messages.citations.**Source**{#yandex_cloud_ml_sdk._messages.citations.Source}

*abstract property* **type**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._messages.citations.Source.type}

## Completions-related message types

### *class* yandex\_cloud\_ml\_sdk.\_types.message.**TextMessage**{#yandex_cloud_ml_sdk._types.message.TextMessage}

TextMessage(role: ‘str’, text: ‘str’)

**role**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.message.TextMessage.role}

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.message.TextMessage.text}

### *class* yandex\_cloud\_ml\_sdk.\_types.message.**TextMessageProtocol**{#yandex_cloud_ml_sdk._types.message.TextMessageProtocol}

*property* **role**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.message.TextMessageProtocol.role}

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.message.TextMessageProtocol.text}

*typeddict* yandex\_cloud\_ml\_sdk.\_types.message.**TextMessageDict**{#yandex_cloud_ml_sdk._types.message.TextMessageDict}

[**typing.TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict).

#|
|| Required Keys | 

- **role** ([**str**](https://docs.python.org/3/library/stdtypes.html#str))
- **text** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) ||
|#

yandex\_cloud\_ml\_sdk.\_types.message.**coerce\_to\_text\_message\_dict**(*message*){#yandex_cloud_ml_sdk._types.message.coerce_to_text_message_dict}

#|
|| Parameters | **message** ([*TextMessage*](#yandex_cloud_ml_sdk._types.message.TextMessage)* \| *[*TextMessageDict*](#yandex_cloud_ml_sdk._types.message.TextMessageDict)* \| *[*TextMessageProtocol*](#yandex_cloud_ml_sdk._types.message.TextMessageProtocol)* \| *[*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Return type | [*TextMessageDict*](#yandex_cloud_ml_sdk._types.message.TextMessageDict) ||
|#

*typeddict* yandex\_cloud\_ml\_sdk.\_models.completions.message.**FunctionResultMessageDict**{#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict}

A class with the TypedDict representing the structure of a function result message. The dictionary contains the role of the message sender and the results of tool calls.

#|
|| Required Keys | 

- **role** ([**str**](https://docs.python.org/3/library/stdtypes.html#str))
- **tool\_results** ([**Iterable**](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)[[**FunctionResultDict**](#yandex_cloud_ml_sdk._tools.tool_result.FunctionResultDict)]) ||
|#

*typeddict* yandex\_cloud\_ml\_sdk.\_tools.tool\_result.**FunctionResultDict**{#yandex_cloud_ml_sdk._tools.tool_result.FunctionResultDict}

[**typing.TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict).

#|
|| Required Keys | 

- **name** ([**str**](https://docs.python.org/3/library/stdtypes.html#str))
- **content** ([**str**](https://docs.python.org/3/library/stdtypes.html#str))
- **type** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) ||
|#

*typeddict* yandex\_cloud\_ml\_sdk.\_types.tools.function.**FunctionDictType**{#yandex_cloud_ml_sdk._types.tools.function.FunctionDictType}

[**typing.TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict).

#|
|| Required Keys | 

- **type** (**Literal**[**'function'**])
- **function** ([**FunctionNameType**](#yandex_cloud_ml_sdk._types.tools.function.FunctionNameType)) ||
|#

*typeddict* yandex\_cloud\_ml\_sdk.\_types.tools.function.**FunctionNameType**{#yandex_cloud_ml_sdk._types.tools.function.FunctionNameType}

[**typing.TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict).

#|
|| Required Keys | 

- **name** ([**str**](https://docs.python.org/3/library/stdtypes.html#str))
- **instruction** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) ||
|#

### *class* yandex\_cloud\_ml\_sdk.\_models.completions.token.**Token**{#yandex_cloud_ml_sdk._models.completions.token.Token}

This class encapsulates the properties of a token and represents it in a text processing context.

**id**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._models.completions.token.Token.id}

a unique identifier for the token

**special**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._models.completions.token.Token.special}

a flag indicating if the token is a special one

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._models.completions.token.Token.text}

the textual representation of the token

## Chat completions related message types

*typeddict* yandex\_cloud\_ml\_sdk.\_chat.completions.message.**ChatFunctionResultMessageDict**{#yandex_cloud_ml_sdk._chat.completions.message.ChatFunctionResultMessageDict}

[**typing.TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict).

#|
|| Required Keys | 

- **role** ([**str**](https://docs.python.org/3/library/stdtypes.html#str))
- **tool\_call\_id** ([**str**](https://docs.python.org/3/library/stdtypes.html#str))
- **content** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) ||
|#

## Image generation messages

### *class* yandex\_cloud\_ml\_sdk.\_models.image\_generation.message.**ImageMessage**{#yandex_cloud_ml_sdk._models.image_generation.message.ImageMessage}

This class represents a message for using in image generation models with optional weight field.

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._models.image_generation.message.ImageMessage.text}

the text content of the message for using in image generation models

**weight**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._models.image_generation.message.ImageMessage.weight}

the weight associated with the message

*typeddict* yandex\_cloud\_ml\_sdk.\_models.image\_generation.message.**ImageMessageDict**{#yandex_cloud_ml_sdk._models.image_generation.message.ImageMessageDict}

The class with TypedDict representing the structure of an image message.

#|
|| Required Keys | 

- **text** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) – the text content of the message for using in image generation models
- **weight** ([**float**](https://docs.python.org/3/library/functions.html#float)) – the weight associated with the message ||
|#

### *class* yandex\_cloud\_ml\_sdk.\_models.image\_generation.message.**AnyMessage**{#yandex_cloud_ml_sdk._models.image_generation.message.AnyMessage}

The class with a protocol which defines an object with a text field. The protocol can be used to check if an object has a text attribute.

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._models.image_generation.message.AnyMessage.text}

yandex\_cloud\_ml\_sdk.\_models.image\_generation.message.**ImageMessageType**{#yandex_cloud_ml_sdk._models.image_generation.message.ImageMessageType}

type alias for different types of messages that can be processed by image generation models

Alias of **Union**[[**ImageMessage**](#yandex_cloud_ml_sdk._models.image_generation.message.ImageMessage), [**ImageMessageDict**](#yandex_cloud_ml_sdk._models.image_generation.message.ImageMessageDict), [**AnyMessage**](#yandex_cloud_ml_sdk._models.image_generation.message.AnyMessage), [**str**](https://docs.python.org/3/library/stdtypes.html#str)]

yandex\_cloud\_ml\_sdk.\_models.image\_generation.message.**ImageMessageInputType**{#yandex_cloud_ml_sdk._models.image_generation.message.ImageMessageInputType}

type alias for input types accepted by the *messages\_to\_proto* function

Alias of **Union**[[**ImageMessage**](#yandex_cloud_ml_sdk._models.image_generation.message.ImageMessage), [**ImageMessageDict**](#yandex_cloud_ml_sdk._models.image_generation.message.ImageMessageDict), [**AnyMessage**](#yandex_cloud_ml_sdk._models.image_generation.message.AnyMessage), [**str**](https://docs.python.org/3/library/stdtypes.html#str), [**Iterable**](https://docs.python.org/3/library/typing.html#typing.Iterable)[**Union**[[**ImageMessage**](#yandex_cloud_ml_sdk._models.image_generation.message.ImageMessage), [**ImageMessageDict**](#yandex_cloud_ml_sdk._models.image_generation.message.ImageMessageDict), [**AnyMessage**](#yandex_cloud_ml_sdk._models.image_generation.message.AnyMessage), [**str**](https://docs.python.org/3/library/stdtypes.html#str)]]]