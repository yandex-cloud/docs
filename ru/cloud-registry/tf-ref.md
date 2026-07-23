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
| [yandex_cloudregistry_lifecycle_policy]({{ tf-provider-resources-link }}/cloudregistry_lifecycle_policy) | [Политика жизненного цикла](./concepts/lifecycle-policy.md) |
| [yandex_cloudregistry_folder]({{ tf-provider-resources-link }}/cloudregistry_folder) | Папка для хранения артефактов |
| [yandex_cloudregistry_folder_iam_binding]({{ tf-provider-resources-link }}/cloudregistry_folder_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к папке |

## Источники данных {#data-sources}

Для {{ cloud-registry-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_cloudregistry_registry]({{ tf-provider-datasources-link }}/cloudregistry_registry) | Информация о [реестре](./concepts/registry.md) |
| [yandex_cloudregistry_registry_ip_permission]({{ tf-provider-datasources-link }}/cloudregistry_registry_ip_permission) | Информация о политике доступа для IP-адресов |
| [yandex_cloudregistry_lifecycle_policy]({{ tf-provider-datasources-link }}/cloudregistry_lifecycle_policy) | Информация о [политике жизненного цикла](./concepts/lifecycle-policy.md) |
| [yandex_cloudregistry_folder]({{ tf-provider-datasources-link }}/cloudregistry_folder) | Информация о папке |