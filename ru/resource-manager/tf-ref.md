---
title: Справочник {{ TF }} для {{ resmgr-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ resmgr-name }}.
---

# Справочник {{ TF }} для {{ resmgr-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ resmgr-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_resourcemanager_cloud]({{ tf-provider-resources-link }}/resourcemanager_cloud) | [Облако](./concepts/resources-hierarchy.md#cloud) |
| [yandex_resourcemanager_cloud_iam_binding]({{ tf-provider-resources-link }}/resourcemanager_cloud_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к облаку. Имеет ограничение в 1000 привязок на ресурс. <br>Вместо `yandex_resourcemanager_cloud_iam_binding` рекомендуется использовать `yandex_resourcemanager_cloud_iam_member` |
| [yandex_resourcemanager_cloud_iam_member]({{ tf-provider-resources-link }}/resourcemanager_cloud_iam_member) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к облаку |
| [yandex_resourcemanager_folder]({{ tf-provider-resources-link }}/resourcemanager_folder) | [Каталог](./concepts/resources-hierarchy.md#folder) |
| [yandex_resourcemanager_folder_iam_binding]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к каталогу. Имеет ограничение в 1000 привязок на ресурс. <br>Вместо `yandex_resourcemanager_folder_iam_binding` рекомендуется использовать `yandex_resourcemanager_folder_iam_member` |
| [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к каталогу |
| [yandex_resourcemanager_folder_iam_policy]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_policy) | Устанавливает политику доступа к каталогу и заменяет любую заданную политику |

## Источники данных {#data-sources}

Для {{ resmgr-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_resourcemanager_cloud]({{ tf-provider-datasources-link }}/resourcemanager_cloud) | Информация об [облаке](./concepts/resources-hierarchy.md#cloud) |
| [yandex_resourcemanager_folder]({{ tf-provider-datasources-link }}/resourcemanager_folder) | Информация о [каталоге](./concepts/resources-hierarchy.md#folder) |