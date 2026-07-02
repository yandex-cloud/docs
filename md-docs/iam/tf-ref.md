[Документация Yandex Cloud](../index.md) > [Yandex Identity and Access Management](index.md) > Справочник Terraform

# Справочник Terraform для Yandex Identity and Access Management

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Identity and Access Management поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_iam_service_account](../terraform/resources/iam_service_account.md) | [Сервисный аккаунт](concepts/users/service-accounts.md) |
| [yandex_iam_service_account_api_key](../terraform/resources/iam_service_account_api_key.md) | [API-ключ](concepts/authorization/api-key.md) |
| [yandex_iam_service_account_iam_binding](../terraform/resources/iam_service_account_iam_binding.md) | [Назначение](concepts/access-control/index.md#access-bindings) прав доступа к сервисному аккаунту. Имеет ограничение в 1000 привязок на ресурс. <br>Вместо `iam_service_account_iam_binding` рекомендуется использовать `iam_service_account_iam_member` |
| [yandex_iam_service_account_iam_member](../terraform/resources/iam_service_account_iam_member.md) | [Назначение](concepts/access-control/index.md#access-bindings) прав доступа к сервисному аккаунту |
| [yandex_iam_service_account_iam_policy](../terraform/resources/iam_service_account_iam_policy.md) | Устанавливает политику доступа сервисного аккаунта и заменяет любую заданную политику |
| [yandex_iam_service_account_key](../terraform/resources/iam_service_account_key.md) | [Авторизованный ключ](concepts/authorization/key.md) |
| [yandex_iam_service_account_static_access_key](../terraform/resources/iam_service_account_static_access_key.md) | [Статический ключ](concepts/authorization/access-key.md) |

## Источники данных {#data-sources}

Для Identity and Access Management поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_iam_policy](../terraform/data-sources/iam_policy.md) | Информация о политике доступа |
| [yandex_iam_role](../terraform/data-sources/iam_role.md) | Информация о [роли](concepts/access-control/roles.md) |
| [yandex_iam_service_account](../terraform/data-sources/iam_service_account.md) | Информация о [сервисном аккаунте](concepts/users/service-accounts.md) |
| [yandex_iam_user](../terraform/data-sources/iam_user.md) | Информация о пользователе |