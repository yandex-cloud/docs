# Creating a preemptible VM

To create a preemptible VM:

{% list tabs %}

- Management console

  1. Open the folder where the VM will be created.

  1. Click **Create resource**.

  1. Select **Virtual machine**.

  1. In the **Name** field, enter a name for the VM.

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

  1. Select the [availability zone](../../../overview/concepts/geo-scope.md) to host the VM in.

  1. Select one of the [public images](../../operations/images-with-pre-installed-software/get-list.md) on Linux.

  1. Under **Computing resources**:
      - Choose a [platform](../../concepts/vm-platforms.md).
      - Specify the required amount of computing resources.
      - Set the **Preemptible** flag.

  1. In the **Network settings** section, click **Add network**.

  1. In the window that opens, select the subnet to connect the VM to while being created.

  1. In **Public address**, choose:
      - **Automatically** — to set a public IP address automatically. The address is allocated from the {{ yandex-cloud }} address pool.
      - **List** — to select a public IP address from the list of static addresses. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md) in the {{ vpc-name }} documentation.
      - **No address**: Don't assign a public IP address.

  1. Select the [appropriate security groups](../../../vpc/concepts/security-groups.md) (if there is no corresponding field, all incoming and outgoing traffic will be allowed for the VM).

  1. Specify data required for accessing the VM:
      - Enter the username in the **Login** field.
      - In the **SSH key** field, paste the contents of the public key file.
You need to create a key pair for an SSH connection yourself. Learn more in [{#T}](../vm-connect/ssh.md#creating-ssh-keys).

  1. Click **Create VM**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for creating a VM:

      ```
      $ yc compute instance create --help
      ```

  1. Prepare the key pair (public and private keys) for SSH access to the VM.

  1. Select a public [image](../images-with-pre-installed-software/get-list.md) based on a Linux OS (for example, [CentOS 7]{% if lang == "ru" %}(https://cloud.yandex.ru/marketplace/products/f2esfplfav536pn90mdo){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/en-ru/marketplace/products/f2esfplfav536pn90mdo){% endif %}.

      {% include [standard-images](../../../_includes/standard-images.md) %}

  1. Create a VM in the default folder:

      ```
      $ yc compute instance create \
          --name first-preemptible-instance \
          --zone ru-central1-a \
          --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
          --preemptible \
          --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
          --ssh-key ~/.ssh/id_rsa.pub
      ```

      This command creates a preemptible VM with the following characteristics:
      - Named `first-preemptible-instance`.
      - Running CentOS 7.
      - In the `ru-central1-a` availability zone.
      - In the `default-a` subnet.
      - With a public IP address.

      To create a VM without a public IP address, disable the `nat-ip-version=ipv4` option.

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

- API

  Use the [Create](../../api-ref/Instance/create.md) method for the `Instance` resource.

- Terraform

  If you don't have Terraform yet, [install it and configure the {{ yandex-cloud }} provider](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. In the configuration file, describe the parameters of resources that you want to create:

       {% note info %}

       If you already have suitable resources, such as a cloud network and subnet, you don't need to describe them again. Use their names and IDs in the appropriate parameters.

       {% endnote %}

     * `yandex_compute_instance`: Description of the [VM](../../concepts/vm.md):
       * `name`: VM name.
       * `platform_id`: The [platform](../../concepts/vm-platforms.md).
       * `resources`: The number of vCPU cores and the amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
       * `boot_disk`: Boot disk settings. Specify the ID of the selected image. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).
       * `network_interface`: Network settings. Specify the ID of the selected subnet. To automatically assign a public IP address to the VM, set `nat = true`.
       * `metadata`: In the metadata, pass the public key for accessing the VM via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
       * `scheduling_policy`: Scheduling policy. To create a preemptible VM, set `preemptible = true`.
     * `yandex_vpc_network`: Description of the [cloud network](../../../vpc/concepts/network.md#network).
     * `yandex_vpc_subnet`: Description of the [subnet](../../../vpc/concepts/network.md#network) that the VM will be connected to.

     Example configuration file structure:

     ```
     resource "yandex_compute_instance" "vm-1" {
     
       name        = "preemptible-vm"
       platform_id = "standard-v2"
     
       resources {
         cores  = <number of vCPU cores>
         memory = <RAM in GB>
       }
     
       boot_disk {
         initialize_params {
           image_id = "<image ID>"
         }
       }
     
       network_interface {
         subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
         nat       = true
       }
     
       metadata = {
         ssh-keys = "<username>:<SSH key contents>}"
       }
     
       scheduling_policy {
         preemptible = true
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

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

#### See also {#see-also}

- [{#T}](../vm-connect/ssh.md)
