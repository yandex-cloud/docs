---
sourcePath: en/_sdk-ref/sdk-ref/types/tuning.md
---
# Tuning

## Tuning settings types

### *class* yandex\_cloud\_ml\_sdk.\_types.tuning.tuning\_types.**BaseTuningType**{#yandex_cloud_ml_sdk._types.tuning.tuning_types.BaseTuningType}

### *class* yandex\_cloud\_ml\_sdk.\_types.tuning.tuning\_types.**TuningTypeLora**{#yandex_cloud_ml_sdk._types.tuning.tuning_types.TuningTypeLora}

TuningTypeLora(rank: ‘int | None’ = None, alpha: ‘float | None’ = None, initialization: ‘str | None’ = None, type: ‘str | None’ = None)

**rank**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.tuning.tuning_types.TuningTypeLora.rank}

**alpha**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.tuning.tuning_types.TuningTypeLora.alpha}

**initialization**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.tuning.tuning_types.TuningTypeLora.initialization}

**type**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.tuning.tuning_types.TuningTypeLora.type}

### *class* yandex\_cloud\_ml\_sdk.\_types.tuning.tuning\_types.**TuningTypePromptTune**{#yandex_cloud_ml_sdk._types.tuning.tuning_types.TuningTypePromptTune}

TuningTypePromptTune(virtual\_tokens: ‘int | None’ = None)

**virtual\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.tuning.tuning_types.TuningTypePromptTune.virtual_tokens}

### *class* yandex\_cloud\_ml\_sdk.\_types.tuning.schedulers.**BaseScheduler**{#yandex_cloud_ml_sdk._types.tuning.schedulers.BaseScheduler}

BaseScheduler(warmup\_ratio: ‘float | None’ = None)

**warmup\_ratio**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.tuning.schedulers.BaseScheduler.warmup_ratio}

### *class* yandex\_cloud\_ml\_sdk.\_types.tuning.schedulers.**SchedulerLinear**{#yandex_cloud_ml_sdk._types.tuning.schedulers.SchedulerLinear}

SchedulerLinear(warmup\_ratio: ‘float | None’ = None, min\_lr: ‘float | None’ = None)

**min\_lr**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.tuning.schedulers.SchedulerLinear.min_lr}

**warmup\_ratio**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.tuning.schedulers.SchedulerLinear.warmup_ratio}

### *class* yandex\_cloud\_ml\_sdk.\_types.tuning.schedulers.**SchedulerConstant**{#yandex_cloud_ml_sdk._types.tuning.schedulers.SchedulerConstant}

SchedulerConstant(warmup\_ratio: ‘float | None’ = None)

**warmup\_ratio**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.tuning.schedulers.SchedulerConstant.warmup_ratio}

### *class* yandex\_cloud\_ml\_sdk.\_types.tuning.schedulers.**SchedulerCosine**{#yandex_cloud_ml_sdk._types.tuning.schedulers.SchedulerCosine}

SchedulerCosine(warmup\_ratio: ‘float | None’ = None, min\_lr: ‘float | None’ = None)

**min\_lr**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.tuning.schedulers.SchedulerCosine.min_lr}

**warmup\_ratio**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.tuning.schedulers.SchedulerCosine.warmup_ratio}

### *class* yandex\_cloud\_ml\_sdk.\_types.tuning.optimizers.**BaseOptimizer**{#yandex_cloud_ml_sdk._types.tuning.optimizers.BaseOptimizer}

BaseOptimizer()

### *class* yandex\_cloud\_ml\_sdk.\_types.tuning.optimizers.**OptimizerAdamw**{#yandex_cloud_ml_sdk._types.tuning.optimizers.OptimizerAdamw}

OptimizerAdamw(beta1: ‘float | None’ = None, beta2: ‘float | None’ = None, eps: ‘float | None’ = None, weight\_decay: ‘float | None’ = None)

**beta1**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.tuning.optimizers.OptimizerAdamw.beta1}

**beta2**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.tuning.optimizers.OptimizerAdamw.beta2}

**eps**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.tuning.optimizers.OptimizerAdamw.eps}

**weight\_decay**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._types.tuning.optimizers.OptimizerAdamw.weight_decay}

## Tuning task operation

### *class* yandex\_cloud\_ml\_sdk.\_tuning.tuning\_task.**AsyncTuningTask**{#yandex_cloud_ml_sdk._tuning.tuning_task.AsyncTuningTask}

