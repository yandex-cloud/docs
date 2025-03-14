| Тип хранения | Цена за 1 ГБ в месяц, вкл. НДС |
| --- | --- |
| Объем хранилища проекта, до 10 ГБ | Не тарифицируется |
| Объем хранилища проекта, сверх 10 ГБ | {% calc [currency=RUB] round((0.003829269547325 × 2592000 × {{ sku|RUB|ai.datasphere.disk.v1|number }}) × 100) / 100 %} |
| Диск инстанса ноды | {% calc [currency=RUB] round((0.003829269547325 × 2592000 × {{ sku|RUB|ai.datasphere.deployment|number }}) × 100) / 100 %} |
| Датасет | {% calc [currency=RUB] round((0.003829269547325 × 2592000 × {{ sku|RUB|ai.datasphere.datasets.v1|number }}) × 100) / 100 %} |
| Модель | {% calc [currency=RUB] round((0.003829269547325 × 2592000 × {{ sku|RUB|ai.datasphere.models.v1|number }}) × 100) / 100 %} |
| Данные {{ ds-jobs }} | {% calc [currency=RUB] round((0.003829269547325 × 2592000 × {{ sku|RUB|ai.datasphere.jobs|number }}) × 100) / 100 %} |
