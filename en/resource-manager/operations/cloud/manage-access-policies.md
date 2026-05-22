---
title: Managing cloud access policies
description: In this tutorial, you will learn how to view {{ iam-full-name }} access policies created for a cloud, as well as create and delete such policies.
---

# Managing cloud access policies

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{% include [access-policies-instruction-intro](../../../_includes/iam/access-policies-instruction-intro.md) %}

The [cloud](../../concepts/resources-hierarchy.md#cloud) access policies can be managed by users with the [`resource-manager.admin`](../../security/index.md#resource-manager-admin) or [`admin`](../../../iam/roles-reference.md#admin) role for the cloud.

## Creating an access policy for a cloud {#assign}

{% include [access-policies-assign-cloud](../../../_includes/iam/access-policies-assign-cloud.md) %}

## Viewing the list of your cloud's access policies {#view-assigned}

{% include [access-policies-view-assigned-cloud](../../../_includes/iam/access-policies-view-assigned-cloud.md) %}

## Deleting an access policy created for a cloud {#revoke}

{% include [access-policies-revoke-cloud](../../../_includes/iam/access-policies-revoke-cloud.md) %}

#### See also {#see-also}

* [{#T}](../../../iam/concepts/access-control/access-policies.md)