---
title: '{{ TF }} reference for {{ objstorage-full-name }}'
description: This page provides reference information on the Terraform provider resources supported for {{ objstorage-name }}.
---

# {{ TF }} reference for {{ objstorage-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ objstorage-name }} supports the following {{ TF }} provider resources:

#|
|| **{{ TF }} resource** | **{{ yandex-cloud }} resource** ||
|| [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket) | [Bucket](./concepts/bucket.md) ||
|| [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object) | [Object](./concepts/object.md) ||
|| [yandex_storage_bucket_iam_binding]({{ tf-provider-resources-link }}/storage_bucket_iam_binding) | 
[Configuring](operations/buckets/iam-access.md) access permissions for a bucket using {{ iam-name }}.

{% include [tf-iam-binding-warning](../_includes/storage/tf-iam-binding-warning.md) %}

||
|| [yandex_storage_bucket_grant]({{ tf-provider-resources-link }}/storage_bucket_grant) | [Configuring](operations/buckets/edit-acl.md) access permissions for a bucket using the [{{ objstorage-name }} ACL](./concepts/acl.md).

{% include [tf-iam-binding-warning](../_includes/storage/tf-bucket-grant-warning.md) %}

||
|#