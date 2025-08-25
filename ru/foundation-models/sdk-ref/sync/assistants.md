---
sourcePath: en/_sdk-ref/sdk-ref/sync/assistants.md
---
# Assistants domain

## *class* yandex\_cloud\_ml\_sdk.\_assistants.domain.**Assistants**{#yandex_cloud_ml_sdk._assistants.domain.Assistants}

Base class for assistants management.

Provides common functionality for creating, getting and listing assistants.

**create**(*model*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *temperature=Undefined*, *max\_tokens=Undefined*, *instruction=Undefined*, *max\_prompt\_tokens=Undefined*, *prompt\_truncation\_strategy=Undefined*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *ttl\_days=Undefined*, *tools=Undefined*, *expiration\_policy=Undefined*, *response\_format=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._assistants.domain.Assistants.create}

Create a new assistant instance.

#|
|| Parameters | 

- **model** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseGPTModel*](../internals/bases.md#yandex_cloud_ml_sdk._models.completions.model.BaseGPTModel)) – Model ID or BaseGPTModel instance
- **temperature** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*float*](https://docs.python.org/3/library/functions.html#float)*]*) – A sampling temperature to use - higher values mean more random results. Should be a double number between 0 (inclusive) and 1 (inclusive).
- **max\_tokens** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*]*) – Maximum number of tokens to generate
- **instruction** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – System instruction for the assistant
- **max\_prompt\_tokens** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*]*) – Maximum tokens allowed in prompt
- **prompt\_truncation\_strategy** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*PromptTruncationStrategyType*](../types/assistants.md#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationStrategyType)*]*) – Strategy for prompt truncation
- **name** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – Assistant name
- **description** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – Assistant description
- **labels** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*]]*) – Additional labels associated with the assistant
- **ttl\_days** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*]*) – Time-to-live in days
- **tools** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[Iterable[*[*BaseTool*](../internals/bases.md#yandex_cloud_ml_sdk._tools.tool.BaseTool)*]]*) – Tools to use for completion. Can be a sequence or a single tool.
- **expiration\_policy** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*ExpirationPolicyAlias*](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.yandex_cloud_ml_sdk._types.expiration.ExpirationPolicyAlias)*]*) – Expiration policy for assistant
- **response\_format** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[ResponseType]*) – A format of the response returned by the model. Could be a JsonSchema, a JSON string, or a pydantic model. Read more about possible response formats in the [structured output documentation](https://yandex.cloud/docs/foundation-models/concepts/yandexgpt/#structured-output).
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [Assistant](#yandex_cloud_ml_sdk._assistants.assistant.Assistant) ||
|#

**get**(*assistant\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._assistants.domain.Assistants.get}

Get an existing assistant by ID.

#|
|| Parameters | 

- **assistant\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – ID of the assistant to retrieve
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*Assistant*](#yandex_cloud_ml_sdk._assistants.assistant.Assistant) ||
|#

**list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page\_size=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._assistants.domain.Assistants.list}

List all assistants.

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Number of assistants per page
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*Iterator*](https://docs.python.org/3/library/typing.html#typing.Iterator)[[*Assistant*](#yandex_cloud_ml_sdk._assistants.assistant.Assistant)] ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_assistants.assistant.**Assistant**{#yandex_cloud_ml_sdk._assistants.assistant.Assistant}

Base class providing read-only access to Yandex Cloud ML Assistant configuration and metadata.

This class implements the core interface for interacting with Yandex Cloud ML Assistant API in a read-only manner. It serves as the parent class for both synchronous (Assistant) and asynchronous (AsyncAssistant) implementations.

**update**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model=Undefined*, *temperature=Undefined*, *max\_tokens=Undefined*, *instruction=Undefined*, *max\_prompt\_tokens=Undefined*, *prompt\_truncation\_strategy=Undefined*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *ttl\_days=Undefined*, *tools=Undefined*, *expiration\_policy=Undefined*, *response\_format=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._assistants.assistant.Assistant.update}

Update the assistant’s configuration with new parameters.

This method sends an update request to Yandex Cloud ML API to modify the assistant’s configuration. Only specified parameters will be updated, others remain unchanged.

#|
|| Parameters | 

- **model** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseGPTModel*](../internals/bases.md#yandex_cloud_ml_sdk._models.completions.model.BaseGPTModel)*]*) – New model URI or BaseGPTModel instance to use
- **temperature** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*float*](https://docs.python.org/3/library/functions.html#float)*]*) – A sampling temperature to use - higher values mean more random results. Should be a double number between 0 (inclusive) and 1 (inclusive).
- **max\_tokens** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*]*) – Maximum number of tokens to generate
- **instruction** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – New instructions for the assistant
- **max\_prompt\_tokens** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*]*) – Maximum tokens allowed in the prompt
- **prompt\_truncation\_strategy** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*PromptTruncationStrategyType*](../types/assistants.md#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationStrategyType)*]*) – Strategy for truncating long prompts
- **name** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – New name for the assistant
- **description** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – New description for the assistant
- **labels** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*]]*) – New key-value labels for the assistant
- **ttl\_days** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*]*) – Time-to-live in days before automatic deletion
- **tools** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[Iterable[*[*BaseTool*](../internals/bases.md#yandex_cloud_ml_sdk._tools.tool.BaseTool)*]]*) – Tools to use for completion. Can be a sequence or a single tool.
- **expiration\_policy** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*ExpirationPolicyAlias*](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.yandex_cloud_ml_sdk._types.expiration.ExpirationPolicyAlias)*]*) – Policy for handling expiration
- **response\_format** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[ResponseType]*) – A format of the response returned by the model. Could be a JsonSchema, a JSON string, or a pydantic model. Read more about possible response formats in the [structured output documentation](https://yandex.cloud/docs/foundation-models/concepts/yandexgpt/#structured-output).
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | Self ||
|#

**delete**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._assistants.assistant.Assistant.delete}

