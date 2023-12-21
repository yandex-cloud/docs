# Migrating {{ managed-k8s-name }} resources to a different availability zone


{% note info %}

{{ managed-k8s-name }} only supports [node group](../concepts/index.md#node-group) migration. Going forward, you will also be able to migrate your [master host](../concepts/index.md#master) to another availability zone.

{% endnote %}

## Getting started {#before-you-begin}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}


## Migrate a node group to a different availability zone {#transfer-a-node-group}

{% list tabs %}

- CLI

   1. Create a subnet in the availability zone you want to move your node group to.

      ```bash
      yc vpc subnet create \
         --name <subnet_name> \
         --zone <availability_zone> \
         --network-id <network_ID> \
         --range <subnet_CIDR>
      ```

      In the command, specify the following subnet parameters:

      * `--name`: Subnet name.
      * `--zone`: Availability zone (`{{ region-id }}-a`, `{{ region-id }}-b`, or `{{ region-id }}-d`).
      * `--network-id`: ID of the network the new subnet belongs to.
      * `--range`: List of IPv4 addresses for outgoing and incoming traffic, e.g., `10.0.0.0/22` or `192.168.0.0/16`. Make sure the addresses are unique within the network. The minimum subnet size is `/28`, the maximum subnet size is `/16`. Only IPv4 is supported.

   1. Migrate your node group to a different availability zone:

      ```bash
      {{ yc-k8s }} node-group update \
         --id <node_group_ID> \
         --location zone=<availability_zone>,subnet-id=<subnet_ID> \
         --network-interface subnets=<subnet_ID>
      ```

      This command recreates the nodes within their group in the specified availability zone and subnet. When recreating, the deployment settings are considered: the maximum number of nodes by which you can increase or decrease the group size versus the original node count.

      In the command, set the following parameter values:

      * `--id`: ID of the node group to migrate to a different availability zone.
      * `zone`: New availability zone.
      * `subnet-id` and `subnets`: ID of the new subnet that you created when migrating the master host.

{% endlist %}
