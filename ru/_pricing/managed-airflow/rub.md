| Ресурс        | Цена за 1 час,<br>вкл. НДС                           | Цена за 1 месяц,<br>вкл. НДС |
|---------------|-----------------------------------------------------:|-----------------------------:|
| 100% vCPU     | {{ sku|RUB|airflow.cluster.generic.vcpu.v1|string }} | {% calc [currency=RUB] 720 × {{ sku|RUB|airflow.cluster.generic.vcpu.v1|number }} %} |
| RAM (за 1 ГБ) | {{ sku|RUB|airflow.cluster.generic.ram.v1|string }}  | {% calc [currency=RUB] 720 × {{ sku|RUB|airflow.cluster.generic.ram.v1|number }} %}  |
