---
title: Integration with {{ objstorage-full-name }} in {{ mgl-full-name }}
description: In this article, you will learn about integration with an S3-compatible {{ objstorage-full-name }} in {{ mgl-full-name }}.
---

# Integration with {{ objstorage-full-name }}

{{ GL }} supports storing various types of data in an S3 storage. Integration with an S3 storage allows you to reduce the amount of data on [instance](index.md#instance) disks to prevent their overflow. Learn more about data storage in [this {{ GL }} guide](https://docs.gitlab.com/administration/object_storage/).

In {{ mgl-name }}, you can [enable integration with an S3-compatible {{ objstorage-name }}](../operations/objstorage-integration.md) using the [management console]({{ link-console-main }}). In which case {{ mgl-name }} will manage the storage creation, usage, and scaling.

## Specifics and limitations {#restrictions}

Enabling integration with {{ objstorage-name }} will reconfigure the instance. If you need to reissue your {{ lets-encrypt }} certificate at this point, the reconfiguration will run an HTTP-01 Challenge check and {{ lets-encrypt }} will connect to your domain on port `80`. If the security group is blocking traffic on this port, the certificate will not be renewed, the reconfiguration will fail, and the data migration will not start. Therefore, before enabling integration with {{ objstorage-name }}, make sure the security group of the {{ mgl-name }} instance allows incoming connections on port `80` from external IP addresses of {{ lets-encrypt }}.

{% include [objstorage-disable-note](../../_includes/managed-gitlab/objstorage-disable-note.md) %}

## Data types available for storage {#data-types}

You can select data types to store in {{ objstorage-name }}:

{% include [s3-object-type](../../_includes/managed-gitlab/s3-object-type.md) %}

Migrating files from large repositories to {{ objstorage-name }} can take more than a day.
