---
title: Справочник {{ TF }} для {{ metastore-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для {{ metastore-name }} в сервисе {{ metadata-hub-full-name }}.
---

# Справочник {{ TF }} для {{ metastore-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ metastore-name }} поддерживается следующий ресурс провайдера {{ TF }}:

| **Ресурс {{ TF }}**                                                            | **Ресурс {{ yandex-cloud }}**                           |
|--------------------------------------------------------------------------------|---------------------------------------------------------|
| [yandex_metastore_cluster]({{ tf-provider-resources-link }}/metastore_cluster) | [Кластер {{ metastore-name }}](./concepts/metastore.md) |

## Источники данных {#data-sources}

Для {{ metastore-name }} поддерживается следующий источник данных провайдера {{ TF }}:

| **Источник данных {{ TF }}**                                                     | **Описание**                                                          |
|----------------------------------------------------------------------------------|-----------------------------------------------------------------------|
| [yandex_metastore_cluster]({{ tf-provider-datasources-link }}/metastore_cluster) | Информация о [кластере {{ metastore-name }}](./concepts/metastore.md) |