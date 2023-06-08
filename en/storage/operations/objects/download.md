---
title: "Tutorial for downloading an object from a bucket {{ objstorage-full-name }}"
description: "From this tutorial, you will learn how to download an object from {{ objstorage-full-name }}."
---

# Downloading an object


{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ objstorage-name }}**.
   1. Click the name of the bucket you need.
   1. Click the object name.
   1. In the top-right corner, click ![image](../../../_assets/horizontal-ellipsis.svg).
   1. Click **{{ ui-key.yacloud.storage.file.button_download }}**.

- API

   To download an object, use the [get](../../s3/api-ref/object/get.md) S3 API method.

{% endlist %}
