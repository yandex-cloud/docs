---
title: "Справочник {{ TF }} для {{ message-queue-full-name }}"
description: "На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ message-queue-name }}."
---

# Справочник {{ TF }} для {{ message-queue-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ message-queue-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_message_queue]({{ tf-provider-resources-link }}/message_queue) | [Очередь сообщений](./concepts/queue.md) |

## Источники данных {#data-sources}

Для {{ message-queue-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_message_queue]({{ tf-provider-datasources-link }}/datasource_message_queue) | Информация об [очереди сообщений](./concepts/queue.md) |