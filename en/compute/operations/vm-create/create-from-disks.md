---
title: How to create a VM from disks
description: Follow this guide to create a VM from existing disks.
---

# Creating a VM from disks


You can create a [VM](../../concepts/vm.md) from existing [disks](../../concepts/disk.md). Make sure the disks reside in one of the [availability zones](../../../overview/concepts/geo-scope.md) and are not added to other VMs.

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

{% include [role-note](../../../_includes/compute/role-note.md) %}

{% list tabs group=instructions %}

- Management console {#console}



  1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Select **{{ ui-key.yacloud.compute.instances.create.option_create-form-extended-title }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select an [image](../../concepts/image.md).
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../../overview/concepts/geo-scope.md) for your VM.
  1. Add a [disk](../../concepts/disk.md):

      * Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, click **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
      * In the window that opens, select **{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}** → `Connect existing disk`.
      * Select the disk you need.
      * Optionally, enable **{{ ui-key.yacloud.compute.field_additional_vt356 }}** in the **{{ ui-key.yacloud.compute.field_disk-autodelete_qZn4x }}** field if you need this disk automatically deleted when deleting the VM.
      * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. {% include [encryption-section-secondary](../../../_includes/compute/encryption-section-secondary.md) %}
  1. {% include [section-storages-filesystem](../../../_includes/compute/create/section-storages-filesystem.md) %}
  1. {% include [section-platform](../../../_includes/compute/create/section-platform.md) %}
  1. {% include [network-settings](../../../_includes/compute/create/section-network.md) %}
  1. {% include [section-access](../../../_includes/compute/create/section-access.md) %}
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter a name for the VM:

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}
  1. {% include [section-additional](../../../_includes/compute/create/section-additional.md) %}
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) command for creating a VM:

     ```bash
     yc compute instance create --help
     ```

  1. Get a list of disks in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Select the IDs (`ID`) or names (`NAME`) of the disks you need.
  1. Create a VM in the default folder:

     ```bash
     yc compute instance create \
       --name first-instance \
       --zone {{ region-id }}-a \
       --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
       --use-boot-disk disk-name=first-disk \
       --attach-disk disk-name=second-disk \
       --ssh-key ~/.ssh/id_ed25519.pub
     ```

     This command will create a VM with the following parameters:
     * Name: `first-instance`

       {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

     * Availability zone: `{{ region-id }}-a`
     * [Subnet](../../../vpc/concepts/network.md#network): `default-a`
     * With a [public IP address](../../../vpc/concepts/address.md#public-addresses) and two disks

     To specify whether to delete the disk when deleting the VM, set the `--auto-delete` flag:

     ```bash
     yc compute instance create \
       --name first-instance \
       --zone {{ region-id }}-a \
       --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
       --use-boot-disk disk-name=first-disk,auto-delete=yes \
       --attach-disk disk-name=second-disk,auto-delete=yes \
       --ssh-key ~/.ssh/id_ed25519.pub
     ```

     {% include [add-several-net-interfaces-notice-cli](../../../_includes/compute/add-several-net-interfaces-notice-cli.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To create a VM from disks:
  1. In the configuration file, define the parameters of the resources you want to create:

     ```hcl
     resource "yandex_compute_disk" "boot-disk" {
       name     = "<disk_name>"
       type     = "<disk_type>"
       zone     = "<availability_zone>"
       size     = "<disk_size>"
       image_id = "<image_ID>"
     }

     resource "yandex_compute_instance" "vm-1" {
       name                      = "vm-from-disks"
       allow_stopping_for_update = true
       platform_id               = "standard-v3"
       zone                      = "<availability_zone>"

       resources {
         cores  = <number_of_vCPUs>
         memory = <RAM_in_GB>
       }

       boot_disk {
         disk_id = <boot_disk_ID>
       }

       secondary_disk {
         disk_id = "<secondary_disk_ID>"
       }

       network_interface {
         subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
         nat       = true
       }

       metadata = {
         ssh-keys = "<username>:<SSH_key_contents>"
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name       = "subnet1"
       zone       = "<availability_zone>"
       network_id = "${yandex_vpc_network.network-1.id}"
     }
     ```

     Where:
     * `yandex_compute_disk`: Boot [disk](../../concepts/disk.md) description:
       * `name`: Disk name.
       * `type`: Disk [type](../../concepts/disk.md#disks_types).
       * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md) the disk will reside in.
       * `size`: Disk size in GB.
       * `image_id`: ID of the [image](../../concepts/image.md) to create the VM from. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).

         {% include [id-info](../../../_includes/compute/id-info.md) %}

     * `yandex_compute_instance`: [VM](../../concepts/vm.md) description:
       * `name`: VM name.
       * {% include [terraform-allow-stopping](../../../_includes/compute/terraform-allow-stopping.md) %}
       * `platform_id`: [Platform](../../concepts/vm-platforms.md).
       * `zone`: Availability zone the VM will reside in.
       * `resources`: Number of vCPUs and amount of RAM available to the VM. The values must match the selected platform.
       * `boot_disk`: Boot disk settings. Specify the disk ID.
       * `secondary_disk`: Secondary disk to connect to the VM. Specify the ID of the secondary disk. If there is no disk, [create](../disk-create/empty.md) one.
       * `network_interface`: VM [network interface](../../concepts/network.md) settings. Specify the ID of the selected [subnet](../../../vpc/concepts/network.md#subnet). To automatically assign a [public IP address](../../../vpc/concepts/address.md#public-addresses) to the VM, set `nat = true`.

           {% include [add-several-net-interfaces-notice-tf](../../../_includes/compute/add-several-net-interfaces-notice-tf.md) %}

       * `metadata`: In metadata, provide the public key for SSH access to the VM. For more information, see [{#T}](../../concepts/vm-metadata.md).
     * `yandex_vpc_network`: Cloud network description.
     * `yandex_vpc_subnet`: Description of the subnet to connect your VM to.

     {% note info %}

     If you already have suitable resources, such as a cloud network and subnet, you do not need to redefine them. Specify their names and IDs in the appropriate parameters.

     {% endnote %}

     For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-link }}).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     This will create all the resources you need in the specified [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder). You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Create](../../api-ref/grpc/Instance/create.md) gRPC API call.

{% endlist %}