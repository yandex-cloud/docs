---
title: "How to create a VM from a custom image"
description: "Use this guide to create a VM from a custom image."
---

# Creating a VM from a custom image

## Getting started {#before-you-begin}

[Prepare and upload](../image-create/upload.md) the [image](../../concepts/image.md) to {{ compute-name }} to create a [VM](../../concepts/vm.md) from.

Make sure the uploaded image is in the `READY` status.

## Create a VM from the prepared image {#create-vm-from-image}

{% list tabs group=instructions %}

- Management console {#console}


   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. At the top right, click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:

      * Enter a name and description for the VM. The naming requirements are as follows:

         {% include [name-format](../../../_includes/name-format.md) %}

         {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * Select an [availability zone](../../../overview/concepts/geo-scope.md) to place your VM in.

   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select an image:

      * Go to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom }}** tab and click **{{ ui-key.yacloud.compute.instances.create.button_choose }}**.
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


      * (Optional) Enable the **{{ ui-key.yacloud.compute.instances.create-disk.field_auto-delete }}** option if you need to automatically delete the disk when deleting the VM it will be attached to.
      * Select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` as content.
      * Select the necessary image.
      * Click **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.

   
   1. (Optional) Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, select the **{{ ui-key.yacloud.compute.nfs.label_filesystems }}** tab and attach the [file storage](../../concepts/filesystem.md):

      * Click **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.
      * In the window that opens, select the file storage.
      * Enter the device name.
      * Click **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.


   1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:

      * Choose a [platform](../../concepts/vm-platforms.md).
      * Specify the [guaranteed share](../../../compute/concepts/performance-levels.md) and the required number of vCPUs, as well as the amount of RAM.
      * If required, make your VM [preemptible](../../concepts/preemptible-vm.md).
      * (Optional) Enable a [software-accelerated network](../../concepts/software-accelerated-network.md).

   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      {% include [network-settings](../../../_includes/compute/network-settings.md) %}

   
   1. {% include [backup-info](../../../_includes/compute/backup-info.md) %}


   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the instance:

      * (Optional) Select or create a [service account](../../../iam/concepts/users/service-accounts.md). With a service account, you can flexibly configure access rights for your resources.
      * (Optional) [Enable VM access via OS Login](../vm-connect/os-login.md). This option is only available for Linux images.
      * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.

         {% note alert %}

         Do not use the `root` username or other names reserved by the operating system. To perform operations that require superuser permissions, use the `sudo` command.

         {% endnote %}

      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../operations/vm-connect/ssh.md#creating-ssh-keys) file.
      * If required, grant access to the [serial console](../../operations/serial-console/index.md).

      {% include [vm-connect-linux](../../../_includes/vm-connect-linux.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.compute.instances.create.section_placement }}**, select a VM [placement group](../../concepts/placement-groups.md).
   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   The VM appears in the list. Once created, the VM is assigned an [IP address](../../../vpc/concepts/address.md) and a [host name (FQDN)](../../../vpc/concepts/address.md#fqdn).

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI create VM command:

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

   1. Select the identifier (`ID`) or name (`NAME`) of the desired image.
   1. Create a VM in the default folder:

      ```bash
      yc compute instance create \
        --name <VM_name> \
        --zone <availability_zone> \
        --create-boot-disk name=<disk_name>,size=<disk_size_in_GB>,image-id=<custom_image_ID> \
        --public-ip \
        --ssh-key <path_to_public_key_file>
      ```

      Where:

      * `--name`: VM instance name. The naming requirements are as follows:

         {% include [name-format](../../../_includes/name-format.md) %}

         {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) to host the VM.
      * `--create-boot-disk`: Boot disk parameters:
         * `name`: Boot disk name. The naming requirements are as follows:

            {% include [name-format](../../../_includes/name-format.md) %}

         * `size`: Disk size in GB.
         * `image-id`: ID of the custom image to create the VM from. Specify the identifier of the [uploaded](../image-create/upload.md) image.
      * `--public-ip`: Add this flag to assign a [public IP](../../../vpc/concepts/address.md#public-addresses) to the VM. To create a VM without a public IP address, remove this flag.
      * `--ssh-key`: Path to the public [SSH key](../../operations/vm-connect/ssh.md#creating-ssh-keys) file. The default username for access via SSH is `yc-user`.


      Result:

      ```bash
      id: fhmue131en37********
      folder_id: b1g681qpemb4********
      created_at: "2024-03-02T12:58:43Z"
      name: test-vm-from-image
      zone_id: ru-central1-a
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
        image_id = "<user_image_ID>"
      }

      resource "yandex_compute_instance" "vm-1" {
        name                      = "vm-from-image"
        allow_stopping_for_update = true
        platform_id               = "standard-v3"
        zone                      = "<availability_zone>"

        resources {
          cores  = <number_of_vCPU_cores>
          memory = <GB_of_RAM>
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
         * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md) to host the disk.
         * `size`: Disk size in GB.
         * `image_id`: ID of the custom image to create the VM from. Specify the identifier of the [uploaded](../image-create/upload.md) image.
      * `yandex_compute_instance`: Description of the VM:
         * `name`: VM name. The naming requirements are as follows:

            {% include [name-format](../../../_includes/name-format.md) %}

            {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

         * {% include [terraform-allow-stopping](../../../_includes/compute/terraform-allow-stopping.md) %}
         * `platform_id`: [Platform](../../concepts/vm-platforms.md).
         * `zone`: Availability zone to host the VM.
         * `resources`: Number of vCPU cores and the amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
         * `boot_disk`: Boot disk settings. Specify the disk ID.
         * `network_interface`: [Network](../../../vpc/concepts/network.md#network) settings. Specify the ID of the selected [subnet](../../../vpc/concepts/network.md#network). To automatically assign a [public IP address](../../../vpc/concepts/address.md#public-addresses) to the VM, set `nat = true`.
         * `metadata`: In metadata, provide the public key for accessing the VM via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
      * `yandex_vpc_network`: Description of the cloud network.
      * `yandex_vpc_subnet`: Description of the subnet your VM will connect to.

      {% note info %}

      If you already have suitable resources, such as a cloud network and subnet, you do not need to describe them again. Use their names and IDs in the appropriate parameters.

      {% endnote %}

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

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
