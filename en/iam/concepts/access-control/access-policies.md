---
title: Access policies in {{ iam-full-name }}
description: In this article, you will learn about access policies in {{ iam-full-name }} and how to use them when managing {{ yandex-cloud }} resources.
---

# Access policies

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

_Access policies_ are a {{ iam-full-name }} mechanism that allows you to manage permissions for performing specific operations on [{{ yandex-cloud }} resources](../../../overview/roles-and-resources.md). Access policies complement the [role](./roles.md) system for more flexible [access management](./index.md).

## Relationships between access policies and roles {#policy-role-interrelation}

Access policies enforce explicit restrictions, unlike [roles](./roles.md), which grant explicit permissions. The relationships between access policies and roles are as follows:

* To perform an operation, it must be allowed by a role and not prohibited by an access policy. Access permissions are checked in the following order:

    1. The system checks if the user is assigned a role required to perform the operation. If they have no such role, the operation is denied without any further checks.
    1. If the user has the required role, the system checks access policies for an explicit restriction to perform the operation and denies or allows the operation accordingly.
* Access policies do not replace roles, but add an extra layer of access control. To perform operations, users still require the relevant roles, regardless of the exisiting access policies.
* {% include [access-policies-roles](../../../_includes/iam/access-policies-roles.md) %}

## Resources governed by access policies {#resources}

Access policies assigned at higher levels of the [{{ yandex-cloud }} resource hierarchy](../../../resource-manager/concepts/resources-hierarchy.md) are [inherited](../../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) by lower-level resources.

You can [assign](../../operations/access-policies/assign.md) access policies for the following resources:

* [Organization](../../../organization/concepts/organization.md): Access policy applies to resources in all clouds and folders within an organization.
* [Cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud): Access policy applies to resources in all folders within a cloud.
* [Folder](../../../resource-manager/concepts/resources-hierarchy.md#folder): Access policy applies only to resources within a specific folder.

You can assign multiple policies for a single resource.

## Supported access policies {#supported-policies}

Currently, {{ iam-name }} [supports](../../operations/access-policies/list.md) the following access policies:

#|
|| **Policy ID** | **Imposed restrictions** ||
|| `iam.denyServiceAccountCreation` | Prohibits creating [service accounts](../users/service-accounts.md). ||
|| `iam.denyServiceAccountAccessKeysCreation` | Prohibits creating [static access keys](../authorization/access-key.md) for service accounts. ||
|| `iam.denyServiceAccountApiKeysCreation` | Prohibits creating [API keys](../authorization/api-key.md) for service accounts. ||
|| `iam.denyServiceAccountAuthorizedKeysCreation` | Prohibits creating [authorized keys](../authorization/key.md) for service accounts. ||
|| `iam.denyServiceAccountFederatedCredentialsCreation` | Prohibits associating service accounts with [workload identity federations](../workload-identity.md). ||
|| `iam.denyServiceAccountCredentialsCreation` |
* Prohibits creating any [credentials](../authorization/index.md) for service accounts (except [IAM tokens](../authorization/iam-token.md)).
* Prohibits associating service accounts with [workload identity federations](../workload-identity.md).
||
|| `iam.denyServiceAccountImpersonation` | Prohibits [impersonation](../access-control/impersonation.md). ||
|| `organization.denyMemberInvitation` | Prohibits [inviting](../../../organization/operations/add-account.md#useraccount) new Yandex account [users](../users/accounts.md#passport) to the organization. This policy must be assigned to an [organization](../../../organization/concepts/organization.md). ||
|| `organization.denyUserListing` | Prohibits viewing the list of [organization](../../../organization/concepts/organization.md) users. This policy must be assigned to an organization. ||
|#

#### See also {#see-also}

* [{#T}](../../operations/access-policies/list.md)
* [{#T}](../../operations/access-policies/assign.md)
* [{#T}](../../operations/access-policies/view-assigned.md)
* [{#T}](../../operations/access-policies/revoke.md)