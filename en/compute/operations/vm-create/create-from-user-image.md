# Creating a VM from a custom image

## Before getting started

[Prepare and upload](../image-create/upload.md) the image to create a VM from.

Make sure the uploaded image is in the `READY` status.

## Create a VM from the prepared image

---

**[!TAB Management console]**

1. Open the folder where the VM will be created.

1. Click **Create resource**.
1. Select **Virtual machine**.
1. In the **Name** field, enter the VM name.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

1. Select the [availability zone](../../../overview/concepts/geo-scope.md) to locate the VM in.
1. In the **Disks** section, click **Add disk**.
   1. In the **Name** field, enter the disk name.
   1. Set the required disk size.
   1. In the **Disk purpose** section, choose **Boot**
   1. Select the [disk type](../../concepts/disk.md#concept_z5t_rtr_52b): **HDD** or **NVMe**.
   1. In the  **Contents** section, choose **Image**. A list of images that you uploaded opens.
   1. Select the necessary image.
   1. Click **Add**

1. In the **Computing resources** section:
    - Choose the [type of virtual machine](../../concepts/vm-types.md) (light or standard).
    - Specify the required amount of vCPUs and RAM.
1. In the **Network settings** section, select the subnet to connect the VM to when creating it and assign a public address to access the VM.
1. Specify data required for accessing the VM:
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the public key file.
    You need to create a key pair for SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTygen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.
1. Click **Create VM**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

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
      --create-boot-disk name=disk1,size=5,image-id=fd8gkcd3l6ov84aon8s1 \
      --public-ip \
      --ssh-key ~/.ssh/id_rsa.pub
    ```

    This command creates a VM with a 5 GB boot disk from the pre-loaded image named `test-vm-from-image`.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

    The `yc-user` user will be created on the VM with a public key from the `~/.ssh/id_rsa.pub` file. The VM gets a public IP address. To create a VM without a public IP, remove the `--public-ip` flag.

---

