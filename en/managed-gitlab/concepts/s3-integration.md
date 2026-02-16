---
title: Integration with {{ objstorage-full-name }} in {{ mgl-full-name }}
description: In this article, you will learn about integration with an S3 {{ objstorage-full-name }} instance in {{ mgl-full-name }}.
---

# Integration with {{ objstorage-full-name }}

{{ GL }} supports storing various types of data in an S3 storage. Integration with an S3 storage allows you to reduce the amount of data on [instance](index.md#instance) disks to prevent their overflow. For more information, see [this {{ GL }} article](https://docs.gitlab.com/administration/object_storage/).

In {{ mgl-name }}, you can [enable integration with an S3-compatible {{ objstorage-name }} instance](../operations/objstorage-integration.md) using the [management console]({{ link-console-main }}). In which case {{ mgl-name }} will manage the storage creation, usage, and scaling.

You can select data types to store in {{ objstorage-name }}:

{% include [s3-object-type](../../_includes/managed-gitlab/s3-object-type.md) %}

Migrating files from large repositories to {{ objstorage-name }} can take more than a day.

{% include [objstorage-disable-note](../../_includes/managed-gitlab/objstorage-disable-note.md) %}