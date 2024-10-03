---
title: Справочник {{ TF }} для {{ mos-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ mos-name }}.
---

# Справочник {{ TF }} для {{ mos-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ mos-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_mdb_opensearch_cluster]({{ tf-provider-resources-link }}/mdb_opensearch_cluster) | [Кластер](./concepts/index.md) |

## Источники данных {#data-sources}

Для {{ mos-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_mdb_opensearch_cluster]({{ tf-provider-datasources-link }}/datasource_mdb_opensearch_cluster) | Информация о [кластере](./concepts/index.md) |