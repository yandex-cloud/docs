[Документация Yandex Cloud](../index.md) > [Yandex Cloud Functions](index.md) > Справочник Terraform

# Справочник Terraform для Yandex Cloud Functions

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Cloud Functions поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_function](../terraform/resources/function.md) | [Функция](concepts/function.md) |
| [yandex_function_iam_binding](../terraform/resources/function_iam_binding.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к функции |
| [yandex_function_scaling_policy](../terraform/resources/function_scaling_policy.md) | [Настройки масштабирования функции](concepts/function.md#scaling) |
| [yandex_function_trigger](../terraform/resources/function_trigger.md) | [Триггер](concepts/trigger/index.md) |

## Источники данных {#data-sources}

Для Cloud Functions поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_function](../terraform/data-sources/function.md) | Информация о [функции](concepts/function.md) |
| [yandex_function_scaling_policy](../terraform/data-sources/function_scaling_policy.md) | Информация о [настройках масштабирования функции](concepts/function.md#scaling) |
| [yandex_function_trigger](../terraform/data-sources/function_trigger.md) | Информация о [триггере](concepts/trigger/index.md) |