[Документация Yandex Cloud](../index.md) > [Yandex Lockbox](index.md) > Справочник Terraform

# Справочник Terraform для Yandex Lockbox

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Yandex Lockbox поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_lockbox_secret](../terraform/resources/lockbox_secret.md) | [Секрет](concepts/secret.md#secret) |
| [yandex_lockbox_secret_iam_binding](../terraform/resources/lockbox_secret_iam_binding.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к секрету. <br>Вместо `yandex_lockbox_secret_iam_binding` рекомендуется использовать `yandex_lockbox_secret_iam_member` |
| [yandex_lockbox_secret_iam_member](../terraform/resources/lockbox_secret_iam_member.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к секрету |
| [yandex_lockbox_secret_version](../terraform/resources/lockbox_secret_version.md) | [Версия секрета](concepts/secret.md#version)<br> Вместо `lockbox_secret_version` рекомендуется использовать `lockbox_secret_version_hashed` |
| [yandex_lockbox_secret_version_hashed](../terraform/resources/lockbox_secret_version_hashed.md) | [Версия секрета](concepts/secret.md#version), хранит в состоянии Terraform значения в хешированном виде. <br> Хранить данные в таком виде безопаснее, чем в открытом. <br> Может содержать не более 10 пар ключей и значений |

## Источники данных {#data-sources}

Для Yandex Lockbox поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_lockbox_secret](../terraform/data-sources/lockbox_secret.md) | Информация о [секрете](concepts/secret.md#secret) |
| [yandex_lockbox_secret_version](../terraform/data-sources/lockbox_secret_version.md) | Информация о [версии секрета](concepts/secret.md#version) |