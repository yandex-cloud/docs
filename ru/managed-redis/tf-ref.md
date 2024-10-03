---
title: Справочник {{ TF }} для {{ mrd-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ mrd-name }}.
---

# Справочник {{ TF }} для {{ mrd-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ mrd-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_mdb_redis_cluster]({{ tf-provider-resources-link }}/mdb_redis_cluster) | [Кластер](./concepts/index.md) |

## Источники данных {#data-sources}

Для {{ mrd-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_mdb_redis_cluster]({{ tf-provider-datasources-link }}/datasource_mdb_redis_cluster) | Информация о [кластере](./concepts/index.md) |