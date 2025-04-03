| Ресурс | Цена за 1 ГБ в месяц, вкл. НДС |
| --- | --- |
| Объем хранилища проекта, до 10 ГБ | Не тарифицируется |
| Объем хранилища проекта, сверх 10 ГБ | {% calc [currency=KZT] round((0.003829269547325 × 2592000 × {{ sku|KZT|ai.datasphere.disk.v1|number }}) × 100) / 100 %} |
| Диск инстанса ноды | {% calc [currency=KZT] round((0.003829269547325 × 2592000 × {{ sku|KZT|ai.datasphere.deployment|number }}) × 100) / 100 %} |
| Датасет | {% calc [currency=KZT] round((0.003829269547325 × 2592000 × {{ sku|KZT|ai.datasphere.datasets.v1|number }}) × 100) / 100 %} |
| Файловое хранилище | {% calc [currency=KZT] round((0.004403452932099 × 2592000 × {{ sku|KZT|datasphere.filestores|number }}) × 100) / 100 %} |
| Модель | {% calc [currency=KZT] round((0.003829269547325 × 2592000 × {{ sku|KZT|ai.datasphere.models.v1|number }}) × 100) / 100 %} |
| Данные {{ ds-jobs }} | {% calc [currency=KZT] round((0.003829269547325 × 2592000 × {{ sku|KZT|ai.datasphere.jobs|number }}) × 100) / 100 %} |
