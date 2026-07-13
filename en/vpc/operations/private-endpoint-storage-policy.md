---
title: How to assign an access policy in {{ objstorage-short-name }} for a {{ vpc-full-name }} service connection
description: Follow this guide to assign an access policy in {{ objstorage-short-name }} for a service connection.
---

# Assigning an access policy in {{ objstorage-short-name }} for a service connection


[Bucket policies](../../storage/concepts/policy.md) set permissions for operations with [buckets](../../storage/concepts/bucket.md), [objects](../../storage/concepts/object.md), and object groups.

The minimum role required to apply or update a bucket policy is `storage.configurer`. For the role description, see [Access management](../../storage/security/index.md#storage-configurer).

To assign an access policy in {{ objstorage-short-name }} for a [service connection](../concepts/private-endpoint.md):

{% include [private-endpoint-policy-tabs](../../_includes/storage/private-endpoint-policy-tabs.md) %}
