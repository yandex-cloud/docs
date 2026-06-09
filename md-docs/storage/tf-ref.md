# Справочник {{ TF }} для {{ objstorage-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ objstorage-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

#|
|| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** ||
|| [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket) | [Бакет](concepts/bucket.md) ||
|| [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object) | [Объект](concepts/object.md) ||
|| [yandex_storage_bucket_iam_binding]({{ tf-provider-resources-link }}/storage_bucket_iam_binding) | 
[Настройка](operations/buckets/iam-access.md) прав доступа к бакету с помощью {{ iam-name }}.

{% note warning %}

Ресурс [yandex_storage_bucket_iam_binding]({{ tf-provider-resources-link }}/storage_bucket_iam_binding) нельзя использовать для назначения [примитивных ролей](security/index.md#primitive-roles) (`viewer`, `editor` и `admin`) на бакет, если одновременно используется ресурс [yandex_storage_bucket_grant]({{ tf-provider-resources-link }}/storage_bucket_grant) или параметры `acl` и `grant` ресурса [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).

{% endnote %}

||
|| [yandex_storage_bucket_grant]({{ tf-provider-resources-link }}/storage_bucket_grant) | [Настройка](operations/buckets/edit-acl.md) прав доступа к бакету с помощью [ACL {{ objstorage-name }}](concepts/acl.md).

Одному бакету `yandex_storage_bucket` может соответствовать только один ресурс `yandex_storage_bucket_grant`. Использование нескольких ресурсов для одного бакета может привести к ошибкам в конфигурации.

{% note warning %}

Ресурс [yandex_storage_bucket_grant]({{ tf-provider-resources-link }}/storage_bucket_grant) нельзя использовать, если одновременно используется ресурс [yandex_storage_bucket_iam_binding]({{ tf-provider-resources-link }}/storage_bucket_iam_binding) для назначения [примитивных ролей](security/index.md#primitive-roles) (`viewer`, `editor` и `admin`) на бакет, или если одновременно используются параметры `acl` или `grant` ресурса [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).

{% endnote %}

||
|| [yandex_storage_bucket_policy]({{ tf-provider-resources-link }}/storage_bucket_policy) | [Управление](operations/buckets/policy.md) политикой доступа ([bucket policy](concepts/policy.md)) бакета. ||
|#