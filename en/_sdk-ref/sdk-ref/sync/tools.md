# Tools domain

## *class* yandex\_ai\_studio\_sdk.\_tools.domain.**Tools**{#yandex_ai_studio_sdk._tools.domain.Tools}

Class for tools functionality.

Tools are specialized utilities that extend the capabilities of language models and AI assistants by providing access to external functions, data sources, and computational resources. They enable models to perform actions beyond text generation, such as searching through knowledge bases, executing custom functions, and processing structured data.

This class serves as the foundation for tool management in both synchronous and asynchronous contexts, providing a unified interface for tools. For more information see the description of members of this class.

Tools are particularly useful in:

- **Completions**\: Enabling language models to invoke functions during text generation for dynamic content creation and problem-solving

The tools framework supports both streaming and non-streaming operations, making it suitable for real-time applications and batch processing scenarios.

*property* **function**\: *[FunctionToolsTypeT](../types/other.md#yandex_ai_studio_sdk._tools.function.FunctionToolsTypeT)*{#yandex_ai_studio_sdk._tools.domain.Tools.function}

Get the function sub-domain for creating function tools.

## Types

### *class* yandex\_ai\_studio\_sdk.\_tools.tool\_call.**ToolCall**{#yandex_ai_studio_sdk._tools.tool_call.ToolCall}

A tool call returned by models as a result of server-side tool calls.

This class encapsulates the response from language models when they invoke tools during conversation or completion. It contains information about the specific tool that was called, including its unique identifier and the associated function call with parameters and results.

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._tools.tool_call.ToolCall.id}

Unique tool call identifier

**function**\: *[FunctionCallTypeT](../types/other.md#yandex_ai_studio_sdk._tools.function_call.FunctionCallTypeT) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._tools.tool_call.ToolCall.function}

Function call associated with this tool call

### *class* yandex\_ai\_studio\_sdk.\_tools.function\_call.**FunctionCall**{#yandex_ai_studio_sdk._tools.function_call.FunctionCall}

Represents a function call returned by models as a result of server-side tool calls.

This class encapsulates the details of a function call that was invoked by the model during processing, including the function name and the arguments passed to it.

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._tools.function_call.FunctionCall.name}

Name of the function being called

**arguments**\: *JsonObject*{#yandex_ai_studio_sdk._tools.function_call.FunctionCall.arguments}

Arguments passed to the function