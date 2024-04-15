# {{ TF }} reference for {{ mkf-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ mkf-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_mdb_kafka_cluster]({{ tf-provider-resources-link }}/mdb_kafka_cluster) | [{{ KF }} cluster](./concepts/index.md) |
| [yandex_mdb_kafka_connect]({{ tf-provider-resources-link }}/mdb_kafka_connect) | [Connector](./concepts/connectors.md) |
| [yandex_mdb_kafka_topic]({{ tf-provider-resources-link }}/mdb_kafka_topic) | [Topic](./concepts/topics.md) |
| [yandex_mdb_kafka_user]({{ tf-provider-resources-link }}/mdb_kafka_user) | [User](./concepts/managed-schema-registry.md#msr-auth) |

## Data sources {#data-sources}

{{ mkf-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_mdb_kafka_cluster]({{ tf-provider-datasources-link }}/datasource_mdb_kafka_cluster) | [{{ KF }} cluster](./concepts/index.md) information |
| [yandex_mdb_kafka_connector]({{ tf-provider-datasources-link }}/datasource_mdb_kafka_connector) | [Connector](./concepts/connectors.md) information |
| [yandex_mdb_kafka_topic]({{ tf-provider-datasources-link }}/datasource_mdb_kafka_topic) | [Topic](./concepts/topics.md) information |
| [yandex_mdb_kafka_user]({{ tf-provider-datasources-link }}/datasource_mdb_kafka_user) | [User](./concepts/managed-schema-registry.md#msr-auth) information |