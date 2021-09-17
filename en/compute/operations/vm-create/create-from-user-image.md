# Creating a VM from a custom image

## Before you start {#before-you-begin}

[Prepare and upload](../image-create/upload.md) the image to create a VM from.

Make sure the uploaded image is in the `READY` status.

## Create a VM from the prepared image {#create-vm-from-image}

{% list tabs %}

- Management console

  1. Open the folder where the VM will be created.

  1. Click **Create resource**.

  1. Select **Virtual machine**.

  1. In the **Name** field, enter a name for the VM.

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

  1. Select the [availability zone](../../../overview/concepts/geo-scope.md) to host the VM in.

  1. In the **Disks** section, click **Add disk**.
     1. In the **Name** field, enter the disk name.
     1. Set the required disk size.
     1. In the **Disk designation** section, choose **Boot**.
     1. Select the [disk type](../../concepts/disk.md#disks_types): **HDD** or **SSD**.
     1. In the **Content** section, choose **Image**. A list of images that you uploaded opens.
     1. Select the necessary image.
     1. Click **Add**.

  1. Under **Computing resources**:
      - Choose a [platform](../../concepts/vm-platforms.md).
      - Specify the necessary number of vCPUs and amount of RAM.

  1. Under **Network settings**, select a network from the list or create a new one by clicking **Create new network**.

  1. In the window that opens, select the subnet to connect the VM to while being created.

  1. In **Public address**, choose:
      - **Automatically** — to set a public IP address automatically. The address is allocated from the {{ yandex-cloud }} address pool.
      - **List** — to select a public IP address from the list of static addresses. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md) in the {{ vpc-name }} documentation.
      - **No address** — don't assign a public IP address.

  1. Select the [appropriate security groups](../../../vpc/concepts/security-groups.md) (if there is no corresponding field, all incoming and outgoing traffic will be allowed for the VM).

  1. Specify data required for accessing the VM:
      - Enter the username in the **Login** field.
      - In the **SSH key** field, paste the contents of the public key file.
          You need to create a key pair for an SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTygen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.

  1. Click **Create VM**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for creating a VM:

      ```
      yc compute instance create --help
      ```

  1. Get a list of images in the default folder:

      ```
      yc compute image list
      +----------------------+-------------------+--------+-------------+--------+
      |          ID          |       NAME        | FAMILY | PRODUCT IDS | STATUS |
      +----------------------+-------------------+--------+-------------+--------+
      |         ...          |         ...       |        |             |  ...   |
      | fd8gkcd3l6ov84aon8s1 |  your-test-image  |        |             | READY  |
      |         ...          |         ...       |        |             |  ...   |
      +----------------------+-------------------+--------+-------------+--------+
      ```

  1. Select the identifier (`ID`) or name (`NAME`) of the desired image.

  1. Create a VM in the default folder:

      ```
      yc compute instance create \
        --name test-vm-from-image \
        --zone ru-central1-a \
        --create-boot-disk name=disk1,size=5,image-id=fd8gkcd3l6ov84aon8s1 \
        --public-ip \
        --ssh-key ~/.ssh/id_rsa.pub
      ```

      This command creates a VM with a 5 GB boot disk from the pre-loaded image named `test-vm-from-image`.

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      The `yc-user` user will be created on the VM with the public key from the `~/.ssh/id_rsa.pub` file. The VM gets a public IP address. To create a VM without a public IP, remove the `--public-ip` flag.

- API

  Use the [Create](../../api-ref/Instance/create.md) method for the `Instance` resource.

- Terraform

  If you don't have Terraform yet, [install it and configure the {{ yandex-cloud }} provider](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  To create a VM from a custom image:

  1. In the configuration file, describe the parameters of resources that you want to create:

       {% note info %}

       If you already have suitable resources, such as a cloud network and subnet, you don't need to describe them again. Use their names and IDs in the appropriate parameters.

       {% endnote %}

     * `yandex_compute_instance`: Description of the [VM](../../concepts/vm.md):
       * `name`: VM name.
       * `platform_id`: The [platform](../../concepts/vm-platforms.md).
       * `resources`: The number of vCPU cores and the amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
       * `boot_disk`: Boot disk settings. Specify the identifier of the [uploaded](../image-create/upload.md) image.
       * `network_interface`: Network settings. Specify the ID of the selected subnet. To automatically assign a public IP address to the VM, set `nat = true`.
       * `metadata`: In the metadata, pass the public key for accessing the VM via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
     * `yandex_vpc_network`: Description of the [cloud network](../../../vpc/concepts/network.md#network).
     * `yandex_vpc_subnet`: Description of the [subnet](../../../vpc/concepts/network.md#network) that the VM will be connected to.

     Example configuration file structure:

     ```
     resource "yandex_compute_instance" "vm-1" {
     
       name        = "vm-from-image"
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
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

  3. Deploy the cloud resources.

     1. If the configuration doesn't contain any errors, run the command:

        ```
        terraform apply
        ```

     2. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

{% endlist %}
