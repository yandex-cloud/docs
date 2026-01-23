---
sourcePath: en/_sdk-ref/sdk-ref/async/batch.md
---
# Batch domain

## *class* yandex\_cloud\_ml\_sdk.\_batch.domain.**AsyncBatch**{#yandex_cloud_ml_sdk._batch.domain.AsyncBatch}

Сlass for managing batch operations in Yandex Cloud ML SDK.

For usage examples see [batch example](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/blob/master/examples/async/completions/batch.py).

*async* **get**(*task*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._batch.domain.AsyncBatch.get}

Get batch task operation by ID or by BatchTaskInfo object.

#|
|| Parameters | 

- **task** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BatchTaskInfo*](../types/batch.md#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo)) – Either task ID string or BatchTaskInfo object.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*AsyncBatchTaskOperation*](#yandex_cloud_ml_sdk._types.batch.operation.AsyncBatchTaskOperation) ||
|#

*async* **list\_operations**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page\_size=Undefined*, *status=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._batch.domain.AsyncBatch.list_operations}

List batch task operations with optional filtering.

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Maximum number of tasks per page (optional).
- **status** ([*BatchTaskStatus*](../types/batch.md#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Filter tasks by status (optional).
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*AsyncIterator*](https://docs.python.org/3/library/collections.abc.html#collections.abc.AsyncIterator)[[*AsyncBatchTaskOperation*](#yandex_cloud_ml_sdk._types.batch.operation.AsyncBatchTaskOperation)] ||
|#

*async* **list\_info**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page\_size=Undefined*, *status=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._batch.domain.AsyncBatch.list_info}

List batch task information with optional filtering.

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Maximum number of tasks per page (optional).
- **status** ([*BatchTaskStatus*](../types/batch.md#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Filter tasks by status (optional).
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*AsyncIterator*](https://docs.python.org/3/library/collections.abc.html#collections.abc.AsyncIterator)[[*BatchTaskInfo*](../types/batch.md#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo)] ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_types.batch.operation.**AsyncBatchTaskOperation**{#yandex_cloud_ml_sdk._types.batch.operation.AsyncBatchTaskOperation}

*async* **delete**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._types.batch.operation.AsyncBatchTaskOperation.delete}

Delete batch task from tasks history.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout, or the maximum time to wait for the request to complete in seconds. ||
|| Return type | None ||
|#

*async* **get\_task\_info**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._types.batch.operation.AsyncBatchTaskOperation.get_task_info}

Get detailed batch task info.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout, or the maximum time to wait for the request to complete in seconds. ||
|| Returns | task info object with a lot of info fields. ||
|| Return type | [*BatchTaskInfo*](../types/batch.md#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo) ||
|#

*async* **cancel**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._types.batch.operation.AsyncBatchTaskOperation.cancel}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | None ||
|#

*async* **get\_result**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._types.batch.operation.AsyncBatchTaskOperation.get_result}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AnyResultTypeT\_co*](../types/other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#

*async* **get\_status**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._types.batch.operation.AsyncBatchTaskOperation.get_status}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*OperationStatusTypeT*](../types/other.md#yandex_cloud_ml_sdk._types.operation.OperationStatusTypeT) ||
|#

*property* **id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.operation.AsyncBatchTaskOperation.id}

*property* **task\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.operation.AsyncBatchTaskOperation.task_id}

*async* **wait**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *poll\_timeout=None*, *poll\_interval=None*){#yandex_cloud_ml_sdk._types.batch.operation.AsyncBatchTaskOperation.wait}

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **poll\_timeout** ([*int*](https://docs.python.org/3/library/functions.html#int) *\| None*)
- **poll\_interval** ([*float*](https://docs.python.org/3/library/functions.html#float) *\| None*) ||
|| Return type | [*AnyResultTypeT\_co*](../types/other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#