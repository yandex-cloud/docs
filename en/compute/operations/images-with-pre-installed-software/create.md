# Creating a VM from a public image

To create a [VM](../../concepts/vm.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM in.
   1. Click **Create resource**.
   1. Select **Virtual machine**.
   1. In the **Name** field, enter the VM name.

      {% include [name-format](../../../_includes/name-format.md) %}

   1. Select an [availability zone](../../../overview/concepts/geo-scope.md) to place the VM in.
   1. Select a public [image](../../concepts/image.md) with the software you want to use.
   1. (Optional) If you want to add more [disks](../../concepts/disk.md) to the VM, [select them](../vm-create/create-from-disks.md) under **Disks and file storage** by clicking the **Disks** tab.

   
   1. (Optional) If you want to connect more [file stores](../../concepts/filesystem.md) to the VM, attach them under **Disks and file storage** by clicking the **File stores** tab. [Create](../filesystem/create.md) the storages first.


   1. Under **Computing resources**:
      * Choose a [platform](../../concepts/vm-platforms.md).
      * Specify the [guaranteed share](../../concepts/performance-levels.md) and the required number of vCPUs as well as the amount of RAM.

      {% note info %}

      Each public image has its own minimum requirements for a VM. A [{{ GL }}](/marketplace/products/yc/gitlab) image from {{ marketplace-full-name }}, for instance, requires at least 4 virtual cores and 8 GB of RAM.

      {% endnote %}

   1. Under **Network settings**:
      * Enter a [subnet](../../../vpc/concepts/network.md#subnet) ID or select a [cloud network](../../../vpc/concepts/network.md#network) from the list. You can select the search scope: in the current folder or in all folders. If you do not have a network, click **Create network**:
         * In the window that opens, enter the folder to host the new network, as well as the network name.
         * Enable the option **Create subnets**: each network must have at least one subnet.
         * Click **Create**.
      * In the **Public IP** field, choose a method for assigning an IP address:
         * **Auto**: Assign a random [IP address](../../../vpc/concepts/address.md) from the {{ yandex-cloud }} IP pool.
         * **List**: Select a [public IP address](../../../vpc/concepts/address.md#public-addresses) from the list of previously reserved static addresses. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md).
         * **No address**: Do not assign a public IP address.

      
      * (optional) Enable [DDoS protection](../../../vpc/ddos-protection/index.md), if required.


      * Select [appropriate security groups](../../../vpc/concepts/security-groups.md) (if there is no corresponding field, the VM will be enabled for all incoming and outgoing traffic).
   1. Under **Access**, specify the information required to access the instance:
      * (optional) Select or create a [service account](../../../iam/concepts/index.md#sa). By using a service account, you can flexibly configure access rights for your resources.
      * Enter the username in the **Login** field.
      * In the **SSH key** field, paste the contents of the [public key](../vm-connect/ssh.md#creating-ssh-keys) file.
      * (optional) Enable access to the [serial console](../index.md#serial-console), if required.
   1. Specify data required for accessing the VM.
   1. Click **Create VM**.

   VM creation takes several minutes. When the VM status changes to `RUNNING`, proceed to [configuring software](setup.md). You can monitor VM statuses on the list of VMs in the folder.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI create VM command:

      ```bash
      yc compute instance create --help
      ```

   1. Prepare the [key pair](../../operations/vm-connect/ssh.md#creating-ssh-keys) (public and private keys) for SSH access to the VM.
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
      | b0c6n43f9lgh3695v2k2 | default-{{ region-id }}-a | enpe3m3fa00udao8g5lg |                | {{ region-id }}-a | [10.130.0.0/24] |
      | e2l2da8a20b33g7o73bv | default-{{ region-id }}-b | enpe3m3fa00udao8g5lg |                | {{ region-id }}-b | [10.129.0.0/24] |
      | e9bnlm18l70ao30pvfaa | default-{{ region-id }}-c | enpe3m3fa00udao8g5lg |                | {{ region-id }}-c | [10.128.0.0/24] |
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
      * `name`: VM name.

         {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md) that corresponds to the selected subnet.
      * `subnet-name`: Name of the selected subnet.
      * `image-family`: [Image family](../../concepts/image.md#family), such as `centos-7`. This option allows you to install the latest version of the operating system from the specified family.
      * `nat-ip-version=ipv4`: [Public IP address](../../../vpc/concepts/address.md#public-addresses). To create a VM without a public IP address, disable this parameter.
      * `ssh-key`: Path to the [public SSH key](../vm-connect/ssh.md#creating-ssh-keys). The VM will automatically create a user named `yc-user` for this key.




   {% include [vm-create-check](../../../_includes/compute/vm-create-check.md) %}

   {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_compute_instance" "linux-vm" {

        name        = "linux-vm"
        platform_id = "standard-v3"
        zone        = "<availability_zone>"

        resources {
          cores  = "<number_of_vCPU_cores>"
          memory = "<GB_of_RAM>"
        }

        boot_disk {
          initialize_params {
            image_id = "<image_ID"
          }
        }

        network_interface {
          subnet_id = yandex_vpc_subnet.subnet-1.id
          nat       = true
        }

        metadata = {
          user-data = "#cloud-config\nusers:\n  - name: <username>\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("<path_to_public_SSH_key>")}"
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
      * `yandex_compute_instance`: Description of the VM:
         * `name`: VM name.
         * `platform_id`: [Platform](../../concepts/vm-platforms.md).
         * `zone`: ID of the [availability zone](../../../overview/concepts/geo-scope.md) that will host your VM.
         * `resources`: Number of vCPU cores and the amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
         * `boot_disk`: Boot [disk](../../concepts/disk.md) settings. Specify the ID of the selected [image](../../concepts/image.md). You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).

            {% include [id-info](../../../_includes/compute/id-info.md) %}

         * `network_interface`: [Network](../../../vpc/concepts/network.md#network) settings. Specify the ID of the selected [subnet](../../../vpc/concepts/network.md#network). To automatically assign a [public IP address](../../../vpc/concepts/address.md#public-addresses) to the VM, set `nat = true`.
         * `metadata`: In the metadata, provide the username and [public key for accessing the VM via SSH](../vm-connect/ssh.md#creating-ssh-keys). For more information, see [{#T}](../../concepts/vm-metadata.md).
      * `yandex_vpc_network`: Description of the cloud network.
      * `yandex_vpc_subnet`: Description of the subnet your VM will connect to.

      {% note info %}

      If you already have suitable resources, such as a cloud network and subnet, you do not need to describe them again. Use their names and IDs in the appropriate parameters.

      {% endnote %}

      For more information about the resources that you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/compute_instance).
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

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      {% include [vm-create-check](../../../_includes/compute/vm-create-check.md) %}

   {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

{% endlist %}