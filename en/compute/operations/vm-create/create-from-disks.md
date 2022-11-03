# Creating a VM from a set of disks

You can create a VM from existing disks. The disks must reside in one of the availability zones and not be added to other VMs.

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

To create a VM from a set of disks:

{% list tabs %}

- Management console

   To create a VM:
   1. In the [management console]({{ link-console-main }}), select the folder to create the virtual machine in.
   1. In the list of services, select **{{ compute-name }}**.
   1. Click **Create VM**.
   1. Under **Basic parameters**:
      * Enter a name and description for the VM. Naming requirements:

         {% include [name-format](../../../_includes/name-format.md) %}

         {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * Select an [availability zone](../../../overview/concepts/geo-scope.md) to put your virtual machine in.

   1. Under **Image/boot disk selection**, select one of the [images](../../operations/images-with-pre-installed-software/get-list.md).

   1. Under **Disks and file storage**, [add a disk](./create-from-disks.md):
      * Click **Add disk**.
      * Enter the disk name.
      * Select the [disk type](../../concepts/disk.md#disks_types).
      * Specify the desired block size.
      * Specify the necessary disk size.
      * (optional) Enable the **Delete with the VM** option if you need to automatically delete the disk when deleting the VM it will be attached to.
      * Select `Disk` as content.
      * Click **Add**.

      1. (optional) Under **Disks and file storage**, click the **File storage tab** and connect a [file store](../../concepts/filesystem.md):
      * Click **Connect file storage**.
      * In the resulting window, select a file store.
      * Enter a device name.
      * Click **Connect file storage**.

   1. Under **Computing resources**:
      * Choose a [platform](../../concepts/vm-platforms.md).
      * Specify the [guaranteed share](../../../compute/concepts/performance-levels.md) and the required number of vCPUs, as well as the amount of RAM.
      * If necessary, make your VM [preemptible](../../concepts/preemptible-vm.md).
      * (optional) Enable a [software-accelerated network](../../concepts/software-accelerated-network.md).

   1. Under **Network settings**:
      * Enter a subnet ID or select a [cloud network](../../../vpc/concepts/network.md#network) from the list.
         If you don't have a network, click **Create network** to create one:
         * In the window that opens, enter the network name and folder to host the network.
         * (optional) To automatically create subnets, select the **Create subnets** option.
         * Click **Create**.
            Each network must have at least one [subnet](../../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **Add subnet**.
      * In the **Public IP** field, choose a method for assigning an IP address:
         * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool. With this, you can enable [DDoS protection](../../../vpc/ddos-protection/index.md) using the option below.
         * **List**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md).
         * **No address**: Don't assign a public IP address.
      * In the **Internal address** field, select the method for assigning internal addresses: **Auto** or **Manual**.
      * (optional) Create a record for the VM in the [DNS zone](../../../dns/concepts/dns-zone.md). Expand the **DNS settings for internal addresses** section, click **Add record** and specify the zone, FQDN and TTL for the record. For more information, see [Cloud DNS integration with Compute Cloud](../../../dns/concepts/compute-integration.md).
      * Select [appropriate security groups](../../../vpc/concepts/security-groups.md) (if there is no corresponding field, the virtual machine will be enabled for all incoming and outgoing traffic).

   1. Under **Access**, specify the data required to access the VM:
      * (optional) Select or create a [service account](../../../iam/concepts/users/service-accounts.md). By using a service account, you can flexibly configure access rights for your resources.
      * Enter the username in the **Login** field.

         {% note alert %}

         Don't use the username `root` or other names reserved by the operating system. To perform operations that require superuser permissions, use the command `sudo`.

         {% endnote %}

      * In the **SSH key** field, paste the contents of the [public key](../../operations/vm-connect/ssh.md#creating-ssh-keys) file.
      * If required, grant access to the [serial console](../../operations/serial-console/index.md).

   1. Click **Create VM**.

   The virtual machine appears in the list. When a VM is created, it is assigned an [IP address](../../../vpc/concepts/address.md) and [hostname](../../../vpc/concepts/address.md#fqdn) (FQDN).

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the CLI command for creating a VM:

      ```
      yc compute instance create --help
      ```

   1. Get a list of disks in the default folder:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

   1. Select the identifier (`ID`) or name (`NAME`) of the necessary disks.
   1. Create a VM in the default folder:

      ```
      yc compute instance create \
          --name first-instance \
          --zone {{ region-id }}-a \
          --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
          --use-boot-disk disk-name=first-disk \
          --attach-disk disk-name=second-disk \
          --ssh-key ~/.ssh/id_rsa.pub
      ```

      This command creates the VM:

      - Named `first-instance`.

        {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}
        
      - In the `{{ region-id }}-a` availability zone.
      - In the `default-a` subnet.
      - With a public IP address and two disks.


      To specify whether to delete the disk when deleting the VM, set the `--auto-delete` flag:

      ```
      yc compute instance create \
      --name first-instance \
      --zone {{ region-id }}-a \
      --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
      --use-boot-disk disk-name=first-disk,auto-delete=yes \
      --attach-disk disk-name=second-disk,auto-delete=yes \
      --ssh-key ~/.ssh/id_rsa.pub
      ```

- API

   Use the [Create](../../api-ref/Instance/create.md) method for the `Instance` resource.

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a VM from a set of disks:

   1. In the configuration file, describe the parameters of resources that you want to create:

      ```
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
          disk_id = "<additional disk ID>"
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
         * `platform_id`: The [platform](../../concepts/vm-platforms.md).
         * `resources`: The number of vCPU cores and the amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
         * `boot_disk`: Boot disk settings. Specify the disk ID. If you have no boot disk available, specify the [ID of a public image](../images-with-pre-installed-software/get-list.md) using the `image_id` parameter.
         * `secondary_disk`: Secondary disk to attach to the VM. Specify the ID of the secondary disk. If you don't have a disk, [create](../disk-create/empty.md) one.
         * `network_interface`: Network settings. Specify the ID of the selected subnet. To automatically assign a public IP address to the VM, set `nat = true`.
         * `metadata`: In the metadata, pass the public key for accessing the VM via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
      * `yandex_vpc_network`: Description of the [cloud network](../../../vpc/concepts/network.md#network).
      * `yandex_vpc_subnet`: Description of [subnet](../../../vpc/concepts/network.md#network) your virtual machine will connect to.

      {% note info %}

      If you already have suitable resources, such as a cloud network and subnet, you don't need to describe them again. Use their names and IDs in the appropriate parameters.

      {% endnote %}

      For more information about resources that you can create with {{ TF }}, please see the [provider documentation]({{ tf-provider-link }}/).

   2. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      2. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

   3. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      2. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

{% endlist %}
