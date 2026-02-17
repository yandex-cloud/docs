# Datasets

## *class* yandex\_ai\_studio\_sdk.\_datasets.status.**DatasetStatus**{#yandex_ai_studio_sdk._datasets.status.DatasetStatus}

Enumeration representing the status of a dataset.

The statuses correspond to the different states a dataset can be in during its lifecycle.

**UNKNOWN** = *-1*{#yandex_ai_studio_sdk._datasets.status.DatasetStatus.UNKNOWN}

the status of the dataset is unknown; this is typically used as a fallback when the status cannot be determined

**STATUS\_UNSPECIFIED** = *0*{#yandex_ai_studio_sdk._datasets.status.DatasetStatus.STATUS_UNSPECIFIED}

the status has not been specified; this is often used as a default value when creating or initializing a dataset

**DRAFT** = *1*{#yandex_ai_studio_sdk._datasets.status.DatasetStatus.DRAFT}

the dataset is in a draft state; this means it is still being created or modified

**VALIDATING** = *2*{#yandex_ai_studio_sdk._datasets.status.DatasetStatus.VALIDATING}

the dataset is currently undergoing validation

**READY** = *3*{#yandex_ai_studio_sdk._datasets.status.DatasetStatus.READY}

the dataset is ready for use; it has passed all necessary validations and can be utilized in operations

**INVALID** = *4*{#yandex_ai_studio_sdk._datasets.status.DatasetStatus.INVALID}

the dataset is considered invalid; this may occur if it fails validation

**DELETING** = *5*{#yandex_ai_studio_sdk._datasets.status.DatasetStatus.DELETING}

the dataset is in the process of being deleted

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._datasets.status.DatasetStatus.__new__i}

## *class* yandex\_ai\_studio\_sdk.\_datasets.dataset.**ValidationErrorInfo**{#yandex_ai_studio_sdk._datasets.dataset.ValidationErrorInfo}

This class represents information about a validation error.

**error**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._datasets.dataset.ValidationErrorInfo.error}

the error message

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._datasets.dataset.ValidationErrorInfo.description}

a description of the error

**rows**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[int](https://docs.python.org/3/library/functions.html#int)*]... ,{#yandex_ai_studio_sdk._datasets.dataset.ValidationErrorInfo.rows}

a tuple of row numbers associated with the error

## *class* yandex\_ai\_studio\_sdk.\_datasets.schema.**DatasetUploadSchema**{#yandex_ai_studio_sdk._datasets.schema.DatasetUploadSchema}

This class represents the schema for uploading datasets.

**task\_type**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._datasets.schema.DatasetUploadSchema.task_type}

the type of task associated with the dataset

**upload\_format**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._datasets.schema.DatasetUploadSchema.upload_format}

the format in which the dataset is uploaded

**raw\_schema**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._datasets.schema.DatasetUploadSchema.raw_schema}

the raw schema definition in string format

*property* **json**\: *JsonSchemaType*{#yandex_ai_studio_sdk._datasets.schema.DatasetUploadSchema.json}

Get the JSON representation of the raw schema.