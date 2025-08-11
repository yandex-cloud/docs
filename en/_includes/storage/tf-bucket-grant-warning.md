{% note warning %}

You cannot use the [yandex_storage_bucket_grant]({{ tf-provider-resources-link }}/storage_bucket_grant) resource if the [yandex_storage_bucket_iam_binding]({{ tf-provider-resources-link }}/storage_bucket_iam_binding) resource is simultaneously used to assign [primitive roles](../../storage/security/index.md#primitive-roles), such as `viewer`, `editor`, or `admin` for a bucket, or if the `acl` or `grant` parameters of the [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket) resource are simultaneously in use.

{% endnote %}