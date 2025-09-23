---
sourcePath: en/_sdk-ref/sdk-ref/types/operation.md
---
# Operation

## *class* yandex\_cloud\_ml\_sdk.\_types.operation.**AsyncOperation**{#yandex_cloud_ml_sdk._types.operation.AsyncOperation}

*async* **cancel**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._types.operation.AsyncOperation.cancel}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | None ||
|#

*async* **get\_result**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._types.operation.AsyncOperation.get_result}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AnyResultTypeT\_co*](other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#

*async* **get\_status**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._types.operation.AsyncOperation.get_status}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*OperationStatusTypeT*](other.md#yandex_cloud_ml_sdk._types.operation.OperationStatusTypeT) ||
|#

*property* **id**{#yandex_cloud_ml_sdk._types.operation.AsyncOperation.id}

*async* **wait**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *poll\_timeout=None*, *poll\_interval=None*){#yandex_cloud_ml_sdk._types.operation.AsyncOperation.wait}

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **poll\_timeout** ([*int*](https://docs.python.org/3/library/functions.html#int) *\| None*)
- **poll\_interval** ([*float*](https://docs.python.org/3/library/functions.html#float) *\| None*) ||
|| Return type | [*AnyResultTypeT\_co*](other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_types.operation.**Operation**{#yandex_cloud_ml_sdk._types.operation.Operation}

**cancel**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._types.operation.Operation.cancel}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | None ||
|#

**get\_result**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._types.operation.Operation.get_result}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AnyResultTypeT\_co*](other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#

**get\_status**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._types.operation.Operation.get_status}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*OperationStatusTypeT*](other.md#yandex_cloud_ml_sdk._types.operation.OperationStatusTypeT) ||
|#

*property* **id**{#yandex_cloud_ml_sdk._types.operation.Operation.id}

**wait**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *poll\_timeout=None*, *poll\_interval=None*){#yandex_cloud_ml_sdk._types.operation.Operation.wait}

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **poll\_timeout** ([*int*](https://docs.python.org/3/library/functions.html#int) *\| None*)
- **poll\_interval** ([*float*](https://docs.python.org/3/library/functions.html#float) *\| None*) ||
|| Return type | [*AnyResultTypeT\_co*](other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_types.operation.**OperationStatus**{#yandex_cloud_ml_sdk._types.operation.OperationStatus}

OperationStatus(done: ‘bool’, error: ‘OperationErrorInfo | None’, response: ‘Any | None’, metadata: ‘Any | None’)

**done**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._types.operation.OperationStatus.done}

**error**\: *[OperationErrorInfo](#yandex_cloud_ml_sdk._types.operation.OperationErrorInfo) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._types.operation.OperationStatus.error}

**response**\: *[Any](https://docs.python.org/3/library/typing.html#typing.Any) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._types.operation.OperationStatus.response}

**metadata**\: *[Any](https://docs.python.org/3/library/typing.html#typing.Any) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._types.operation.OperationStatus.metadata}

*property* **is\_running**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._types.operation.OperationStatus.is_running}

*property* **is\_succeeded**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._types.operation.OperationStatus.is_succeeded}

*property* **is\_failed**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._types.operation.OperationStatus.is_failed}

*property* **is\_finished**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._types.operation.OperationStatus.is_finished}

*property* **status\_name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.operation.OperationStatus.status_name}

## *class* yandex\_cloud\_ml\_sdk.\_types.operation.**OperationErrorInfo**{#yandex_cloud_ml_sdk._types.operation.OperationErrorInfo}

OperationErrorInfo(code: ‘int’, message: ‘str’, details: ‘Iterable[str] | None’)

**code**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._types.operation.OperationErrorInfo.code}

**message**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.operation.OperationErrorInfo.message}

**details**\: *[Iterable](https://docs.python.org/3/library/typing.html#typing.Iterable)[[str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._types.operation.OperationErrorInfo.details}