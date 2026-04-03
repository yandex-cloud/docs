---
title: Access policies in {{ iam-full-name }}
description: In this article, you will learn about access policies in {{ iam-full-name }} and how to use them when managing {{ yandex-cloud }} resources.
---

# Access policies

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

_Access policies_ are a {{ iam-full-name }} mechanism that allows you to manage permissions for performing specific operations on [{{ yandex-cloud }} resources](../../../overview/roles-and-resources.md). Access policies complement the [role](./roles.md) system for more flexible [access management](./index.md).

Access policies for [resources](#resources) are created based on access policy [templates](#supported-policies).

## Relationships between access policies and roles {#policy-role-interrelation}

Access policies enforce explicit restrictions, unlike [roles](./roles.md), which grant explicit permissions. The relationships between access policies and roles are as follows:

* To perform an operation, it must be allowed by a role and not prohibited by an access policy. Access permissions are checked in the following order:

    1. The system checks if the user is assigned a role required to perform the operation. If they have no such role, the operation is denied without any further checks.
    1. If the user has the required role, the system checks access policies for an explicit restriction to perform the operation and denies or allows the operation accordingly.
* Access policies do not replace roles, but add an extra layer of access control. Users still need relevant roles for operations, regardless of the access policies in place.
* {% include [access-policies-roles](../../../_includes/iam/access-policies-roles.md) %}

## Resources that take access policies {#resources}

You can [create](../../operations/access-policies/assign.md) access policies for the following resources:

* [Organization](../../../organization/concepts/organization.md): Access policy applies to resources in all clouds and folders within an organization.
* [Cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud): Access policy applies to resources in all folders within a cloud.
* [Folder](../../../resource-manager/concepts/resources-hierarchy.md#folder): Access policy applies only to resources within a specific folder.

Access policies created at higher levels of the [{{ yandex-cloud }} resource](../../../resource-manager/concepts/resources-hierarchy.md) hierarchy are [inherited](../../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) by lower-level resources.

You can create several access policies for one resource at the same time.

## Access policy templates {#supported-policies}

Some access policy templates require you to specify additional parameters when assigned to a resource; others do not.

### Templates without additional parameters {#fixed}

The following access policy templates do not contain additional parameters and unconditionally restrict relevant actions:

* [iam.denyServiceAccountCreation](#iam-denyServiceAccountCreation)
* [iam.denyServiceAccountAccessKeysCreation](#iam-denyServiceAccountAccessKeysCreation)
* [iam.denyServiceAccountApiKeysCreation](#iam-denyServiceAccountApiKeysCreation)
* [iam.denyServiceAccountAuthorizedKeysCreation](#iam-denyServiceAccountAuthorizedKeysCreation)
* [iam.denyServiceAccountFederatedCredentialsCreation](#iam-denyServiceAccountFederatedCredentialsCreation)
* [iam.denyServiceAccountCredentialsCreation](#iam-denyServiceAccountCredentialsCreation)
* [iam.denyServiceAccountImpersonation](#iam-denyServiceAccountImpersonation)
* [organization.denyMemberInvitation](#organization-denyMemberInvitation)
* [organization.denyUserListing](#organization-denyUserListing)

#### iam.denyServiceAccountCreation {#iam-denyServiceAccountCreation}

This policy prohibits creating [service accounts](../users/service-accounts.md). 

#### iam.denyServiceAccountAccessKeysCreation {#iam-denyServiceAccountAccessKeysCreation}

This policy prohibits creating [static access keys](../authorization/access-key.md) for service accounts.

#### iam.denyServiceAccountApiKeysCreation {#iam-denyServiceAccountApiKeysCreation}

This policy prohibits creating [API keys](../authorization/api-key.md) for service accounts.

#### iam.denyServiceAccountAuthorizedKeysCreation {#iam-denyServiceAccountAuthorizedKeysCreation}

This policy prohibits creating [authorized keys](../authorization/key.md) for service accounts.

#### iam.denyServiceAccountFederatedCredentialsCreation {#iam-denyServiceAccountFederatedCredentialsCreation}

This policy prohibits associating service accounts with [workload identity federations](../workload-identity.md).

#### iam.denyServiceAccountCredentialsCreation {#iam-denyServiceAccountCredentialsCreation}

This policy prohibits the following:

* Creating any [credentials](../authorization/index.md) for service accounts (except [IAM tokens](../authorization/iam-token.md)).
* Associating service accounts with [workload identity federations](../workload-identity.md).

#### iam.denyServiceAccountImpersonation {#iam-denyServiceAccountImpersonation}

This policy prohibits [impersonation](../access-control/impersonation.md).

#### organization.denyMemberInvitation {#organization-denyMemberInvitation}

This policy prohibits [inviting](../../../organization/operations/add-account.md#useraccount) new Yandex account [users](../users/accounts.md#passport) to the organization. The policy can be created only for an [organization](../../../organization/concepts/organization.md).

#### organization.denyUserListing {#organization-denyUserListing}

This policy prohibits viewing the list of [organization](../../../organization/concepts/organization.md) users. The policy can be created only for an [organization](../../../organization/concepts/organization.md).

### Templates with additional parameters {#customizable}

The following access policy templates allow their restrictions to be modified by additional parameters:

* [serverless.restrictPrivateNetworkInvocation](#serverless-restrictPrivateNetworkInvocation)
* [serverless.restrictPublicInvocation](#serverless-restrictPublicInvocation)

#### serverless.restrictPrivateNetworkInvocation {#serverless-restrictPrivateNetworkInvocation}

{% include [access-policies-private-endpoint-notice](../../../_includes/iam/access-policies-private-endpoint-notice.md) %}

This policy limits calling [functions](../../../functions/concepts/function.md) and [containers](../../../serverless-containers/concepts/container.md) from {{ vpc-full-name }}'s [private IP addresses](../../../vpc/concepts/address.md#internal-addresses) to explicitly specified [cloud networks](../../../vpc/concepts/network.md#network) or specific IP addresses within them.

There must be a cloud network from the list specified in the policy parameters linked to the function/container.

Additional parameters:

* `allowed_vpc_network_ids`: List of cloud networks in which function/container calls are allowed from any private IP addresses.

    `allowed_vpc_network_ids` has priority over other parameters: if a non-empty value is set for it, the values of `src_ip_restricted_network_ids` and `allowed_src_ips` will be ignored by the policy.
* `src_ip_restricted_network_ids`: List of cloud networks in which function/container calls are allowed only from the private IP addresses specified in the `allowed_src_ips` parameter.
* `allowed_src_ips`: List of private IP addresses or [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) IP address ranges that belong to the networks specified in the `src_ip_restricted_network_ids` parameter, and from which function and container calls are allowed.

See also the [examples of assigning a policy template](../../operations/access-policies/assign.md#serverless-restrictPrivateNetworkInvocation).

#### serverless.restrictPublicInvocation {#serverless-restrictPublicInvocation}

The `serverless.restrictPublicInvocation` policy restricts the ability to call [functions](../../../functions/concepts/function.md) and [containers](../../../serverless-containers/concepts/container.md) from [public IP addresses](../../../vpc/concepts/address.md#internal-addresses).

Additional parameters:

* `allowed_src_ip`: List of public IP addresses or [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) IP address ranges from which function and container calls are allowed.

See also the [example of assigning a policy template](../../operations/access-policies/assign.md#serverless-restrictPublicInvocation).

#### See also {#see-also}

* [{#T}](./roles.md)
* [{#T}](../../operations/access-policies/list.md)
* [{#T}](../../operations/access-policies/assign.md)
* [{#T}](../../operations/access-policies/view-assigned.md)
* [{#T}](../../operations/access-policies/revoke.md)