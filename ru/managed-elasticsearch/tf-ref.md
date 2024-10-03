---
title: Справочник {{ TF }} для {{ mes-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ mes-name }}.
---

# Справочник {{ TF }} для {{ mes-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ mes-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_mdb_elasticsearch_cluster]({{ tf-provider-resources-link }}/mdb_elasticsearch_cluster) | [Кластер](./concepts/index.md) |

## Источники данных {#data-sources}

Для {{ mes-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_mdb_elasticsearch_cluster]({{ tf-provider-datasources-link }}/datasource_mdb_elasticsearch_cluster) | Информация о [кластере](./concepts/index.md) |