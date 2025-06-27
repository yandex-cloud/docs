{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the VM belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Select the VM.
  1. In the window that opens, under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**, click ![image](../../_assets/console-icons/ellipsis.svg) in the top-right corner of the relevant network interface section and select **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**. In the window that opens:
      * In the **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** field, select `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}` to get an IP address automatically or `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}` to choose a reserved address from the list.
      * Optionally, if you selected `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}` in the **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** field, enable **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_ddos-protection-provider }}**. For more information, see [{#T}](../../vpc/ddos-protection/index.md).
      * If you selected `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}` in the **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** field, choose the IP address you want to assign to your VM. The IP address and the VM must be in the same availability zone.
      * Click **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.button_submit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To assign a public IP address to a VM, run the following [CLI](../../cli/) command:

  ```bash
  yc compute instance add-one-to-one-nat \
    --id=<VM_ID> \
    --network-interface-index=<VM_network_interface_number> \
    --nat-address=<IP_address>
  ```

  Where:
  * `--id`: VM ID. You can get a list of available VM IDs in the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) using the `yc compute instance list` [CLI command](../../cli/cli-ref/compute/cli-ref/instance/list.md).
  * `--network-interface-index`: VM network interface number. The default value is `0`. To get a list of VM network interfaces and their numbers, run `yc compute instance get <VM_ID>`.
  * `--nat-address`: Public IP address to assign to the VM. This is an optional setting. If you skip it, the VM will get a public IP address automatically.

    You can get a list of reserved public IP addresses available in the folder using the `yc vpc address list` [CLI command](../../cli/cli-ref/vpc/cli-ref/address/list.md). The IP address and the VM must be in the same availability zone.

  Here is a possible use case:

  ```bash
  yc compute instance add-one-to-one-nat \
    --id=fhmsbag62taf******** \
    --network-interface-index=0 \
    --nat-address=51.250.*.***
  ```

  Result:

  ```text
  id: fhmsbag62taf********
  folder_id: b1gv87ssvu49********
  created_at: "2022-05-06T10:41:56Z"
  ...
  network_settings:
    type: STANDARD
  placement_policy: {}
  ```

  For more information about the `yc compute instance add-one-to-one-nat` command, see the [CLI reference](../../cli/cli-ref/compute/cli-ref/instance/add-one-to-one-nat.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. To create a public IP address and link it to a VM network interface, use the `yandex_vpc_address` resource and specify the address you get in the `nat_ip_address` field under `network_interface` for the network interface in question in the `yandex_compute_instance` resource configuration:

     ```hcl
     # Creating a static IP address

     resource "yandex_vpc_address" "addr" {
       name = "vm-adress"
       external_ipv4_address {
         zone_id = "<availability_zone>"
       }
     }

     # Creating a VM

     resource "yandex_compute_instance" "vm-1" {
       name        = "<VM_name>"
       platform_id = "standard-v3"
       resources {
         core_fraction = 20
         cores         = 2
         memory        = 1
       }
       ...

       ## Assigning a subnet and IP address to the VM network interface under `network_interface`

       network_interface {
         subnet_id      = "<VM_subnet_ID>"
         nat            = true
         nat_ip_address = yandex_vpc_address.addr.external_ipv4_address[0].address
       }
       ...

     }
     ```

     Where `nat_ip_address` is the public IP address to assign to the VM network interface. The `yandex_vpc_address` resource contains a list of items, where `[0]` is the list's first item that contains the IP address. If you already have a reserved public IP address to assign to your VM, specify it in the `nat_ip_address` field:

     ```hcl
     nat_ip_address = "<IP_address>"
     ```

     The IP address and the VM must be in the same availability zone.

     For more information about `yandex_compute_instance` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/compute_instance).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources in the [management console]({{ link-console-main }}).

- API {#api}

  To assign a public IP address to a VM network interface, use the [addOneToOneNat](../../compute/api-ref/Instance/addOneToOneNat.md) REST API method for the [Instance](../../compute/api-ref/Instance/index.md) resource or the [InstanceService/AddOneToOneNat](../../compute/api-ref/grpc/Instance/addOneToOneNat.md) gRPC API call.

{% endlist %}

Your VM network interface will have a public IP address assigned. You can use this IP address to [connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.