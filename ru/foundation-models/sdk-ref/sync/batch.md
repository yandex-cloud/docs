---
sourcePath: en/_sdk-ref/sdk-ref/sync/batch.md
---
# Batch domain

## *class* yandex\_cloud\_ml\_sdk.\_batch.domain.**Batch**{#yandex_cloud_ml_sdk._batch.domain.Batch}

**get**(*task*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._batch.domain.Batch.get}

#|
|| Parameters | 

- **task** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*BatchTaskInfo*](../types/batch.md#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*BatchTaskOperation*](#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation) ||
|#

**list\_operations**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page\_size=Undefined*, *status=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._batch.domain.Batch.list_operations}

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **status** ([*BatchTaskStatus*](../types/batch.md#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus)* \| *[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*Iterator*](https://docs.python.org/3/library/typing.html#typing.Iterator)[[*BatchTaskOperation*](#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation)] ||
|#

**list\_info**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page\_size=Undefined*, *status=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._batch.domain.Batch.list_info}

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **status** ([*BatchTaskStatus*](../types/batch.md#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus)* \| *[*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*int*](https://docs.python.org/3/library/functions.html#int)* \| *[*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*Iterator*](https://docs.python.org/3/library/typing.html#typing.Iterator)[[*BatchTaskInfo*](../types/batch.md#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo)] ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_types.batch.operation.**BatchTaskOperation**{#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation}

**delete**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation.delete}

Delete batch task from tasks history.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout, or the maximum time to wait for the request to complete in seconds. ||
|| Return type | None ||
|#

**get\_task\_info**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation.get_task_info}

Get detailed batch task info.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout, or the maximum time to wait for the request to complete in seconds. ||
|| Returns | task info object with a lot of info fields. ||
|| Return type | [*BatchTaskInfo*](../types/batch.md#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo) ||
|#

**cancel**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation.cancel}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | None ||
|#

**get\_result**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation.get_result}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AnyResultTypeT\_co*](../types/other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#

**get\_status**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation.get_status}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*OperationStatusTypeT*](../types/other.md#yandex_cloud_ml_sdk._types.operation.OperationStatusTypeT) ||
|#

*property* **id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation.id}

*property* **task\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation.task_id}

**wait**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *poll\_timeout=None*, *poll\_interval=None*){#yandex_cloud_ml_sdk._types.batch.operation.BatchTaskOperation.wait}

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **poll\_timeout** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| **None*)
- **poll\_interval** ([*float*](https://docs.python.org/3/library/functions.html#float)* \| **None*) ||
|| Return type | [*AnyResultTypeT\_co*](../types/other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#