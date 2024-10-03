---
title: Справочник {{ TF }} для {{ dataproc-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ dataproc-name }}.
---

# Справочник {{ TF }} для {{ dataproc-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ dataproc-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_dataproc_cluster]({{ tf-provider-resources-link }}/dataproc_cluster) | [Кластер {{ dataproc-name }}](./concepts/index.md#resources) |

## Источники данных {#data-sources}

Для {{ dataproc-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_dataproc_cluster]({{ tf-provider-datasources-link }}/datasource_dataproc_cluster) | Информация о [кластере {{ dataproc-name }}](./concepts/index.md#resources) |