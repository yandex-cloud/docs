{% list tabs group=instructions %}

- CLI {#cli}

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

   1. Move the node group to the new availability zone. The example below shows a command for moving a group residing in a single zone:

      ```bash
      {{ yc-k8s }} node-group update \
         --id <node_group_ID> \
         --location zone=<availability_zone>,subnet-id=<subnet_ID> \
         --network-interface subnets=<subnet_ID>,`
              `ipv4-address=nat,`
              `security-group-ids=[<security_group_IDs>]
      ```

      Where:

      * `id`: ID of the node group to move to a different availability zone.
      * `zone`: Availability zone you want to move your node group to (`{{ region-id }}-a`, `{{ region-id }}-b`, or `{{ region-id }}-d`).
      * `subnet-id` and `subnets`: ID of the new subnet you created earlier.
      * `ipv4-address`: Method of assigning an IPv4 address. The `nat` value allows assigning public and internal IP addresses to nodes.
      * `security-group-ids`: List of [security group](../../managed-kubernetes/operations/connect/security-groups.md) IDs.

      {% note warning %}

      If you want to keep the values of other network parameters for the node group, specify them in the `network-interface` parameter as well. Otherwise, the group can be recreated with default values. For more information, see [Updating a Managed Service for Kubernetes node group](../../managed-kubernetes/operations/node-group/node-group-update.md).

      {% endnote %}

      It is important to provide the `ipv4-address` and `security-group-ids` parameters in the command: this will assign public IP addresses to the node group and keep security groups within it.

      This command recreates the nodes within their group in the specified availability zone and subnet. When recreating, the deployment settings are considered: the maximum number of nodes by which you can increase or decrease the group size versus the original node count.

      {% cut "How to move a node group residing in different availability zones" %}

      In this case, use the following command:

      ```bash
      {{ yc-k8s }} node-group update \
         --id <node_group_ID> \
         --location zone=<availability_zone>,subnet-id=<subnet_ID> \
         ...
         --location zone=<availability_zone>,subnet-id=<subnet_ID> \
         --network-interface subnets=[<subnet_IDs>],`
              `ipv4-address=nat,`
              `security-group-ids=[<security_group_IDs>]
      ```

      Where:

      * `id`: ID of the node group to move to a different availability zone.
      * `zone`: Availability zone (`{{ region-id }}-a`, `{{ region-id }}-b`, or `{{ region-id }}-d`). Specify the `location` parameters for each availability zone that will host the node group.
      * `subnet-id` and `subnets`: IDs of the subnets for the specified availability zones.
      * `ipv4-address`: Method of assigning an IPv4 address. The `nat` value allows assigning public and internal IP addresses to nodes.
      * `security-group-ids`: List of [security group](../../managed-kubernetes/operations/connect/security-groups.md) IDs.

      {% endcut %}

- {{ TF }} {#tf}

   {% note alert %}

   To make sure your node group is not recreated (unless it is your intention to do so), analyze the output of the `terraform plan` and `terraform apply` commands before applying the configuration.

   You can migrate a node group to a different availability zone without recreating it only if the configuration file contains the `allocation_policy` section.

   {% endnote %}

   1. Make the following changes to the configuration file:
      * Add a new subnet manifest (`yandex_vpc_subnet` resource) in the availability zone to which you want to move the node group.
      * Change the node group location parameters (`yandex_kubernetes_node_group` resource):
         * `allocation_policy.location.subnet_id`: Remove this parameter if it is in the manifest.
         * `allocation_policy.location.zone`: Specify the availability zone you want to move the node group to.
         * `instance_template.network_interface.subnet_ids`: Specify the new subnet ID. Add this parameter if it is not in the manifest.

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
      * `v4_cidr_blocks`: List of IPv4 addresses to deal with outgoing and incoming traffic, e.g., `10.0.0.0/22` or `192.168.0.0/16`. Make sure the addresses are unique within the network. The minimum subnet size is `/28`, the maximum subnet size is `/16`. Only IPv4 is supported.
      * `subnet_ids`: ID of the new subnet.

   1. Check that the configuration file is correct.

      {% include [terraform-validate](../mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../mdb/terraform/apply.md) %}

   The group nodes will be recreated in the specified availability zone and subnet. When recreating, the deployment settings are considered: the maximum number of nodes by which you can increase or decrease the group size versus the original node count.

{% endlist %}