# Getting information about an instance group

After creating an [instance group](../../concepts/instance-groups/index.md), you can get basic information about it.

You can only use the [CLI](../../../cli/) or API to retrieve custom [metadata](../../concepts/vm-metadata.md) provided when creating or updating the instance group.

To get information about an instance group:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), open the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the instance group is in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Click the name of your instance group.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting information about an instance group:

     ```bash
     {{ yc-compute-ig }} get --help
     ```

  1. Get a list of instance groups in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Select `ID` or `NAME` of the instance group in question, e.g., `first-instance-group`.
  1. Get information about the instance group:

     ```bash
     {{ yc-compute-ig }} get --name first-instance-group
     ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To get information about an instance group using {{ TF }}:
  1. In the {{ TF }} configuration file, define the parameters of the resources you want to create:

     ```hcl
     data "yandex_compute_instance_group" "my_group" {
       instance_group_id = "<instance_group_ID>"
     }

     output "instancegroupvm_external_ip" {
       value = "${data.yandex_compute_instance_group.my_group.instances.*.network_interface.0.nat_ip_address}"
     }
     ```

     Where:
     * `data "yandex_compute_instance_group"`: Description of the data source to get information about the instance group from:
       * `instance_group_id`: Instance group ID.
     * `output "instancegroupvm_external_ip"`: List of all [public IP addresses](../../../vpc/concepts/address.md#public-addresses) of the group instances to return in the output:
       * `value`: Return value.

     For more information about the `yandex_compute_instance_group` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/compute_instance_group).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create the required resources and display their output variables. To check the results, run this command:

     ```bash
     terraform output instancegroupvm_external_ip
     ```

     Result:

     ```text
     instancegroupvm_external_ip = tolist([
       "158.160.112.7",
       "158.160.2.119",
     ])
     ```

- API {#api}

  Use the [get](../../instancegroup/api-ref/InstanceGroup/get.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Get](../../instancegroup/api-ref/grpc/InstanceGroup/get.md) gRPC API call.

  To request a list of available instance groups, use the [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md) gRPC API call.

{% endlist %}