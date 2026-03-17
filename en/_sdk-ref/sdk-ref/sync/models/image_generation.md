# Domain

## *class* yandex\_ai\_studio\_sdk.\_models.image\_generation.function.**ImageGeneration**{#yandex_ai_studio_sdk._models.image_generation.function.ImageGeneration}

A class for image generation models.

It provides the functionality to call an image generation model by constructing the appropriate URI based on the provided model name and version.

Returns a model’s object through which requests to the backend are made.

```python
>>> model = sdk.models.image_generation('yandex-art')  # this is how the model is created
```

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_ai_studio_sdk._models.image_generation.function.ImageGeneration.__call__i}

Call the image generation model with the specified name and version.

Constructs the URI for the model based on the provided model’s name and version. If the name contains **\://**, it is treated as a complete URI. Otherwise, it looks up the model name in the well-known names dictionary. But after this, in any case, we construct a URI in the form **art://<folder\_id>/<model>/<version>**.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the name or URI of the model to call.
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the version of the model to use. Defaults to ‘latest’. ||
|| Return type | [*ModelTypeT*](../../types/other.md#yandex_ai_studio_sdk._types.model.ModelTypeT) ||
|#

# Model

## *class* yandex\_ai\_studio\_sdk.\_models.image\_generation.model.**ImageGenerationModel**{#yandex_ai_studio_sdk._models.image_generation.model.ImageGenerationModel}

A class of the one, concrete model. This model encapsulates the URI and configuration.

**run\_deferred**(*messages*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_ai_studio_sdk._models.image_generation.model.ImageGenerationModel.run_deferred}

Executes the image generation operation asynchronously and returns an operation representing the ongoing image generation process.

#|
|| Parameters | 

- **messages** ([*ImageMessage*](../../types/message.md#yandex_ai_studio_sdk._models.image_generation.message.ImageMessage) *\|* [*ImageMessageDict*](../../types/message.md#yandex_ai_studio_sdk._models.image_generation.message.ImageMessageDict) *\|* [*TextMessage*](../../types/message.md#yandex_ai_studio_sdk._types.message.TextMessage) *\|* [*AnyMessage*](../../types/message.md#yandex_ai_studio_sdk._models.image_generation.message.AnyMessage) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*ImageMessage*](../../types/message.md#yandex_ai_studio_sdk._models.image_generation.message.ImageMessage) *\|* [*ImageMessageDict*](../../types/message.md#yandex_ai_studio_sdk._models.image_generation.message.ImageMessageDict) *\|* [*TextMessage*](../../types/message.md#yandex_ai_studio_sdk._types.message.TextMessage) *\|* [*AnyMessage*](../../types/message.md#yandex_ai_studio_sdk._models.image_generation.message.AnyMessage) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – the input messages for image generation.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*Operation*](../../types/operation.md#yandex_ai_studio_sdk._types.operation.Operation)[[*ImageGenerationModelResult*](../../types/model_results.md#yandex_ai_studio_sdk._models.image_generation.result.ImageGenerationModelResult)] ||
|#

**attach\_deferred**(*operation\_id*, *timeout=60*){#yandex_ai_studio_sdk._models.image_generation.model.ImageGenerationModel.attach_deferred}

Attaches to an ongoing image generation operation.

#|
|| Parameters | 

- **operation\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the ID of the operation to attach to.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*Operation*](../../types/operation.md#yandex_ai_studio_sdk._types.operation.Operation)[[*ImageGenerationModelResult*](../../types/model_results.md#yandex_ai_studio_sdk._models.image_generation.result.ImageGenerationModelResult)] ||
|#

*property* **config**\: *[ConfigTypeT](../../types/other.md#yandex_ai_studio_sdk._types.model_config.ConfigTypeT)*{#yandex_ai_studio_sdk._models.image_generation.model.ImageGenerationModel.config}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *seed=Undefined*, *width\_ratio=Undefined*, *height\_ratio=Undefined*, *mime\_type=Undefined*){#yandex_ai_studio_sdk._models.image_generation.model.ImageGenerationModel.configure}

Configures the image generation model with specified parameters and returns the configured instance of the model.

#|
|| Parameters | 

- **seed** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – a random seed for generation.
- **width\_ratio** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – the width ratio for the generated image.
- **height\_ratio** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – the height ratio for the generated image.
- **mime\_type** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – the MIME type of the generated image. Read more on what MIME types exist in [the documentation](https://yandex.cloud/docs/foundation-models/image-generation/api-ref/ImageGenerationAsync/generate). ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*property* **fine\_tuned**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._models.image_generation.model.ImageGenerationModel.fine_tuned}

*property* **name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._models.image_generation.model.ImageGenerationModel.name}

*property* **owner**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._models.image_generation.model.ImageGenerationModel.owner}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._models.image_generation.model.ImageGenerationModel.uri}

*property* **version**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._models.image_generation.model.ImageGenerationModel.version}