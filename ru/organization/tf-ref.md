---
title: Справочник {{ TF }} для {{ org-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ org-name }}.
---

# Справочник {{ TF }} для {{ org-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ org-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_organizationmanager_group]({{ tf-provider-resources-link }}/organizationmanager_group) | [Группа пользователей](./concepts/groups.md) |
| [yandex_organizationmanager_group_iam_member]({{ tf-provider-resources-link }}/organizationmanager_group_iam_member) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к группе пользователей |
| [yandex_organizationmanager_group_mapping]({{ tf-provider-resources-link }}/organizationmanager_group_mapping) | Настройка [сопоставления групп пользователей](./concepts/add-federation.md#group-mapping) |
| [yandex_organizationmanager_group_mapping_item]({{ tf-provider-resources-link }}/organizationmanager_group_mapping_item) | Элемент [сопоставления групп пользователей](./concepts/add-federation.md#group-mapping) |
| [yandex_organizationmanager_group_membership]({{ tf-provider-resources-link }}/organizationmanager_group_membership) | Участник [группы пользователей](./concepts/groups.md) |
| [yandex_organizationmanager_idp_application_oauth_application]({{ tf-provider-resources-link }}/organizationmanager_idp_application_oauth_application) | [OIDC-приложение](./concepts/applications.md#oidc) |
| [yandex_organizationmanager_idp_application_saml_application]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application) | [SAML-приложение](./concepts/applications.md#saml) |
| [yandex_organizationmanager_idp_user]({{ tf-provider-resources-link }}/organizationmanager_idp_user) | [Локальный пользователь](../iam/concepts/users/accounts.md#local) |
| [yandex_organizationmanager_idp_userpool]({{ tf-provider-resources-link }}/organizationmanager_idp_userpool) | [Пул пользователей](./concepts/user-pools.md) |
| [yandex_organizationmanager_organization_iam_binding]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к организации. Имеет ограничение в 1000 привязок на ресурс. <br>Вместо `yandex_organizationmanager_organization_iam_binding` рекомендуется использовать `yandex_organizationmanager_organization_iam_member` |
| [yandex_organizationmanager_organization_iam_member]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_member) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к организации |
| [yandex_organizationmanager_os_login_settings]({{ tf-provider-resources-link }}/organizationmanager_os_login_settings) | Настройки доступа по [{{ oslogin }}](./concepts/os-login.md) |
| [yandex_organizationmanager_saml_federation]({{ tf-provider-resources-link }}/organizationmanager_saml_federation) | [SAML-совместимая федерация удостоверений](./concepts/add-federation.md) |
| [yandex_organizationmanager_saml_federation_user_account]({{ tf-provider-resources-link }}/organizationmanager_saml_federation_user_account) | [Федеративный пользователь](./concepts/add-federation.md#saml-authentication) |
| [yandex_organizationmanager_user_ssh_key]({{ tf-provider-resources-link }}/organizationmanager_user_ssh_key) | [SSH-ключ](./concepts/os-login.md#ssh-keys) для доступа по {{ oslogin }} |


## Источники данных {#data-sources}

Для {{ org-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_organizationmanager_group]({{ tf-provider-datasources-link }}/organizationmanager_group) | Информация о [группе пользователей](./concepts/groups.md) |
| [yandex_organizationmanager_idp_application_oauth_application]({{ tf-provider-datasources-link }}/organizationmanager_idp_application_oauth_application) | Информация о [OIDC-приложении](./concepts/applications.md#oidc) |
| [yandex_organizationmanager_idp_application_saml_application]({{ tf-provider-datasources-link }}/organizationmanager_idp_application_saml_application) | Информация о [SAML-приложении](./concepts/applications.md#saml) |
| [yandex_organizationmanager_idp_user]({{ tf-provider-datasources-link }}/organizationmanager_idp_user) | Информация о [локальном пользователе](../iam/concepts/users/accounts.md#local) |
| [yandex_organizationmanager_idp_userpool]({{ tf-provider-datasources-link }}/organizationmanager_idp_userpool) | Информация о [пуле пользователей](./concepts/user-pools.md) |
| [yandex_organizationmanager_os_login_settings]({{ tf-provider-datasources-link }}/organizationmanager_os_login_settings) | Информация о настройках доступа по [{{ oslogin }}](./concepts/os-login.md) |
| [yandex_organizationmanager_saml_federation]({{ tf-provider-datasources-link }}/organizationmanager_saml_federation) | Информация о [SAML-совместимой федерации удостоверений](./concepts/add-federation.md) |
| [yandex_organizationmanager_saml_federation_user_account]({{ tf-provider-datasources-link }}/organizationmanager_saml_federation_user_account) | Информация о [федеративном пользователе](./concepts/add-federation.md#saml-authentication) |
| [yandex_organizationmanager_user_ssh_key]({{ tf-provider-datasources-link }}/organizationmanager_user_ssh_key) | Информация о [SSH-ключе](./concepts/os-login.md#ssh-keys) пользователя |
