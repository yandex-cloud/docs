---
title: How to manage access permissions for {{ yandex-cloud }} resources. Step-by-step guides
description: Step-by-step guides on how to manage access permissions for{{ yandex-cloud }} resources. In these guides, you will learn how to manage users, service accounts, and identity federations and assign roles to them. We will cover everything you need to know about IAM tokens, authorized keys, and API keys.
---

# Step-by-step guides for {{ iam-name }}

## Publicly available secrets {#credentials}

- [Processing secrets that have become publicly available](compromised-credentials.md)

## Users {#users}

For user management, see [this {{ org-full-name }} guide](../../organization/operations/manage-users.md).

## User groups {#users-groups}

For user group management, see [this {{ org-full-name }} guide](../../organization/operations/manage-groups.md).

## Service accounts {#sa}

- [{#T}](sa/create.md)
- [{#T}](sa/list-get.md)
- [{#T}](sa/update.md)
- [{#T}](sa/assign-role-for-sa.md)
- [{#T}](sa/set-access-bindings.md)
- [{#T}](sa/impersonate-sa.md)
- [{#T}](sa/get-id.md)
- [{#T}](sa/get-id-token.md)
- [{#T}](sa/suspend-reactivate.md)
- [{#T}](sa/delete.md)

## Identity federations {#federations}

Identity federation management guides are now included in the {{ org-full-name }} [documentation](../../organization/).

## Access policies {#access-policies}

- [{#T}](access-policies/list.md)
- [{#T}](access-policies/assign.md)
- [{#T}](access-policies/view-assigned.md)
- [{#T}](access-policies/revoke.md)

## Roles {#roles}

- [{#T}](roles/grant.md)
- [{#T}](roles/get-assigned-roles.md)
- [{#T}](roles/revoke.md)

## Authentication {#authentication}

- [{#T}](iam-token/create.md)
- [{#T}](iam-token/create-for-sa.md)
- [{#T}](iam-token/create-for-federation.md)
- [{#T}](iam-token/create-for-local.md)
- [Reissuing an IAM token](compromised-credentials.md#iam-reissue)
- [{#T}](refresh-token/list.md)
- [{#T}](refresh-token/revoke.md)
- [{#T}](authentication/manage-access-keys.md)
- [{#T}](authentication/manage-api-keys.md)
- [{#T}](authentication/manage-authorized-keys.md)
- [{#T}](sa/create-sts-key.md)

## Service access {#service-control}

{% include notitle [preview](../../_includes/note-preview.md) %}

- [{#T}](service-control/list-get.md)
- [{#T}](service-control/enable-disable.md)

## Workload identity federations {#wlif}

- [{#T}](wlif/setup-wlif.md)