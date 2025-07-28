{% note warning %}

Ресурс [yandex_storage_bucket_grant]({{ tf-provider-resources-link }}/storage_bucket_grant) нельзя использовать, если одновременно используется ресурс [yandex_storage_bucket_iam_binding]({{ tf-provider-resources-link }}/storage_bucket_iam_binding) для назначения [примитивных ролей](../../storage/security/index.md#primitive-roles) (`viewer`, `editor` и `admin`) на бакет, или если одновременно используются параметры `acl` или `grant` ресурса [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).

{% endnote %}