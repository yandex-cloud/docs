---
sourcePath: en/_sdk-ref/sdk-ref/sync/chat/completions.md
---
# Domain

## *class* yandex\_cloud\_ml\_sdk.\_chat.completions.function.**ChatCompletions**{#yandex_cloud_ml_sdk._chat.completions.function.ChatCompletions}

**list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._chat.completions.function.ChatCompletions.list}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[*ChatModel*](#yandex_cloud_ml_sdk._chat.completions.model.ChatModel), …] ||
|#

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_cloud_ml_sdk._chat.completions.function.ChatCompletions.__call__i}

Call self as a function.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Return type | [*ModelTypeT*](../../types/other.md#yandex_cloud_ml_sdk._types.model.ModelTypeT) ||
|#

# Model

## *class* yandex\_cloud\_ml\_sdk.\_chat.completions.model.**ChatModel**{#yandex_cloud_ml_sdk._chat.completions.model.ChatModel}

**run**(*messages*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=180*){#yandex_cloud_ml_sdk._chat.completions.model.ChatModel.run}

#|
|| Parameters | **messages** ([*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*ChatFunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._chat.completions.message.ChatFunctionResultMessageDict) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict)*] \|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*ChatFunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._chat.completions.message.ChatFunctionResultMessageDict) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict)*]]*) ||
|| Return type | [*ChatModelResult*](../../types/model_results.md#yandex_cloud_ml_sdk._chat.completions.result.ChatModelResult)[[*ToolCall*](../tools.md#yandex_cloud_ml_sdk._tools.tool_call.ToolCall)] ||
|#

**run\_stream**(*messages*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=180*){#yandex_cloud_ml_sdk._chat.completions.model.ChatModel.run_stream}

#|
|| Parameters | **messages** ([*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*ChatFunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._chat.completions.message.ChatFunctionResultMessageDict) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict)*] \|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*ChatFunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._chat.completions.message.ChatFunctionResultMessageDict) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict)*]]*) ||
|| Return type | [*Iterator*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterator)[[*ChatModelResult*](../../types/model_results.md#yandex_cloud_ml_sdk._chat.completions.result.ChatModelResult)[[*ToolCall*](../tools.md#yandex_cloud_ml_sdk._tools.tool_call.ToolCall)]] ||
|#

*property* **config**\: *[ConfigTypeT](../../types/other.md#yandex_cloud_ml_sdk._types.model.ConfigTypeT)*{#yandex_cloud_ml_sdk._chat.completions.model.ChatModel.config}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *temperature=Undefined*, *max\_tokens=Undefined*, *reasoning\_mode=Undefined*, *response\_format=Undefined*, *tools=Undefined*, *parallel\_tool\_calls=Undefined*, *tool\_choice=Undefined*){#yandex_cloud_ml_sdk._chat.completions.model.ChatModel.configure}

#|
|| Parameters | 

- **temperature** ([*float*](https://docs.python.org/3/library/functions.html#float) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*)
- **max\_tokens** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*)
- **reasoning\_mode** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*ChatReasoningMode*](../../types/other.md#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*)
- **response\_format** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['json'] \| ~yandex\_cloud\_ml\_sdk.\_types.schemas.JsonSchemaResponseType \| type \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined \| None*)
- **tools** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*FunctionTool*](../../types/tools.md#yandex_cloud_ml_sdk._tools.tool.FunctionTool)*] \|* [*FunctionTool*](../../types/tools.md#yandex_cloud_ml_sdk._tools.tool.FunctionTool) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **parallel\_tool\_calls** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **tool\_choice** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['none', 'None', 'NONE', 'auto', 'Auto', 'AUTO', 'required', 'Required', 'REQUIRED'] \| ~yandex\_cloud\_ml\_sdk.\_types.tools.function.FunctionDictType \| ~yandex\_cloud\_ml\_sdk.\_tools.tool.FunctionTool \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._chat.completions.model.ChatModel.uri}