# Creating a VM from a set of disks

You can create a VM from existing disks. The disks must reside in one of the availability zones and not be added to other VMs.

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

To create a VM from a set of disks:

{% list tabs %}

- Management console

  1. In the management console, select the folder where you want to create a VM.

  1. Select **{{ compute-name }}**.

  1. On the **Virtual machines** page, click **Create VM**.

  1. Under **Basic parameters**, enter a name and description for the VM.

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

  1. In the **Availability zone** section, select the desired availability zone. [More about the geo scope of {{ yandex-cloud }}](../../../overview/concepts/geo-scope.md).

  1. Select one of the [public images](../../operations/images-with-pre-installed-software/get-list.md).

  1. Under **Disks**, click **Add disk**:
      - Enter the disk name.
      - Specify the necessary disk size.
      - Select the [disk type](../../concepts/disk.md#disks_types).
      - Under **Content**, choose **Disk**. If you don't have a disk, [create](../disk-create/empty.md) one.

  1. Under **Computing resources**:
      - Choose a [platform](../../concepts/vm-platforms.md).
      - Select the [performance level](../../concepts/performance-levels.md) and number of vCPUs and RAM you need.

  1. Under **Network settings**, select a network from the list or create a new one by clicking **Create new network**.

  1. Select the desired subnet from the list or create a new one by clicking **Create new subnet**.

  1. Select the appropriate public IP address option.

  1. Select the [appropriate security groups](../../../vpc/concepts/security-groups.md) (if there is no corresponding field, all incoming and outgoing traffic will be allowed for the VM).

  1. Under **Access**, specify the data required to access the VM:
      - Enter the username in the **Login** field.
      - In the **SSH key** field, paste the contents of the public key file. [Create](../vm-connect/ssh.md#creating-ssh-keys) a key pair for connecting to an instance over SSH on your own.

  1. Click **Create VM**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for creating a VM:

      ```
      $ yc compute instance create --help
      ```

  1. Get a list of disks in the default folder:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Select the identifier (`ID`) or name (`NAME`) of the necessary disks.

  1. Create a VM in the default folder:

      ```
      $ yc compute instance create \
          --name first-instance \
          --zone ru-central1-a \
          --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
          --use-boot-disk disk-name=first-disk \
          --attach-disk disk-name=second-disk \
          --ssh-key ~/.ssh/id_rsa.pub
      ```

      This command creates the VM:

      - Named `first-instance`.
      - In the `ru-central1-a` availability zone.
      - In the `default-a` subnet.
      - With a public IP address and two disks.

      To create a VM without a public IP, remove the `--public-ip` flag.

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      To specify whether to delete the disk when deleting the VM, set the `--auto-delete` flag:

      ```
      yc compute instance create \
      --name first-instance \
      --zone ru-central1-a \
      --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
      --use-boot-disk disk-name=first-disk,auto-delete=yes \
      --attach-disk disk-name=second-disk,auto-delete=yes \
      --ssh-key ~/.ssh/id_rsa.pub
      ```

- API

  Use the [Create](../../api-ref/Instance/create.md) method for the `Instance` resource.

- Terraform

  If you don't have Terraform yet, [install it and configure the {{ yandex-cloud }} provider](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  To create a VM from a set of disks:

  1. In the configuration file, describe the parameters of resources that you want to create:

       {% note info %}

       If you already have suitable resources, such as a cloud network and subnet, you don't need to describe them again. Use their names and IDs in the appropriate parameters.

       {% endnote %}

     * `yandex_compute_instance`: Description of the [VM](../../concepts/vm.md):
       * `name`: VM name.
       * `platform_id`: The [platform](../../concepts/vm-platforms.md).
       * `resources`: The number of vCPU cores and the amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
       * `boot_disk`: Boot disk settings. Specify the disk ID. If you have no boot disk available, specify the [ID of a public image](../images-with-pre-installed-software/get-list.md) using the `image_id` parameter.
       * `secondary_disk`: Secondary disk to attach to the VM. Specify the ID of the secondary disk. If you don't have a disk, [create](../disk-create/empty.md) one.
       * `network_interface`: Network settings. Specify the ID of the selected subnet. To automatically assign a public IP address to the VM, set `nat = true`.
       * `metadata`: In the metadata, pass the public key for accessing the VM via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
     * `yandex_vpc_network`: Description of the [cloud network](../../../vpc/concepts/network.md#network).
     * `yandex_vpc_subnet`: Description of the [subnet](../../../vpc/concepts/network.md#network) that the VM will be connected to.

     Example configuration file structure:

     ```
     resource "yandex_compute_instance" "vm-1" {
     
       name        = "vm-from-disks"
       platform_id = "standard-v2"
     
       resources {
         cores  = <number of vCPU cores>
         memory = <RAM in GB>
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
         ssh-keys = "<user name>:<SSH key contents>"
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

     For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

  2. Make sure that the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.

     2. Run the check using the command:

        ```
        $ terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

  3. Deploy the cloud resources.

     1. If the configuration doesn't contain any errors, run the command:

        ```
        $ terraform apply
        ```

     2. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

{% endlist %}

