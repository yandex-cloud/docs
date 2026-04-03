---
title: Creating an access policy for a resource
description: In this tutorial, you will learn how to create a {{ iam-full-name }} access policy for a folder, cloud, or organization based on a policy template.
---

# Creating an access policy for a resource

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{% include [access-policies-instruction-intro](../../../_includes/iam/access-policies-instruction-intro.md) %}

You can create an access policy for a [folder](#folder), [cloud](#cloud), or [organization](#organization).

{% note info %}

{% include [access-policies-roles](../../../_includes/iam/access-policies-roles.md) %}

{% endnote %}

## Creating an access policy for a folder {#folder}

{% include [access-policies-assign-folder](../../../_includes/iam/access-policies-assign-folder.md) %}

## Creating an access policy for a cloud {#cloud}

{% include [access-policies-assign-cloud](../../../_includes/iam/access-policies-assign-cloud.md) %}

## Creating an access policy for an organization {#organization}

{% include [access-policies-assign-org](../../../_includes/iam/access-policies-assign-org.md) %}

All access policy templates [without additional parameters](../../concepts/access-control/access-policies.md#fixed) are assigned for resources in the same way. For information on how to assign a policy template [with additional parameters](../../concepts/access-control/access-policies.md#customizable) for a resource, see [{#T}](#examples).

## Examples {#examples}

### Creating the serverless.restrictPrivateNetworkInvocation policy for a folder {#serverless-restrictPrivateNetworkInvocation}

The `serverless.restrictPrivateNetworkInvocation` [policy](../../concepts/access-control/access-policies.md#serverless-restrictPrivateNetworkInvocation) limits calling [functions](../../../functions/concepts/function.md) and [containers](../../../serverless-containers/concepts/container.md) from {{ vpc-full-name }}'s [private IP addresses](../../../vpc/concepts/address.md#internal-addresses) to explicitly specified [cloud networks](../../../vpc/concepts/network.md#network) or specific IP addresses within them.

{% include [access-policies-private-endpoint-notice](../../../_includes/iam/access-policies-private-endpoint-notice.md) %}

To assign the `serverless.restrictPrivateNetworkInvocation` policy template for a folder:

{% list tabs group=instructions %}

- CLI {#cli}

  **No IP-based restriction**

  ```bash
  yc resource-manager folder bind-access-policy \
    --name "my-folder" \
    --access-policy-template-id=serverless.restrictPrivateNetworkInvocation \
    --parameters '"allowed_vpc_network_ids=[<network_1_ID>,<network_2_ID>,<network_3_ID>]","src_ip_restricted_network_ids=[]","allowed_src_ips=[]"'
  ```

  Where `allowed_vpc_network_ids` is a list of cloud network IDs from which you can call functions and containers. Function and container calls will be allowed from any IP addresses within the [subnets](../../../vpc/concepts/network.md#subnet) forming part of the specified cloud networks. In addition, there must be a cloud network from the mentioned list linked to the function/container.

  You can provide a zero value for this parameter; in which case you must set an IP-based restriction in `src_ip_restricted_network_ids` and `allowed_src_ips`.

  After you apply the policy in `my-folder`, you will only be able to use the private IP addresses to call those functions/containers that have linked cloud networks with the following IDs: `<network_1_ID>`, `<network_2_ID>`, and `<network_3_ID>`, and only from the IP addresses of the subnets belonging to those cloud networks.

  **With an IP-based restriction**

  ```bash
  yc resource-manager folder bind-access-policy \
    --name "my-folder" \
    --access-policy-template-id=serverless.restrictPrivateNetworkInvocation \
    --parameters '"allowed_vpc_network_ids=[]","src_ip_restricted_network_ids=[<network_1_ID>,<network_2_ID>,<network_3_ID>]","allowed_src_ips=[10.1.2.0/24,172.16.17.0/28,192.168.1.2/32]"'
  ```

  Where:

  * `src_ip_restricted_network_ids` is a list of cloud network IDs from which you can call functions and containers, with an additional restrictions on allowed IP addresses. Function and container calls will be allowed from specific IP addresses belonging to specified cloud networks and explicitly named in `allowed_src_ips`. In addition, there must be a cloud network from the mentioned list linked to the function/container.
  * `allowed_src_ips` is a list of private IP addresses or IP address ranges in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation you can call functions and containers from.

      These IP addresses must belong to the cloud networks specified in `src_ip_restricted_network_ids`.

  After you apply the policy in `my-folder`, you will only be able to use the private IP addresses to call those functions/containers that have linked cloud networks with the following IDs: `<network_ID_1>`, `<network_ID_2>`, and `<network_ID_3>`, and only from the IP addresses that belong to those cloud networks and the `10.1.2.0/24`, `172.16.17.0/28`, and `192.168.1.2/32` ranges at the same time.

{% endlist %}

{% note info %}

If `allowed_vpc_network_ids` has a non-zero value, the list of IP addresses specified by `src_ip_restricted_network_ids` and `allowed_src_ips` will be ignored.

{% endnote %}

### Creating the serverless.restrictPublicInvocation policy for a folder {#serverless-restrictPublicInvocation}

The `serverless.restrictPublicInvocation` [policy](../../concepts/access-control/access-policies.md#serverless-restrictPublicInvocation) restricts the ability to call [functions](../../../functions/concepts/function.md) and [containers](../../../serverless-containers/concepts/container.md) from [public IP addresses](../../../vpc/concepts/address.md#internal-addresses).

To assign the `serverless.restrictPublicInvocation` policy template for a folder:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc resource-manager folder bind-access-policy \
    --name "my-folder" \
    --access-policy-template-id=serverless.restrictPublicInvocation \
    --parameters '"allowed_src_ips=[198.51.100.104/29,192.0.2.4/30]"'
  ```

  Where `allowed_src_ip` is a list of public IP addresses or IP address ranges in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation you can call functions and containers from.

  After you apply the policy in `my-folder` using public IP addresses, you will be able to call functions/containers only from the IP addresses belonging to the `198.51.100.104/29` and `192.0.2.4/30` ranges.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/access-control/access-policies.md)
* [{#T}](./list.md)
* [{#T}](./view-assigned.md)
* [{#T}](./revoke.md)