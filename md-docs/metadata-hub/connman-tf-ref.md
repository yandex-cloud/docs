# Справочник Terraform для Connection Manager

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Connection Manager поддерживается следующий ресурс провайдера Terraform:

| **Ресурс Terraform**                                       | **Ресурс Yandex Cloud**                   |
|-----------------------------------------------------------|-------------------------------------------------|
| [yandex_connectionmanager_connection](../terraform/resources/connectionmanager_connection.md) | [Подключение](concepts/connection-manager.md) |

## Источники данных {#data-sources}

Для Connection Manager поддерживается следующий источник данных провайдера Terraform:

| **Источник данных Terraform** | **Описание**                                    |
| --- |-------------------------------------------------|
| [yandex_connectionmanager_connection](../terraform/data-sources/connectionmanager_connection.md) | Информация о [подключении](concepts/connection-manager.md) |