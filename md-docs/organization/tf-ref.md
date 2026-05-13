# Справочник Terraform для Yandex Identity Hub

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Yandex Identity Hub поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_organizationmanager_group](../terraform/resources/organizationmanager_group.md) | [Группа пользователей](concepts/groups.md) |
| [yandex_organizationmanager_group_iam_member](../terraform/resources/organizationmanager_group_iam_member.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к группе пользователей |
| [yandex_organizationmanager_group_mapping](../terraform/resources/organizationmanager_group_mapping.md) | Настройка [сопоставления групп пользователей](concepts/add-federation.md#group-mapping) |
| [yandex_organizationmanager_group_mapping_item](../terraform/resources/organizationmanager_group_mapping_item.md) | Элемент [сопоставления групп пользователей](concepts/add-federation.md#group-mapping) |
| [yandex_organizationmanager_group_membership](../terraform/resources/organizationmanager_group_membership.md) | Участник [группы пользователей](concepts/groups.md) |
| [yandex_organizationmanager_idp_application_oauth_application](../terraform/resources/organizationmanager_idp_application_oauth_application.md) | [OIDC-приложение](concepts/applications.md#oidc) |
| [yandex_organizationmanager_idp_application_saml_application](../terraform/resources/organizationmanager_idp_application_saml_application.md) | [SAML-приложение](concepts/applications.md#saml) |
| [yandex_organizationmanager_idp_user](../terraform/resources/organizationmanager_idp_user.md) | [Локальный пользователь](../iam/concepts/users/accounts.md#local) |
| [yandex_organizationmanager_idp_userpool](../terraform/resources/organizationmanager_idp_userpool.md) | [Пул пользователей](concepts/user-pools.md) |
| [yandex_organizationmanager_mfa_enforcement](../terraform/resources/organizationmanager_mfa_enforcement.md) | [Политика MFA](concepts/mfa.md#mfa-policies) |
| [yandex_organizationmanager_mfa_enforcement_audience](../terraform/resources/organizationmanager_mfa_enforcement_audience.md) | Целевая группа [политики MFA](concepts/mfa.md#mfa-policies) |
| [yandex_organizationmanager_organization_iam_binding](../terraform/resources/organizationmanager_organization_iam_binding.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к организации. Имеет ограничение в 1000 привязок на ресурс. <br>Вместо `yandex_organizationmanager_organization_iam_binding` рекомендуется использовать `yandex_organizationmanager_organization_iam_member` |
| [yandex_organizationmanager_organization_iam_member](../terraform/resources/organizationmanager_organization_iam_member.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к организации |
| [yandex_organizationmanager_os_login_settings](../terraform/resources/organizationmanager_os_login_settings.md) | Настройки доступа по [OS Login](concepts/os-login.md) |
| [yandex_organizationmanager_saml_federation](../terraform/resources/organizationmanager_saml_federation.md) | [SAML-совместимая федерация удостоверений](concepts/add-federation.md) |
| [yandex_organizationmanager_saml_federation_user_account](../terraform/resources/organizationmanager_saml_federation_user_account.md) | [Федеративный пользователь](concepts/add-federation.md#saml-authentication) |
| [yandex_organizationmanager_user_ssh_key](../terraform/resources/organizationmanager_user_ssh_key.md) | [SSH-ключ](concepts/os-login.md#ssh-keys) для доступа по OS Login |


## Источники данных {#data-sources}

Для Yandex Identity Hub поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_organizationmanager_group](../terraform/data-sources/organizationmanager_group.md) | Информация о [группе пользователей](concepts/groups.md) |
| [yandex_organizationmanager_idp_application_oauth_application](../terraform/data-sources/organizationmanager_idp_application_oauth_application.md) | Информация о [OIDC-приложении](concepts/applications.md#oidc) |
| [yandex_organizationmanager_idp_application_saml_application](../terraform/data-sources/organizationmanager_idp_application_saml_application.md) | Информация о [SAML-приложении](concepts/applications.md#saml) |
| [yandex_organizationmanager_idp_user](../terraform/data-sources/organizationmanager_idp_user.md) | Информация о [локальном пользователе](../iam/concepts/users/accounts.md#local) |
| [yandex_organizationmanager_idp_userpool](../terraform/data-sources/organizationmanager_idp_userpool.md) | Информация о [пуле пользователей](concepts/user-pools.md) |
| [yandex_organizationmanager_mfa_enforcement](../terraform/data-sources/organizationmanager_mfa_enforcement.md) | Информация о [политике MFA](concepts/mfa.md#mfa-policies) |
| [yandex_organizationmanager_os_login_settings](../terraform/data-sources/organizationmanager_os_login_settings.md) | Информация о настройках доступа по [OS Login](concepts/os-login.md) |
| [yandex_organizationmanager_saml_federation](../terraform/data-sources/organizationmanager_saml_federation.md) | Информация о [SAML-совместимой федерации удостоверений](concepts/add-federation.md) |
| [yandex_organizationmanager_saml_federation_user_account](../terraform/data-sources/organizationmanager_saml_federation_user_account.md) | Информация о [федеративном пользователе](concepts/add-federation.md#saml-authentication) |
| [yandex_organizationmanager_user_ssh_key](../terraform/data-sources/organizationmanager_user_ssh_key.md) | Информация о [SSH-ключе](concepts/os-login.md#ssh-keys) пользователя |