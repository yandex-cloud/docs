# Website on LAMP or LEMP stack

To configure a static website or dynamic website in PHP:

1. [Create a VM with a pre-installed web server](#create-vm)
1. [Upload the website files](#upload-files)
1. [Configure DNS](#configure-dns)

## Before you start {#before-begin}

Before creating a VM:

1. Go to the Yandex.Cloud [management console](https://console.cloud.yandex.ru) and select the folder where you want to perform the operations.
1. Make sure the selected folder has a network with a subnet that the VM can be connected to. To do this, click the **Yandex Virtual Private Cloud** tile on the folder page. If the list contains a network, click on its name to see the list of subnets. If there aren't any networks or subnets, [create them](../../vpc/quickstart.md).

## 1. Create a VM with a pre-installed web server {#create-vm}

To create a VM:

1. On the folder page of the [management console](https://console.cloud.yandex.ru), click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter the VM name.

    [!INCLUDE [name-format](../../_includes/name-format.md)]

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to locate the VM in.

1. Select a public image:
   * **LEMP** for Linux, nginx, MySQL, and PHP
   * **LAMP** for Linux, Apache, MySQL, and PHP

   For static websites, we recommend using **LEMP**.

1. In the **Computing resources** section:
    - Choose the [type of virtual machine](../../compute/concepts/vm-types.md) (light or standard).
    - Specify the required amount of vCPUs and RAM.

    The minimum configuration is enough for functional testing:
    * **Guaranteed vCPU share**: 5%.
    * **vCPU**: 1.
    * **RAM**: 1 GB.

1. In the **Network settings** section, select the subnet to connect the VM to when creating it.

1. Specify data required for accessing the VM.
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the public key file.
You need to create a key pair for SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.

1. Click **Create VM**.

Creating the VM may take several minutes. When the VM status changes to `RUNNING`, you can [upload the website files to it](#upload-files).

When a VM is created, it is assigned an IP address and hostname (FQDN). This data can be used for SSH access.

#### See also

- [[!TITLE]](../../compute/operations/vm-control/vm-connect-ssh.md)

## 2. Upload the website files {#upload-files}

[!INCLUDE [upload-files](../_solutions_includes/upload-web-site-files.md)]

## 3. Configure DNS {#configure-dns}

The domain name that you want to use for your website must be associated with the created VM.

[!INCLUDE [configure-a-record-and-cname](../_solutions_includes/configure-a-record-and-cname.md)]

