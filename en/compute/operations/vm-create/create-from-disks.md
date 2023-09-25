# Creating a VM from a set of disks

You can create a [VM](../../concepts/vm.md) from existing [disks](../../concepts/disk.md). Make sure the disks reside in one of the [availability zones](../../../overview/concepts/geo-scope.md) and are not added to other VMs.

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

{% list tabs %}

- Management console


   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. At the top right, click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * Enter a name and description for the VM. The naming requirements are as follows:

        {% include [name-format](../../../_includes/name-format.md) %}

        {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * Select an availability zone to place your VM in.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select an [image](../../concepts/image.md).

  
  1. {% include [encryption-section-boot](../../../_includes/compute/encryption-section-boot.md) %}


  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, [add a disk](create-from-disks.md):
      * Click **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**.
      * Enter the disk name.
      * Select the [disk type](../../concepts/disk.md#disks_types).
      * Specify the desired block size.
      * Specify the desired disk size.

      
      * {% include [encryption-section-secondary](../../../_includes/compute/encryption-section-secondary.md) %}


      * (Optional) Enable the **{{ ui-key.yacloud.compute.instances.create-disk.field_auto-delete }}** option if you need to automatically delete the disk when deleting the VM it will be attached to.
      * Select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}` as content.
      * Click **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.

  
  1. (Optional) Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, select the **{{ ui-key.yacloud.compute.nfs.label_filesystems }}** tab and attach the [file storage](../../concepts/filesystem.md):
      * Click **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.
      * In the window that opens, select a file store.
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
      * Enter username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.

         {% note alert %}

         Do not use the `root` username or other names reserved by the operating system. To perform operations that require superuser permissions, use the `sudo` command.

         {% endnote %}

      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../operations/vm-connect/ssh.md#creating-ssh-keys) file.
      * If required, grant access to the [serial console](../../operations/serial-console/index.md).

      {% include [vm-connect-linux](../../../_includes/vm-connect-linux.md) %}

   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   The VM appears in the list. Once created, the VM is assigned an [IP address](../../../vpc/concepts/address.md) and a [host name (FQDN)](../../../vpc/concepts/address.md#fqdn).

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI create VM command:

      ```bash
      yc compute instance create --help
      ```

  1. Get a list of disks in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Select the identifier (`ID`) or name (`NAME`) of the necessary disks.
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

      This command creates the VM:
      * Named `first-instance`.

        {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * In the `{{ region-id }}-a` availability zone.
      * In the `default-a` subnet.
      * With a [public IP address](../../../vpc/concepts/address.md#public-addresses) and two disks.


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

- API

  Use the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Create](../../api-ref/grpc/instance_service.md#Create) gRPC API call.

- {{ TF }}

  If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  To create a VM from a set of disks:
  1. In the configuration file, describe the parameters of the resources you want to create:

     ```hcl
     resource "yandex_compute_instance" "vm-1" {

        name                      = "vm-from-disks"
        allow_stopping_for_update = true
        platform_id               = "standard-v3"
        zone                      = "<availability_zone>"

       resources {
         cores  = <number_of_vCPU_cores>
         memory = <amount_of_RAM_in_GB>
       }

       boot_disk {
         initialize_params {
           disk_id = "<boot_disk_ID>"
         }
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
      * `yandex_compute_instance`: Description of the [VM](../../concepts/vm.md):
         * `name`: VM name.
         * {% include [terraform-allow-stopping](../../../_includes/compute/terraform-allow-stopping.md) %}
         * `platform_id`: [Platform](../../concepts/vm-platforms.md).
         * `zone`: ID of the availability zone that will host your VM.
         * `resources`: Number of vCPU cores and the amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
         * `boot_disk`: Boot disk settings. Specify the disk ID. If you have no boot disk available, specify the ID of a public image using the `image_id` parameter.

            {% include [id-info](../../../_includes/compute/id-info.md) %}

         * `secondary_disk`: Secondary disk to attach to the VM. Specify the ID of the secondary disk. If you do not have a disk, [create](../disk-create/empty.md) one.
         * `network_interface`: [Network](../../../vpc/concepts/network.md#network) settings. Specify the ID of the selected [subnet](../../../vpc/concepts/network.md#network). To automatically assign a [public IP address](../../../vpc/concepts/address.md#public-addresses) to the VM, set `nat = true`.
         * `metadata`: In metadata, provide the public key for accessing the VM via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
      * `yandex_vpc_network`: Description of the cloud network.
      * `yandex_vpc_subnet`: Description of the subnet your VM will connect to.

      {% note info %}

      If you already have suitable resources, such as a cloud network and subnet, you do not need to describe them again. Use their names and IDs in the appropriate parameters.

      {% endnote %}

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

      All the resources you need will then be created in the specified folder. You can check that the resources are there and their settings are correct using the [management console]({{ link-console-main }}).

{% endlist %}