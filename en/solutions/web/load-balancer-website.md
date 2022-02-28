# Fault-tolerant website with load balancing by {{ network-load-balancer-full-name }}

Create and set up a website on a [LAMP]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/LAMP){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/LAMP_(software_bundle)){% endif %} ([Linux](https://www.linux.org/), [Apache HTTP Server](https://httpd.apache.org/), [MySQL](https://www.mysql.com/), and [PHP](https://www.php.net/)) or LEMP (with [Nginx](https://www.nginx.com/) used instead of Apache) stack with load balancing enabled by [{{ network-load-balancer-short-name }}](../../network-load-balancer/concepts/index.md) between two availability zones and fault tolerance in one zone.

1. [Before you start](#before-you-begin).
1. [Prepare the network infrastructure](#prepare-network).
1. [Create an instance group](#create-vms).
1. [Upload the website files](#upload-files).
1. [Create a network load balancer](#create-load-balancer).
1. [Test the fault tolerance](#test-availability).

If you no longer need the website, [delete all its resources](#clear-out).

## Before you start {#before-you-begin}

Before deploying the server, you need to sign up for {{ yandex-cloud }} and create a billing account:

{% include [prepare-register-billing](../../_includes/solutions/_common/prepare-register-billing.md) %}

If you have an active billing account, you can create a folder to run your VM in or select one on the [{{ yandex-cloud }} page]({{ link-console-cloud }}).

[Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).

### Required paid resources {#paid-resources}

The cost of hosting a website includes:

* A fee for the disks and continuously running VMs (see [{{ compute-full-name }}pricing](../../compute/pricing.md)).
* A fee for using dynamic public IP addresses (see [{{ vpc-full-name }}pricing](../../vpc/pricing.md)).
* A fee for network load balancers and traffic balancing (see [pricing{{ network-load-balancer-full-name}}](../../network-load-balancer/pricing.md)).

## Prepare the network infrastructure {#prepare-network}

Before creating a VM:

1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder where you want to perform the operations.

1. Make sure that the selected folder contains a network with subnets in the `ru-cental1-a` and `ru-central1-b` availability zones. To do this, select **{{ vpc-name }}** on the folder page. If you don't have the right [network](../../vpc/operations/network-create.md) or [subnets](../../vpc/operations/subnet-create.md), create them.

## Create an instance group {#create-vms}

To create an instance group with a pre-installed web server:

1. In the [management console]({{ link-console-main }}), open **{{ compute-name }}**.
1. Open the **Instance groups** tab and click **Create group**.
1. Under **Basic parameters**:
   * Name the instance group like `nlb-vm-group`.
   * Select a [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete group instances, assign the `editor` role to the service account. All operations in {{ ig-name }} are performed on behalf of the service account.

1. Under **Allocation**, select the `ru-cental1-a` and `ru-central1-b` availability zones to ensure fault tolerance of your hosting.
1. Under **Instance template**, click **Define** and set up the configuration for a basic instance:
   * Under **Basic parameters**, enter the template **Description**:
   * Under **Image/boot disk selection**, open the **Cloud Marketplace** tab and click **Show more**. Choose a product:
     * [LEMP]{% if lang == "ru" %}(https://cloud.yandex.ru/marketplace/products/yc/lemp){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/marketplace/products/yc/lemp){% endif %} for Linux, NGINX, MySQL, and PHP.
     * [LAMP]{% if lang == "ru" %}(https://cloud.yandex.ru/marketplace/products/yc/lamp){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/marketplace/products/yc/lamp){% endif %} for Linux, Apache, MySQL, and PHP.

     Click **Use**.
   * Under **Disks**, specify:
     * **Disk type**: HDD.
     * **Size**: 3 GB.
   * Under **Computing resources**, specify:
     * **Platform**: Intel Ice Lake.
     * **vCPU**: 2.
     * **Guaranteed vCPU share**: 20%.
     * **RAM**: 1 GB.
   * Under **Network settings**:
     * Select a cloud network and its subnets.
     * In the **Public address** field, select **Auto**.
   * Under **Access**, specify the data required to access the VM:
     * In the **Service account** field, select the service account to link the VM to.
     * Enter the username in the **Login** field.
     * In the **SSH key** field, paste the contents of the public key file.
     To establish an SSH connection, you need to create a key pair. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * Click **Save**.

1. Under **Scaling**, enter the **Size** of the instance group: 2.
1. Under **Integration with Network Load Balancer**, select **Create target group** and specify `nlb-tg` as the group name.
1. Click **Create**.

It may take several minutes to create an instance group. Once all VMs change their status to `RUNNING`, you can [upload the website files to them](#upload-files).

#### See also

* [{#T}](../../compute/operations/vm-connect/ssh.md)

## Upload the website files {#upload-files}

To test the web server, upload the website files to each VM. For example, you can use the `index.html` file from the [archive](https://storage.yandexcloud.net/doc-files/index.html.zip).

Do the following for each VM instance in the [created group](#create-vms):

1. On the **Virtual machines** tab, click on the name of the desired VM in the list. Under **Network**, find the VM's public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
1. Grant your user write access to the directory `/var/www/html`:

   ```bash
   sudo chown -R "$USER":www-data /var/www/html
   ```

1. Upload the website files to the VM via [SCP protocol]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/SCP){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Secure_copy_protocol){% endif %}.

   {% list tabs %}

   - Linux/macOS

     Use the `scp` command-line utility:

     ```bash
     scp -r <path to the file directory> <VM user name>@<VM IP address>:/var/www/html
     ```

   - Windows

     Use [WinSCP](https://winscp.net/eng/download.php) to copy the local file directory to `/var/www/html` on the VM.

   {% endlist %}

## Create a network load balancer {#create-load-balancer}

When creating a network load balancer, you need to add a listener that the load balancer will use to receive traffic, attach the target group created together with the instance group, and set up health checks for resources in it.

To create a network load balancer:

1. In the [management console]({{ link-console-main }}), open **{{ network-load-balancer-short-name }}**.
1. Click **Create a network load balancer**.
1. Name the load balancer, such as `nlb-1`.
1. Under **Listeners**, click **Add listener** and specify the parameters:
    * **Listener name**: `nlb-listener`.
    * **Port**: `80`.
    * **Target port**: `80`.

1. Click **Add**.
1. Under **Target groups**:
    1. Click **Add target group** and choose the [previously created](#create-vms) `nlb-tg` target group. If there's only one target group, it's selected automatically.
    1. Under **Health check**, click **Configure** and edit the parameters:
        * **Name** of the check: `health-check-1`.
        * **Healthy threshold**: The number of successful checks required to consider the VM ready to receive traffic: `5`.
        * **Unhealthy threshold**: The number of failed checks after which no traffic will be routed to the VM: `5`.
    1. Click **Apply**.

1. Click **Create**.

## Test the fault tolerance {#test-availability}

1. In the [management console]({{ link-console-main }}), open **{{ compute-name }}**.
1. Go to the page of the VM from the previously created group. Under **Network**, find the VM's public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.
1. Stop the web service to simulate a failure on the web server:

   {% list tabs %}

   - LAMP

     ```bash
     sudo service apache2 stop
     ```

   - LEMP

     ```bash
     sudo service nginx stop
     ```
   {% endlist %}

1. Go to **{{ network-load-balancer-name }}** and select the `nlb-1` load balancer created earlier.
1. Find the listener IP address under **Listeners**. Open the website in the browser using the listener address.

   The connection should be successful, even though one of the web servers has failed.
1. When the check is complete, start the web service again:

   {% list tabs %}

   - LAMP

     ```bash
     sudo service apache2 start
     ```

   - LEMP
     ```bash
     sudo service nginx start
     ```

   {% endlist %}

## How to delete created resources {#clear-out}

To shut down the hosting and stop paying for the created resources:

1. [Delete](../../network-load-balancer/operations/load-balancer-delete.md) the `nlb-1` network load balancer.

1. [Delete](../../compute/operations/instance-groups/delete.md) the `nlb-vm-group` instance group.
