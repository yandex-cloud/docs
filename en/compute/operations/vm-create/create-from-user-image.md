# Creating a VM from a custom image

## Before getting started {#before-you-begin}

[Prepare and upload](../image-create/upload.md) the image to create a VM from.

Make sure the uploaded image is in the `READY` status.

## Create a VM from the prepared image {create-vm-from-image}

{% list tabs %}

- Management console

  1. Open the folder where the VM will be created.

  1. Click **Create resource**.

  1. Select **Virtual machine**.

  1. In the **Name** field, enter the VM name.

      {% include [name-format](../../../_includes/name-format.md) %}

      {% note info %}

      The virtual machine name is used for generating the FQDN, which cannot be changed later. If the FQDN is important to you, choose an appropriate name for the virtual machine at the creation stage. For more information about generating FQDN names, see the section [{#T}](../../concepts/network.md#hostname).

      {% endnote %}

  1. Select the [availability zone](../../../overview/concepts/geo-scope.md) to locate the VM in.

  1. In the **Disks** section, click **Add disk**.
     1. In the **Name** field, enter the disk name.
     1. Set the required disk size.
     1. In **Disk designation**, choose **Boot**.
     1. Select the [disk type](../../concepts/disk.md#disks_types): **HDD** or **SSD**.
     1. In **Content**, choose **Image**. A list of images that you uploaded opens.
     1. Select the necessary image.
     1. Click **Add**.

  1. In the **Computing resources** section:
      - Choose the [platform](../../concepts/vm-platforms.md).
      - Specify the necessary number of vCPUs and amount of RAM.

  1. In the **Network settings** section, click **Add network**.

  1. In the window that opens, select the subnet to connect the VM to when creating it.

  1. In **Public address**, choose:
      - **Automatically** — to set a public IP address automatically. The address is allocated from the pool of Yandex.Cloud addresses.
      - **List** — to select a public IP address from the list of static addresses. For more information, see the section [{#T}](../../../vpc/operations/set-static-ip.md) in the {{ vpc-name }} service documentation.
      - **No address** — to not assign a public IP address.

  1. Specify data required for accessing the VM:
      - Enter the username in the **Login** field.
      - In the **SSH key** field, paste the contents of the public key file.
  You need to create a key pair for SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTygen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.

  1. Click **Create VM**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI's create VM command:

      ```
      $ yc compute instance create --help
      ```

  1. Get a list of images in the default folder:

      ```
      $ yc compute image list
      +----------------------+-------------------+--------+-------------+--------+
      |          ID          |       NAME        | FAMILY | PRODUCT IDS | STATUS |
      +----------------------+-------------------+--------+-------------+--------+
      |         ...          |         ...       |        |             |  ...   |
      | fd8gkcd3l6ov84aon8s1 |  your-test-image  |        |             | READY  |
      |         ...          |         ...       |        |             |  ...   |
      +----------------------+-------------------+--------+-------------+--------+
      ```

  1. Select the `ID` or `NAME` of the image you need.

  1. Create a VM in the default folder:

      ```
      $ yc compute instance create \
        --name test-vm-from-image \
        --zone ru-central1-a \
        --create-boot-disk name=disk1,size=5,image-id=fd8gkcd3l6ov84aon8s1 \
        --public-ip \
        --ssh-key ~/.ssh/id_rsa.pub
      ```

      This command creates a VM with a 5 GB boot disk from the pre-loaded image named `test-vm-from-image`.

      {% include [name-format](../../../_includes/name-format.md) %}

      {% note info %}

      The virtual machine name is used for generating the FQDN, which cannot be changed later. If the FQDN is important to you, choose an appropriate name for the virtual machine at the creation stage. For more information about generating FQDN names, see the section [{#T}](../../concepts/network.md#hostname).

      {% endnote %}

      The `yc-user` user will be created on the VM with a public key from the `~/.ssh/id_rsa.pub` file. The VM gets a public IP address. To create a VM without a public IP, remove the `--public-ip` flag.

- API

  Use the [Create](../../api-ref/Instance/create.md) method for the `Instance` resource.

{% endlist %}

