---
sourcePath: en/_sdk-ref/sdk-ref/sync/models/completions.md
---
# Domain

## *class* yandex\_cloud\_ml\_sdk.\_models.completions.function.**Completions**{#yandex_cloud_ml_sdk._models.completions.function.Completions}

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_cloud_ml_sdk._models.completions.function.Completions.__call__i}

Create a model object to call for generating completions.

This method constructs the URI for the model based on the provided name and version. If the name contains **\://**, it is treated as a full URI. Otherwise, it looks up the model name in the well-known names dictionary. But after this, in any case, we construct a URI in the form **gpt://<folder\_id>/<model>/<version>**.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the name or URI of the model to call.
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the version of the model to use. Defaults to ‘latest’. ||
|| Return type | [*ModelTypeT*](../../types/other.md#yandex_cloud_ml_sdk._types.model.ModelTypeT) ||
|#

# Model

## *class* yandex\_cloud\_ml\_sdk.\_models.completions.model.**GPTModel**{#yandex_cloud_ml_sdk._models.completions.model.GPTModel}

A class for GPT models providing various functionalities including tuning, and batch processing.

**run**(*messages*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=180*){#yandex_cloud_ml_sdk._models.completions.model.GPTModel.run}

Executes the model with the provided messages.

#|
|| Parameters | 

- **messages** ([*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict)*]*) – the input messages to process. Could be a string, a dictionary, or a result object. Read more about other possible message types in the [corresponding documentation](https://yandex.cloud/docs/foundation-models/sdk/#usage).
- **timeout** – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*GPTModelResult*](../../types/model_results.md#yandex_cloud_ml_sdk._models.completions.result.GPTModelResult)[[*ToolCall*](../tools.md#yandex_cloud_ml_sdk._tools.tool_call.ToolCall)] ||
|#

**run\_stream**(*messages*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=180*){#yandex_cloud_ml_sdk._models.completions.model.GPTModel.run_stream}

Executes the model with the provided messages and yields partial results as they become available.

#|
|| Parameters | 

- **messages** ([*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict)*]*) – the input messages to process.
- **timeout** – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*Iterator*](https://docs.python.org/3/library/typing.html#typing.Iterator)[[*GPTModelResult*](../../types/model_results.md#yandex_cloud_ml_sdk._models.completions.result.GPTModelResult)[[*ToolCall*](../tools.md#yandex_cloud_ml_sdk._tools.tool_call.ToolCall)]] ||
|#

**run\_deferred**(*messages*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._models.completions.model.GPTModel.run_deferred}

Initiates a deferred execution of the model with the provided messages.

#|
|| Parameters | 

- **messages** ([*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict)*]*) – the input messages to process.
- **timeout** – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*Operation*](../../types/operation.md#yandex_cloud_ml_sdk._types.operation.Operation)[[*GPTModelResult*](../../types/model_results.md#yandex_cloud_ml_sdk._models.completions.result.GPTModelResult)[[*ToolCall*](../tools.md#yandex_cloud_ml_sdk._tools.tool_call.ToolCall)]] ||
|#

**attach\_deferred**(*operation\_id*, *timeout=60*){#yandex_cloud_ml_sdk._models.completions.model.GPTModel.attach_deferred}

Attaches to an ongoing deferred operation using its operation id.

#|
|| Parameters | 

- **operation\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the id of the deferred operation to attach to.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*Operation*](../../types/operation.md#yandex_cloud_ml_sdk._types.operation.Operation)[[*GPTModelResult*](../../types/model_results.md#yandex_cloud_ml_sdk._models.completions.result.GPTModelResult)[[*ToolCall*](../tools.md#yandex_cloud_ml_sdk._tools.tool_call.ToolCall)]] ||
|#

**tokenize**(*messages*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._models.completions.model.GPTModel.tokenize}

Tokenizes the provided messages into a tuple of tokens.

#|
|| Parameters | 

- **messages** ([*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*TextMessage*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessage) *\|* [*TextMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageDict) *\|* [*TextMessageProtocol*](../../types/message.md#yandex_cloud_ml_sdk._types.message.TextMessageProtocol) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*FunctionResultMessageDict*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.message.FunctionResultMessageDict)*]*) – the input messages to tokenize.
- **timeout** – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[*Token*](../../types/message.md#yandex_cloud_ml_sdk._models.completions.token.Token), …] ||
|#

**tune\_deferred**(*train\_datasets*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *validation\_datasets=Undefined*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *seed=Undefined*, *lr=Undefined*, *n\_samples=Undefined*, *additional\_arguments=Undefined*, *tuning\_type=Undefined*, *scheduler=Undefined*, *optimizer=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._models.completions.model.GPTModel.tune_deferred}

Initiate a deferred tuning process for the model.

#|
|| Parameters | 

- **train\_datasets** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset) *\|* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*] \|* [*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset) *\|* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*]] \|* [*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*]*) – the dataset objects and/or dataset ids used for training of the model.
- **validation\_datasets** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset) *\|* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*] \|* [*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset) *\|* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*]] \|* [*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*] \|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the dataset objects and/or dataset ids used for validation of the model.
- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the name of the tuning task.
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the description of the tuning task.
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – labels for the tuning task.
- **seed** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a random seed for reproducibility.
- **lr** ([*float*](https://docs.python.org/3/library/functions.html#float) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a learning rate for tuning.
- **n\_samples** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a number of samples for tuning.
- **additional\_arguments** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – additional arguments for tuning.
- **tuning\_type** ([*BaseTuningType*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.tuning_types.BaseTuningType) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a type of tuning to be applied.
- **scheduler** ([*BaseScheduler*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.schedulers.BaseScheduler) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a scheduler for tuning.
- **optimizer** ([*BaseOptimizer*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.optimizers.BaseOptimizer) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – an optimizer for tuning.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*TuningTask*](../../types/tuning.md#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask)[[*GPTModel*](#yandex_cloud_ml_sdk._models.completions.model.GPTModel)] ||
|#

**tune**(*train\_datasets*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *validation\_datasets=Undefined*, *name=Undefined*, *description=Undefined*, *labels=Undefined*, *seed=Undefined*, *lr=Undefined*, *n\_samples=Undefined*, *additional\_arguments=Undefined*, *tuning\_type=Undefined*, *scheduler=Undefined*, *optimizer=Undefined*, *timeout=60*, *poll\_timeout=259200*, *poll\_interval=60*){#yandex_cloud_ml_sdk._models.completions.model.GPTModel.tune}

Tune the model with the specified training datasets and parameters.

#|
|| Parameters | 

- **train\_datasets** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset) *\|* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*] \|* [*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset) *\|* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*]] \|* [*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*]*) – the dataset objects and/or dataset ids used for training of the model.
- **validation\_datasets** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset) *\|* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*] \|* [*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset) *\|* [*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*]] \|* [*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseDataset*](../../internals/bases.md#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*] \|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the dataset objects and/or dataset ids used for validation of the model.
- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the name of the tuning task.
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the description of the tuning task.
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – labels for the tuning task.
- **seed** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a random seed for reproducibility.
- **lr** ([*float*](https://docs.python.org/3/library/functions.html#float) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a learning rate for tuning.
- **n\_samples** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a number of samples for tuning.
- **additional\_arguments** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – additional arguments for tuning.
- **tuning\_type** ([*BaseTuningType*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.tuning_types.BaseTuningType) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a type of tuning to be applied.
- **scheduler** ([*BaseScheduler*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.schedulers.BaseScheduler) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a scheduler for tuning.
- **optimizer** ([*BaseOptimizer*](../../types/tuning.md#yandex_cloud_ml_sdk._types.tuning.optimizers.BaseOptimizer) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – an optimizer for tuning.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds.
- **poll\_timeout** ([*int*](https://docs.python.org/3/library/functions.html#int)) – the maximum time to wait while polling for completion of the tuning task. Defaults to 259200 seconds (72 hours).
- **poll\_interval** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the interval between polling attempts during the tuning process. Defaults to 60 seconds. ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**attach\_tune\_deferred**(*task\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._models.completions.model.GPTModel.attach_tune_deferred}

Attach a deferred tuning task using its task id.

#|
|| Parameters | 

- **task\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the id of the deferred tuning task to attach to.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*TuningTask*](../../types/tuning.md#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask)[[*GPTModel*](#yandex_cloud_ml_sdk._models.completions.model.GPTModel)] ||
|#

*property* **batch**\: *[BatchSubdomainTypeT](../../types/other.md#yandex_cloud_ml_sdk._types.batch.domain.BatchSubdomainTypeT)*{#yandex_cloud_ml_sdk._models.completions.model.GPTModel.batch}

*property* **config**\: *[ConfigTypeT](../../types/other.md#yandex_cloud_ml_sdk._types.model.ConfigTypeT)*{#yandex_cloud_ml_sdk._models.completions.model.GPTModel.config}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *temperature=Undefined*, *max\_tokens=Undefined*, *reasoning\_mode=Undefined*, *response\_format=Undefined*, *tools=Undefined*, *parallel\_tool\_calls=Undefined*, *tool\_choice=Undefined*){#yandex_cloud_ml_sdk._models.completions.model.GPTModel.configure}

Configures the model with specified parameters.

#|
|| Parameters | 

- **temperature** ([*float*](https://docs.python.org/3/library/functions.html#float) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a sampling temperature to use - higher values mean more random results. Should be a double number between 0 (inclusive) and 1 (inclusive).
- **max\_tokens** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a maximum number of tokens to generate in the response.
- **reasoning\_mode** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*ReasoningMode*](../../types/other.md#yandex_cloud_ml_sdk._models.completions.config.ReasoningMode) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the mode of reasoning to apply during generation, allowing the model to perform internal reasoning before responding. Read more about possible modes in the [reasoning documentation](https://yandex.cloud/docs/foundation-models/text-generation/api-ref/TextGeneration/completion#yandex.cloud.ai.foundation_models.v1.ReasoningOptions).
- **response\_format** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['json'] \| ~yandex\_cloud\_ml\_sdk.\_types.schemas.JsonSchemaResponseType \| type \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) – a format of the response returned by the model. Could be a JsonSchema, a JSON string, or a pydantic model. Read more about possible response formats in the [structured output documentation](https://yandex.cloud/docs/foundation-models/concepts/yandexgpt/#structured-output).
- **tools** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*FunctionTool*](../../types/tools.md#yandex_cloud_ml_sdk._tools.tool.FunctionTool)*] \|* [*FunctionTool*](../../types/tools.md#yandex_cloud_ml_sdk._tools.tool.FunctionTool) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – tools to use for completion. Can be a sequence or a single tool.
- **parallel\_tool\_calls** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – whether to allow parallel calls to tools during completion. Defaults to **true**.
- **tool\_choice** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['none', 'None', 'NONE', 'auto', 'Auto', 'AUTO', 'required', 'Required', 'REQUIRED'] \| ~yandex\_cloud\_ml\_sdk.\_types.tools.function.FunctionDictType \| ~yandex\_cloud\_ml\_sdk.\_tools.tool.FunctionTool \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) – the strategy for choosing tools. There are several ways to configure **tool\_choice** for query processing: - no tools to call (tool\_choice=``’none’**); - required to call any tool (tool\_choice=**’required’**); - call a specific tool (tool\_choice=``{'type': 'function', 'function': {'name': 'another\_calculator'}}** or directly passing a tool object). ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**langchain**(*model\_type='chat'*, *timeout=60*){#yandex_cloud_ml_sdk._models.completions.model.GPTModel.langchain}

Initializes a langchain model based on the specified model type.

#|
|| Parameters | 

- **model\_type** (*Literal['chat']*) – the type of langchain model to initialize. Defaults to **"chat"**.
- **timeout** ([*int*](https://docs.python.org/3/library/functions.html#int)) – the timeout which sets the default for the langchain model object. Defaults to 60 seconds. ||
|| Return type | BaseYandexLanguageModel ||
|#

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._models.completions.model.GPTModel.uri}