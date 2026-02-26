---
title: Справочник {{ TF }} для {{ mmg-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ mmg-name }}.
---

# Справочник {{ TF }} для {{ mmg-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ mmg-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_mdb_mongodb_cluster]({{ tf-provider-resources-link }}/mdb_mongodb_cluster) | [Кластер](concepts/index.md) |
| [yandex_mdb_mongodb_cluster_iam_binding]({{ tf-provider-resources-link }}/mdb_mongodb_cluster_iam_binding) | [Настройка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру |

## Источники данных {#data-sources}

Для {{ mmg-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_mdb_mongodb_cluster]({{ tf-provider-datasources-link }}/mdb_mongodb_cluster) | Информация о [кластере](./concepts/index.md) |
| [yandex_mdb_mongodb_database]({{ tf-provider-datasources-link }}/mdb_mongodb_database) | Информация о базе данных |
| [yandex_mdb_mongodb_user]({{ tf-provider-datasources-link }}/mdb_mongodb_user) | Информация о пользователе базы данных |
