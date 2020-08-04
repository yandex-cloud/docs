# Website on a LAMP or LEMP stack

[LAMP](https://en.wikipedia.org/wiki/LAMP_(software_bundle)) (Linux, the Apache HTTP Server, MySQL, and PHP) and LEMP (its variation where Apache is replaced with Nginx) are popular sets of components for deploying web applications and dynamic websites.

In this tutorial, you'll learn how to deploy LAMP in the Yandex.Cloud infrastructure: as a result, you'll launch a VM running your site's web server.

To set up a LAMP or LEMP-based website:

1. [Before you start](#before-you-begin).
1. [Create a VM with a pre-installed web server](#create-vm).
1. [Upload the website files](#upload-files).
1. [Configure DNS](#configure-dns).
1. [Check that the website is running](#test-site).

If you no longer need the website, [delete all its resources](#clear-out).

## Before you start {#before-you-begin}

Before deploying the server, you need to sign up for Yandex.Cloud and create a billing account:

{% include [prepare-register-billing](../_solutions_includes/prepare-register-billing.md) %}

If you have an active billing account, you can create or select a folder to run your VM in from the [Yandex.Cloud page](https://console.cloud.yandex.com/cloud).

[Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).

### Required paid resources {#paid-resources}

The cost for maintaining a LAMP server includes:

* A fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Create a VM with a pre-installed web server {#create-vm}

To create a VM:

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource**, and select **Virtual machine**.

1. In the **Name** field, enter a name for the VM: `lamp-vm` or `lemp-vm`.

    {% include [name-format](../../_includes/name-format.md) %}

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM in. If you don't know which availability zone you need, leave the default.

1. Under **Images from {{ marketplace-name }}**, click **Select** and choose a VM image with the desired set of components:
   * **LAMP** for Linux, Apache, MySQL, and PHP.
   * **LEMP** for Linux, Nginx, MySQL, and PHP.

   For static websites, we recommend using LEMP.

1. Under **Computing resources**:
    - Choose a [platform](../../compute/concepts/vm-platforms.md) for the VM.
    - Specify the necessary number of vCPUs and amount of RAM.

   The minimum configuration is enough for functional website testing:
   * **Platform**: Intel Cascade Lake.
   * **Guaranteed vCPU share**: 5%.
   * **vCPU**: 2.
   * **RAM**: 1 GB.

1. In the **Network settings** section, select the network and subnet to connect the VM to. If you don't have a network or subnet, create them right on the VM creation page.

1. In the **Public address** field, leave the **Auto** value to assign a random external IP address from the Yandex.Cloud pool, or select a static address from the list if you reserved one in advance.

1. Specify data required for accessing the VM:

    - Enter the username in the **Login** field.

    - In the **SSH key** field, paste the contents of the public key file.

      You need to create a key pair for the SSH connection yourself. Learn [how to connect to VMs via SSH](../../compute/operations/vm-connect/ssh.md).

    {% note alert %}

     The IP address and host name (FQDN) to connect to the VM are assigned on VM creation. If you selected **No address** in the **Public address** field, you won't be able to access the VM from the internet.

    {% endnote %}

1. Click **Create VM**.

Creating the VM may take several minutes. When the VM status changes to `RUNNING`, you can [upload the website files to it](#upload-files).

## Upload the website files {#upload-files}

To test the web server, upload the `index.html` file to the VM. You can use a [test file](https://storage.yandexcloud.net/doc-files/index.html.zip). Make sure you unzip the archive.

{% include [upload-files](../_solutions_includes/upload-web-site-files.md) %}

## Configure DNS (if you have a domain name) {#configure-dns}

If you want to link a domain name to the deployed server, edit the DNS records for your domain.

{% include [configure-a-record-and-cname](../_solutions_includes/configure-a-record-and-cname.md) %}

## Check that the website is running {#test-site}

To test the website, open it in the browser at: `http://<VM public IP address>`.

You can check the domain name the same way only 15-20 minutes after editing the DNS records.

## How to delete created resources {#clear-out}

To stop paying for your deployed server, just [delete](../../compute/operations/vm-control/vm-delete.md) the `lamp-vm` or `lemp-vm` virtual machine.

If you reserved a static public IP address specifically for this VM:

1. Open the **Virtual Private Cloud** in your folder.
1. Go to the **IP addresses** tab.
1. Find the address you need, click ![ellipsis](../../_assets/options.svg), and select **Delete**.

