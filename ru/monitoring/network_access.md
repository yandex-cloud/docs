# Получение сетевых доступов
В зависимости от выбранного режима передачи данных и используемого окружения сервиса Solomon, необходимо заказать следующие сетевые доступы при помощи сервиса [Puncher](https://puncher.yandex-team.ru).

### Доступы для pull-режима передачи данных {#access-pull}

{% note tip %}

Для сервисов, запущенных в RTC и собирающих метрики в {% if audience == "internal" %}[кластера Solomon Production/Prestable/Testing](overview/clusters.md){% endif %}{% if audience == "external" %}кластера Solomon Production/Prestable/Testing{% endif %}, можно использовать порт из диапазона 3400-3499 и не заказывать дополнительные сетевые доступы.

{% endnote %}

<small>Таблица 1 — Параметры сетевого доступа от кластеров Solomon для pull-режима</small>

|**Кластер Solomon**|**Источник**|**Шаблон заявки в Puncher**
|-------------------|------------|-------------------|
| Solomon Production/Prestable/Testing | `_SOLOMONNETS_` | [Создать заявку](https://puncher.yandex-team.ru?create_sources=_SOLOMONNETS_&create_protocol=tcp&create_locations=office&create_locations=vpn&create_comment=Solomon%20собирает%20метрики%20в%20pull-режиме)
| Solomon Cloud Prod | `_C_CLOUD_PROD_SOLOMON_CORE_` | [Создать заявку](https://puncher.yandex-team.ru?create_sources=_C_CLOUD_PROD_SOLOMON_CORE_&create_protocol=tcp&create_locations=office&create_locations=vpn&create_comment=Solomon%20Cloud%20Prod%20собирает%20метрики%20в%20pull-режиме)
| Solomon Cloud Preprod overlay | `_CLOUD_MONITORING_PREPROD_NETS_` | [Создать заявку](https://puncher.yandex-team.ru?create_sources=_CLOUD_MONITORING_PREPROD_NETS_&create_protocol=tcp&create_locations=office&create_locations=vpn&create_comment=Solomon%20Cloud%20Prerod%20собирает%20метрики%20в%20pull-режиме)
| Solomon Cloud Preprod underlay | `_CLOUDPREPRODNETS_` | [Создать заявку](https://puncher.yandex-team.ru?create_sources=_CLOUDPREPRODNETS_&create_protocol=tcp&create_locations=office&create_locations=vpn&create_comment=Solomon%20Cloud%20Prerod%20собирает%20метрики%20в%20pull-режиме)


В качестве приёмника необходимо указать хосты кластера по порту, указанному в настройках сервиса.

### Доступы для push-режима сбора данных {#access-push}

<small>Таблица 2 — Параметры сетевого доступа к кластерам Solomon для push-режима</small>

|**Кластер Solomon**|**Приемник**|**Шаблон заявки в Puncher**
|-------------------|------------|-------------------|
| Solomon Prestable | `solomon-pre.yandex.net:443` | [Создать заявку](https://puncher.yandex-team.ru?create_destinations=solomon-pre.yandex.net&create_protocol=tcp&create_locations=office&create_locations=vpn&create_ports=443&create_comment=Push%20метрик%20в%20Solomon%20Prestable)
| Solomon Production | `solomon.yandex.net:443` | [Создать заявку](https://puncher.yandex-team.ru?create_destinations=solomon.yandex.net&create_protocol=tcp&create_locations=office&create_locations=vpn&create_ports=443&create_comment=Push%20метрик%20в%20Solomon%20Production)
| Solomon Cloud Preprod | `solomon.cloud-preprod.yandex-team.ru:443` | [Создать заявку](https://puncher.yandex-team.ru?create_destinations=solomon.cloud-preprod.yandex-team.ru&create_protocol=tcp&create_locations=office&create_locations=vpn&create_ports=443&create_comment=Push%20метрик%20в%20Solomon%20Cloud%20Preprod)
| Solomon Cloud Production | `solomon.cloud.yandex-team.ru:443`| [Создать заявку](https://puncher.yandex-team.ru/?create_destinations=solomon.cloud.yandex-team.ru&create_protocol=tcp&create_locations=office&create_locations=vpn&create_ports=443&create_comment=Push%20метрик%20в%20Solomon%20Cloud%20Prod)

В качестве источника необходимо указать хосты, c которых будут выполняться push-запросы.
