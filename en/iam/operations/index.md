---
title: How to manage access permissions to {{ yandex-cloud }} resources. Step-by-step guides
description: Step-by-step guides on how to manage access permissions to {{ yandex-cloud }} resources. In this article, you will learn how to manage users, service accounts, and identity federations and assign roles to them. We will get into more detail about IAM tokens, authorized keys, and API keys.
---

# Step-by-step guides for {{ iam-name }}

## Publicly available secrets {#credentials}

- [Processing secrets that have become publicly available](compromised-credentials.md)

## Users {#users}

- [{#T}](users/create.md)
- [{#T}](users/get.md)
- [{#T}](users/delete.md)

## User groups {#users-groups}

- [{#T}](groups/create.md)
- [{#T}](groups/access-binding-object.md)
- [{#T}](groups/access-binding-subject.md)

## Service accounts {#sa}

- [{#T}](sa/create.md)
- [{#T}](sa/update.md)
- [{#T}](sa/assign-role-for-sa.md)
- [{#T}](sa/set-access-bindings.md)
- [{#T}](sa/get-id.md)
- [{#T}](sa/delete.md)
- [{#T}](sa/get-id-token.md)

## Identity federations {#federations}

The guides on managing identity federations are now included in the {{ org-full-name }} [documentation](../../organization/).

## Roles {#roles}

- [{#T}](roles/grant.md)
- [{#T}](roles/get-assigned-roles.md)
- [{#T}](roles/revoke.md)

## Authentication {#authentication}

- [{#T}](iam-token/create.md)
- [{#T}](iam-token/create-for-sa.md)
- [{#T}](iam-token/create-for-federation.md)
- [Reissue an IAM token](compromised-credentials.md#iam-reissue)
- [{#T}](authentication/manage-access-keys.md)
- [{#T}](authentication/manage-api-keys.md)
- [{#T}](authentication/manage-authorized-keys.md)
- [{#T}](sa/create-sts-key.md)

## Service control {#service-control}

{% include notitle [preview](../../_includes/note-preview.md) %}

- [{#T}](service-control/list-get.md)
- [{#T}](service-control/enable-disable.md)

## Workload identity federations {#wlif}

- [{#T}](wlif/setup-wlif.md)