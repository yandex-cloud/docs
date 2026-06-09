# Справочник {{ TF }} для {{ iam-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ iam-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account) | [Сервисный аккаунт](concepts/users/service-accounts.md) |
| [yandex_iam_service_account_api_key]({{ tf-provider-resources-link }}/iam_service_account_api_key) | [API-ключ](concepts/authorization/api-key.md) |
| [yandex_iam_service_account_iam_binding]({{ tf-provider-resources-link }}/iam_service_account_iam_binding) | [Назначение](concepts/access-control/index.md#access-bindings) прав доступа к сервисному аккаунту. Имеет ограничение в 1000 привязок на ресурс. <br>Вместо `iam_service_account_iam_binding` рекомендуется использовать `iam_service_account_iam_member` |
| [yandex_iam_service_account_iam_member]({{ tf-provider-resources-link }}/iam_service_account_iam_member) | [Назначение](concepts/access-control/index.md#access-bindings) прав доступа к сервисному аккаунту |
| [yandex_iam_service_account_iam_policy]({{ tf-provider-resources-link }}/iam_service_account_iam_policy) | Устанавливает политику доступа сервисного аккаунта и заменяет любую заданную политику |
| [yandex_iam_service_account_key]({{ tf-provider-resources-link }}/iam_service_account_key) | [Авторизованный ключ](concepts/authorization/key.md) |
| [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key) | [Статический ключ](concepts/authorization/access-key.md) |

## Источники данных {#data-sources}

Для {{ iam-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_iam_policy]({{ tf-provider-datasources-link }}/iam_policy) | Информация о политике доступа |
| [yandex_iam_role]({{ tf-provider-datasources-link }}/iam_role) | Информация о [роли](concepts/access-control/roles.md) |
| [yandex_iam_service_account]({{ tf-provider-datasources-link }}/iam_service_account) | Информация о [сервисном аккаунте](concepts/users/service-accounts.md) |
| [yandex_iam_user]({{ tf-provider-datasources-link }}/iam_user) | Информация о пользователе |