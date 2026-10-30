# Domain

## *class* yandex\_ai\_studio\_sdk.\_chat.text\_embeddings.function.**ChatEmbeddings**{#yandex_ai_studio_sdk._chat.text_embeddings.function.ChatEmbeddings}

Access text embeddings models through the OpenAI-compatible API.

See the [available models and URI formats](https://aistudio.yandex.ru/docs/ai-studio/concepts/embeddings#yandexgpt-embeddings) and the [embeddings search example](https://aistudio.yandex.ru/docs/ai-studio/concepts/embeddings#example) in the AI Studio documentation.

**list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *filters=None*){#yandex_ai_studio_sdk._chat.text_embeddings.function.ChatEmbeddings.list}

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/builtins/functions.html#float))
- **filters** ([*ModelFilter*](../../types/other.md#yandex_ai_studio_sdk._chat.utils.ModelFilter) *\| None*) ||
|| Return type | [tuple](https://docs.python.org/3/builtins/stdtypes.html#tuple)[[*ChatEmbeddingsModel*](#yandex_ai_studio_sdk._chat.text_embeddings.model.ChatEmbeddingsModel), …] ||
|#

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_ai_studio_sdk._chat.text_embeddings.function.ChatEmbeddings.__call__i}

Create a model instance in the selected chat subdomain (completions, embeddings, etc)

Constructs the model URI based on the provided name and version. If the name contains ‘://’, it is treated as a full URI. Otherwise constructs a URI in the form **<prefix>://<folder\_id>/<model>/<version>**, using **gpt** for completions and **emb** for embeddings.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/builtins/stdtypes.html#str)) – The name or URI of the model.
- **model\_version** ([*str*](https://docs.python.org/3/builtins/stdtypes.html#str)) – The version of the model to use. Defaults to ‘latest’. ||
|| Return type | [*ModelTypeT*](../../types/other.md#yandex_ai_studio_sdk._types.model.ModelTypeT) ||
|#

# Model

## *class* yandex\_ai\_studio\_sdk.\_chat.text\_embeddings.model.**ChatEmbeddingsModel**{#yandex_ai_studio_sdk._chat.text_embeddings.model.ChatEmbeddingsModel}

**run**(*input*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=180*){#yandex_ai_studio_sdk._chat.text_embeddings.model.ChatEmbeddingsModel.run}

#|
|| Parameters | **input** ([*str*](https://docs.python.org/3/builtins/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/builtins/stdtypes.html#str)*]*) ||
|| Return type | [*ChatEmbeddingsModelResult*](../../types/model_results.md#yandex_ai_studio_sdk._chat.text_embeddings.result.ChatEmbeddingsModelResult) ||
|#

*property* **config**\: *[ConfigTypeT](../../types/other.md#yandex_ai_studio_sdk._types.model_config.ConfigTypeT)*{#yandex_ai_studio_sdk._chat.text_embeddings.model.ChatEmbeddingsModel.config}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *dimensions=Undefined*, *encoding\_format=Undefined*, *extra\_query=Undefined*){#yandex_ai_studio_sdk._chat.text_embeddings.model.ChatEmbeddingsModel.configure}

#|
|| Parameters | 

- **dimensions** ([*UndefinedOr*](../../types/other.md#yandex_ai_studio_sdk._types.misc.UndefinedOr)*[*[*int*](https://docs.python.org/3/builtins/functions.html#int)*]*)
- **encoding\_format** ([*UndefinedOr*](../../types/other.md#yandex_ai_studio_sdk._types.misc.UndefinedOr)*[*[*EncodingFormatType*](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._chat.text_embeddings.config.EncodingFormatType)*]*)
- **extra\_query** ([*UndefinedOr*](../../types/other.md#yandex_ai_studio_sdk._types.misc.UndefinedOr)*[*[*QueryType*](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._chat.completions.config.QueryType)*]*) ||
|| Return type | Self ||
|#

*property* **fine\_tuned**\: *[bool](https://docs.python.org/3/builtins/functions.html#bool) | [None](https://docs.python.org/3/builtins/constants.html#None)*{#yandex_ai_studio_sdk._chat.text_embeddings.model.ChatEmbeddingsModel.fine_tuned}

*property* **name**\: *[str](https://docs.python.org/3/builtins/stdtypes.html#str) | [None](https://docs.python.org/3/builtins/constants.html#None)*{#yandex_ai_studio_sdk._chat.text_embeddings.model.ChatEmbeddingsModel.name}

*property* **owner**\: *[str](https://docs.python.org/3/builtins/stdtypes.html#str) | [None](https://docs.python.org/3/builtins/constants.html#None)*{#yandex_ai_studio_sdk._chat.text_embeddings.model.ChatEmbeddingsModel.owner}

*property* **uri**\: *[str](https://docs.python.org/3/builtins/stdtypes.html#str)*{#yandex_ai_studio_sdk._chat.text_embeddings.model.ChatEmbeddingsModel.uri}

*property* **version**\: *[str](https://docs.python.org/3/builtins/stdtypes.html#str) | [None](https://docs.python.org/3/builtins/constants.html#None)*{#yandex_ai_studio_sdk._chat.text_embeddings.model.ChatEmbeddingsModel.version}