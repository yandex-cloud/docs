# Справочник {{ TF }} для {{ certificate-manager-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ certificate-manager-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate) | [TLS-сертификат](concepts/index.md#types) |
| [yandex_cm_certificate_iam_binding]({{ tf-provider-resources-link }}/cm_certificate_iam_binding)| [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к TLS-сертификату. Имеет ограничение в 1000 привязок на ресурс. <br>Вместо `yandex_cm_certificate_iam_binding` рекомендуется использовать `yandex_cm_certificate_iam_member` |
| [yandex_cm_certificate_iam_member]({{ tf-provider-resources-link }}/cm_certificate_iam_member) |  [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к TLS-сертификату. |


## Источники данных {#data-sources}

Для {{ certificate-manager-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_cm_certificate]({{ tf-provider-datasources-link }}/cm_certificate) | Информация о [TLS-сертификате](concepts/index.md#types) |
| [yandex_cm_certificate_content]({{ tf-provider-datasources-link }}/cm_certificate_content) | Содержимое TLS-сертификата |