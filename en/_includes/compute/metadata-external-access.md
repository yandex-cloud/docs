{% include [external-access-directories](./metadata/external-access-directories.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  In **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**, the **{{ ui-key.yacloud.compute.instances.label_title }}** page gives a list of VMs in the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) and brief information on each of them.

  For more information about a VM, click the row with its name.

  Here is a description of the available tabs:
  * **{{ ui-key.yacloud.common.overview }}** shows general information about the VM, including the [IP addresses](../../vpc/concepts/address.md) assigned to it.
  * **{{ ui-key.yacloud.compute.instance.switch_disks }}** gives information about the [disks](../../compute/concepts/disk.md) attached to the VM.
  * **{{ ui-key.yacloud.compute.instance.switch_file-storages }}** provides information about the connected [file storages](../../compute/concepts/filesystem.md).
  * **{{ ui-key.yacloud.common.operations-key-value }}** lists operations on the VM and its resources, such as disks.
  * **{{ ui-key.yacloud.common.monitoring }}** shows information about VM resource consumption. You can only get this info from the management console or from within the VM.
  * **{{ ui-key.yacloud.compute.instance.switch_console }}** provides access to the [serial console](../../compute/operations/serial-console/index.md) if enabled when [creating](../../compute/operations/index.md#vm-create) the VM.
  * **{{ ui-key.yacloud.compute.instance.switch_service-console }}** provides information that the VM outputs to the serial port. To get this information via the API or CLI, follow [{#T}](../../compute/operations/vm-info/get-serial-port-output.md).

- CLI {#cli}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the command for getting the [serial port output](../../compute/operations/vm-info/get-serial-port-output.md):

     ```bash
     yc compute instance get --help
     ```

  1. Select a VM, e.g., `first-instance`:

     {% include [compute-instance-list](../../compute/_includes_service/compute-instance-list.md) %}

  1. Get basic information about the VM:

     ```bash
     yc compute instance get first-instance
     ```

     To get VM information with metadata, use the `--full` flag:

     ```bash
     yc compute instance get --full first-instance
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../terraform-install.md) %}

  1. In the {{ TF }} configuration file, define the parameters of the resources you want to create:

     ```hcl
     data "yandex_compute_instance" "my_instance" {
       instance_id = "<VM_ID>"
     }

     output "instance_external_ip" {
       value = "${data.yandex_compute_instance.my_instance.network_interface.0.nat_ip_address}"
     }
     ```

     Where:
     * `data "yandex_compute_instance"`: Description of the data source to get VM information from:
       * `instance_id`: VM ID.
     * `output "instance_external_ip"`: [Public IP address](../../vpc/concepts/address.md#public-addresses) of the VM to return in the output:
       * `value`: Returned value.

     For more information about the `yandex_compute_instance` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/compute_instance).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources and display the output variable values in the terminal. To check the results, run this command:

     ```bash
     terraform output instance_external_ip
     ```

     Result:

     ```text
     instance_external_ip = "158.160.50.228"
     ```

- API {#api}

  To get basic information about a VM, use the [get](../../compute/api-ref/Instance/get.md) REST API method for the [Instance](../../compute/api-ref/Instance/index.md) resource or the [InstanceService/Get](../../compute/api-ref/grpc/Instance/get.md) gRPC API call.

  The basic information does not include any custom metadata provided when creating or [updating](../../compute/operations/vm-control/vm-update.md) the VM. To get the information along with the metadata, specify `view=FULL` in the parameters.

{% endlist %}