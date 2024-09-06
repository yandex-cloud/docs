---
title: "Справочник {{ TF }} для {{ iam-full-name }}"
description: "На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ iam-name }}."
---

# Справочник {{ TF }} для {{ iam-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ iam-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account) | [Сервисный аккаунт](./concepts/users/service-accounts.md) |
| [yandex_iam_service_account_api_key]({{ tf-provider-resources-link }}/iam_service_account_api_key) | [API-ключ](./concepts/authorization/api-key.md) |
| [yandex_iam_service_account_iam_binding]({{ tf-provider-resources-link }}/iam_service_account_iam_binding) | [Назначение](./concepts/access-control/index.md#access-bindings) прав доступа к сервисному аккаунту. Имеет ограничение в 1000 привязок на ресурс. <br>Вместо `iam_service_account_iam_binding` рекомендуется использовать `iam_service_account_iam_member` |
| [yandex_iam_service_account_iam_member]({{ tf-provider-resources-link }}/iam_service_account_iam_member) | [Назначение](./concepts/access-control/index.md#access-bindings) прав доступа к сервисному аккаунту |
| [yandex_iam_service_account_iam_policy]({{ tf-provider-resources-link }}/iam_service_account_iam_policy) | Устанавливает политику доступа сервисного аккаунта и заменяет любую заданную политику |
| [yandex_iam_service_account_key]({{ tf-provider-resources-link }}/iam_service_account_key) | [Авторизованный ключ](./concepts/authorization/key.md) |
| [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key) | [Статический ключ](./concepts/authorization/access-key.md) |

## Источники данных {#data-sources}

Для {{ iam-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_iam_policy]({{ tf-provider-datasources-link }}/datasource_iam_policy) | Информация о политике доступа |
| [yandex_iam_role]({{ tf-provider-datasources-link }}/datasource_iam_role) | Информация о [роли](./concepts/access-control/roles.md) |
| [yandex_iam_service_account]({{ tf-provider-datasources-link }}/datasource_iam_service_account) | Информация о [сервисном аккаунте](./concepts/users/service-accounts.md) |
| [yandex_iam_user]({{ tf-provider-datasources-link }}/datasource_iam_user) | Информация о пользователе |