Delete the assistant from Yandex Cloud ML.

Sends a delete request to the Yandex Cloud ML API to remove the assistant. After successful deletion, marks the assistant as deleted internally.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | None ||
|#

**list\_versions**(*page\_size=Undefined*, *page\_token=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._assistants.assistant.Assistant.list_versions}

List all versions of the assistant.

This method retrieves historical versions of the assistant in a paginated manner.

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Maximum number of versions to return per page
- **page\_token** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Token for pagination
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*Iterator*](https://docs.python.org/3/library/typing.html#typing.Iterator)[[*AssistantVersion*](../types/assistants.md#yandex_cloud_ml_sdk._assistants.assistant.AssistantVersion)] ||
|#

**run**(*thread*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *custom\_temperature=Undefined*, *custom\_max\_tokens=Undefined*, *custom\_max\_prompt\_tokens=Undefined*, *custom\_prompt\_truncation\_strategy=Undefined*, *custom\_response\_format=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._assistants.assistant.Assistant.run}

Execute a non-streaming run with the assistant on the given thread.

#|
|| Parameters | 

- **thread** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Thread*](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread)) – Thread ID or Thread object to run on
- **custom\_temperature** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*float*](https://docs.python.org/3/library/functions.html#float)*]*) – Override for model temperature
- **custom\_max\_tokens** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*]*) – Override for max tokens to generate
- **custom\_max\_prompt\_tokens** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*]*) – Override for max prompt tokens
- **custom\_prompt\_truncation\_strategy** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*PromptTruncationStrategyType*](../types/assistants.md#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationStrategyType)*]*) – Override for prompt truncation strategy
- **custom\_response\_format** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[ResponseType]*) – Override for response format
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [Run](runs.md#yandex_cloud_ml_sdk._runs.run.Run) ||
|#

**run\_stream**(*thread*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *custom\_temperature=Undefined*, *custom\_max\_tokens=Undefined*, *custom\_max\_prompt\_tokens=Undefined*, *custom\_prompt\_truncation\_strategy=Undefined*, *custom\_response\_format=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._assistants.assistant.Assistant.run_stream}

Execute a streaming run with the assistant on the given thread.

#|
|| Parameters | 

- **thread** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Thread*](threads.md#yandex_cloud_ml_sdk._threads.thread.Thread)) – Thread ID or Thread object to run on
- **custom\_temperature** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*float*](https://docs.python.org/3/library/functions.html#float)*]*) – Override for model temperature
- **custom\_max\_tokens** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*]*) – Override for max tokens to generate
- **custom\_max\_prompt\_tokens** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*]*) – Override for max prompt tokens
- **custom\_prompt\_truncation\_strategy** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*PromptTruncationStrategyType*](../types/assistants.md#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationStrategyType)*]*) – Override for prompt truncation strategy
- **custom\_response\_format** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[ResponseType]*) – Override for response format
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [Run](runs.md#yandex_cloud_ml_sdk._runs.run.Run) ||
|#

*property* **max\_prompt\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._assistants.assistant.Assistant.max_prompt_tokens}

Returns the maximum number of prompt tokens allowed for the assistant.

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._assistants.assistant.Assistant.name}

The name of the assistant.

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._assistants.assistant.Assistant.description}

The description of the assistant.

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._assistants.assistant.Assistant.created_by}

The identifier of the user who created the assistant.

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._assistants.assistant.Assistant.created_at}

The timestamp when the assistant was created.

**updated\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._assistants.assistant.Assistant.updated_by}

The identifier of the user who last updated the assistant.

**updated\_at**\: *datetime*{#yandex_cloud_ml_sdk._assistants.assistant.Assistant.updated_at}

The timestamp when the assistant was last updated.

**expires\_at**\: *datetime*{#yandex_cloud_ml_sdk._assistants.assistant.Assistant.expires_at}

The timestamp when the assistant will expire.

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._assistants.assistant.Assistant.labels}

Additional labels associated with the assistant.

**expiration\_config**\: *[ExpirationConfig](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig)*{#yandex_cloud_ml_sdk._assistants.assistant.Assistant.expiration_config}

Expiration configuration for the assistant.

**model**\: *[BaseGPTModel](../internals/bases.md#yandex_cloud_ml_sdk._models.completions.model.BaseGPTModel)*{#yandex_cloud_ml_sdk._assistants.assistant.Assistant.model}

The GPT model used by the assistant.

**instruction**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._assistants.assistant.Assistant.instruction}

Instructions or guidelines that the assistant should follow. These instructions guide the assistant’s behavior and responses.

**prompt\_truncation\_options**\: *[PromptTruncationOptions](../types/assistants.md#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationOptions)*{#yandex_cloud_ml_sdk._assistants.assistant.Assistant.prompt_truncation_options}

Options for truncating thread messages. Controls how messages are truncated when forming the prompt.

**tools**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[BaseTool](../internals/bases.md#yandex_cloud_ml_sdk._tools.tool.BaseTool)*]... ,{#yandex_cloud_ml_sdk._assistants.assistant.Assistant.tools}

Tools available to the assistant. Can be a sequence or a single tool. Tools must implement BaseTool interface.

**response\_format**\: *ResponseType | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._assistants.assistant.Assistant.response_format}

A format of the response returned by the model. Could be a JsonSchema, a JSON string, or a pydantic model

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._assistants.assistant.Assistant.id}