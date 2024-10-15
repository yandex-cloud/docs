---
title: Справочник {{ TF }} для {{ mkf-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ mkf-name }}.
---

# Справочник {{ TF }} для {{ mkf-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ mkf-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_mdb_kafka_cluster]({{ tf-provider-resources-link }}/mdb_kafka_cluster) | [Кластер {{ KF }}](./concepts/index.md) |
| [yandex_mdb_kafka_connect]({{ tf-provider-resources-link }}/mdb_kafka_connect) | [Коннектор](./concepts/connectors.md) |
| [yandex_mdb_kafka_topic]({{ tf-provider-resources-link }}/mdb_kafka_topic) | [Топик](./concepts/topics.md) |
| [yandex_mdb_kafka_user]({{ tf-provider-resources-link }}/mdb_kafka_user) | [Пользователь](./concepts/managed-schema-registry.md#msr-auth) |

## Источники данных {#data-sources}

Для {{ mkf-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_mdb_kafka_cluster]({{ tf-provider-datasources-link }}/mdb_kafka_cluster) | Информация о [кластере {{ KF }}](./concepts/index.md) |
| [yandex_mdb_kafka_connector]({{ tf-provider-datasources-link }}/mdb_kafka_connector) | Информация о [коннекторе](./concepts/connectors.md) |
| [yandex_mdb_kafka_topic]({{ tf-provider-datasources-link }}/mdb_kafka_topic) | Информация о [топике](./concepts/topics.md) |
| [yandex_mdb_kafka_user]({{ tf-provider-datasources-link }}/mdb_kafka_user) | Информация о [пользователе](./concepts/managed-schema-registry.md#msr-auth) |