---
title: Справочник {{ TF }} для {{ connection-manager-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для {{ connection-manager-name }} в сервисе {{ metadata-hub-full-name }}.
---

# Справочник {{ TF }} для {{ connection-manager-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ connection-manager-name }} поддерживается следующий ресурс провайдера {{ TF }}:

| **Ресурс {{ TF }}**                                       | **Ресурс {{ yandex-cloud }}**                   |
|-----------------------------------------------------------|-------------------------------------------------|
| [yandex_connectionmanager_connection]({{ tf-provider-resources-link }}/connectionmanager_connection) | [Подключение](./concepts/connection-manager.md) |

## Источники данных {#data-sources}

Для {{ connection-manager-name }} поддерживается следующий источник данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание**                                    |
| --- |-------------------------------------------------|
| [yandex_connectionmanager_connection]({{ tf-provider-datasources-link }}/connectionmanager_connection) | Информация о [подключении](./concepts/connection-manager.md) |
