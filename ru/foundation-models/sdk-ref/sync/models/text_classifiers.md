---
sourcePath: en/_sdk-ref/sdk-ref/sync/models/text_classifiers.md
---
# Domain

## *class* yandex\_cloud\_ml\_sdk.\_models.text\_classifiers.function.**TextClassifiers**{#yandex_cloud_ml_sdk._models.text_classifiers.function.TextClassifiers}

A class for text classifiers.

It provides a common interface for text classification models and constructs the model URI based on the provided model name and version.

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_cloud_ml_sdk._models.text_classifiers.function.TextClassifiers.__call__i}

Call the text classification model.

Constructs the URI for the model based on the provided model’s name and version. If the name contains **\://**, it is treated as a complete URI. Otherwise, it looks up the model name in the well-known names dictionary. But after this, in any case, we construct a URI in the form **cls://<folder\_id>/<model>/<version>**.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the name or URI of the model to call.
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the version of the model to be used. Defaults to ‘latest’. ||
|#

# Model

## *class* yandex\_cloud\_ml\_sdk.\_models.text\_classifiers.model.**TextClassifiersModel**{#yandex_cloud_ml_sdk._models.text_classifiers.model.TextClassifiersModel}

A class for text classifiers models. It provides the foundational structure for building text classification models, including configuration and execution of classification tasks.

**run**(*text*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._models.text_classifiers.model.TextClassifiersModel.run}

Execute the text classification on the provided input text.

If only labels are specified, apply a zero-shot classifier. If samples are also specified - it is a case of the few-shot classifier. If nothing is specified, use the classify method, but it is only available for pre-trained models.

Read more about the classifiers in [the documentation](https://yandex.cloud/docs/foundation-models/concepts/classifier/).

#|
|| Parameters | 

- **text** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the input text to classify.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*TextClassifiersModelResultBase*](../../types/model_results.md#yandex_cloud_ml_sdk._models.text_classifiers.result.TextClassifiersModelResultBase) ||
|#

**tune\_deferred**(*train\_datasets*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *classification\_type*, *validation\_datasets=Undefined*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *seed=Undefined*, *lr=Undefined*, *n\_samples=Undefined*, *additional\_arguments=Undefined*, *tuning\_type=Undefined*, *scheduler=Undefined*, *optimizer=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._models.text_classifiers.model.TextClassifiersModel.tune_deferred}

Initiate a deferred tuning process for the model.

#|
|| Parameters | 

- **train\_datasets** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset) *\|* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*] \|* [*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset) *\|* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*]] \|* [*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*]*) – the dataset objects and/or dataset ids used for training of the model.
- **validation\_datasets** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset) *\|* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*] \|* [*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset) *\|* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*]] \|* [*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*] \|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the dataset objects and/or dataset ids used for validation of the model.
- **classification\_type** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['multilabel', 'multiclass', 'binary']*) – the type of classification to perform during tuning (multilabel, multiclass, or binary).
- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the name of the tuning task.
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the description of the tuning task.
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – labels for the tuning task.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds.
- **seed** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a random seed for reproducibility.
- **lr** ([*float*](https://docs.python.org/3/library/functions.html#float) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a learning rate for tuning.
- **n\_samples** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a number of samples for tuning.
- **additional\_arguments** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – additional arguments for tuning.
- **tuning\_type** ([*BaseTuningType*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.tuning_types.BaseTuningType) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a type of tuning to be applied.
- **scheduler** ([*BaseScheduler*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.schedulers.BaseScheduler) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a scheduler for tuning.
- **optimizer** ([*BaseOptimizer*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.optimizers.BaseOptimizer) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – an optimizer for tuning. ||
|| Return type | [*TuningTask*](../../types/tuning.md#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask)[[*TextClassifiersModel*](#yandex_cloud_ml_sdk._models.text_classifiers.model.TextClassifiersModel)] ||
|#

**tune**(*train\_datasets*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *classification\_type*, *validation\_datasets=Undefined*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *seed=Undefined*, *lr=Undefined*, *n\_samples=Undefined*, *additional\_arguments=Undefined*, *tuning\_type=Undefined*, *scheduler=Undefined*, *optimizer=Undefined*, *timeout=60*, *poll\_timeout=259200*, *poll\_interval=60*){#yandex_cloud_ml_sdk._models.text_classifiers.model.TextClassifiersModel.tune}

Tune the model with the specified training datasets and parameters.

#|
|| Parameters | 

- **train\_datasets** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset) *\|* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*] \|* [*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset) *\|* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*]] \|* [*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*]*) – the dataset objects and/or dataset ids used for training of the model.
- **validation\_datasets** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset) *\|* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*] \|* [*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset) *\|* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*]] \|* [*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*] \|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the dataset objects and/or dataset ids used for validation of the model.
- **classification\_type** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['multilabel', 'multiclass', 'binary']*) – the type of classification to perform during tuning (multilabel, multiclass, or binary).
- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the name of the tuning task.
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the description of the tuning task.
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – labels for the tuning task.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds.
- **seed** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a random seed for reproducibility.
- **lr** ([*float*](https://docs.python.org/3/library/functions.html#float) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a learning rate for tuning.
- **n\_samples** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a number of samples for tuning.
- **additional\_arguments** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – additional arguments for tuning.
- **tuning\_type** ([*BaseTuningType*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.tuning_types.BaseTuningType) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a type of tuning to be applied.
- **scheduler** ([*BaseScheduler*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.schedulers.BaseScheduler) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a scheduler for tuning.
- **optimizer** ([*BaseOptimizer*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.optimizers.BaseOptimizer) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – an optimizer for tuning.
- **poll\_timeout** ([*int*](https://docs.python.org/3/library/functions.html#int)) – the maximum time to wait while polling for completion of the tuning task. Defaults to 259200 seconds (72 hours).
- **poll\_interval** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the interval between polling attempts during the tuning process. Defaults to 60 seconds. ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**attach\_tune\_deferred**(*task\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._models.text_classifiers.model.TextClassifiersModel.attach_tune_deferred}

Attach a deferred tuning task using its task ID.

#|
|| Parameters | 

- **task\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the ID of the deferred tuning task to attach to.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*TuningTask*](../../types/tuning.md#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask)[[*TextClassifiersModel*](#yandex_cloud_ml_sdk._models.text_classifiers.model.TextClassifiersModel)] ||
|#

*property* **config**\: *[ConfigTypeT](../../types/other.md#yandex_cloud_ml_sdk._types.model.ConfigTypeT)*{#yandex_cloud_ml_sdk._models.text_classifiers.model.TextClassifiersModel.config}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *task\_description=Undefined*, *labels=Undefined*, *samples=Undefined*){#yandex_cloud_ml_sdk._models.text_classifiers.model.TextClassifiersModel.configure}

#|
|| Parameters | 

- **task\_description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **labels** ([*Sequence*](https://docs.python.org/3/library/typing.html#typing.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **samples** ([*Sequence*](https://docs.python.org/3/library/typing.html#typing.Sequence)*[*[*TextClassificationSample*](../../types/model_results.md#yandex_cloud_ml_sdk._models.text_classifiers.types.TextClassificationSample)*] \|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._models.text_classifiers.model.TextClassifiersModel.uri}