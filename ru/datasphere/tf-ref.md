---
title: "Справочник {{ TF }} для {{ ml-platform-full-name }}"
description: "На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ ml-platform-name }}."
---

# Справочник {{ TF }} для {{ ml-platform-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ ml-platform-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_datasphere_community]({{ tf-provider-resources-link }}/datasphere_community) | [Сообщество](concepts/community.md) |
| [yandex_datasphere_community_iam_binding]({{ tf-provider-resources-link }}/datasphere_community_iam_binding) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к сообществу |
| [yandex_datasphere_project]({{ tf-provider-resources-link }}/datasphere_project) | [Проект](concepts/project.md) |
| [yandex_datasphere_project_iam_binding]({{ tf-provider-resources-link }}/datasphere_project_iam_binding) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к проекту |

## Источники данных {#data-sources}

Для {{ ml-platform-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_datasphere_community]({{ tf-provider-datasources-link }}/datasource_datasphere_community) | Информация о [сообществе](concepts/community.md) |
| [yandex_datasphere_project]({{ tf-provider-datasources-link }}/datasource_datasphere_project) | Информация о [проекте](concepts/project.md) |
