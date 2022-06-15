# {{ yandex-cloud }} service APIs

{{ yandex-cloud }} services offer APIs that you can use to create automated systems, plugins, and other applications for managing cloud resources.

For more information, see [{{ yandex-cloud }} API concepts](../api-design-guide/).

## {{ yandex-cloud }} API reference guides {#ref}

- Infrastructure and network:
   {% if product == "yandex-cloud" %}- [{{ api-gw-full-name }}](../api-gateway/apigateway/api-ref/){% endif %}
   - [{{ compute-full-name }}](../compute/api-ref/)
   - [{{ dns-full-name }}](../dns/api-ref/)
   - [{{ monitoring-full-name }}](../monitoring/api-ref/)
   - [{{ network-load-balancer-full-name }}](../network-load-balancer/api-ref/)
   - [{{ objstorage-full-name }}](../storage/s3/)
   - [{{ vpc-full-name }}](../vpc/api-ref/)

- Data platform:
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
   - [{{ mpg-full-name }}](../managed-postgresql/api-ref/)
      {% if product == "yandex-cloud" %}- [{{ mrd-full-name }}](../managed-redis/api-ref/){% endif %}
      {% if product == "yandex-cloud" %}- [{{ mms-full-name }}](../managed-sqlserver/api-ref/){% endif %}
   - [{{ message-queue-full-name }}](../message-queue/api-ref/)
   - [{{ monitoring-full-name }}](../monitoring/api-ref/)
   - [{{ objstorage-full-name }}](../storage/s3/)

- Container-based development:
   - [{{ container-registry-full-name }}](../container-registry/api-ref/)
   - [{{ managed-k8s-full-name }}<sup>®</sup>](../managed-kubernetes/api-ref/)

{% if product == "yandex-cloud" %}
- Serverless computing:
   - [{{ api-gw-full-name }}](../api-gateway/apigateway/api-ref/)
   - [{{ sf-full-name }}](../functions/functions/api-ref/)
   - [{{ ydb-full-name }}](../ydb/docapi/api-ref/)
   - [{{ yds-full-name }}](../data-streams/kinesisapi/api-ref/)
   - [{{ iot-full-name }}](../iot-core/api-ref/)
   - [{{ message-queue-full-name }}](../message-queue/api-ref/)
   - [{{ objstorage-full-name }}](../storage/s3/)
{% endif %}

- Security:
   - [{{ certificate-manager-full-name }}](../certificate-manager/api-ref/)
   - [{{ iam-full-name }}](../iam/api-ref/)
   - [{{ kms-full-name }}](../kms/api-ref/)
   - [{{ lockbox-name }}](../lockbox/api-ref/) {% if product == "yandex-cloud" %}_The service is at the [Preview stage](./concepts/launch-stages.md)._{% endif %}

- Resources and management:
   {% if product == "yandex-cloud" %}- [{{ cloud-logging-full-name }}](../logging/api-ref/) _The service is at the [Preview](./concepts/launch-stages.md) stage._{% endif %}
   - [{{ org-full-name }}](../organization/api-ref/)
   - [{{ iam-full-name }}](../iam/api-ref/)
   - [{{ monitoring-full-name }}](../monitoring/api-ref/)
   - [{{ resmgr-full-name }}](../resource-manager/api-ref/)

{% if product == "yandex-cloud" %}
- Machine learning:
   - [{{ ml-platform-full-name }}](../datasphere/api-ref/)
   - [{{ speechkit-full-name }}](../speechkit/)
   - [{{ translate-full-name }}](../translate/api-ref/)
   - [{{ vision-full-name }}](../message-queue/api-ref/)
{% endif %}

{% if product == "yandex-cloud" %}
- Business tools:
   - [{{ tracker-full-name }}](../tracker/about-api/)
{% endif %}

{% if product == "yandex-cloud" %}

{% include [Greenplum trademark](../_includes/mdb/mgp/trademark.md) %}

{% endif %}