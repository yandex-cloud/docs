---
title: Organization access policy management
description: In this tutorial, you will learn how to view {{ iam-full-name }} access policies created for an organization, as well as create and delete such policies.
---

# Organization access policy management

{% include [note-preview-by-request](../../_includes/note-preview-by-request.md) %}

{% include [access-policies-instruction-intro](../../_includes/iam/access-policies-instruction-intro.md) %}

An [organization's](../concepts/organization.md) access policies can be managed by a user with the [`organization-manager.admin`](../security/index.md#organization-manager-admin) or [`admin`](../../iam/roles-reference.md#admin) role.

## Creating an access policy for an organization {#assign}

{% include [access-policies-assign-org](../../_includes/iam/access-policies-assign-org.md) %}

## Viewing the list of your organization's access policies {#view-assigned}

{% include [access-policies-view-assigned-org](../../_includes/iam/access-policies-view-assigned-org.md) %}

## Deleting an access policy created for an organization {#revoke}

{% include [access-policies-revoke-org](../../_includes/iam/access-policies-revoke-org.md) %}

#### See also {#see-also}

* [{#T}](../../iam/concepts/access-control/access-policies.md)