---
title: Getting a pre-signed URL to upload an object to a {{ objstorage-full-name }} bucket
description: Follow this guide to get a pre-signed URL to upload an object to an {{ objstorage-name }} bucket.
---

# Getting a pre-signed URL to upload an object

If your bucket is public, you can upload objects without restrictions even if the bucket has no [website hosting](../../concepts/hosting.md) configured. You can get a link by following this guide or generate one yourself. Learn more about the link format [here](../../concepts/object.md#object-url).

If you have a bucket with restricted access, {{ objstorage-name }} enables you to generate a pre-signed URL to upload an object. Anyone with this link can upload the object, even to a bucket with restricted access. You can read more about pre-signed URLs, their generation, and their use [here](../../concepts/pre-signed-urls.md).

{% note info %}

If the bucket has an [access policy](../buckets/policy.md) in place which bans creating pre-signed URLs, you will not be able to create a link. 

{% endnote %}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [storage-get-link-for-upload-cli](../../_includes_service/storage-get-link-for-upload-cli.md) %}

- SDK for Python (boto3) {#sdk-python}

  {% include [storage-get-link-for-upload-sdk-python](../../_includes_service/storage-get-link-for-upload-sdk-python.md) %}

- SDK for JavaScript {#sdk-javascript}

  {% include [storage-get-link-for-upload-sdk-javascript](../../_includes_service/storage-get-link-for-upload-sdk-javascript.md) %}

- SDK for Go {#go}

  {% include [storage-get-link-for-upload-sdk-go](../../_includes_service/storage-get-link-for-upload-sdk-go.md) %}

{% endlist %}

{% note info %}

You cannot extend the validity period of a pre-signed URL to an object in a bucket with restricted access. If the URL has expired, generate a new one.

{% endnote %}

#### See also {#see-also}

* [{#T}](./link-for-download.md)
