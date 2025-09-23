---
sourcePath: en/_sdk-ref/sdk-ref/types/datasets.md
---
# Datasets

## *class* yandex\_cloud\_ml\_sdk.\_datasets.status.**DatasetStatus**{#yandex_cloud_ml_sdk._datasets.status.DatasetStatus}

**UNKNOWN** = *-1*{#yandex_cloud_ml_sdk._datasets.status.DatasetStatus.UNKNOWN}

**STATUS\_UNSPECIFIED** = *0*{#yandex_cloud_ml_sdk._datasets.status.DatasetStatus.STATUS_UNSPECIFIED}

**DRAFT** = *1*{#yandex_cloud_ml_sdk._datasets.status.DatasetStatus.DRAFT}

**VALIDATING** = *2*{#yandex_cloud_ml_sdk._datasets.status.DatasetStatus.VALIDATING}

**READY** = *3*{#yandex_cloud_ml_sdk._datasets.status.DatasetStatus.READY}

**INVALID** = *4*{#yandex_cloud_ml_sdk._datasets.status.DatasetStatus.INVALID}

**DELETING** = *5*{#yandex_cloud_ml_sdk._datasets.status.DatasetStatus.DELETING}

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._datasets.status.DatasetStatus.__new__i}

## *class* yandex\_cloud\_ml\_sdk.\_datasets.dataset.**ValidationErrorInfo**{#yandex_cloud_ml_sdk._datasets.dataset.ValidationErrorInfo}

ValidationErrorInfo(error: ‘str’, description: ‘str’, rows: ‘tuple[int, …]’)

**error**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.ValidationErrorInfo.error}

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.ValidationErrorInfo.description}

**rows**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[int](https://docs.python.org/3/library/functions.html#int)*]... ,{#yandex_cloud_ml_sdk._datasets.dataset.ValidationErrorInfo.rows}

## *class* yandex\_cloud\_ml\_sdk.\_datasets.schema.**DatasetUploadSchema**{#yandex_cloud_ml_sdk._datasets.schema.DatasetUploadSchema}

DatasetUploadSchema(task\_type: ‘str’, upload\_format: ‘str’, raw\_schema: ‘str’)

**task\_type**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.schema.DatasetUploadSchema.task_type}

**upload\_format**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.schema.DatasetUploadSchema.upload_format}

**raw\_schema**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.schema.DatasetUploadSchema.raw_schema}

*property* **json**\: *JsonSchemaType*{#yandex_cloud_ml_sdk._datasets.schema.DatasetUploadSchema.json}