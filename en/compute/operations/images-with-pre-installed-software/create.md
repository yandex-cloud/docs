---
title: How to create a VM from a public image in {{ compute-full-name }}
description: Follow this guide to create a VM from a public image.
---

# Creating a VM from a public image


To create a [VM](../../concepts/vm.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.  
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select a public [image](../../concepts/image.md) with the software you want to use.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../../overview/concepts/geo-scope.md) to place your VM in.
  1. (Optional) Configure the boot [disk](../../concepts/disk.md) in the **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** section:

      * Select the [disk type](../../concepts/disk.md#disks_types).
      * Specify the required disk size.

  1. {% include [section-storages-secondary-disk](../../../_includes/compute/create/section-storages-secondary-disk.md) %}
  1. {% include [section-storages-filesystem](../../../_includes/compute/create/section-storages-filesystem.md) %}
  1. {% include [section-platform](../../../_includes/compute/create/section-platform.md) %}

      {% note info %}

      Each public image has its own minimum requirements for a VM. A [{{ GL }}](/marketplace/products/yc/gitlab) image from {{ marketplace-full-name }}, for instance, requires at least 4 virtual cores and 8 GB of RAM.

      {% endnote %}

  1. {% include [network-settings](../../../_includes/compute/create/section-network.md) %}
  1. {% include [section-access](../../../_includes/compute/create/section-access.md) %}

      {% note info %}

      On VMs with access via {{ oslogin }} enabled, provide your custom SSH keys through [metadata](../../concepts/vm-metadata.md#how-to-send-metadata).

      {% endnote %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name:

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

  1. {% include [section-additional](../../../_includes/compute/create/section-additional.md) %}
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  VM creation takes several minutes. When the VM status changes to `RUNNING`, proceed to [configure the software](setup.md). You can monitor VM statuses on the list of VMs in the folder.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to create a VM:

     ```bash
     yc compute instance create --help
     ```

  1. Prepare a [key pair](../../operations/vm-connect/ssh.md#creating-ssh-keys) (public and private keys) for SSH access to the VM.
  1. Select one of the {{ marketplace-full-name }} public [images](../images-with-pre-installed-software/get-list.md).

     {% include [id-info](../../../_includes/compute/id-info.md) %}

     {% include [standard-images](../../../_includes/standard-images.md) %}

  1. Select a [subnet](../../../vpc/concepts/network.md#subnet):

     ```bash
     yc vpc subnet list
     ```

     Result:

     ```text
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     | b0c6n43f9lgh******** | default-{{ region-id }}-a     | enpe3m3fa00u******** |                | {{ region-id }}-a     | [10.130.0.0/24] |
     | e2l2da8a20b3******** | default-{{ region-id }}-b     | enpe3m3fa00u******** |                | {{ region-id }}-a     | [10.129.0.0/24] |
     | e9bnlm18l70a******** | default-{{ region-id }}-d     | enpe3m3fa00u******** |                | {{ region-id }}-a     | [10.128.0.0/24] |
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     ```

  1. Create a VM in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc compute instance create \
        --name first-instance \
        --zone {{ region-id }}-a \
        --network-interface subnet-name=default-{{ region-id }}-a,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```

      Where:

      * `--name`: VM name. The naming requirements are as follows:

        {% include [name-format](../../../_includes/name-format.md) %}

        {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) corresponding to the selected subnet.
      * `--network-interface`: VM [network interface](../../concepts/network.md) settings.
          * `subnet-name`: Name of the selected subnet.
          * `nat-ip-version=ipv4`: [Public IP address](../../../vpc/concepts/address.md#public-addresses). To create a VM without a public IP address, disable this parameter.

          {% include [add-several-net-interfaces-notice-cli](../../../_includes/compute/add-several-net-interfaces-notice-cli.md) %}

      * `--create-boot-disk`: VM boot disk settings:
          * `image-family`: [Image family](../../concepts/image.md#family), e.g., `centos-7`. This option allows you to install the latest version of the OS from the specified family.

      * `--ssh-key`: Path to the file with the [public SSH key](../vm-connect/ssh.md#creating-ssh-keys). The VM will automatically create a user named `yc-user` for this key.

          {% include [ssh-note](../../../_includes/compute/ssh-note.md) %}

          If you want to add several users with SSH keys to the VM at the same time, [specify](../../concepts/vm-metadata.md#how-to-send-metadata) these users' data using the `--metadata-from-file` parameter.




  {% include [vm-create-check](../../../_includes/compute/vm-create-check.md) %}

  {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the parameters of the resources you want to create:

     ```hcl

     resource "yandex_compute_disk" "boot-disk" {
       name     = "<disk_name>"
       type     = "<disk_type>"
       zone     = "<availability_zone>"
       size     = "<disk_size>"
       image_id = "<image_ID>"
     }

     resource "yandex_compute_instance" "linux-vm" {
       name        = "linux-vm"
       platform_id = "standard-v3"
       zone        = "<availability_zone>"

       resources {
         cores  = "<number_of_vCPU_cores>"
         memory = "<RAM_in_GB>"
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk.id
       }

       network_interface {
         subnet_id = yandex_vpc_subnet.subnet-1.id
         nat       = true
       }

       metadata = {
         user-data = "#cloud-config\nusers:\n  - name: <username>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("<path_to_public_SSH_key>")}"
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name           = "subnet1"
       zone           = "<availability_zone>"
       v4_cidr_blocks = ["192.168.10.0/24"]
       network_id     = yandex_vpc_network.network-1.id
     }
     ```

     Where:

     * `yandex_compute_disk`: Boot [disk](../../concepts/disk.md) description:
       * `name`: Disk name.
       * `type`: Disk type.
       * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md) the disk will be in.
       * `size`: Disk size in GB.
       * `image_id`: ID of the image to create the VM from. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).

         {% include [id-info](../../../_includes/compute/id-info.md) %}

     * `yandex_compute_instance`: VM description.
       * `name`: VM name.
       * `platform_id`: [Platform](../../concepts/vm-platforms.md).
       * `zone`: Availability zone the VM will be in.
       * `resources`: Number of vCPU cores and RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
       * `boot_disk`: Boot disk settings. Specify the disk ID.
       * `network_interface`: VM's [network interface](../../concepts/network.md) settings. Specify the ID of the selected [subnet](../../../vpc/concepts/network.md#subnet). To automatically assign a [public IP address](../../../vpc/concepts/address.md#public-addresses) to the VM, set `nat = true`.

           {% include [add-several-net-interfaces-notice-tf](../../../_includes/compute/add-several-net-interfaces-notice-tf.md) %}

       * `metadata`: In the metadata, provide the username and [public key for SSH access to the VM](../vm-connect/ssh.md#creating-ssh-keys). For more information, see [{#T}](../../concepts/vm-metadata.md).

           If you want to add multiple users with SSH keys to the VM at the same time, [specify](../../concepts/vm-metadata.md#how-to-send-metadata) these users' data in a file and provide it under `metadata`.
     * `yandex_vpc_network`: Description of the cloud network.
     * `yandex_vpc_subnet`: Description of the subnet your VM will be connected to.

     {% note info %}

     If you already have suitable resources, such as a cloud network and subnet, you do not need to describe them again. Use their names and IDs in the appropriate parameters.

     {% endnote %}

     For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/compute_instance).
  1. Make sure the configuration files are correct.
     1. In the command line, go to the folder where you created the configuration file.
     1. Run a check using this command:

        ```bash
        terraform plan
        ```

     If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.
  1. Deploy cloud resources.
     1. If the configuration does not contain any errors, run this command:

        ```bash
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

     {% include [vm-create-check](../../../_includes/compute/vm-create-check.md) %}

  {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

{% endlist %}