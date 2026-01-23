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

Tuning task class that provides an Operation interface for tracking the tuning task and obtaining results.

*async* **get\_task\_info**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._tuning.tuning_task.AsyncTuningTask.get_task_info}

Retrieves tuning task information from the Yandex Cloud ML service.

Makes an async gRPC call to the TuningService to get detailed information about the current tuning task. The method first obtains the task ID and then fetches the full task information.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*TuningTaskInfo*](#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo) \| None ||
|#

*async* **get\_metrics\_url**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._tuning.tuning_task.AsyncTuningTask.get_metrics_url}

Fetches metrics URL for the current tuning task.

Returns None if the task has not yet generated metrics or if metrics are not available.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
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

Get fine-tuning task identifier.

*async* **wait**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *poll\_timeout=None*, *poll\_interval=None*){#yandex_cloud_ml_sdk._tuning.tuning_task.AsyncTuningTask.wait}

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **poll\_timeout** ([*int*](https://docs.python.org/3/library/functions.html#int) *\| None*)
- **poll\_interval** ([*float*](https://docs.python.org/3/library/functions.html#float) *\| None*) ||
|| Return type | [*AnyResultTypeT\_co*](other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#

### *class* yandex\_cloud\_ml\_sdk.\_tuning.tuning\_task.**TuningTask**{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask}

Tuning task class that provides an Operation interface for tracking the tuning task and obtaining results.

**get\_task\_info**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask.get_task_info}

Retrieves tuning task information from the Yandex Cloud ML service.

Makes an async gRPC call to the TuningService to get detailed information about the current tuning task. The method first obtains the task ID and then fetches the full task information.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*TuningTaskInfo*](#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo) \| None ||
|#

**get\_metrics\_url**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask.get_metrics_url}

Fetches metrics URL for the current tuning task.

Returns None if the task has not yet generated metrics or if metrics are not available.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
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

Get fine-tuning task identifier.

**wait**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *poll\_timeout=None*, *poll\_interval=None*){#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask.wait}

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **poll\_timeout** ([*int*](https://docs.python.org/3/library/functions.html#int) *\| None*)
- **poll\_interval** ([*float*](https://docs.python.org/3/library/functions.html#float) *\| None*) ||
|| Return type | [*AnyResultTypeT\_co*](other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#

### *class* yandex\_cloud\_ml\_sdk.\_tuning.tuning\_task.**TuningTaskInfo**{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo}

Contains metadata and status information about a model tuning task.

This class represents the state and configuration of a fine-tuning operation for machine learning models. It tracks the task lifecycle through status updates and provides references to related resources.

**task\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.task_id}

Unique task identifier

**operation\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.operation_id}

Associated operation ID

**status**\: *[TuningTaskStatusEnum](#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatusEnum)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.status}

Current task status

**folder\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.folder_id}

Yandex Cloud folder ID

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.created_by}

Creator identity

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.created_at}

Creation timestamp

**started\_at**\: *datetime | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.started_at}

Start timestamp (None if not started)

**finished\_at**\: *datetime | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.finished_at}

Completion timestamp (None if not finished)

**source\_model\_uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.source_model_uri}

URI of source model

**target\_model\_uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.target_model_uri}

URI of tuned model (None if not completed)

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskInfo.id}

### *class* yandex\_cloud\_ml\_sdk.\_tuning.tuning\_task.**TuningTaskStatus**{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus}

Status of a tuning task operation.

Extends OperationStatus with tuning-specific status information.

*property* **is\_failed**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.is_failed}

Check if operation execution failed.

*property* **is\_finished**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.is_finished}

Check if operation execution finished.

*property* **is\_running**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.is_running}

Check if operation execution is still in progress.

*property* **is\_succeeded**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.is_succeeded}

Check if operation execution completed successfully.

*property* **status\_name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.status_name}

Get operation execution status name.

**done**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.done}

**error**\: *[OperationErrorInfo](operation.md#yandex_cloud_ml_sdk._types.operation.OperationErrorInfo) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.error}

**response**\: *[Any](https://docs.python.org/3/library/typing.html#typing.Any) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.response}

**metadata**\: *[Any](https://docs.python.org/3/library/typing.html#typing.Any) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatus.metadata}

### *class* yandex\_cloud\_ml\_sdk.\_tuning.tuning\_task.**TuningTaskStatusEnum**{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatusEnum}

Enum representing possible statuses of a tuning task.

**STATUS\_UNSPECIFIED** = *0*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatusEnum.STATUS_UNSPECIFIED}

Status not specified

**CREATED** = *1*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatusEnum.CREATED}

Task created but not started

**PENDING** = *2*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatusEnum.PENDING}

Task pending execution

**IN\_PROGRESS** = *3*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatusEnum.IN_PROGRESS}

Task execution in progress

**COMPLETED** = *4*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatusEnum.COMPLETED}

Task completed successfully

**FAILED** = *5*{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTaskStatusEnum.FAILED}

Task failed