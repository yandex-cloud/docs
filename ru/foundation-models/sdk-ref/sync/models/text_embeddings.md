---
sourcePath: en/_sdk-ref/sdk-ref/sync/models/text_embeddings.md
---
# Domain

## *class* yandex\_cloud\_ml\_sdk.\_models.text\_embeddings.function.**TextEmbeddings**{#yandex_cloud_ml_sdk._models.text_embeddings.function.TextEmbeddings}

A class for text embeddings models.

It provides the functionality to call a text embeddings model either by a well-known name or a full URI.

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_cloud_ml_sdk._models.text_embeddings.function.TextEmbeddings.__call__i}

Call the specified model for text embeddings. It returns an instance of the specified type of the model.

This method constructs the URI for the model based on the provided name and version. If the name contains **\://**, it is treated as a full URI. Otherwise, it looks up the model name in the well-known names dictionary. But after this, in any case, we construct a URI in the form **emb://<folder\_id>/<model>/<version>**.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the name or URI of the model to call.
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the version of the model to use. Defaults to ‘latest’. ||
|#

# Model

## *class* yandex\_cloud\_ml\_sdk.\_models.text\_embeddings.model.**TextEmbeddingsModel**{#yandex_cloud_ml_sdk._models.text_embeddings.model.TextEmbeddingsModel}

A class for text embeddings models, providing configuration, request creation, and execution functionalities.

**run**(*text*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._models.text_embeddings.model.TextEmbeddingsModel.run}

Run the model to generate text embeddings.

#|
|| Parameters | 

