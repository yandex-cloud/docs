---
title: How to assign an access policy in {{ objstorage-short-name }} for a {{ vpc-full-name }} service connection
description: Follow this guide to assign an access policy in {{ objstorage-short-name }} for a service connection.
---

# Assigning an access policy in {{ objstorage-short-name }} for a service connection

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}


[Bucket policies](../../storage/concepts/policy.md) set permissions for operations with [buckets](../../storage/concepts/bucket.md), [objects](../../storage/concepts/object.md), and object groups.

The minimum role required to apply or modify an access policy is `storage.configurer`. For more information, see the [role description](../../storage/security/index.md#storage-configurer).

To assign an access policy in {{ objstorage-short-name }} for a service connection:

{% include [private-endpoint-policy-tabs](../../_includes/storage/private-endpoint-policy-tabs.md) %}
