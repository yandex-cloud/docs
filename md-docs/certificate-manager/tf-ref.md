# Справочник Terraform для Yandex Certificate Manager

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Certificate Manager поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_cm_certificate](../terraform/resources/cm_certificate.md) | [TLS-сертификат](concepts/index.md#types) |
| [yandex_cm_certificate_iam_binding](../terraform/resources/cm_certificate_iam_binding.md)| [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к TLS-сертификату. Имеет ограничение в 1000 привязок на ресурс. <br>Вместо `yandex_cm_certificate_iam_binding` рекомендуется использовать `yandex_cm_certificate_iam_member` |
| [yandex_cm_certificate_iam_member](../terraform/resources/cm_certificate_iam_member.md) |  [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к TLS-сертификату. |


## Источники данных {#data-sources}

Для Certificate Manager поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_cm_certificate](../terraform/data-sources/cm_certificate.md) | Информация о [TLS-сертификате](concepts/index.md#types) |
| [yandex_cm_certificate_content](../terraform/data-sources/cm_certificate_content.md) | Содержимое TLS-сертификата |