[Документация Yandex Cloud](../index.md) > [Yandex Serverless Containers](index.md) > Справочник Terraform

# Справочник Terraform для Yandex Serverless Containers

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Serverless Containers поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_serverless_container](../terraform/resources/serverless_container.md) | [Контейнер](concepts/container.md) |
| [yandex_serverless_container_iam_binding](../terraform/resources/serverless_container_iam_binding.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к контейнеру |
| [yandex_function_trigger](../terraform/resources/function_trigger.md) | [Триггер](concepts/trigger/index.md) |

## Источники данных {#data-sources}

Для Serverless Containers поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_serverless_container](../terraform/data-sources/serverless_container.md) | Информация о [контейнере](concepts/container.md) |