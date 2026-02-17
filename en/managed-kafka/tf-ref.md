---
title: '{{ TF }} reference for {{ mkf-full-name }}'
description: This page gives information about the {{ TF }} provider resources and data sources supported by {{ mkf-name }}.
---

# {{ TF }} reference for {{ mkf-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ mkf-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_mdb_kafka_cluster]({{ tf-provider-resources-link }}/mdb_kafka_cluster) | [{{ KF }} cluster](./concepts/index.md) |
| [yandex_mdb_kafka_connect]({{ tf-provider-resources-link }}/mdb_kafka_connector) | [Connector](./concepts/connectors.md) |
| [yandex_mdb_kafka_topic]({{ tf-provider-resources-link }}/mdb_kafka_topic) | [Topic](./concepts/topics.md) |
| [yandex_mdb_kafka_user]({{ tf-provider-resources-link }}/mdb_kafka_user) | [User](./concepts/managed-schema-registry.md#msr-auth) |

## Data sources {#data-sources}

{{ mkf-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_mdb_kafka_cluster]({{ tf-provider-datasources-link }}/mdb_kafka_cluster) | [{{ KF }} cluster](./concepts/index.md) information |
| [yandex_mdb_kafka_connector]({{ tf-provider-datasources-link }}/mdb_kafka_connector) | [Connector](./concepts/connectors.md) information |
| [yandex_mdb_kafka_topic]({{ tf-provider-datasources-link }}/mdb_kafka_topic) | [Topic](./concepts/topics.md) information |
| [yandex_mdb_kafka_user]({{ tf-provider-datasources-link }}/mdb_kafka_user) | [User](./concepts/managed-schema-registry.md#msr-auth) information |