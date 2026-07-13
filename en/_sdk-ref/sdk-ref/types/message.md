# Messages

## Completions-related message types

### *class* yandex\_ai\_studio\_sdk.\_types.message.**TextMessage**{#yandex_ai_studio_sdk._types.message.TextMessage}

TextMessage(role: ‘str’, text: ‘str’)

**role**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._types.message.TextMessage.role}

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._types.message.TextMessage.text}

### *class* yandex\_ai\_studio\_sdk.\_types.message.**TextMessageProtocol**{#yandex_ai_studio_sdk._types.message.TextMessageProtocol}

*property* **role**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._types.message.TextMessageProtocol.role}

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._types.message.TextMessageProtocol.text}

*typeddict* yandex\_ai\_studio\_sdk.\_types.message.**TextMessageDict**{#yandex_ai_studio_sdk._types.message.TextMessageDict}

[**typing.TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict).

#|
|| Required Keys | 

- **role** ([**str**](https://docs.python.org/3/library/stdtypes.html#str))
- **text** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) ||
|#

yandex\_ai\_studio\_sdk.\_types.message.**coerce\_to\_text\_message\_dict**(*message*){#yandex_ai_studio_sdk._types.message.coerce_to_text_message_dict}

#|
|| Parameters | **message** ([*TextMessage*](#yandex_ai_studio_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](#yandex_ai_studio_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](#yandex_ai_studio_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Return type | [*TextMessageDict*](#yandex_ai_studio_sdk._types.message.TextMessageDict) ||
|#

*typeddict* yandex\_ai\_studio\_sdk.\_models.completions.message.**FunctionResultMessageDict**{#yandex_ai_studio_sdk._models.completions.message.FunctionResultMessageDict}

A class with the TypedDict representing the structure of a function result message. The dictionary contains the role of the message sender and the results of tool calls.

#|
|| Required Keys | 

- **role** ([**str**](https://docs.python.org/3/library/stdtypes.html#str))
- **tool\_results** ([**Iterable**](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)[[**FunctionResultDict**](#yandex_ai_studio_sdk._tools.tool_result.FunctionResultDict)]) ||
|#

*typeddict* yandex\_ai\_studio\_sdk.\_tools.tool\_result.**FunctionResultDict**{#yandex_ai_studio_sdk._tools.tool_result.FunctionResultDict}

Dictionary structure for function results.

#|
|| Required Keys | 

- **name** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) – Name of the function
- **content** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) – Result content
- **type** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) – Optional result type (default: ‘function’) ||
|#

*typeddict* yandex\_ai\_studio\_sdk.\_types.tools.function.**FunctionDictType**{#yandex_ai_studio_sdk._types.tools.function.FunctionDictType}

[**typing.TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict).

#|
|| Required Keys | 

- **type** ([**Literal**](https://docs.python.org/3/library/typing.html#typing.Literal)[**'function'**])
- **function** ([**FunctionNameType**](#yandex_ai_studio_sdk._types.tools.function.FunctionNameType)) ||
|#

*typeddict* yandex\_ai\_studio\_sdk.\_types.tools.function.**FunctionNameType**{#yandex_ai_studio_sdk._types.tools.function.FunctionNameType}

[**typing.TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict).

#|
|| Required Keys | 

- **name** ([**str**](https://docs.python.org/3/library/stdtypes.html#str))
- **instruction** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) ||
|#

### *class* yandex\_ai\_studio\_sdk.\_models.completions.token.**Token**{#yandex_ai_studio_sdk._models.completions.token.Token}

This class encapsulates the properties of a token and represents it in a text processing context.

**id**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._models.completions.token.Token.id}

a unique identifier for the token

**special**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._models.completions.token.Token.special}

a flag indicating if the token is a special one

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._models.completions.token.Token.text}

the textual representation of the token

## Chat completions related message types

*typeddict* yandex\_ai\_studio\_sdk.\_chat.completions.message.**ChatFunctionResultMessageDict**{#yandex_ai_studio_sdk._chat.completions.message.ChatFunctionResultMessageDict}

Function call result message in chat domain format.

Used to represent the result of a function/tool call in chat conversations.

#|
|| Required Keys | 

- **role** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) – Role of the message (optional)
- **tool\_call\_id** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) – ID of the tool call this result corresponds to
- **content** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) – Mixed content including text and/or images ||
|#

*typeddict* yandex\_ai\_studio\_sdk.\_chat.completions.message.**MultimodalMessageDict**{#yandex_ai_studio_sdk._chat.completions.message.MultimodalMessageDict}

Multimodal message supporting both text and image content.

Allows passing multiple content types (text and images) in a single message.

#|
|| Required Keys | 

- **role** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) – Role of the message (optional)
- **content** ([**Sequence**](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)[[**Union**](https://docs.python.org/3/library/typing.html#typing.Union)[[**ImageUrlDict**](#yandex_ai_studio_sdk._chat.completions.message.ImageUrlDict), [**TextContent**](#yandex_ai_studio_sdk._chat.completions.message.TextContent)]]) – Mixed content including text and/or images ||
|#

*typeddict* yandex\_ai\_studio\_sdk.\_chat.completions.message.**TextContent**{#yandex_ai_studio_sdk._chat.completions.message.TextContent}

Text content type for multimodal messages.

Used to include text data in multimodal chat messages.

#|
|| Required Keys | 

- **type** ([**Literal**](https://docs.python.org/3/library/typing.html#typing.Literal)[**'text'**]) – Content type identifier for text
- **text** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) – Text content ||
|#

*typeddict* yandex\_ai\_studio\_sdk.\_chat.completions.message.**ImageUrlContent**{#yandex_ai_studio_sdk._chat.completions.message.ImageUrlContent}

Image content type for multimodal messages.

Used to include image data in multimodal chat messages.

#|
|| Required Keys | 

- **type** ([**Literal**](https://docs.python.org/3/library/typing.html#typing.Literal)[**'image\_url'**]) – Content type identifier for text
- **image\_url** ([**ImageUrlDict**](#yandex_ai_studio_sdk._chat.completions.message.ImageUrlDict)) – Image URL information ||
|#

*typeddict* yandex\_ai\_studio\_sdk.\_chat.completions.message.**ImageUrlDict**{#yandex_ai_studio_sdk._chat.completions.message.ImageUrlDict}

Dictionary for passing image URL in multimodal messages.

#|
|| Required Keys | 

- **url** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) – URL of the image ||
|#

## Image generation messages

### *class* yandex\_ai\_studio\_sdk.\_models.image\_generation.message.**ImageMessage**{#yandex_ai_studio_sdk._models.image_generation.message.ImageMessage}

This class represents a message for using in image generation models with optional weight field.

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._models.image_generation.message.ImageMessage.text}

the text content of the message for using in image generation models

**weight**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._models.image_generation.message.ImageMessage.weight}

the weight associated with the message

*typeddict* yandex\_ai\_studio\_sdk.\_models.image\_generation.message.**ImageMessageDict**{#yandex_ai_studio_sdk._models.image_generation.message.ImageMessageDict}

The class with TypedDict representing the structure of an image message.

#|
|| Required Keys | 

- **text** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) – the text content of the message for using in image generation models
- **weight** ([**float**](https://docs.python.org/3/library/functions.html#float)) – the weight associated with the message ||
|#

### *class* yandex\_ai\_studio\_sdk.\_models.image\_generation.message.**AnyMessage**{#yandex_ai_studio_sdk._models.image_generation.message.AnyMessage}

The class with a protocol which defines an object with a text field. The protocol can be used to check if an object has a text attribute.

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._models.image_generation.message.AnyMessage.text}

yandex\_ai\_studio\_sdk.\_models.image\_generation.message.**ImageMessageType**{#yandex_ai_studio_sdk._models.image_generation.message.ImageMessageType}

type alias for different types of messages that can be processed by image generation models

Alias of [**Union**](https://docs.python.org/3/library/typing.html#typing.Union)[[**ImageMessage**](#yandex_ai_studio_sdk._models.image_generation.message.ImageMessage), [**ImageMessageDict**](#yandex_ai_studio_sdk._models.image_generation.message.ImageMessageDict), [**TextMessage**](#yandex_ai_studio_sdk._types.message.TextMessage), [**AnyMessage**](#yandex_ai_studio_sdk._models.image_generation.message.AnyMessage), [**str**](https://docs.python.org/3/library/stdtypes.html#str)]

yandex\_ai\_studio\_sdk.\_models.image\_generation.message.**ImageMessageInputType**{#yandex_ai_studio_sdk._models.image_generation.message.ImageMessageInputType}

type alias for input types accepted by the *messages\_to\_proto* function

Alias of [**Union**](https://docs.python.org/3/library/typing.html#typing.Union)[[**ImageMessage**](#yandex_ai_studio_sdk._models.image_generation.message.ImageMessage), [**ImageMessageDict**](#yandex_ai_studio_sdk._models.image_generation.message.ImageMessageDict), [**TextMessage**](#yandex_ai_studio_sdk._types.message.TextMessage), [**AnyMessage**](#yandex_ai_studio_sdk._models.image_generation.message.AnyMessage), [**str**](https://docs.python.org/3/library/stdtypes.html#str), [**Iterable**](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)[[**Union**](https://docs.python.org/3/library/typing.html#typing.Union)[[**ImageMessage**](#yandex_ai_studio_sdk._models.image_generation.message.ImageMessage), [**ImageMessageDict**](#yandex_ai_studio_sdk._models.image_generation.message.ImageMessageDict), [**TextMessage**](#yandex_ai_studio_sdk._types.message.TextMessage), [**AnyMessage**](#yandex_ai_studio_sdk._models.image_generation.message.AnyMessage), [**str**](https://docs.python.org/3/library/stdtypes.html#str)]]]