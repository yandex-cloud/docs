---
title: Getting a pre-signed URL to download an object from a bucket in {{ objstorage-full-name }}
description: Follow this guide to get a pre-signed URL to download an object from a bucket in {{ objstorage-name }}.
---

# Getting a pre-signed URL to download an object

If you have a bucket, its objects are always available even with no [website hosting](../../concepts/hosting.md) configured. You can get a link by following this guide or generate one yourself. Learn more about the link format [here](../../concepts/object.md#object-url).

If you have a bucket with restricted access, {{ objstorage-name }} enables you to generate a pre-signed URL to an object. Anyone with this link can download the object, even from a bucket with restricted access. You can read more about pre-signed URLs, their generation, and their use [here](../../concepts/pre-signed-urls.md).

{% note info %}

If the bucket has an [access policy](../../operations/buckets/policy.md) in place which bans creating pre-signed URLs, you will not be able to create a link. 

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [storage-get-link-for-download](../../_includes_service/storage-get-link-for-download.md) %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [storage-get-link-for-download-cli](../../_includes_service/storage-get-link-for-download-cli.md) %}

{% endlist %}

{% note info %}

You cannot extend the validity period of a pre-signed URL to an object in a bucket with restricted access. If the URL has expired, generate a new one.

{% endnote %}
