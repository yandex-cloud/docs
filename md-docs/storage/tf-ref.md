# Справочник Terraform для Yandex Object Storage

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Object Storage поддерживаются следующие ресурсы провайдера Terraform:

#|
|| **Ресурс Terraform** | **Ресурс Yandex Cloud** ||
|| [yandex_storage_bucket](../terraform/resources/storage_bucket.md) | [Бакет](concepts/bucket.md) ||
|| [yandex_storage_object](../terraform/resources/storage_object.md) | [Объект](concepts/object.md) ||
|| [yandex_storage_bucket_iam_binding](../terraform/resources/storage_bucket_iam_binding.md) | 
[Настройка](operations/buckets/iam-access.md) прав доступа к бакету с помощью Identity and Access Management.

{% note warning %}

Ресурс [yandex_storage_bucket_iam_binding](../terraform/resources/storage_bucket_iam_binding.md) нельзя использовать для назначения [примитивных ролей](security/index.md#primitive-roles) (`viewer`, `editor` и `admin`) на бакет, если одновременно используется ресурс [yandex_storage_bucket_grant](../terraform/resources/storage_bucket_grant.md) или параметры `acl` и `grant` ресурса [yandex_storage_bucket](../terraform/resources/storage_bucket.md).

{% endnote %}

||
|| [yandex_storage_bucket_grant](../terraform/resources/storage_bucket_grant.md) | [Настройка](operations/buckets/edit-acl.md) прав доступа к бакету с помощью [ACL Object Storage](concepts/acl.md).

Одному бакету `yandex_storage_bucket` может соответствовать только один ресурс `yandex_storage_bucket_grant`. Использование нескольких ресурсов для одного бакета может привести к ошибкам в конфигурации.

{% note warning %}

Ресурс [yandex_storage_bucket_grant](../terraform/resources/storage_bucket_grant.md) нельзя использовать, если одновременно используется ресурс [yandex_storage_bucket_iam_binding](../terraform/resources/storage_bucket_iam_binding.md) для назначения [примитивных ролей](security/index.md#primitive-roles) (`viewer`, `editor` и `admin`) на бакет, или если одновременно используются параметры `acl` или `grant` ресурса [yandex_storage_bucket](../terraform/resources/storage_bucket.md).

{% endnote %}

||
|| [yandex_storage_bucket_policy](../terraform/resources/storage_bucket_policy.md) | [Управление](operations/buckets/policy.md) политикой доступа ([bucket policy](concepts/policy.md)) бакета. ||
|#