*async* **get\_task\_info**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._tuning.tuning_task.AsyncTuningTask.get_task_info}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*TuningTaskInfo*](#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo) \| None ||
|#

*async* **get\_metrics\_url**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._tuning.tuning_task.AsyncTuningTask.get_metrics_url}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [str](https://docs.python.org/3/library/stdtypes.html#str) \| None ||
|#

*async* **cancel**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._tuning.tuning_task.AsyncTuningTask.cancel}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | None ||
|#

*async* **get\_result**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._tuning.tuning_task.AsyncTuningTask.get_result}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AnyResultTypeT\_co*](other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#

*async* **get\_status**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._tuning.tuning_task.AsyncTuningTask.get_status}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*OperationStatusTypeT*](other.md#yandex_cloud_ml_sdk._types.operation.OperationStatusTypeT) ||
|#

*property* **id**{#yandex_cloud_ml_sdk._tuning.tuning_task.AsyncTuningTask.id}

*async* **wait**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *poll\_timeout=None*, *poll\_interval=None*){#yandex_cloud_ml_sdk._tuning.tuning_task.AsyncTuningTask.wait}

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **poll\_timeout** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| **None*)
- **poll\_interval** ([*float*](https://docs.python.org/3/library/functions.html#float)* \| **None*) ||
|| Return type | [*AnyResultTypeT\_co*](other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#

### *class* yandex\_cloud\_ml\_sdk.\_tuning.tuning\_task.**TuningTask**{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask}

**get\_task\_info**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask.get_task_info}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*TuningTaskInfo*](#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo) \| None ||
|#

**get\_metrics\_url**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask.get_metrics_url}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [str](https://docs.python.org/3/library/stdtypes.html#str) \| None ||
|#

**cancel**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask.cancel}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | None ||
|#

**get\_result**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask.get_result}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AnyResultTypeT\_co*](other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#

**get\_status**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask.get_status}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*OperationStatusTypeT*](other.md#yandex_cloud_ml_sdk._types.operation.OperationStatusTypeT) ||
|#

*property* **id**{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask.id}

**wait**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *poll\_timeout=None*, *poll\_interval=None*){#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask.wait}

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **poll\_timeout** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| **None*)
- **poll\_interval** ([*float*](https://docs.python.org/3/library/functions.html#float)* \| **None*) ||
|| Return type | [*AnyResultTypeT\_co*](other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#

### *class* yandex\_cloud\_ml\_sdk.\_tuning.tuning\_task.**TuningTaskInfo**{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo}

TuningTaskInfo(id: ‘str’, \_sdk: ‘BaseSDK’, task\_id: ‘str’, operation\_id: ‘str’, status: ‘TuningTaskStatusEnum’, folder\_id: ‘str’, created\_by: ‘str’, created\_at: ‘datetime’, started\_at: ‘datetime | None’, finished\_at: ‘datetime | None’, source\_model\_uri: ‘str’, target\_model\_uri: ‘str | None’)

**task\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.task_id}

**operation\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.operation_id}

**status**\: *[TuningTaskStatusEnum](#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatusEnum)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.status}

**folder\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.folder_id}

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.created_by}

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.created_at}

**started\_at**\: *datetime | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.started_at}

**finished\_at**\: *datetime | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.finished_at}

**source\_model\_uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.source_model_uri}

**target\_model\_uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.target_model_uri}

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.id}

### *class* yandex\_cloud\_ml\_sdk.\_tuning.tuning\_task.**TuningTaskStatus**{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus}

*property* **is\_failed**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.is_failed}

*property* **is\_finished**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.is_finished}

*property* **is\_running**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.is_running}

*property* **is\_succeeded**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.is_succeeded}

*property* **status\_name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.status_name}

**done**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.done}

**error**\: *[OperationErrorInfo](operation.md#yandex_cloud_ml_sdk._types.operation.OperationErrorInfo) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.error}

**response**\: *[Any](https://docs.python.org/3/library/typing.html#typing.Any) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.response}

**metadata**\: *[Any](https://docs.python.org/3/library/typing.html#typing.Any) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.metadata}

### *class* yandex\_cloud\_ml\_sdk.\_tuning.tuning\_task.**TuningTaskStatusEnum**{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatusEnum}

**STATUS\_UNSPECIFIED** = *0*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatusEnum.STATUS_UNSPECIFIED}

**CREATED** = *1*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatusEnum.CREATED}

**PENDING** = *2*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatusEnum.PENDING}

**IN\_PROGRESS** = *3*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatusEnum.IN_PROGRESS}

**COMPLETED** = *4*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatusEnum.COMPLETED}

**FAILED** = *5*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatusEnum.FAILED}