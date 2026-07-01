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

All access policy templates [without parameters](../../concepts/access-control/access-policies.md#fixed) are assigned for resources in the same way. For information on how to assign a policy template [with parameters](../../concepts/access-control/access-policies.md#customizable) for a resource, see [{#T}](#examples).

## Examples {#examples}

### Creating an access policy for a folder based on the serverless.containers.restrictNetworkAccess template {#serverless-containers-restrictNetworkAccess}

The `serverless.containers.restrictNetworkAccess` [policy](../../concepts/access-control/access-policies.md#serverless-containers-restrictNetworkAccess) prohibits calling and managing {{ serverless-containers-full-name }} [containers](../../../serverless-containers/concepts/container.md) from any addresses except explicitly specified IP addresses or {{ vpc-full-name }} [cloud networks](../../../vpc/concepts/network.md#network).

To assign the `serverless.containers.restrictNetworkAccess` policy template for a folder:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc resource-manager folder bind-access-policy \
    --name my-folder \
    --access-policy-template-id=serverless.containers.restrictNetworkAccess \
    --parameters '"allowed_src_ips=[<IP_address_range_1>,<IP_address_range_2>,<IP_address_range_3>]","allowed_vpc_network_ids=[<network_1_ID>,<network_2_ID>,<network_3_ID>]"'
  ```

  Where:
  
  * `--parameters`: Access policy parameters:

      {% note alert %}

      Restrictions specified in parameters are applied using the `OR` logic. 

      {% endnote %}

      * `allowed_src_ips`: List of IP addresses or IP address ranges in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation to allow calling and managing containers.

          If you do not want to list IP addresses or IP address ranges, provide an empty list in the parameter: `"allowed_src_ips=[]"`.
      * `allowed_vpc_network_ids`: List of IDs of [cloud networks](../../../vpc/concepts/network.md#network) that allow calling and managing containers via a configured [service connection](../../../vpc/concepts/private-endpoint.md).

          If you do not want to list cloud network IDs, provide an empty list in the parameter: `"allowed_vpc_network_ids=[]"`.

{% endlist %}


#### See also {#see-also}

* [{#T}](../../concepts/access-control/access-policies.md)
* [{#T}](./list.md)
* [{#T}](./view-assigned.md)
* [{#T}](./revoke.md)