- **text** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the input text for which embeddings are to be generated.
- **timeout** – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*TextEmbeddingsModelResult*](../../types/model_results.md#yandex_cloud_ml_sdk._models.text_embeddings.result.TextEmbeddingsModelResult) ||
|#

**tune\_deferred**(*train\_datasets*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *embeddings\_tune\_type*, *validation\_datasets=Undefined*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *seed=Undefined*, *lr=Undefined*, *n\_samples=Undefined*, *additional\_arguments=Undefined*, *dimensions=Undefined*, *tuning\_type=Undefined*, *scheduler=Undefined*, *optimizer=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._models.text_embeddings.model.TextEmbeddingsModel.tune_deferred}

Initiate a deferred tuning process for the model.

#|
|| Parameters | 

- **train\_datasets** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)* \| *[*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*, *[*float*](https://docs.python.org/3/library/functions.html#float)*] **\| *[*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)* \| *[*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*, *[*float*](https://docs.python.org/3/library/functions.html#float)*]**] **\| *[*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*, *[*float*](https://docs.python.org/3/library/functions.html#float)*]*) – the dataset objects and/or dataset ids used for training of the model.
- **embeddings\_tune\_type** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[**'pair'**, **'triplet'**]*) – the type of tuning to be applied (e.g. pair or triplet).
- **validation\_datasets** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)* \| *[*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*, *[*float*](https://docs.python.org/3/library/functions.html#float)*] **\| *[*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)* \| *[*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*, *[*float*](https://docs.python.org/3/library/functions.html#float)*]**] **\| *[*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*, *[*float*](https://docs.python.org/3/library/functions.html#float)*] **\| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the dataset objects and/or dataset ids used for validation of the model.
- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the name of the tuning task.
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the description of the tuning task.
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*, *[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] **\| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – labels for the tuning task.
- **seed** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a random seed for reproducibility.
- **lr** ([*float*](https://docs.python.org/3/library/functions.html#float)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a learning rate for tuning.
- **n\_samples** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a number of samples for tuning.
- **additional\_arguments** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – additional arguments for tuning.
- **dimensions** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*] **\| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – dimensions for the embeddings.
- **tuning\_type** ([*BaseTuningType*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.tuning_types.BaseTuningType)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a type of tuning to be applied.
- **scheduler** ([*BaseScheduler*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.schedulers.BaseScheduler)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a scheduler for tuning.
- **optimizer** ([*BaseOptimizer*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.optimizers.BaseOptimizer)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – an optimizer for tuning.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*TuningTask*](../../types/tuning.md#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask)[[*TextEmbeddingsModel*](#yandex_cloud_ml_sdk._models.text_embeddings.model.TextEmbeddingsModel)] ||
|#

**tune**(*train\_datasets*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *embeddings\_tune\_type*, *validation\_datasets=Undefined*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *seed=Undefined*, *lr=Undefined*, *n\_samples=Undefined*, *additional\_arguments=Undefined*, *dimensions=Undefined*, *tuning\_type=Undefined*, *scheduler=Undefined*, *optimizer=Undefined*, *timeout=60*, *poll\_timeout=259200*, *poll\_interval=60*){#yandex_cloud_ml_sdk._models.text_embeddings.model.TextEmbeddingsModel.tune}

Tune the model with the specified training datasets and parameters.

#|
|| Parameters | 

- **train\_datasets** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)* \| *[*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*, *[*float*](https://docs.python.org/3/library/functions.html#float)*] **\| *[*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)* \| *[*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*, *[*float*](https://docs.python.org/3/library/functions.html#float)*]**] **\| *[*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*, *[*float*](https://docs.python.org/3/library/functions.html#float)*]*) – the dataset objects and/or dataset ids used for training of the model.
- **embeddings\_tune\_type** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[**'pair'**, **'triplet'**]*) – the type of tuning to be applied (e.g. pair or triplet).
- **validation\_datasets** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)* \| *[*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*, *[*float*](https://docs.python.org/3/library/functions.html#float)*] **\| *[*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)* \| *[*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*, *[*float*](https://docs.python.org/3/library/functions.html#float)*]**] **\| *[*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*, *[*float*](https://docs.python.org/3/library/functions.html#float)*] **\| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the dataset objects and/or dataset ids used for validation of the model.
- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the name of the tuning task.
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the description of the tuning task.
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*, *[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] **\| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – labels for the tuning task.
- **seed** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a random seed for reproducibility.
- **lr** ([*float*](https://docs.python.org/3/library/functions.html#float)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a learning rate for tuning.
- **n\_samples** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a number of samples for tuning.
- **additional\_arguments** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – additional arguments for tuning.
- **dimensions** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*] **\| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – dimensions for the embeddings.
- **tuning\_type** ([*BaseTuningType*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.tuning_types.BaseTuningType)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a type of tuning to be applied.
- **scheduler** ([*BaseScheduler*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.schedulers.BaseScheduler)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a scheduler for tuning.
- **optimizer** ([*BaseOptimizer*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.optimizers.BaseOptimizer)* \| *[*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – an optimizer for tuning.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds.
- **poll\_timeout** ([*int*](https://docs.python.org/3/library/functions.html#int)) – the maximum time to wait while polling for completion of the tuning task. Defaults to 259200 seconds (72 hours).
- **poll\_interval** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the interval between polling attempts during the tuning process. Defaults to 60 seconds. ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**attach\_tune\_deferred**(*task\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._models.text_embeddings.model.TextEmbeddingsModel.attach_tune_deferred}

Attach a deferred tuning task using its task ID.

#|
|| Parameters | 

- **task\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the ID of the deferred tuning task to attach to.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*TuningTask*](../../types/tuning.md#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask)[[*TextEmbeddingsModel*](#yandex_cloud_ml_sdk._models.text_embeddings.model.TextEmbeddingsModel)] ||
|#

*property* **config**\: *[ConfigTypeT](../../types/other.md#yandex_cloud_ml_sdk._types.model.ConfigTypeT)*{#yandex_cloud_ml_sdk._models.text_embeddings.model.TextEmbeddingsModel.config}

**configure**(){#yandex_cloud_ml_sdk._models.text_embeddings.model.TextEmbeddingsModel.configure}

This method calls the parent class’s configure method and returns the configured model instance.

#|
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._models.text_embeddings.model.TextEmbeddingsModel.uri}