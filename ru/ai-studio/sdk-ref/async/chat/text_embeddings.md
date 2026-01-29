---
sourcePath: en/_sdk-ref/sdk-ref/async/chat/text_embeddings.md
---
# Domain

## *class* yandex\_ai\_studio\_sdk.\_chat.text\_embeddings.function.**AsyncChatEmbeddings**{#yandex_ai_studio_sdk._chat.text_embeddings.function.AsyncChatEmbeddings}

*async* **list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *filters=None*){#yandex_ai_studio_sdk._chat.text_embeddings.function.AsyncChatEmbeddings.list}

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **filters** ([*ModelFilter*](../../types/other.md#yandex_ai_studio_sdk._chat.utils.ModelFilter) *\| None*) ||
|| Return type | [tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[*AsyncChatEmbeddingsModel*](#yandex_ai_studio_sdk._chat.text_embeddings.model.AsyncChatEmbeddingsModel), …] ||
|#

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_ai_studio_sdk._chat.text_embeddings.function.AsyncChatEmbeddings.__call__i}

Create a model instance in selected chat subdomain (completions, embeddings, etc)

Constructs the model URI based on the provided name and version. If the name contains ‘://’, it is treated as a full URI. Otherwise constructs a URI in the form ‘gpt://<folder\_id>/<model>/<version>’.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – The name or URI of the model.
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – The version of the model to use. Defaults to ‘latest’. ||
|| Return type | [*ModelTypeT*](../../types/other.md#yandex_ai_studio_sdk._types.model.ModelTypeT) ||
|#

# Model

## *class* yandex\_ai\_studio\_sdk.\_chat.text\_embeddings.model.**AsyncChatEmbeddingsModel**{#yandex_ai_studio_sdk._chat.text_embeddings.model.AsyncChatEmbeddingsModel}

*async* **run**(*input*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=180*){#yandex_ai_studio_sdk._chat.text_embeddings.model.AsyncChatEmbeddingsModel.run}

#|
|| Parameters | **input** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) ||
|| Return type | [*ChatEmbeddingsModelResult*](../../types/model_results.md#yandex_ai_studio_sdk._chat.text_embeddings.result.ChatEmbeddingsModelResult) ||
|#

*property* **config**\: *[ConfigTypeT](../../types/other.md#yandex_ai_studio_sdk._types.model_config.ConfigTypeT)*{#yandex_ai_studio_sdk._chat.text_embeddings.model.AsyncChatEmbeddingsModel.config}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *dimensions=Undefined*, *encoding\_format=Undefined*, *extra\_query=Undefined*){#yandex_ai_studio_sdk._chat.text_embeddings.model.AsyncChatEmbeddingsModel.configure}

#|
|| Parameters | 

- **dimensions** ([*UndefinedOr*](../../types/other.md#yandex_ai_studio_sdk._types.misc.UndefinedOr)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*]*)
- **encoding\_format** ([*UndefinedOr*](../../types/other.md#yandex_ai_studio_sdk._types.misc.UndefinedOr)*[*[*EncodingFormatType*](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._chat.text_embeddings.config.EncodingFormatType)*]*)
- **extra\_query** ([*UndefinedOr*](../../types/other.md#yandex_ai_studio_sdk._types.misc.UndefinedOr)*[*[*QueryType*](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._chat.completions.config.QueryType)*]*) ||
|| Return type | Self ||
|#

*property* **fine\_tuned**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._chat.text_embeddings.model.AsyncChatEmbeddingsModel.fine_tuned}

*property* **name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._chat.text_embeddings.model.AsyncChatEmbeddingsModel.name}

*property* **owner**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._chat.text_embeddings.model.AsyncChatEmbeddingsModel.owner}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._chat.text_embeddings.model.AsyncChatEmbeddingsModel.uri}

*property* **version**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._chat.text_embeddings.model.AsyncChatEmbeddingsModel.version}