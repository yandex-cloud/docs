# Creating a website in WordPress

This scenario describes how to create and set up a WordPress CMS-based website using a special VM image.

To set up a website in WordPress:
1. [Create a VM for WordPress](#create-vm).
1. [Set up WordPress](#wordpress-setup).
1. [Configure DNS](#configure-dns).

If you no longer need the website, [delete the VM with it](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Make sure the selected folder has a cloud network with a subnet in at least one availability zone. To do this, select **{{ vpc-full-name }}** on the folder page. If the list contains a network, click on its name to see the list of subnets. If the subnets or network you need are not listed, [create them](../../vpc/quickstart.md).



### Required paid resources {#paid-resources}

The cost of hosting a website in WordPress includes:
* A fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Creating a VM for WordPress {#create-vm}

To create a VM:

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter the VM name: `wordpress`.

   {% include [name-format](../../_includes/name-format.md) %}

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM in.

1. Under **Image/boot disk selection**, click the **{{ marketplace-name }}** tab, and select the [WordPress](/marketplace/products/yc/wordpress) public image.

1. Under **Computing resources**:
   * Choose a [platform](../../compute/concepts/vm-platforms.md).
   * Specify the necessary number of vCPUs and amount of RAM.

   The minimum configuration is enough for testing:
   * **Platform**: Intel Ice Lake.
   * **vCPU**: 2.
   * **Guaranteed vCPU share**: 20%.
   * **RAM**: 1 GB.

1. In the **Network settings** section, select the subnet to connect the VM to when creating it.

1. In **Public address**, select **Automatically**.

1. Specify data required for accessing the VM:
   * Enter the username in the **Login** field.
   * In the **SSH key** field, paste the contents of the public key file.
You need to create a key pair for an SSH connection yourself. For details, see [{#T}](../../compute/operations/vm-connect/ssh.md).

1. Click **Create VM**.

Creating the VM may take several minutes. When the VM's status changes to `RUNNING`, you can begin configuring the website.

When the VM is created, it is assigned a public IP address and hostname (FQDN). This data can be used for SSH access.

## Setting up WordPress {#wordpress-setup}

After the `wordpress` VM's status changes to `RUNNING`, do the following:

1. You can learn the IP address of the VM under **Network** on the VM page in the [management console]({{ link-console-main }}).

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

## Configuring DNS {#configure-dns}

To link the website to your domain, configure DNS at your registrar as follows:
* A record: `@` subdomain (use the VM's public IP address as the address).
* CNAME record: `www` subdomain (use a domain with a dot at the end as the canonical name, like `example.com`).

## How to delete created resources {#clear-out}

To stop paying for your deployed server, just [delete](../../compute/operations/vm-control/vm-delete.md) the `wordpress` VM.

If you reserved a static public IP address specifically for this VM:
1. Select the **{{ vpc-short-name }}** in your folder.
1. Go to the **IP addresses** tab.
1. Find the address you need, click ![ellipsis](../../_assets/options.svg), and select **Delete**.