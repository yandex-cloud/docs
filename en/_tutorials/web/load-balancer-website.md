# Fault-tolerant website with load balancing by {{ network-load-balancer-full-name }}

{% if product == "cloud-il" %}

{% include [one-az-disclaimer](../../_includes/overview/one-az-disclaimer.md) %}

{% endif %}

This scenario describes how to set up a website on a LAMP (Linux, Apache, MySQL, PHP) or LEMP (Linux, nginx, MySQL, PHP) stack with load balancing from [{{ network-load-balancer-full-name }}](../../network-load-balancer/concepts/index.md) between two availability zones and fault tolerance in one zone.

To set up a fault-tolerant load-balanced website:

1. [Before you start](#before-begin).
1. [Create VMs with a pre-installed web server](#create-vm).
1. [Upload the website files](#upload-files).
1. [Create a target group](#create-target-group).
1. [Create a network load balancer](#create-load-balancer).
1. [Test the fault tolerance](#test-availability).

If you no longer need the website, [delete all its resources](#clear-out).

## Before you start {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost of hosting a website includes:

* A fee for the disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using dynamic public IP addresses (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* A fee for network load balancers and traffic balancing (see [{{ network-load-balancer-full-name }} pricing](../../network-load-balancer/pricing.md)).

{% endif %}

## Create the virtual machines {#create-vm}

The VMs must be created from identical images and their parameters must also be identical.

### Create the first VM with a pre-installed web server {#create-vm-1}

Create a virtual machine:

1. On the folder page, click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter a name for the VM: `lb-tutorial-web-{{ region-id }}-a`.

1. Select the availability zone: `{{ region-id }}-a`.

1. Under **Image/boot disk selection**, click the **{{ marketplace-name }}** tab, and select the one public image for both VMs:
   * [LEMP](/marketplace/products/yc/lemp) for Linux, nginx, MySQL, and PHP.
   * [LAMP](/marketplace/products/yc/lamp) for Linux, Apache, MySQL, and PHP.

1. Under **Computing resources**:
   * **Platform**: Intel Ice Lake.
   * **vCPU**: 2.
   * **Guaranteed vCPU share**: 20%.
   * **RAM**: 1 GB.

1. In the **Network settings** section, select the subnet to connect the VM to when creating it.

1. In the **Public address** field, select **Auto**.

1. Specify data required for accessing the VM:
   * Enter the username in the **Login** field.
   * Under **SSH key**, paste the contents of the public key file. You need to create a key pair for SSH connection yourself. To create keys, use third-party tools, such as `ssh-keygen` (on Linux or macOS) or PuTTYgen (on Windows).

1. Click **Create VM**.

### Create a second VM with a pre-installed web server {#create-vm}

Create a second virtual machine:

1. On the folder page, click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter a name for the VM: `lb-tutorial-web-{{ region-id }}-b`.

1. Select the availability zone: `{{ region-id }}-b`.

1. Choose one public image for both VMs:
   * **LEMP** for Linux, nginx, MySQL, and PHP
   * **LAMP** for Linux, Apache, MySQL, and PHP

1. Under **Computing resources**:
   * **Platform**: Intel Ice Lake.
   * **vCPU**: 2.
   * **Guaranteed vCPU share**: 20%.
   * **RAM**: 1 GB.

1. In the **Network settings** section, select the subnet to connect the VM to when creating it.

1. In the **Public address** field, select **Auto**.

1. Specify data required for accessing the VM:
   * Enter the username in the **Login** field.
   * Under **SSH key**, paste the contents of the public key file. You need to create a key pair for SSH connection yourself. To create keys, use third-party tools, such as `ssh-keygen` (on Linux or macOS) or PuTTYgen (on Windows).

1. Click **Create VM**.

Creating the VM may take several minutes. When the VM status changes to `RUNNING`, you can [upload the website files to it](#upload-files).

Public IP addresses are assigned to virtual machines when they're created. They can be used for [SSH access](../../compute/operations/vm-connect/ssh.md).

## Upload the website files {#upload-files}

As an example, you can create an `index.html` test file with any text.

For the `lb-tutorial-web-{{ region-id }}-a` and `lb-tutorial-web-{{ region-id }}-b` VMs, do the following:

1. Go to **{{ compute-name }}** in the management console and find the public IP address of the VM.

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.

1. Grant your user write access to the directory `/var/www/html`:

   ```bash
   $ sudo chown -R "$USER":www-data /var/www/html
   ```

1. Upload the website files to the VM over SCP.

   {% list tabs %}

   - Linux/macOS

     ```bash
     $ scp -r <path to the file directory> <VM username>@<VM IP address>:/var/www/html
     ```

   - Windows

     Use [WinSCP](https://winscp.net/eng/index.php) to copy the local file directory to `/var/www/html` on the VM.

   {% endlist %}

## Create a target group {#create-target-group}

1. Open the **Load Balancer** section in the folder where the VMs were created.
1. Open the **Target group** tab.
1. Click **Create target group**.
1. Enter a name for the target group, such as `lb-tg-tutorial-web`.
1. Select the virtual machines `lb-tutorial-web-{{ region-id }}-a` and `lb-tutorial-web-{{ region-id }}-b` to add them to the target group.
6. Click **Create target group**.

## Create a network load balancer {#create-load-balancer}

When creating a network load balancer, you need to create a listener that the load balancer will use to receive traffic. You also need to set up health checks for resources in the attached target group.

To create a network load balancer:

1. Open the **Load balancers** tab.
1. Click **Create load balancer**.
1. Enter a name for the load balancer, such as `lb-tutorial-web`.
1. Click **Add listener** under **Listeners**.
1. In the window that opens, enter a name for the listener, like `lb-tut-listener-1`.
1. Set the port to `80`.
1. Click **Add**.
1. Turn on **Target groups**.
1. Select the previously created target group `lb-tg-tutorial-web`. If there's only one target group, it's selected automatically.
1. Under **Health check**, enter a name for the health check, like `health-check-1`.
1. Select the check type: **HTTP**.
1. Set the port to `80`.
1. Specify the URL for health checks. You can leave the default path: `/`.
1. Specify the response timeout in seconds: `1`.
1. Specify the interval, in seconds, for sending health check requests: `2`.
1. Set the healthy threshold, which is the number of successful checks required to consider the VM ready to receive traffic: `5`.
1. Specify the unhealthy threshold, which is the number of failed checks after which no traffic will be routed the VM: `5`.
1. Click **Create load balancer**.

## Test the fault tolerance {#test-availability}

1. Under **Network** on the VM page in the management console, find the public IP address of the `lb-tutorial-web-{{ region-id }}-a` VM.

1. Connect to the VM over SSH.

1. Stop the web service to simulate a failure on the web server:

   {% list tabs %}

   - LAMP

     ```bash
     $ sudo service apache2 stop
     ```

   - LEMP

     ```bash
     $ sudo service nginx stop
     ```

   {% endlist %}

1. In the management console, go to **{{ network-load-balancer-name }}** and select the load balancer created earlier.

1. Find the listener IP address under **Listeners**. Open the website in the browser using the listener address. The connection should be successful, even though one of the web servers has failed.

1. When the check is complete, start the web service again:

   {% list tabs %}

   - LAMP

     ```bash
     $ sudo service apache2 start
     ```

   - LEMP

     ```bash
     $ sudo service nginx start
     ```

   {% endlist %}

## How to delete created resources {#clear-out}

To stop paying for deployed servers, [delete](../../compute/operations/vm-control/vm-delete.md) the virtual machines `dns-lb-tutorial-web-{{ region-id }}-a` and `dns-lb-tutorial-web-{{ region-id }}-b`, and the [load balancer](../../network-load-balancer/operations/load-balancer-delete) `lb-tutorial-web`.
