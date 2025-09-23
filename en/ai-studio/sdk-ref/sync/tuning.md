---
sourcePath: en/_sdk-ref/sdk-ref/sync/tuning.md
---
# Tuning domain

## *class* yandex\_cloud\_ml\_sdk.\_tuning.domain.**Tuning**{#yandex_cloud_ml_sdk._tuning.domain.Tuning}

**get**(*task\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._tuning.domain.Tuning.get}

#|
|| Parameters | 

- **task\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*TuningTask*](../types/tuning.md#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask) ||
|#

**list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page\_size=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._tuning.domain.Tuning.list}

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*Iterator*](https://docs.python.org/3/library/typing.html#typing.Iterator)[[*TuningTask*](../types/tuning.md#yandex_cloud_ml_sdk._tuning.tuning_task.TuningTask)] ||
|#