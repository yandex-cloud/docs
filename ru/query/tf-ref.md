---
title: Справочник {{ TF }} для {{ yq-full-name }}
description: На этой странице приведен справочник ресурсов провайдера {{ TF }}, которые поддерживаются для сервиса {{ yq-name }}.
---

# Справочник {{ TF }} для {{ yq-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ yq-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_yq_ydb_connection]({{ tf-provider-resources-link }}/yq_ydb_connection) | [Соединение {{ ydb-name }}](./concepts/glossary.md#connection) |
| [yandex_yq_yds_connection]({{ tf-provider-resources-link }}/yq_yds_connection) | [Соединение {{ yds-name }}](./concepts/glossary.md#connection) |
| [yandex_yq_yds_binding]({{ tf-provider-resources-link }}/yq_yds_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к [соединению {{ yds-name }}](./concepts/glossary.md#connection) |
| [yandex_yq_monitoring_connection]({{ tf-provider-resources-link }}/yq_monitoring_connection) | [Соединение {{ monitoring-full-name }}](./concepts/glossary.md#connection) |
| [yandex_yq_object_storage_connection]({{ tf-provider-resources-link }}/yq_object_storage_connection) | [Соединение {{ objstorage-name }}](./concepts/glossary.md#connection) |
| [yandex_yq_object_storage_binding]({{ tf-provider-resources-link }}/yq_object_storage_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к [соединению {{ objstorage-name }}](./concepts/glossary.md#connection) |
