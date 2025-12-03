---
title: Справочник {{ TF }} для {{ mch-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ mch-name }}.
---

# Справочник {{ TF }} для {{ mch-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ mch-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_mdb_clickhouse_cluster]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster) | [Кластер](concepts/index.md) |
| [yandex_mdb_clickhouse_database]({{ tf-provider-resources-link }}/mdb_clickhouse_database) | База данных |
| [yandex_mdb_clickhouse_user]({{ tf-provider-resources-link }}/mdb_clickhouse_user) | Пользователь {{ mch-name }} |

## Источники данных {#data-sources}

Для {{ mch-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_mdb_clickhouse_cluster]({{ tf-provider-datasources-link }}/mdb_clickhouse_cluster) | Информация о [кластере](concepts/index.md) |
| [yandex_mdb_clickhouse_database]({{ tf-provider-datasources-link }}/mdb_clickhouse_database) | Информация о базе данных |
| [yandex_mdb_clickhouse_user]({{ tf-provider-datasources-link }}/mdb_clickhouse_user) | Информация о пользователе {{ mch-name }} |

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
