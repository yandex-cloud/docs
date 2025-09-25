---
sourcePath: en/_sdk-ref/sdk-ref/async/chat/completions.md
---
# Domain

## *class* yandex\_cloud\_ml\_sdk.\_chat.completions.function.**AsyncChatCompletions**{#yandex_cloud_ml_sdk._chat.completions.function.AsyncChatCompletions}

A class for working with chat completions models.

This class provides the core functionality for creating chat model instances and managing completions. It handles model URI construction and provides methods for listing available models.

*async* **list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._chat.completions.function.AsyncChatCompletions.list}

Returns all available chat models.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. ||
|| Return type | [tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[*AsyncChatModel*](#yandex_cloud_ml_sdk._chat.completions.model.AsyncChatModel), …] ||
|#

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_cloud_ml_sdk._chat.completions.function.AsyncChatCompletions.__call__i}

Create a chat model instance for generating completions.

Constructs the model URI based on the provided name and version. If the name contains ‘://’, it is treated as a full URI. Otherwise constructs a URI in the form ‘gpt://<folder\_id>/<model>/<version>’.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – The name or URI of the model.
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – The version of the model to use. Defaults to ‘latest’. ||
|| Return type | [*ModelTypeT*](../../types/other.md#yandex_cloud_ml_sdk._types.model.ModelTypeT) ||
|#

# Model

## *class* yandex\_cloud\_ml\_sdk.\_chat.completions.model.**AsyncChatModel**{#yandex_cloud_ml_sdk._chat.completions.model.AsyncChatModel}

A class for working with chat models providing inference functionality.

This class provides the foundation for chat model implementations, handling configuration, request building, and response processing.

*async* **run**(*messages*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=180*){#yandex_cloud_ml_sdk._chat.completions.model.AsyncChatModel.run}

Executes the model with the provided messages.

#|
|| Parameters | 

- **messages** ([*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*ChatFunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._chat.completions.message.ChatFunctionResultMessageDict) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict)*] \|* [*MultimodalMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._chat.completions.message.MultimodalMessageDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*ChatFunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._chat.completions.message.ChatFunctionResultMessageDict) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict)*] \|* [*MultimodalMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._chat.completions.message.MultimodalMessageDict)*]*) – The input messages to process. Could be a string, a dictionary, or a result object. Read more about other possible message types in the [corresponding documentation](https://yandex.cloud/docs/ai-studio/sdk/#usage).
- **timeout** – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 180 seconds. ||
|| Return type | [*ChatModelResult*](../../types/model_results.md#yandex_cloud_ml_sdk._chat.completions.result.ChatModelResult)[[*AsyncToolCall*](../tools.md#yandex_cloud_ml_sdk._tools.tool_call.AsyncToolCall)] ||
|#

*async* **run\_stream**(*messages*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=180*){#yandex_cloud_ml_sdk._chat.completions.model.AsyncChatModel.run_stream}

Executes the model with the provided messages and yields partial results as they become available.

#|
|| Parameters | 

- **messages** ([*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*ChatFunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._chat.completions.message.ChatFunctionResultMessageDict) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict)*] \|* [*MultimodalMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._chat.completions.message.MultimodalMessageDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*ChatFunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._chat.completions.message.ChatFunctionResultMessageDict) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict)*] \|* [*MultimodalMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._chat.completions.message.MultimodalMessageDict)*]*) – The input messages to process.
- **timeout** – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 180 seconds. ||
|| Return type | [*AsyncIterator*](https://docs.python.org/3/library/collections.abc.html#collections.abc.AsyncIterator)[[*ChatModelResult*](../../types/model_results.md#yandex_cloud_ml_sdk._chat.completions.result.ChatModelResult)[[*AsyncToolCall*](../tools.md#yandex_cloud_ml_sdk._tools.tool_call.AsyncToolCall)]] ||
|#

*property* **config**\: *[ConfigTypeT](../../types/other.md#yandex_cloud_ml_sdk._types.model.ConfigTypeT)*{#yandex_cloud_ml_sdk._chat.completions.model.AsyncChatModel.config}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *temperature=Undefined*, *max\_tokens=Undefined*, *reasoning\_mode=Undefined*, *response\_format=Undefined*, *tools=Undefined*, *parallel\_tool\_calls=Undefined*, *tool\_choice=Undefined*, *extra\_query=Undefined*){#yandex_cloud_ml_sdk._chat.completions.model.AsyncChatModel.configure}

Configure the model with specified parameters.

#|
|| Parameters | 

- **temperature** ([*UndefinedOr*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*float*](https://docs.python.org/3/library/functions.html#float)*] \| None*) – Sampling temperature (0-1). Higher values produce more random results.
- **max\_tokens** ([*UndefinedOr*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*] \| None*) – Maximum number of tokens to generate in the response.
- **reasoning\_mode** ([*UndefinedOr*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*ChatReasoningModeType*](../../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningModeType)*] \| None*) – Reasoning mode for internal processing before responding.
- **response\_format** ([*UndefinedOr*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[ResponseType] \| None*) – Format of the response (JsonSchema, JSON string, or pydantic model). See [structured output documentation\_BaseChatModel\_URL](https://yandex.cloud/docs/ai-studio/concepts/generation/structured-output).
- **tools** ([*UndefinedOr*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[Sequence[*[*CompletionTool*](../../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._models.completions.config.CompletionTool)*] \|* [*CompletionTool*](../../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._models.completions.config.CompletionTool)*]*) – Tools available for completion. Can be a sequence or single tool.
- **parallel\_tool\_calls** ([*UndefinedOr*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*bool*](https://docs.python.org/3/library/functions.html#bool)*]*) – Whether to allow parallel tool calls. Defaults to ‘true’.
- **tool\_choice** ([*UndefinedOr*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*ToolChoiceType*](../../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.tools.tool_choice.ToolChoiceType)*]*) – Strategy for tool selection. There are several ways to configure **tool\_choice** for query processing: - no tools to call (**tool\_choice='none'**); - required to call any tool (**tool\_choice='required'**); - call a specific tool (**tool\_choice={'type': 'function', 'function': {'name': 'another\_calculator'}}** or directly passing a tool object).
- **extra\_query** ([*UndefinedOr*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*QueryType*](../../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._chat.completions.config.QueryType)*]*) – Additional experimental model parameters. ||
|| Return type | Self ||
|#

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._chat.completions.model.AsyncChatModel.uri}