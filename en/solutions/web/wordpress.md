# Creating a website in WordPress

To set up a website in WordPress:

1. [Create a VM for WordPress](#create-vm)
1. [Set up WordPress](#wordpress-setup)
1. [Configure DNS](#configure-dns)

## Before you start {#before-begin}

Before creating a VM:

1. Go to the Yandex.Cloud [management console](https://console.cloud.yandex.com/) and select the folder where you want to perform the operations.
1. Make sure the selected folder has a cloud network with a subnet in at least one availability zone. To do this, click **Yandex Virtual Private Cloud** on the folder page. If the list contains a network, click on its name to see the list of subnets. If the subnets or network you need are not listed, [create them](../../vpc/quickstart.md).

## 1. Create a VM for WordPress {#create-vm}

To create a VM:

1. On the folder page of the [management console](https://console.cloud.yandex.com/), click **Create resource** and select **Virtual machine**.
1. In the **Name** field, enter the VM name: `wordpress`.

   {% include [name-format](../../_includes/name-format.md) %}

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to locate the VM in.
1. In the **Public images** section, click **Select**. Select the **WordPress** public image.
1. In the **Computing resources** section:
    - Select the [platform](../../compute/concepts/vm-platforms.md).
    - Specify the necessary number of vCPUs and amount of RAM.

   The minimum configuration is enough for testing:
   * **Platform**: Intel Cascade Lake.
   * **Guaranteed vCPU fraction**: 5%.
   * **vCPU**: 2.
   * **RAM**: 1 GB.

1. In the **Network settings** section, click **Add network**.
1. In the window that opens, select the subnet to connect the VM to when creating it.
1. In **Public address**, select **Automatically**. Click **Select**.
1. Specify data required for accessing the VM:
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the public key file.
You need to create a key pair for SSH connection yourself. For more information, see [#T](../../compute/operations/vm-connect/ssh.md).
1. Click **Create VM**.

Creating the VM may take several minutes. When the VM's status changes to `RUNNING`, you can begin configuring the website.

When the VM is created, it is assigned a public IP address and hostname (FQDN). This data can be used for SSH access.

## 2. Set up WordPress {#wordpress-setup}

After the `wordpress` VM's status changes to `RUNNING`, do the following:

1. Go to the VM page of the [management console](https://console.cloud.yandex.com/). In the **Network** section, find the VM's public IP address.
1. Open the VM by entering its address in your browser.
1. Select the language and click **Continue**.
1. Fill out information to access the website:
   1. Enter any name for the website (for example, `yc-wordpress`).
   1. Specify the username to be used to log in to the admin panel (for example, `yc-user`).
   1. Enter the password to be used to log in to the admin panel.
   1. Enter your email address.

1. Click **Install WordPress**.

1. If the installation is successful, click **Log in**.

1. Log in to the website with the username and password specified in the previous steps. This opens the admin panel, where you can start working with your website.

1. Make sure the website is accessible by opening the VM's public IP address in your browser.

## 3. Configure DNS {#configure-dns}

To link the website to your domain, configure DNS at your registrar as follows:

* A record: `@` subdomain (use the VM's public IP address as the address).
* CNAME record: `www` subdomain (use a domain with a dot at the end as the canonical name, like `example.com).`

