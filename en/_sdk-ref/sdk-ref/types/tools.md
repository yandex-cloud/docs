# Tools

## Function tool

### *class* yandex\_ai\_studio\_sdk.\_tools.tool.**FunctionTool**{#yandex_ai_studio_sdk._tools.tool.FunctionTool}

A function tool that can be called by AI models.

This class represents a callable function that can be used by AI models for function calling capabilities. It encapsulates the function’s metadata including its name, description, parameter schema, and validation settings.

The function tool can be used with both completions and assistants APIs, providing a unified interface for defining external functions that models can invoke during conversations or completion requests.

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._tools.tool.FunctionTool.name}

Name of the function

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._tools.tool.FunctionTool.description}

Optional function description

**parameters**\: *JsonSchemaType*{#yandex_ai_studio_sdk._tools.tool.FunctionTool.parameters}

Function parameters schema

**strict**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._tools.tool.FunctionTool.strict}

Whether to enforce strict parameter validation