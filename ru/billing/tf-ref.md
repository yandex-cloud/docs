---
title: Справочник {{ TF }} для {{ billing-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ billing-name }}.
---

# Справочник {{ TF }} для {{ billing-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ billing-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_billing_cloud_binding]({{ tf-provider-resources-link }}/billing_cloud_binding) | Привязка [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к [платежному аккаунту](./concepts/billing-account.md) |

## Источники данных {#data-sources}

Для {{ billing-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_billing_cloud_binding]({{ tf-provider-datasources-link }}/datasource_billing_cloud_binding) | Информация о привязке [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к [платежному аккаунту](./concepts/billing-account.md) |
