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

## Identity federations {#federations}

The guides on managing identity federations are now included in the {{ org-full-name }} [documentation](../../organization/).

## Roles {#roles}

- [{#T}](roles/grant.md)
- [{#T}](roles/get-assigned-roles.md)
- [{#T}](roles/revoke.md)

## IAM tokens {#iam-tokens}

- [{#T}](iam-token/create.md)
- [{#T}](iam-token/create-for-sa.md)
- [{#T}](iam-token/create-for-federation.md)
- [Reissue an IAM token](compromised-credentials.md#iam-reissue)


## Static access keys {#static-keys}

- [{#T}](sa/create-access-key.md)
- [{#T}](sa/delete-access-key.md)

## Temporary access keys {#temporary-keys}

- [{#T}](sa/create-sts-key.md)

## API keys {#api-keys}

- [{#T}](api-key/create.md)
- [{#T}](api-key/delete.md)

## Authorized keys {#authorized-keys}

- [{#T}](authorized-key/create.md)
- [{#T}](authorized-key/delete.md)

## Service control {#service-control}

{% include notitle [preview](../../_includes/note-preview.md) %}

- [{#T}](service-control/list-get.md)
- [{#T}](service-control/enable-disable.md)

## Workload identity federations {#wlif}

- [{#T}](wlif/setup-wlif.md)