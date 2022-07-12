# Questions and answers

## About {{ yandex-cloud }}

{% if product == "yandex-cloud" %}- [Billing](../billing/qa/all.md){% endif %}
- [Technical support](../support/qa.md)

## {{ yandex-cloud }} services

- Infrastructure and network:
   - [{{ compute-full-name }}](../compute/qa/all.md)
   - [{{ monitoring-full-name }}](../monitoring/qa/all.md)
   - [{{ objstorage-full-name }}](../storage/qa/)
   - [{{ vpc-full-name }}](../vpc/qa/)

- Data platform:
   {% if product == "yandex-cloud" %}- [{{ ydb-full-name }}](../ydb/faq.md){% endif %}
   {% if product == "yandex-cloud" %}- [{{ datalens-full-name }}](../datalens/qa/){% endif %}
   {% if product == "yandex-cloud" %}- [{{ dataproc-full-name }}](../data-proc/qa/){% endif %}
   - [{{ mkf-full-name }}](../managed-kafka/qa/)
   - [{{ mch-full-name }}](../managed-clickhouse/qa/all.md)
   {% if product == "yandex-cloud" %}- [{{ mes-full-name }}](../managed-elasticsearch/qa/){% endif %}
   {% if product == "yandex-cloud" %}- [{{ mmg-full-name }}](../managed-mongodb/qa/all.md){% endif %}
   - [{{ mmy-full-name }}](../managed-mysql/qa/all.md)
   - [{{ mpg-full-name }}](../managed-postgresql/qa/all.md)
   {% if product == "yandex-cloud" %}- [{{ mrd-full-name }}](../managed-redis/qa/general.md){% endif %}
   {% if product == "yandex-cloud" %}- [{{ mms-full-name }}](../managed-sqlserver/qa/general.md){% endif %}
   - [{{ monitoring-full-name }}](../monitoring/qa/all.md)
   - [{{ objstorage-full-name }}](../storage/qa/)

- Container-based development:
   - [{{ container-registry-full-name }}](../container-registry/qa/)
   - [{{ managed-k8s-full-name }}<sup>®</sup>](../managed-kubernetes/qa/all.md)

{% if product == "yandex-cloud" %}
- Serverless computing:
   - [{{ sf-full-name }}](../functions/qa/)
   - [{{ ydb-full-name }}](../ydb/faq.md)
   - [{{ objstorage-full-name }}](../storage/qa/)
{% endif %}

- Resources and management:
   - [{{ iam-full-name }}](../iam/qa/)
   - [{{ monitoring-full-name }}](../monitoring/qa/all.md)

{% if product == "yandex-cloud" %}
- Business tools:
   - [{{ datalens-full-name }}](../datalens/qa/)
   - [{{ tracker-full-name }}](../tracker/faq/)
{% endif %}

{% if product == "yandex-cloud" %}
{% include [Greenplum trademark](../_includes/mdb/mgp/trademark.md) %}
{% endif %}
