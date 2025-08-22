---
sourcePath: en/_sdk-ref/sdk-ref/types/assistants.md
---
# Assistant types

yandex\_cloud\_ml\_sdk.\_types.expiration.**ExpirationProtoTypeT\_contra** = *TypeVar(ExpirationProtoTypeT\_contra, bound=Union, contravariant=True)*{#yandex_cloud_ml_sdk._types.expiration.ExpirationProtoTypeT_contra}

**Type:**[**TypeVar**](https://docs.python.org/3/library/typing.html#typing.TypeVar)

Contravariant [**TypeVar**](https://docs.python.org/3/library/typing.html#typing.TypeVar) bound to **typing.Union**[**yandex.cloud.ai.assistants.v1.assistant\_pb2.Assistant**, **yandex.cloud.ai.assistants.v1.searchindex.search\_index\_pb2.SearchIndex**, **yandex.cloud.ai.assistants.v1.threads.thread\_pb2.Thread**, **yandex.cloud.ai.files.v1.file\_pb2.File**].

## *class* yandex\_cloud\_ml\_sdk.\_types.expiration.**ExpirationPolicy**{#yandex_cloud_ml_sdk._types.expiration.ExpirationPolicy}

**STATIC** = *1*{#yandex_cloud_ml_sdk._types.expiration.ExpirationPolicy.STATIC}

**SINCE\_LAST\_ACTIVE** = *2*{#yandex_cloud_ml_sdk._types.expiration.ExpirationPolicy.SINCE_LAST_ACTIVE}

## *class* yandex\_cloud\_ml\_sdk.\_types.expiration.**ExpirationConfig**{#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig}

ExpirationConfig(ttl\_days: ‘int | None’ = None, expiration\_policy: ‘ExpirationPolicy | None’ = None)

**ttl\_days**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig.ttl_days}

**expiration\_policy**\: *[ExpirationPolicy](#yandex_cloud_ml_sdk._types.expiration.ExpirationPolicy) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig.expiration_policy}

*classmethod* **coerce**(*ttl\_days*, *expiration\_policy*){#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig.coerce}

#|
|| Parameters | 

- **ttl\_days** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **expiration\_policy** ([*ExpirationPolicy*](#yandex_cloud_ml_sdk._types.expiration.ExpirationPolicy)* \| *[*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[**1**, **2**] **\| **~typing.Literal**[**'STATIC'**, **'SINCE\_LAST\_ACTIVE'**] **\| **~typing.Literal**[**'static'**, **'since\_last\_active'**] **\| **~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) ||
|| Return type | [*ExpirationConfig*](#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig) ||
|#

**to\_proto**(){#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig.to_proto}

#|
|| Return type | *ExpirationConfig* \| None ||
|#

**\_\_init\_\_**(*ttl\_days=None*, *expiration\_policy=None*){#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig.__init__i}

#|
|| Parameters | 

- **ttl\_days** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| **None*)
- **expiration\_policy** ([*ExpirationPolicy*](#yandex_cloud_ml_sdk._types.expiration.ExpirationPolicy)* \| **None*) ||
|| Return type | None ||
|#

yandex\_cloud\_ml\_sdk.\_types.expiration.**ExpirationPolicyAlias**{#yandex_cloud_ml_sdk._types.expiration.ExpirationPolicyAlias}

alias of [**ExpirationPolicy**](#yandex_cloud_ml_sdk._types.expiration.ExpirationPolicy) | [**Literal**](https://docs.python.org/3/library/typing.html#typing.Literal)[1, 2] | [**Literal**](https://docs.python.org/3/library/typing.html#typing.Literal)[‘STATIC’, ‘SINCE\_LAST\_ACTIVE’] | [**Literal**](https://docs.python.org/3/library/typing.html#typing.Literal)[‘static’, ‘since\_last\_active’]

## *class* yandex\_cloud\_ml\_sdk.\_types.expiration.**ExpirationPolicyAlias**{#yandex_cloud_ml_sdk._types.expiration.yandex_cloud_ml_sdk._types.expiration.ExpirationPolicyAlias}

## *class* yandex\_cloud\_ml\_sdk.\_assistants.prompt\_truncation\_options.**PromptTruncationOptions**{#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationOptions}

Configuration options for prompt truncation in assistant conversations.

This class defines how to handle prompt truncation when the conversation exceeds the maximum token limit. It allows specifying both the maximum token limit and the strategy for truncation.

**max\_prompt\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationOptions.max_prompt_tokens}

The maximum number of tokens allowed in the prompt. If the prompt exceeds this limit, the thread messages will be truncated. Default max\_prompt\_tokens: 7000

**strategy**\: *[BasePromptTruncationStrategy](#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.BasePromptTruncationStrategy) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationOptions.strategy}

The truncation strategy to use when the prompt exceeds the token limit. Can be either ‘auto’ for automatic strategy or a specific strategy instance. If None, no truncation strategy is applied.

## *class* yandex\_cloud\_ml\_sdk.\_assistants.prompt\_truncation\_options.**BasePromptTruncationStrategy**{#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.BasePromptTruncationStrategy}

Base class for prompt truncation strategies.

This abstract base class defines the interface for different truncation strategies that can be used when the prompt exceeds the maximum token limit. Concrete implementations should override the abstract methods to provide specific truncation behavior.

## *class* yandex\_cloud\_ml\_sdk.\_assistants.prompt\_truncation\_options.**AutoPromptTruncationStrategy**{#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.AutoPromptTruncationStrategy}

Automatic prompt truncation strategy.

The system will handle truncation in a way that aims to preserve the most relevant context. This strategy lets the AI service automatically determine the best approach for truncating the prompt while maintaining conversation coherence.

## *class* yandex\_cloud\_ml\_sdk.\_assistants.prompt\_truncation\_options.**LastMessagesPromptTruncationStrategy**{#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.LastMessagesPromptTruncationStrategy}

Last messages prompt truncation strategy.

This strategy specifies that when truncation is needed, the system should retain the most recent messages up to the specified number, and truncate older messages to fit within the token limit.

**num\_messages**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.LastMessagesPromptTruncationStrategy.num_messages}

The number of most recent messages to retain in the prompt. If these messages exceed *max\_prompt\_tokens*, older messages will be further truncated to fit the limit.

yandex\_cloud\_ml\_sdk.\_assistants.prompt\_truncation\_options.**PromptTruncationStrategyType**{#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationStrategyType}

alias of [**Literal**](https://docs.python.org/3/library/typing.html#typing.Literal)[‘auto’] | [**BasePromptTruncationStrategy**](#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.BasePromptTruncationStrategy)

## *class* yandex\_cloud\_ml\_sdk.\_assistants.prompt\_truncation\_options.**PromptTruncationStrategyType**{#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationStrategyType}

## *class* yandex\_cloud\_ml\_sdk.\_assistants.assistant.**ReadOnlyAssistant**{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant}

Base class providing read-only access to Yandex Cloud ML Assistant configuration and metadata.

This class implements the core interface for interacting with Yandex Cloud ML Assistant API in a read-only manner. It serves as the parent class for both synchronous (Assistant) and asynchronous (AsyncAssistant) implementations.

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant.name}

The name of the assistant.

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant.description}

The description of the assistant.

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant.created_by}

The identifier of the user who created the assistant.

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant.created_at}

The timestamp when the assistant was created.

**updated\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant.updated_by}

The identifier of the user who last updated the assistant.

**updated\_at**\: *datetime*{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant.updated_at}

The timestamp when the assistant was last updated.

**expires\_at**\: *datetime*{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant.expires_at}

The timestamp when the assistant will expire.

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant.labels}

Additional labels associated with the assistant.

*property* **max\_prompt\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant.max_prompt_tokens}

Returns the maximum number of prompt tokens allowed for the assistant.

**expiration\_config**\: *[ExpirationConfig](#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig)*{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant.expiration_config}

Expiration configuration for the assistant.

**model**\: *[BaseGPTModel](../internals/bases.md#yandex_cloud_ml_sdk._models.completions.model.BaseGPTModel)*{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant.model}

The GPT model used by the assistant.

**instruction**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant.instruction}

Instructions or guidelines that the assistant should follow. These instructions guide the assistant’s behavior and responses.

**prompt\_truncation\_options**\: *[PromptTruncationOptions](#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationOptions)*{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant.prompt_truncation_options}

Options for truncating thread messages. Controls how messages are truncated when forming the prompt.

**tools**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[BaseTool](../internals/bases.md#yandex_cloud_ml_sdk._tools.tool.BaseTool)*]... ,{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant.tools}

Tools available to the assistant. Can be a sequence or a single tool. Tools must implement BaseTool interface.

**response\_format**\: *ResponseType | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant.response_format}

A format of the response returned by the model. Could be a JsonSchema, a JSON string, or a pydantic model

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant.id}

## *class* yandex\_cloud\_ml\_sdk.\_assistants.assistant.**AssistantVersion**{#yandex_cloud_ml_sdk._assistants.assistant.AssistantVersion}

Represents a specific version of an Assistant.

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._assistants.assistant.AssistantVersion.id}

ID of the assistant version.

**assistant**\: *[ReadOnlyAssistant](#yandex_cloud_ml_sdk._assistants.assistant.ReadOnlyAssistant)*{#yandex_cloud_ml_sdk._assistants.assistant.AssistantVersion.assistant}

The assistant instance for this version.

**update\_mask**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str)*]... ,{#yandex_cloud_ml_sdk._assistants.assistant.AssistantVersion.update_mask}

Mask specifying which fields were updated in this version. Mask also have a custom JSON encoding