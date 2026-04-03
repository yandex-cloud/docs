---
title: Managing folder access policies
description: In this tutorial, you will learn how to view {{ iam-full-name }} access policies created for a folder, as well as create and delete such policies.
---

# Managing folder access policies

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{% include [access-policies-instruction-intro](../../../_includes/iam/access-policies-instruction-intro.md) %}

A [folder’s](../../concepts/resources-hierarchy.md#folder) access policies can be managed by users with the [`resource-manager.admin`](../../security/index.md#resource-manager-admin) or [`admin`](../../../iam/roles-reference.md#admin) role for the folder.

## Creating an access policy for a folder {#assign}

{% include [access-policies-assign-folder](../../../_includes/iam/access-policies-assign-folder.md) %}

## Viewing the list of your folder’s access policies {#view-assigned}

{% include [access-policies-view-assigned-folder](../../../_includes/iam/access-policies-view-assigned-folder.md) %}

## Deleting an access policy created for a folder {#revoke}

{% include [access-policies-revoke-folder](../../../_includes/iam/access-policies-revoke-folder.md) %}

#### See also {#see-also}

* [{#T}](../../../iam/concepts/access-control/access-policies.md)