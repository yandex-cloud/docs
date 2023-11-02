---
title: "How to manage access rights to {{ yandex-cloud }} resources Step-by-step instructions"
description: "Step-by-step instructions for managing access rights to {{ yandex-cloud }} resources. In this article, you'll learn how to manage users, service accounts, and identity federations and assign roles to them. We'll get into more detail about IAM tokens, authorized keys, and API keys."
---

# Step-by-step guides for {{ iam-name }}


## Publicly available secrets {#credentials}

- [Processing the secrets that have become publicly available](compromised-credentials.md)


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
- [{#T}](sa/create-access-key.md)
- [{#T}](sa/delete-access-key.md)
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


## Keys {#keys}

- [{#T}](api-key/create.md)
- [{#T}](api-key/delete.md)
- [{#T}](authorized-key/create.md)
- [{#T}](authorized-key/delete.md)