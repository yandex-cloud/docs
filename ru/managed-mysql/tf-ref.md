---
title: Справочник {{ TF }} для {{ mmy-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ mmy-name }}.
---

# Справочник {{ TF }} для {{ mmy-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ mmy-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_mdb_mysql_cluster]({{ tf-provider-resources-link }}/mdb_mysql_cluster) | [Кластер](concepts/index.md) |
| [yandex_mdb_mysql_database]({{ tf-provider-resources-link }}/mdb_mysql_database) | База данных |
| [yandex_mdb_mysql_user]({{ tf-provider-resources-link }}/mdb_mysql_user) | Пользователь базы данных |

## Источники данных {#data-sources}

Для {{ mmy-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_mdb_mysql_cluster]({{ tf-provider-datasources-link }}/mdb_mysql_cluster) | Информация о [кластере](./concepts/index.md) |
| [yandex_mdb_mysql_user]({{ tf-provider-datasources-link }}/mdb_mysql_user) | Информация о пользователе базы данных |