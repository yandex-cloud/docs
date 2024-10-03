---
title: Справочник {{ TF }} для {{ mgp-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ mgp-name }}.
---

# Справочник {{ TF }} для {{ mgp-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ mgp-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_mdb_greenplum_cluster]({{ tf-provider-resources-link }}/mdb_greenplum_cluster) | [Кластер](./concepts/index.md) |

## Источники данных {#data-sources}

Для {{ mgp-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_mdb_greenplum_cluster]({{ tf-provider-datasources-link }}/datasource_mdb_greenplum_cluster) | Информация о [кластере](./concepts/index.md) |