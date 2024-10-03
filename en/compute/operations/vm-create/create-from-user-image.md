---
title: How to create a VM from a custom image
description: Use this guide to create a VM from a custom image.
---

# Creating a VM from a custom image

## Getting started {#before-you-begin}

[Prepare and upload](../image-create/upload.md) the [image](../../concepts/image.md) to {{ compute-name }} to create a [VM](../../concepts/vm.md) from.

Make sure the image you upload has the `READY` status.

## Create a VM from the prepared image {#create-vm-from-image}

{% list tabs group=instructions %}

- Management console {#console}


  1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. At the top right, click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:

      * Enter a name and description for the VM. The naming requirements are as follows:

        {% include [name-format](../../../_includes/name-format.md) %}

        {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * Select an [availability zone](../../../overview/concepts/geo-scope.md) to place your VM in.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select an image:

      * Go to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom }}** tab and click **{{ ui-key.yacloud.common.select }}**.
      * In the window that opens, go to the **{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}** tab.
      * Select an image from the list and click **{{ ui-key.yacloud.common.apply }}**.


  1. {% include [encryption-section-boot](../../../_includes/compute/encryption-section-boot.md) %}


  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, [add a disk](create-from-disks.md):

      * Click **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**.
      * Enter the disk name.
      * Select the [disk type](../../concepts/disk.md#disks_types).
      * Specify the required block size.
      * Specify the required disk size.


      * {% include [encryption-section-secondary](../../../_includes/compute/encryption-section-secondary.md) %}


      * (Optional) Enable the **{{ ui-key.yacloud.compute.field_disk-autodelete }}** option if you need to automatically delete the disk when deleting the VM it will be attached to.
      * Select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` as content.
      * Select the image you need.
      * Click **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.


  1. (Optional) Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, select the **{{ ui-key.yacloud.compute.nfs.label_filesystems }}** tab and attach the [file storage](../../concepts/filesystem.md):

     * Click **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.
     * In the window that opens, select the file storage.
     * Enter the device name.
     * Click **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.


  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:

     * Choose a [platform](../../concepts/vm-platforms.md).
     * Specify the [guaranteed share](../../../compute/concepts/performance-levels.md) and required number of vCPUs, as well as RAM size.
     * If required, make your VM [preemptible](../../concepts/preemptible-vm.md).
     * (Optional) Enable a [software-accelerated network](../../concepts/software-accelerated-network.md).

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

     {% include [network-settings](../../../_includes/compute/network-settings.md) %}


  1. {% include [backup-info](../../../_includes/compute/backup-info.md) %}


  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the data for access to the VM:

     * (Optional) Select or create a [service account](../../../iam/concepts/users/service-accounts.md). With a service account, you can flexibly configure access rights for your resources.
     * (Optional) [Enable VM access via OS Login](../vm-connect/os-login.md). This option is only available for Linux images.
     * Enter the username into the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.

       {% note alert %}

       Do not use `root` or other usernames reserved by the operating system. To perform operations requiring superuser permissions, use the `sudo` command.

       {% endnote %}

     * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../operations/vm-connect/ssh.md#creating-ssh-keys) file.
     * If required, grant access to the [serial console](../../operations/serial-console/index.md).

     {% include [vm-connect-linux](../../../_includes/vm-connect-linux.md) %}

  1. (Optional) Under **{{ ui-key.yacloud.compute.instances.create.section_placement }}**, select a VM [placement group](../../concepts/placement-groups.md).
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  The VM appears in the list. Once created, the VM is assigned an [IP address](../../../vpc/concepts/address.md) and a [host name (FQDN)](../../../vpc/concepts/address.md#fqdn).

  You can monitor the VM status in the serial console or the [serial port output](../vm-info/get-serial-port-output.md).

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to create a VM:

     ```bash
     yc compute instance create --help
     ```

  1. Get a list of images in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc compute image list
     ```

     Result:

     ```text
     +----------------------+-----------------+--------+-------------+--------+
     |          ID          |      NAME       | FAMILY | PRODUCT IDS | STATUS |
     +----------------------+-----------------+--------+-------------+--------+
     |         ...          |        ...      |        |             |  ...   |
     | fd8gkcd3l6ov******** | your-test-image |        |             | READY  |
     |         ...          |        ...      |        |             |  ...   |
     +----------------------+-----------------+--------+-------------+--------+
     ```

  1. Select `ID` or `NAME` of the image you need.

  1. Select a [subnet](../../../vpc/concepts/network.md#subnet):

     ```bash
     yc vpc subnet list
     ```

     Result:

     ```text
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     | e9bnlm18l70a******** |   default-{{ region-id }}-a   | enpe3m3fa00u******** |                |   {{ region-id }}-a   | [10.128.0.0/24] |
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     ```

  1. Create a VM in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc compute instance create \
       --name <VM_name> \
       --zone <availability_zone> \
       --network-interface subnet-name=<subnet_name>,nat-ip-version=ipv4 \
       --create-boot-disk name=<disk_name>,size=<disk_size_in_GB>,image-id=<custom_image_ID> \
       --ssh-key <path_to_public_key_file>
     ```

     Where:
     * `--name`: VM name. The naming requirements are as follows:

       {% include [name-format](../../../_includes/name-format.md) %}

       {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

     * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) corresponding to the selected subnet.
     * `--network-interface`: VM [network interface](../../concepts/network.md) settings:
         * `subnet-name`: Name of the selected subnet.
         * `nat-ip-version=ipv4`: [Public IP address](../../../vpc/concepts/address.md#public-addresses). To create a VM without a public IP address, disable this parameter.

         {% include [add-several-net-interfaces-notice-cli](../../../_includes/compute/add-several-net-interfaces-notice-cli.md) %}

     * `--create-boot-disk`: VM boot disk settings:
         * `name`: Boot disk name. The naming requirements are as follows:

             {% include [name-format](../../../_includes/name-format.md) %}

         * `size`: Disk size in GB.
         * `image-id`: ID of the custom image to create the VM from. Specify the ID of the [uploaded](../image-create/upload.md) image.
     * `--ssh-key`: Path to the file with the [public SSH key](../vm-connect/ssh.md#creating-ssh-keys). The VM will automatically create a user named `yc-user` for this key.

         {% include [ssh-note](../../../_includes/compute/ssh-note.md) %}

         If you want to add several users with SSH keys to the VM at the same time, [specify](../../concepts/vm-metadata.md#how-to-send-metadata) these users' data using the `--metadata-from-file` parameter.

  {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

     Result:

      ```text
      id: fhmue131en37********
      folder_id: b1g681qpemb4********
      created_at: "2024-03-02T12:58:43Z"
      name: test-vm-from-image
      zone_id: {{ region-id }}-a
      platform_id: standard-v2
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: fhmn9n1uhutc********
        auto_delete: true
        disk_id: fhmn9n1uhutc********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:1e:70:46:17
          subnet_id: e9bb9n0v4h17********
          primary_v4_address:
            address: 10.12*.*.**
            one_to_one_nat:
              address: 178.154.***.***
              ip_version: IPV4
      gpu_settings: {}
      fqdn: fhmue131en37********.auto.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To create a VM from a custom image:
  1. In the configuration file, describe the parameters of the resources you want to create:

     ```hcl
     resource "yandex_compute_disk" "boot-disk" {
       name     = "<disk_name>"
       type     = "<disk_type>"
       zone     = "<availability_zone>"
       size     = "<disk_size>"
       image_id = "<custom_image_ID>"
     }

     resource "yandex_compute_instance" "vm-1" {
       name                      = "vm-from-image"
       allow_stopping_for_update = true
       platform_id               = "standard-v3"
       zone                      = "<availability_zone>"

       resources {
         cores  = <number_of_vCPU_cores>
         memory = <RAM_GB>
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk.id
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
       * `name`: Disk name. The naming requirements are as follows:

          {% include [name-format](../../../_includes/name-format.md) %}

       * `type`: Disk type.
       * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md) the disk will be in.
       * `size`: Disk size in GB.
       * `image_id`: ID of the custom image for the VM. Specify the ID of the [uploaded](../image-create/upload.md) image.
     * `yandex_compute_instance`: VM description.
       * `name`: VM name. The naming requirements are as follows:

          {% include [name-format](../../../_includes/name-format.md) %}

          {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

       * {% include [terraform-allow-stopping](../../../_includes/compute/terraform-allow-stopping.md) %}
       * `platform_id`: [Platform](../../concepts/vm-platforms.md).
       * `zone`: Availability zone the VM will be in.
       * `resources`: Number of vCPU cores and RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
       * `boot_disk`: Boot disk settings. Specify the disk ID.
       * `network_interface`: VM's [network interface](../../concepts/network.md) settings. Specify the ID of the selected [subnet](../../../vpc/concepts/network.md#subnet). To automatically assign a [public IP address](../../../vpc/concepts/address.md#public-addresses) to the VM, set `nat = true`.

           {% include [add-several-net-interfaces-notice-tf](../../../_includes/compute/add-several-net-interfaces-notice-tf.md) %}

       * `metadata`: In metadata, provide the public key for accessing the VM via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
     * `yandex_vpc_network`: Description of the cloud network.
     * `yandex_vpc_subnet`: Description of the subnet your VM will be connected to.

     {% note info %}

     If you already have suitable resources, such as a cloud network and subnet, you do not need to describe them again. Use their names and IDs in the appropriate parameters.

     {% endnote %}

     For more information about the resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}).

  1. Create resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Create](../../api-ref/grpc/instance_service.md#Create) gRPC API call.

{% endlist %}

## Disable metadata verification {#disable-metadata-check}

{% include [disable-metadata-check](../../../_includes/compute/disable-metadata-check.md) %}

#### See also {#see-also}

* [{#T}](../image-create/custom-image.md)
* [{#T}](../vm-connect/ssh.md)
