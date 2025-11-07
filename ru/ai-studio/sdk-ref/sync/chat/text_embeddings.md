---
sourcePath: en/_sdk-ref/sdk-ref/sync/chat/text_embeddings.md
---
# Domain

## *class* yandex\_cloud\_ml\_sdk.\_chat.text\_embeddings.function.**ChatEmbeddings**{#yandex_cloud_ml_sdk._chat.text_embeddings.function.ChatEmbeddings}

**list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._chat.text_embeddings.function.ChatEmbeddings.list}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[*ChatEmbeddingsModel*](#yandex_cloud_ml_sdk._chat.text_embeddings.model.ChatEmbeddingsModel), …] ||
|#

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_cloud_ml_sdk._chat.text_embeddings.function.ChatEmbeddings.__call__i}

Create a model instance in selected chat subdomain (completions, embeddings, etc)

Constructs the model URI based on the provided name and version. If the name contains ‘://’, it is treated as a full URI. Otherwise constructs a URI in the form ‘gpt://<folder\_id>/<model>/<version>’.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – The name or URI of the model.
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – The version of the model to use. Defaults to ‘latest’. ||
|| Return type | [*ModelTypeT*](../../types/other.md#yandex_cloud_ml_sdk._types.model.ModelTypeT) ||
|#

# Model

## *class* yandex\_cloud\_ml\_sdk.\_chat.text\_embeddings.model.**ChatEmbeddingsModel**{#yandex_cloud_ml_sdk._chat.text_embeddings.model.ChatEmbeddingsModel}

**run**(*input*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=180*){#yandex_cloud_ml_sdk._chat.text_embeddings.model.ChatEmbeddingsModel.run}

#|
|| Parameters | **input** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) ||
|| Return type | [*ChatEmbeddingsModelResult*](../../types/model_results.md#yandex_cloud_ml_sdk._chat.text_embeddings.result.ChatEmbeddingsModelResult) ||
|#

*property* **config**\: *[ConfigTypeT](../../types/other.md#yandex_cloud_ml_sdk._types.model.ConfigTypeT)*{#yandex_cloud_ml_sdk._chat.text_embeddings.model.ChatEmbeddingsModel.config}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *dimensions=Undefined*, *encoding\_format=Undefined*, *extra\_query=Undefined*){#yandex_cloud_ml_sdk._chat.text_embeddings.model.ChatEmbeddingsModel.configure}

#|
|| Parameters | 

- **dimensions** ([*UndefinedOr*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*]*)
- **encoding\_format** ([*UndefinedOr*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*EncodingFormatType*](../../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._chat.text_embeddings.config.EncodingFormatType)*]*)
- **extra\_query** ([*UndefinedOr*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*QueryType*](../../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._chat.completions.config.QueryType)*]*) ||
|| Return type | Self ||
|#

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._chat.text_embeddings.model.ChatEmbeddingsModel.uri}