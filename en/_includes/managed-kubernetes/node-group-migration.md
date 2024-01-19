{% list tabs %}

- CLI

   1. Create a subnet:

      ```bash
      yc vpc subnet create \
         --name <subnet_name> \
         --zone <availability_zone> \
         --network-id <network_ID> \
         --range <subnet_CIDR>
      ```

      Where:

      * `--name`: Subnet name.
      * `--zone`: Availability zone (`{{ region-id }}-a`, `{{ region-id }}-b`, or `{{ region-id }}-d`).
      * `--network-id`: ID of the network the new subnet belongs to.
      * `--range`: List of IPv4 addresses for outgoing and incoming traffic, e.g., `10.0.0.0/22` or `192.168.0.0/16`. Make sure the addresses are unique within the network. The minimum subnet size is `/28`, the maximum subnet size is `/16`. Only IPv4 is supported.

   1. Migrate a node group:

      ```bash
      {{ yc-k8s }} node-group update \
         --id <node_group_ID> \
         --location zone=<availability_zone>,subnet-id=<subnet_ID> \
         --network-interface subnets=<subnet_ID>
      ```

      This command recreates the nodes within their group in the specified availability zone and subnet. When recreating, the deployment settings are considered: the maximum number of nodes by which you can increase or decrease the group size versus the original node count.

      In the command, set the following parameter values:

      * `--id`: ID of the node group to migrate to a different availability zone.
      * `zone`: Availability zone you want to move your node group to (`{{ region-id }}-a`, `{{ region-id }}-b`, or `{{ region-id }}-d`).
      * `subnet-id` and `subnets`: ID of the new subnet you created earlier.

- {{ TF }}

   {% note alert %}

   To make sure your node group is not recreated (unless it is your intention to do so), analyze the output of the `terraform plan` and `terraform apply` commands before applying the configuration.

   You can migrate a node group to a different availability zone without recreating it only if the configuration file contains the `allocation_policy` section.

   {% endnote %}

   1. Add the new subnet's manifest to the cluster configuration file and change the node group location:

      ```hcl
      resource "yandex_vpc_subnet" "my-new-subnet" {
         name           = "<subnet_name>"
         zone           = "<availability_zone>"
         network_id     = "<network_ID>"
         v4_cidr_blocks = ["<subnet_CIDR>"]
      }
      ...
      resource "yandex_kubernetes_node_group" "k8s-node-group" {
         allocation_policy {
            location {
               zone = "<availability_zone>"
            }
         }
         ...
         instance_template {
            network_interface {
               subnet_ids = [yandex_vpc_subnet.my-new-subnet.id]
               ...
            }
            ...
         }
         ...
      }
      ```

      Where:

      * `name`: Subnet name.
      * `zone`: Availability zone you want to move your node group to (`{{ region-id }}-a`, `{{ region-id }}-b`, or `{{ region-id }}-d`).
      * `network_id`: ID of the network the new subnet belongs to.
      * `v4_cidr_blocks`: List of IPv4 addresses to deal with outgoing and incoming traffic. For example, `10.0.0.0/22` or `192.168.0.0/16`. Make sure the addresses are unique within the network. The minimum subnet size is `/28`, the maximum subnet size is `/16`. Only IPv4 is supported.
      * `subnet_ids`: ID of the new subnet.

   1. Check that the configuration file is correct.

      {% include [terraform-validate](../mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../mdb/terraform/apply.md) %}

   The group nodes will be recreated in the specified availability zone and subnet. When recreating, the deployment settings are considered: the maximum number of nodes by which you can increase or decrease the group size versus the original node count.

{% endlist %}