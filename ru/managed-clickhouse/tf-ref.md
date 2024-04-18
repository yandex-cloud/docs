# Справочник {{ TF }} для {{ mch-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ mch-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_mdb_clickhouse_cluster]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster) | [Кластер](concepts/index.md) |

## Источники данных {#data-sources}

Для {{ mch-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_mdb_clickhouse_cluster]({{ tf-provider-datasources-link }}/datasource_mdb_clickhouse_cluster) | Информация о [кластере](concepts/index.md) |

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
