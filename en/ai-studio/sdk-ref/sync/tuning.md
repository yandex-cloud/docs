---
sourcePath: en/_sdk-ref/sdk-ref/sync/tuning.md
---
# Tuning domain

## *class* yandex\_ai\_studio\_sdk.\_tuning.domain.**Tuning**{#yandex_ai_studio_sdk._tuning.domain.Tuning}

Class for model tuning operations.

This class serves as the foundation for all model fine-tuning operations, providing comprehensive functionality.

**get**(*task\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_ai_studio_sdk._tuning.domain.Tuning.get}

Get tuning task by ID.

#|
|| Parameters | 

- **task\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – Tuning task ID
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*TuningTask*](../types/tuning.md#yandex_ai_studio_sdk._tuning.tuning_task.TuningTask) ||
|#

**list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page\_size=Undefined*, *timeout=60*){#yandex_ai_studio_sdk._tuning.domain.Tuning.list}

List tuning tasks.

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – Number of items per page (optional)
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*Iterator*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterator)[[*TuningTask*](../types/tuning.md#yandex_ai_studio_sdk._tuning.tuning_task.TuningTask)] ||
|#