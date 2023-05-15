# Creating a VM from a set of disks

You can create a [VM](../../concepts/vm.md) from existing [disks](../../concepts/disk.md). Make sure the disks reside in one of the [availability zones](../../../overview/concepts/geo-scope.md) and are not added to other VMs.

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

To create a VM from a set of disks:

{% list tabs %}

- Management console

  To create a VM:
  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM in.
  1. In the list of services, select **{{ compute-name }}**.
  1. Click **Create VM**.
  1. Under **Basic parameters**:
      * Enter a name and description for the VM. The naming requirements are as follows:

        {% include [name-format](../../../_includes/name-format.md) %}

        {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * Select the availability zone to place the VM in.
  1. Under **Image/boot disk selection**, select one of the [images](../../concepts/image.md).
  1. Under **Disks and file storage**, [add a disk](create-from-disks.md):
      * Click **Add disk**.
      * Enter the disk name.
      * Select the [disk type](../../concepts/disk.md#disks_types).
      * Specify the desired block size.
      * Specify the required disk size.
      * (optional) Enable the **Delete with the VM** option if you need to automatically delete the disk when deleting the VM it will be attached to.
      * Select `Disk` as content.
      * Click **Add**.

  
  1. (optional) Under **Disks and file storage**, click the **File storage tab** and connect a [file store](../../concepts/filesystem.md):
      * Click **Connect file storage**.
      * In the window that opens, select a file store.
      * Enter a device name.
      * Click **Connect file storage**.


  1. Under **Computing resources**:
      * Choose a [platform](../../concepts/vm-platforms.md).
      * Specify the [guaranteed share](../../../compute/concepts/performance-levels.md) and the required number of vCPUs, as well as the amount of RAM.
      * If required, make your VM [preemptible](../../concepts/preemptible-vm.md).
      * (optional) Enable a [software-accelerated network](../../concepts/software-accelerated-network.md).
  1. Under **Network settings**:

      {% include [network-settings](../../../_includes/compute/network-settings.md) %}

  
  1. {% include [backup-info](../../../_includes/compute/backup-info.md) %}


  1. Under **Access**, specify the information required to access the instance:
      * (optional) Select or create a [service account](../../../iam/concepts/users/service-accounts.md). By using a service account, you can flexibly configure access rights for your resources.
      * Enter the username in the **Login** field.

         {% note alert %}

         Do not use the `root` username or other names reserved by the operating system. To perform operations that require superuser permissions, use the `sudo` command.

         {% endnote %}

      * In the **SSH key** field, paste the contents of the [public key](../../operations/vm-connect/ssh.md#creating-ssh-keys) file.
      * If required, grant access to the [serial console](../../operations/serial-console/index.md).
  1. Click **Create VM**.

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

     ```yaml
     resource "yandex_compute_instance" "vm-1" {

       name        = "vm-from-disks"
       platform_id = "standard-v3"
       zone        = "<availability zone>"

       resources {
         cores  = <number of vCPU cores>
         memory = <RAM amount, GB>
       }

       boot_disk {
         initialize_params {
           disk_id = "<boot disk ID>"
         }
       }

       secondary_disk {
         disk_id = "<secondary disk ID>"
       }

       network_interface {
         subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
         nat       = true
       }

       metadata = {
         ssh-keys = "<username>:<SSH key contents>"
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name       = "subnet1"
       zone       = "<availability zone>"
       network_id = "${yandex_vpc_network.network-1.id}"
     }
     ```

     Where:

     * `yandex_compute_instance`: Description of the [VM](../../concepts/vm.md):
       * `name`: VM name.
       * `platform_id`: [Platform](../../concepts/vm-platforms.md).
       * `zone`: ID of the [availability zone](../../../overview/concepts/geo-scope.md) that will host your VM.
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
  1. Make sure the configuration files are valid.
     1. In the command line, go to the directory where you created the configuration file.
     1. Run the check using this command:

        ```bash
        terraform plan
        ```

     If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.
  1. Deploy cloud resources.
     1. If the configuration does not contain any errors, run this command:

        ```bash
        terraform apply
        ```

     1. Confirm that you want to create the resources.

     Once you are done, all the resources you need will be created in the specified folder. You can check that the resources are there and their settings are correct using the [management console]({{ link-console-main }}).

{% endlist %}