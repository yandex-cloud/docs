---
title: '{{ objstorage-full-name }} release notes'
description: This section contains {{ objstorage-name }} release notes.
---

# {{ objstorage-full-name }} release notes

## Q4 2024 {#q4-2024}

* Announced end of support for the TLS protocol versions 1.0 and 1.1 as of July 1, 2025. For more information, see [{#T}](./concepts/tls.md).
* In the [{{ yandex-cloud }} CLI](../cli/quickstart.md), added the [yc storage s3api](../cli/cli-ref/storage/cli-ref/s3api/index.md) group of commands to work with [objects](./concepts/object.md).

## Q3 2024 {#q3-2024}

* Added support for accessing {{ objstorage-name }} using [{{ sts-name }} temporary keys](./operations/buckets/create-sts-key.md).
* Implemented direct access to buckets from cloud networks using [{{ vpc-full-name }} service connection](./operations/buckets/access-via-vpc.md) without internet access. Added the `yc:private-endpoint-id` special condition to the [bucket policy](./security/policy.md) to allow bucket access via {{ vpc-short-name }} internal IP addresses only.

## Q2 2024 {#q2-2024}

Improved the management console design: bucket settings are now grouped under the ![image](../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}** and ![image](../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}** tabs.

## Q1 2024 {#q1-2024}

* Improved object [lifecycle](./concepts/lifecycles.md) management in a bucket:
  * Added support for new filters for grouping objects: [object labels](./concepts/tags.md#object-tags) and the `AND` operator.
  * Implemented the new filter feature in the management console, YC CLI, {{ TF }}, and for the [tools](./tools/) that support the S3 API.
* Added support for [bucket labels](./concepts/tags.md#bucket-tags) in the management console, YC CLI, and {{ TF }}.
* Implemented adding {{ org-full-name }} [user groups](../organization/concepts/groups.md) to an [access control list (ACL)](./security/acl.md) and [ bucket policy](./security/policy.md) in the management console, YC CLI, and {{ TF }}.
* Improved the management console interface:
  * Added filtering by prefix in the list of bucket objects.
  * Added the feature to download objects from a list.
