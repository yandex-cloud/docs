# Справочник Terraform для Yandex Cloud Billing

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Yandex Cloud Billing поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_billing_cloud_binding](../terraform/resources/billing_cloud_binding.md) | Привязка [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к [платежному аккаунту](concepts/billing-account.md) |

## Источники данных {#data-sources}

Для Yandex Cloud Billing поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_billing_cloud_binding](../terraform/data-sources/billing_cloud_binding.md) | Информация о привязке [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) к [платежному аккаунту](concepts/billing-account.md) |