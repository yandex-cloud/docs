---
title: Справочник {{ TF }} для {{ cloud-registry-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ cloud-registry-full-name }}.
---

# Справочник {{ TF }} для {{ cloud-registry-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ cloud-registry-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_cloudregistry_registry]({{ tf-provider-resources-link }}/cloudregistry_registry) | [Реестр](./concepts/registry.md) |
| [yandex_cloudregistry_registry_iam_binding]({{ tf-provider-resources-link }}/cloudregistry_registry_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к реестру |
| [yandex_cloudregistry_registry_ip_permission]({{ tf-provider-resources-link }}/cloudregistry_registry_ip_permission) | Политика доступа для IP-адресов |

## Источники данных {#data-sources}

Для {{ cloud-registry-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_cloudregistry_registry]({{ tf-provider-datasources-link }}/cloudregistry_registry) | Информация о [реестре](./concepts/registry.md) |
| [yandex_cloudregistry_registry_ip_permission]({{ tf-provider-datasources-link }}/cloudregistry_registry_ip_permission) | Информация о политике доступа для IP-адресов |