---
title: Getting information about an object in an {{ objstorage-full-name }} bucket
description: Follow this guide to get information about an object in an {{ objstorage-name }} bucket.
---

# Getting information about an object

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Click the name of the object you need.

- API {#api}

  To get information about an object, use the [getObjectMeta](../../s3/api-ref/object/getobjectmeta.md) S3 API method.

{% endlist %}
