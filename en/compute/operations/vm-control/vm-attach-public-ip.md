# Assigning a public IP to a virtual machine

If you created a virtual machine without a public IP, you can associate it with an IP [you reserved](../../../vpc/operations/get-static-ip.md) in {{ vpc-name }} or with one automatically selected by {{ compute-name }} from among available IPs. The reserved IP address and the VM must be in the same availability zone.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
   1. Select the VM you need.
   1. In the window that opens, under **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) in the top-right corner and select **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**.
   1. In the window that opens:
      * In the **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** field, select `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}` to get an IP automatically or `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}` to choose a reserved one from the list.
         (Option) If you selected `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}` under **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}**, enable the **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_ddos-protection-provider }}** option. For more information, see [{#T}](../../../vpc/ddos-protection/index.md).
      * If you selected `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}` in the **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** field, select the address that you would like to assign to your VM. The IP address and the VM must be in the same [availability zone](../../../overview/concepts/geo-scope.md).
      * Click **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.button_submit }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To assign a public IP address to a VM, run the following CLI command:

   ```bash
   yc compute instance add-one-to-one-nat \
     --id=<instance_ID> \
     --network-interface-index=<instance_network_interface_index> \
     --nat-address=<IP_address>
   ```

   Where:

   * `--id`: VM ID. You can get a list of instance IDs in a folder using the `yc compute instance list` [CLI command](../../../cli/cli-ref/managed-services/compute/instance/list.md).
   * `--network-interface-index`: VM network interface index. The default value is `0`.
   * `--nat-address`: Public IP address to assign to the VM. This is an optional parameter. If you omit the `--nat-address` parameter, a public IP address will be assigned to your VM automatically.

      You can get a list of reserved public IP addresses in a folder using the `yc vpc address list` [CLI command](../../../cli/cli-ref/managed-services/vpc/address/list.md). The IP address and the VM must be in the same [availability zone](../../../overview/concepts/geo-scope.md).

   Usage example:

   ```bash
   yc compute instance add-one-to-one-nat \
     --id=fhmsbag62taf******** \
     --network-interface-index=0 \
     --nat-address=51.250.*.***
   ```

   Result:

   ```bash
   id: fhmsbag62taf********
   folder_id: b1gv87ssvu49********
   created_at: "2022-05-06T10:41:56Z"
   name: steel-machine
   description: for work
   zone_id: {{ region-id }}-a
   platform_id: standard-v3
   resources:
     memory: "1073741824"
     cores: "2"
     core_fraction: "20"
   status: RUNNING
   boot_disk:
     mode: READ_WRITE
     device_name: fhmeihe6vgg1********
     auto_delete: true
     disk_id: fhmeihe6vgg1********
   network_interfaces:
   - index: "0"
     mac_address: d0:0d:1c:5a:**:**
     subnet_id: e9bn57jvjnbu********
     primary_v4_address:
       address: 10.128.0.23
       one_to_one_nat:
         address: 51.250.*.***
         ip_version: IPV4
     security_group_ids:
     - enpcuhcljhb0********
   fqdn: steel-machine.{{ region-id }}.internal
   scheduling_policy:
     preemptible: true
   network_settings:
     type: STANDARD
   placement_policy: {}
   ```

   For more information about the `yc compute instance add-one-to-one-nat` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance/add-one-to-one-nat.md).

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. To create a public IP address and link it to a VM, use the `yandex_vpc_address` resource and specify it for the VM in the `nat_ip_address` field:

      ```hcl
      # Creating a static IP

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

        ## Assigning the VM a subnet and IP in the network_interface section

        network_interface {
          subnet_id      = "<VM_subnet_ID>"
          nat            = true
          nat_ip_address = yandex_vpc_address.addr.external_ipv4_address[0].address
        }
        ...

      }
      ```

      Where `nat_ip_address` is the public IP to assign to the VM. The `yandex_vpc_address` resource contains a list of items, where `[0]` is the list's first item that contains the IP address. If you already have a reserved public IP address to assign to your VM, specify it in the `nat_ip_address` field:

      ```hcl
      nat_ip_address = "<IP_address>"
      ```

      The IP address and the VM must be in the same [availability zone](../../../overview/concepts/geo-scope.md).

      For more information about the `yandex_compute_instance` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/compute_instance).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}).

- API {#api}

   To assign a public IP address to a VM, use the [addOneToOneNat](../../api-ref/Instance/addOneToOneNat.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/AddOneToOneNat](../../api-ref/grpc/instance_service.md#AddOneToOneNat) gRPC API call.

{% endlist %}

Your VM will have а [public IP address](../../../vpc/concepts/ips.md) assigned. You can use this IP address to [connect](../vm-connect/ssh.md#vm-connect) to the VM via SSH.