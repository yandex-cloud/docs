---
title: Справочник {{ TF }} для {{ objstorage-full-name }}
description: На этой странице приведен справочник ресурсов провайдера {{ TF }}, которые поддерживаются для сервиса {{ objstorage-name }}.
---

# Справочник {{ TF }} для {{ objstorage-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ objstorage-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

#|
|| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** ||
|| [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket) | [Бакет](./concepts/bucket.md) ||
|| [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object) | [Объект](./concepts/object.md) ||
|| [yandex_storage_bucket_iam_binding]({{ tf-provider-resources-link }}/storage_bucket_iam_binding) | 
[Настройка](operations/buckets/iam-access.md) прав доступа к бакету с помощью {{ iam-name }}.

{% include [tf-iam-binding-warning](../_includes/storage/tf-iam-binding-warning.md) %}

||
|| [yandex_storage_bucket_grant]({{ tf-provider-resources-link }}/storage_bucket_grant) | [Настройка](operations/buckets/edit-acl.md) прав доступа к бакету с помощью [ACL {{ objstorage-name }}](./concepts/acl.md).

{% include [tf-iam-binding-warning](../_includes/storage/tf-bucket-grant-warning.md) %}

||
|| [yandex_storage_bucket_policy]({{ tf-provider-resources-link }}/storage_bucket_policy) | [Управление](operations/buckets/policy.md) политикой доступа ([bucket policy](concepts/policy.md)) бакета. ||
|#