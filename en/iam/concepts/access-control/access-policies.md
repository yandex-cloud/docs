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

Some access policy templates require you to specify parameters when assigned to a resource; others do not.

### Templates without parameters {#fixed}

The following access policy templates do not contain parameters and unconditionally restrict relevant actions:

* [backup.denyActivation](#backup-denyActivation)
* [backup.denyRemoveProtection](#backup-denyRemoveProtection)
* [iam.denyServiceAccountAccessKeysCreation](#iam-denyServiceAccountAccessKeysCreation)
* [iam.denyServiceAccountApiKeysCreation](#iam-denyServiceAccountApiKeysCreation)
* [iam.denyServiceAccountAuthorizedKeysCreation](#iam-denyServiceAccountAuthorizedKeysCreation)
* [iam.denyServiceAccountCreation](#iam-denyServiceAccountCreation)
* [iam.denyServiceAccountCredentialsCreation](#iam-denyServiceAccountCredentialsCreation)
* [iam.denyServiceAccountFederatedCredentialsCreation](#iam-denyServiceAccountFederatedCredentialsCreation)
* [iam.denyServiceAccountImpersonation](#iam-denyServiceAccountImpersonation)
* [organization.denyMemberInvitation](#organization-denyMemberInvitation)
* [organization.denyUserListing](#organization-denyUserListing)

{% include [backup-access-policies](../../../_includes/backup/backup-access-policies.md) %}

#### iam.denyServiceAccountAccessKeysCreation {#iam-denyServiceAccountAccessKeysCreation}

This policy prohibits creating [static access keys](../authorization/access-key.md) for service accounts.

#### iam.denyServiceAccountApiKeysCreation {#iam-denyServiceAccountApiKeysCreation}

This policy prohibits creating [API keys](../authorization/api-key.md) for service accounts.

#### iam.denyServiceAccountAuthorizedKeysCreation {#iam-denyServiceAccountAuthorizedKeysCreation}

This policy prohibits creating [authorized keys](../authorization/key.md) for service accounts.

#### iam.denyServiceAccountCreation {#iam-denyServiceAccountCreation}

This policy prohibits creating [service accounts](../users/service-accounts.md).

#### iam.denyServiceAccountCredentialsCreation {#iam-denyServiceAccountCredentialsCreation}

This policy prohibits the following:

* Creating any [credentials](../authorization/index.md) for service accounts (except [IAM tokens](../authorization/iam-token.md)).
* Associating service accounts with [workload identity federations](../workload-identity.md).

#### iam.denyServiceAccountFederatedCredentialsCreation {#iam-denyServiceAccountFederatedCredentialsCreation}

This policy prohibits associating service accounts with [workload identity federations](../workload-identity.md).

#### iam.denyServiceAccountImpersonation {#iam-denyServiceAccountImpersonation}

This policy prohibits [impersonation](../access-control/impersonation.md).

#### organization.denyMemberInvitation {#organization-denyMemberInvitation}

This policy prohibits [inviting](../../../organization/operations/add-account.md#useraccount) new Yandex [account](../users/accounts.md#passport) users to an organization. You can only create this policy for an [organization](../../../organization/concepts/organization.md).

#### organization.denyUserListing {#organization-denyUserListing}

This policy prohibits viewing the list of [organization](../../../organization/concepts/organization.md) users. You can only create this policy for an [organization](../../../organization/concepts/organization.md).

### Templates with parameters {#customizable}

The following access policy templates support parameters to define restrictions:

{% note tip %}

For more information on how to create access policies based on templates with parameters, see [Creating an access policy for a resource](../../operations/access-policies/assign.md#examples).

{% endnote %}

* [serverless.containers.restrictNetworkAccess](#serverless-containers-restrictNetworkAccess)
* [serverless.containers.restrictResourceVPCNetwork](#serverless-containers-restrictResourceVPCNetwork)
* [serverless.functions.restrictNetworkAccess](#serverless-functions-restrictNetworkAccess)
* [serverless.functions.restrictResourceVPCNetwork](#serverless-functions-restrictResourceVPCNetwork)
* [serverless.mcpGateways.restrictNetworkAccess](#serverless-mcpGateways-restrictNetworkAccess)
* [serverless.mcpGateways.restrictResourceVPCNetwork](#serverless-mcpGateways-restrictResourceVPCNetwork)
* [serverless.responses.restrictNetworkAccess](#serverless-responses-restrictNetworkAccess)
* [serverless.workflows.restrictNetworkAccess](#serverless-workflows-restrictNetworkAccess)
* [serverless.workflows.restrictResourceVPCNetwork](#serverless-workflows-restrictResourceVPCNetwork)

#### serverless.containers.restrictNetworkAccess {#serverless-containers-restrictNetworkAccess}

The policy prohibits calling and managing {{ serverless-containers-full-name }} [containers](../../../serverless-containers/concepts/container.md) from any addresses except explicitly specified IP addresses or {{ vpc-full-name }} [cloud networks](../../../vpc/concepts/network.md#network).

Customizable parameters (applied using the `OR` logic):

* `allowed_src_ips`: List of IP addresses or IP address ranges in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation you can call and manage containers from.
* `allowed_vpc_network_ids`: List of IDs of cloud networks that allow calling and managing containers via a configured [service connection](../../../vpc/concepts/private-endpoint.md).

#### serverless.containers.restrictResourceVPCNetwork {#serverless-containers-restrictResourceVPCNetwork}

This policy restricts which [cloud networks](../../../vpc/concepts/network.md#network) can be bound to [containers](../../../serverless-containers/concepts/container.md) in {{ serverless-containers-full-name }}, prohibiting all networks except those explicitly specified.

Customizable parameter:

* `allowed_vpc_network_ids`: List of IDs for cloud networks that can be bound to containers.

#### serverless.functions.restrictNetworkAccess {#serverless-functions-restrictNetworkAccess}

This policy prohibits calling and managing [functions](../../../functions/concepts/function.md)in {{ sf-full-name }} from any addresses except explicitly specified IP addresses or {{ vpc-full-name }} [cloud networks](../../../vpc/concepts/network.md#network).

Customizable parameters (applied using the `OR` logic):

* `allowed_src_ips`: List of IP addresses or IP address ranges in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation you can call and manage functions from.
* `allowed_vpc_network_ids`: List of IDs of cloud networks that allow calling and managing functions via a configured [service connection](../../../vpc/concepts/private-endpoint.md).

#### serverless.functions.restrictResourceVPCNetwork {#serverless-functions-restrictResourceVPCNetwork}

This policy restricts which [cloud networks](../../../vpc/concepts/network.md#network) can be bound to {{ sf-full-name }} [functions](../../../functions/concepts/function.md), prohibiting all networks except those explicitly specified.

Customizable parameter:

* `allowed_vpc_network_ids`: List of IDs for cloud networks that can be bound to functions.

#### serverless.mcpGateways.restrictNetworkAccess {#serverless-mcpGateways-restrictNetworkAccess}

The policy prohibits calling and managing {{ mcp-hub-name }} [MCP servers]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/#servers) from any addresses except explicitly specified IP addresses or {{ vpc-full-name }} [cloud networks](../../../vpc/concepts/network.md#network).

Customizable parameters (applied using the `OR` logic):

* `allowed_src_ips`: List of IP addresses or IP address ranges in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation you can call and manage MCP servers from.
* `allowed_vpc_network_ids`: List of IDs of cloud networks that allow calling and managing MCP servers via a configured [service connection](../../../vpc/concepts/private-endpoint.md).

#### serverless.mcpGateways.restrictResourceVPCNetwork {#serverless-mcpGateways-restrictResourceVPCNetwork}

This policy restricts which [cloud networks](../../../vpc/concepts/network.md#network) can be bound to {{ mcp-hub-name }} [MCP servers]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/#servers), prohibiting all networks except those explicitly specified.

Customizable parameter:

* `allowed_vpc_network_ids`: List of IDs for cloud networks that can be bound to MCP servers.

#### serverless.responses.restrictNetworkAccess {#serverless-responses-restrictNetworkAccess}

The policy prohibits calling {{ ai-studio-full-name }} [{{ responses-api }}]({{ link-docs-ai }}ai-studio/responses/) methods from any addresses except explicitly specified IP addresses or {{ vpc-full-name }} [cloud networks](../../../vpc/concepts/network.md#network).

Customizable parameters (applied using the `OR` logic):

* `allowed_src_ips`: List of IP addresses or IP address ranges in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation you can call {{ responses-api }} methods from.
* `allowed_vpc_network_ids`: List of IDs of cloud networks that allow calling {{ responses-api }} methods via a configured [service connection](../../../vpc/concepts/private-endpoint.md).

#### serverless.workflows.restrictNetworkAccess {#serverless-workflows-restrictNetworkAccess}

The policy prohibits executing {{ si-full-name }} [workflows](../../../serverless-integrations/concepts/workflows/workflow.md) from any addresses except explicitly specified IP addresses or {{ vpc-full-name }} [cloud networks](../../../vpc/concepts/network.md#network).

Customizable parameters (applied using the `OR` logic):

* `allowed_src_ips`: List of IP addresses or IP address ranges in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation you can execute and manage workflows from.
* `allowed_vpc_network_ids`: List of IDs of cloud networks that allow executing and managing workflows via a configured [service connection](../../../vpc/concepts/private-endpoint.md).

#### serverless.workflows.restrictResourceVPCNetwork {#serverless-workflows-restrictResourceVPCNetwork}

This policy restricts which [cloud networks](../../../vpc/concepts/network.md#network) can be bound to {{ si-full-name }} [workflows](../../../serverless-integrations/concepts/workflows/workflow.md), prohibiting all networks except those explicitly specified.

Customizable parameter:

* `allowed_vpc_network_ids`: List of IDs for cloud networks that can be bound to workflows.

#### See also {#see-also}

* [{#T}](./roles.md)
* [{#T}](../../operations/access-policies/list.md)
* [{#T}](../../operations/access-policies/assign.md)
* [{#T}](../../operations/access-policies/view-assigned.md)
* [{#T}](../../operations/access-policies/revoke.md)
