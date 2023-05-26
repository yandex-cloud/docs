---
title: "Tutorial on how to get information about an {{ objstorage-full-name }} object"
description: "In this tutorial, you'll learn how to get information about an {{ objstorage-full-name }} object."
---

# Getting information about an object

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ objstorage-name }}**.
   1. Click the name of the bucket you need.
   1. Click the object name.

- API

   To get information about an object, use the [getObjectMeta](../../s3/api-ref/object/getobjectmeta.md) S3 API method.

{% endlist %}
