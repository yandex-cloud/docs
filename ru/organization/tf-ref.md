---
title: "Справочник {{ TF }} для {{ org-full-name }}"
description: "На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ org-name }}."
---

# Справочник {{ TF }} для {{ org-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ org-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_organizationmanager_group]({{ tf-provider-resources-link }}/organizationmanager_group) | [Группа пользователей](./concepts/groups.md) |
| [yandex_organizationmanager_group_iam_member]({{ tf-provider-resources-link }}/organizationmanager_group_iam_member) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к группе пользователей |
| [yandex_organizationmanager_group_membership]({{ tf-provider-resources-link }}/organizationmanager_group_membership) | Участник группы пользователей |
| [yandex_organizationmanager_organization_iam_binding]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к организации. Имеет ограничение в 1000 привязок на ресурс. <br>Вместо `yandex_organizationmanager_organization_iam_binding` рекомендуется использовать `yandex_organizationmanager_organization_iam_member` |
| [yandex_organizationmanager_organization_iam_member]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_member) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к организации |
| [yandex_organizationmanager_saml_federation]({{ tf-provider-resources-link }}/organizationmanager_saml_federation) | [SAML-совместимая федерация удостоверений](./concepts/add-federation.md) |
| [yandex_organizationmanager_saml_federation_user_account]({{ tf-provider-resources-link }}/organizationmanager_saml_federation_user_account) | [Федеративный пользователь](./concepts/add-federation.md#saml-authentication) |

## Источники данных {#data-sources}

Для {{ org-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_organizationmanager_group]({{ tf-provider-datasources-link }}/datasource_organizationmanager_group) | Информация о [группе пользователей](./concepts/groups.md) |
| [yandex_organizationmanager_os_login_settings]({{ tf-provider-datasources-link }}/datasource_organizationmanager_os_login_settings) | Информация о настройках доступа по [OS Login](./concepts/os-login.md) |
| [yandex_organizationmanager_saml_federation]({{ tf-provider-datasources-link }}/datasource_organizationmanager_saml_federation) | Информация о [SAML-совместимой федерации удостоверений](./concepts/add-federation.md) |
| [yandex_organizationmanager_saml_federation_user_account]({{ tf-provider-datasources-link }}/datasource_organizationmanager_saml_federation_user_account) | Информация о [федеративном пользователе](./concepts/add-federation.md#saml-authentication) |
| [yandex_organizationmanager_user_ssh_key]({{ tf-provider-datasources-link }}/datasource_organizationmanager_user_ssh_key) | Информация об [SSH-ключе](../glossary/ssh-keygen.md) пользователя |