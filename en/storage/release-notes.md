---
title: '{{ objstorage-full-name }} release notes'
description: This section contains {{ objstorage-name }} release notes.
---

# {{ objstorage-full-name }} release notes

## Q2 2024 {#q2-2024}

Improved the management console design: bucket settings are now grouped under the ![image](../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}** and ![image](../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}** tabs.

## Q1 2024 {#q1-2024}

* Improved object [lifecycle](./concepts/lifecycles.md) management in a bucket:
  * Added support for new filters for grouping objects: [object labels](./concepts/tags.md#object-tags) and the `AND` operator.
  * Implemented the new filter feature in the management console, YC CLI, {{ TF }}, and for the [tools](./tools/) that support the S3 API.
* Added support for [bucket labels](./concepts/tags.md#bucket-tags) in the management console, YC CLI, and {{ TF }}.
* Implemented adding {{ org-full-name }} [user groups](../organization/concepts/groups.md) to an [access control list (ACL)](./security/acl.md) and a [bucket policy](./security/policy.md) in the management console, YC CLI, and {{ TF }}.
* Improved the management console interface:
  * Added filtering by prefix in the list of bucket objects.
  * Added the feature to download objects from a list.
