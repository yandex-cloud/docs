# API сервисов {{ yandex-cloud }}

Сервисы {{ yandex-cloud }} дают вам возможность создавать системы автоматизации, плагины и другие приложения для управления облачными ресурсами на базе API.

Подробнее читайте в документе [Концепции API {{ yandex-cloud }}](../api-design-guide/).

## Справочники API сервисов {{ yandex-cloud }} {#ref}

- Инфраструктура и сеть:
   {% if product == "yandex-cloud" %}- [{{ api-gw-full-name }}](../api-gateway/apigateway/api-ref/){% endif %}
   - [{{ compute-full-name }}](../compute/api-ref/)
   - [{{ dns-full-name }}](../dns/api-ref/)
   - [{{ monitoring-full-name }}](../monitoring/api-ref/)
   - [{{ network-load-balancer-full-name }}](../network-load-balancer/api-ref/)
   - [{{ objstorage-full-name }}](../storage/s3/)
   - [{{ vpc-full-name }}](../vpc/api-ref/)

- Платформа данных:
   {% if product == "yandex-cloud" %}- [{{ ydb-full-name }}](../ydb/docapi/api-ref/){% endif %}
   {% if product == "yandex-cloud" %}- [{{ dataproc-full-name }}](../data-proc/api-ref/){% endif %}
   {% if product == "yandex-cloud" %}- [{{ yds-full-name }}](../data-streams/kinesisapi/api-ref/){% endif %}
   - [{{ data-transfer-full-name }}](../data-transfer/api-ref/)
   - [{{ mkf-full-name }}](../managed-kafka/api-ref/)
   - [{{ mch-full-name }}](../managed-clickhouse/api-ref/)
   {% if product == "yandex-cloud" %}- [{{ mes-full-name }}](../managed-elasticsearch/api-ref/){% endif %}
   {% if product == "yandex-cloud" %}- [{{ mgp-full-name }}](../managed-greenplum/api-ref/){% endif %}
   {% if product == "yandex-cloud" %}- [{{ mmg-full-name }}](../managed-mongodb/api-ref/){% endif %}
   - [{{ mmy-full-name }}](../managed-mysql/api-ref/)
   {% if product == "yandex-cloud" %}- [{{ mos-full-name }}](../managed-opensearch/api-ref/){% endif %}
   - [{{ mpg-full-name }}](../managed-postgresql/api-ref/)
   {% if product == "yandex-cloud" %}- [{{ mrd-full-name }}](../managed-redis/api-ref/){% endif %}
   {% if product == "yandex-cloud" %}- [{{ mms-full-name }}](../managed-sqlserver/api-ref/){% endif %}
   {% if product == "yandex-cloud" %}- [{{ message-queue-full-name }}](../message-queue/api-ref/){% endif %}
   - [{{ monitoring-full-name }}](../monitoring/api-ref/)
   - [{{ objstorage-full-name }}](../storage/s3/)

- Контейнерная разработка:
   - [{{ container-registry-full-name }}](../container-registry/api-ref/)
   - [{{ managed-k8s-full-name }}<sup>®</sup>](../managed-kubernetes/api-ref/)

{% if product == "yandex-cloud" %}
- Бессерверные вычисления:
   - [{{ api-gw-full-name }}](../api-gateway/apigateway/api-ref/)
   - [{{ sf-full-name }}](../functions/functions/api-ref/)
   - [{{ ydb-full-name }}](../ydb/docapi/api-ref/)
   - [{{ yds-full-name }}](../data-streams/kinesisapi/api-ref/)
   - [{{ iot-full-name }}](../iot-core/api-ref/) 
   - [{{ message-queue-full-name }}](../message-queue/api-ref/)
   - [{{ objstorage-full-name }}](../storage/s3/)
{% endif %}

- Безопасность:
   - [{{ certificate-manager-full-name }}](../certificate-manager/api-ref/)
   - [{{ iam-full-name }}](../iam/api-ref/)
   - [{{ kms-full-name }}](../kms/api-ref/)
   - [{{ lockbox-name }}](../lockbox/api-ref/) {% if product == "yandex-cloud" %}_Сервис находится на стадии [Preview](./concepts/launch-stages.md)._{% endif %}

- Ресурсы и управление:
   {% if product == "yandex-cloud" %}- [{{ cloud-logging-full-name }}](../logging/api-ref/) _Сервис находится на стадии [Preview](./concepts/launch-stages.md)._{% endif %}
   - [{{ org-full-name }}](../organization/api-ref/)
   - [{{ iam-full-name }}](../iam/api-ref/)
   - [{{ monitoring-full-name }}](../monitoring/api-ref/)
   - [{{ resmgr-full-name }}](../resource-manager/api-ref/)

{% if product == "yandex-cloud" %}
- Машинное обучение:
   - [{{ speechkit-full-name }}](../speechkit/)
   - [{{ translate-full-name }}](../translate/api-ref/)
   - [{{ vision-full-name }}](../vision/api-ref/)
{% endif %}

{% if product == "yandex-cloud" %}
- Бизнес-инструменты:
   - [{{ tracker-full-name }}](../tracker/about-api/)
{% endif %}

{% if product == "yandex-cloud" %}

{% include [Greenplum trademark](../_includes/mdb/mgp/trademark.md) %}

{% endif %}