---
title: Creating a VM in a placement group
description: Follow this guide to create a VM in a placement group.
---

# Creating a VM in a placement group


Create a [VM](../../concepts/vm.md) in a [placement group](../../concepts/placement-groups.md).

{% include [placement-groups-info.md](../../../_includes/compute/placement-groups-info.md) %}

{% include [role-note](../../../_includes/compute/role-note.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) command for creating a placement group:

     ```bash
     yc compute placement-group create --help
     ```

  1. Create a placement group in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) with one of the following placement strategies:

     {% include [pg-create](../../../_includes/compute/placement-groups-create.md) %}

  1. See the description of the CLI command for creating a VM:

     ```bash
     yc compute instance create --help
     ```

  1. Create a VM:

     ```bash
     yc compute instance create \
       --zone {{ region-id }}-a \
       --name instance-in-group-1 \
       --placement-group-name my-group \
       --placement-group-partition <partition_number>
     ```

     Where:
     * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) for the VM.
     * `--name`: VM name.
     * `--placement-group-name`: Placement group name.
     * `--placement-group-partition`: Partition number in the placement group with the [partition placement](../../concepts/placement-groups.md#partition) strategy.

       {% note info %}

       If you do not specify the partition number when creating a VM in a partition placement group, the VM will be added to a random partition.

       {% endnote %}

     Result:

     ```text
     id: epdep2kq6dt5********
     ...
     placement_policy:
       placement_group_id: fd83bv4rnsna********
     ```

  1. Check the new VM and its placement group:

     ```bash
     yc compute placement-group list-instances --name my-group
     ```

     Where `--name` is the placement group name.

     Result:

     ```text
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     |          ID          |        NAME         |      ZONE ID      | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     | epdep2kq6dt5******** | instance-in-group-1 | {{ region-id }}-a | RUNNING |             | 10.129.0.5  |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To create a VM in a placement group:
  1. In the configuration file, define the VM parameters indicating the `yandex_compute_placement_group` resource in the `placement_group_id` field. The `yandex_compute_instance` resource describes the VM parameters.

     Here is an example of the configuration file structure:

     ```hcl
     ...
     resource "yandex_compute_instance" "vm-1" {
       name        = "linux-vm"
       platform_id = "standard-v3"
       placement_policy {
         placement_group_id = "${yandex_compute_placement_group.group1.id}"
       }
     }

     resource "yandex_compute_placement_group" "group1" {
       name = "test-pg"
     }
     ...
     ```

     Where `placement_group_id` is the placement group ID.

     For more information about the `yandex_compute_instance` and `yandex_compute_placement_group` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_instance).
  1. In the command line, go to the directory with the {{ TF }} configuration file.
  1. Check the configuration using this command:

     ```bash
     terraform validate
     ```

     If the configuration is correct, you will get this message:

     ```text
     Success! The configuration is valid.
     ```

  1. Run this command:

     ```bash
     terraform plan
     ```

     You will see a detailed list of resources. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
  1. Apply the changes:

     ```bash
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     This will create all the resources you need in the specified [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder). You can check that the VM has been created and added to the placement group using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Create](../../api-ref/grpc/Instance/create.md) gRPC API call.

{% endlist %}

## See also {#see-also}

* [Adding a VM to a placement group](add-vm.md)