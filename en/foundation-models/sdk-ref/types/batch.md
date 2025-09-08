---
sourcePath: en/_sdk-ref/sdk-ref/types/batch.md
---
# Batch

## *class* yandex\_cloud\_ml\_sdk.\_types.batch.task\_info.**BatchTaskInfo**{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo}

BatchTaskInfo(task\_id: ‘str’, operation\_id: ‘str’, folder\_id: ‘str’, model\_uri: ‘str’, source\_dataset\_id: ‘str’, result\_dataset\_id: ‘str | None’, status: ‘BatchTaskStatus’, labels: ‘dict[str, str]’, created\_by: ‘str’, created\_at: ‘datetime’, started\_at: ‘datetime’, finished\_at: ‘datetime’, errors: ‘BatchTaskErrorsInfo’)

**task\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo.task_id}

**operation\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo.operation_id}

**folder\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo.folder_id}

**model\_uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo.model_uri}

**source\_dataset\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo.source_dataset_id}

**result\_dataset\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo.result_dataset_id}

**status**\: *[BatchTaskStatus](#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus)*{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo.status}

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)*]{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo.labels}

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo.created_by}

**created\_at**\: *[datetime](https://docs.python.org/3/library/datetime.html#datetime.datetime)*{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo.created_at}

**started\_at**\: *[datetime](https://docs.python.org/3/library/datetime.html#datetime.datetime)*{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo.started_at}

**finished\_at**\: *[datetime](https://docs.python.org/3/library/datetime.html#datetime.datetime)*{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo.finished_at}

**errors**\: *[BatchTaskErrorsInfo](#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskErrorsInfo)*{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskInfo.errors}

## *class* yandex\_cloud\_ml\_sdk.\_types.batch.task\_info.**BatchTaskErrorsInfo**{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskErrorsInfo}

BatchTaskErrorsInfo(line\_errors: ‘tuple[LineErrorInfo, …]’, batch\_errors: ‘tuple[BatchErrorInfo, …]’)

**line\_errors**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[LineErrorInfo](#yandex_cloud_ml_sdk._types.batch.task_info.LineErrorInfo)*]... ,{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskErrorsInfo.line_errors}

**batch\_errors**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[BatchErrorInfo](#yandex_cloud_ml_sdk._types.batch.task_info.BatchErrorInfo)*]... ,{#yandex_cloud_ml_sdk._types.batch.task_info.BatchTaskErrorsInfo.batch_errors}

## *class* yandex\_cloud\_ml\_sdk.\_types.batch.task\_info.**BatchErrorInfo**{#yandex_cloud_ml_sdk._types.batch.task_info.BatchErrorInfo}

BatchErrorInfo(batch\_number: ‘int’, first\_line: ‘int’, last\_line: ‘int’, message: ‘str’)

**batch\_number**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._types.batch.task_info.BatchErrorInfo.batch_number}

**first\_line**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._types.batch.task_info.BatchErrorInfo.first_line}

**last\_line**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._types.batch.task_info.BatchErrorInfo.last_line}

**message**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.task_info.BatchErrorInfo.message}

## *class* yandex\_cloud\_ml\_sdk.\_types.batch.task\_info.**LineErrorInfo**{#yandex_cloud_ml_sdk._types.batch.task_info.LineErrorInfo}

LineErrorInfo(line\_number: ‘int’, message: ‘str’)

**line\_number**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._types.batch.task_info.LineErrorInfo.line_number}

**message**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.task_info.LineErrorInfo.message}

## *class* yandex\_cloud\_ml\_sdk.\_types.batch.status.**BatchTaskStatus**{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus}

**UNKNOWN** = *-1*{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.UNKNOWN}

**STATUS\_UNSPECIFIED** = *0*{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.STATUS_UNSPECIFIED}

**CREATED** = *1*{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.CREATED}

**PENDING** = *2*{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.PENDING}

**IN\_PROGRESS** = *3*{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.IN_PROGRESS}

**COMPLETED** = *4*{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.COMPLETED}

**FAILED** = *5*{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.FAILED}

**CANCELED** = *6*{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.CANCELED}

*property* **is\_running**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.is_running}

*property* **is\_succeeded**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.is_succeeded}

*property* **is\_failed**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.is_failed}

*property* **is\_finished**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.is_finished}

*property* **status\_name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.status_name}

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.__new__i}

**conjugate**(){#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.real}

the real part of a complex number

**imag**{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.imag}

the imaginary part of a complex number

**numerator**{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_cloud_ml_sdk._types.batch.status.BatchTaskStatus.__init__i}