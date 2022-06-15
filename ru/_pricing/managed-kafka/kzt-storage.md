{% include [local-ssd for Intel Ice Lake only by request](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                     |
| ----- | ----- |
| Хранилище на сетевых HDD-дисках         | {{ sku|KZT|mdb.cluster.network-hdd.kafka|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.kafka|month|string }} |
| Хранилище на сетевых SSD-дисках         | {{ sku|KZT|mdb.cluster.network-nvme.kafka|month|string }}              |
| Хранилище на локальных SSD-дисках       | {{ sku|KZT|mdb.cluster.local-nvme.kafka|month|string }} *              |

{% if product == "yandex-cloud" %}
\* Хранилище выделенных хостов оплачивается по тарифам, указанным в [документации {{ compute-full-name }}](../../compute/pricing.md#prices).
{% endif %}
