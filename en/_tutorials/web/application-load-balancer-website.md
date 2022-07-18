# Fault-tolerant website with load balancing by {{ alb-full-name }}



Create and set up a website with load balancing by [{{ alb-name }}](../../application-load-balancer/concepts/index.md) between three availability zones and fault tolerance in one zone.

1. [Before you start](#before-you-begin).
1. [Prepare the network infrastructure](#prepare-network).
1. [Create security groups](#create-security-groups).
1. [Create an instance group](#create-vms).
1. [Upload the website files](#upload-files).
1. [Create a backend group](#create-backend-group).
1. [Create an HTTP router](#create-http-routers-sites).
1. [Create an L7 load balancer](#create-alb).
1. [Configure the DNS](#configure-dns).
1. [Test the fault tolerance](#test-ha).

If you no longer need the website, [delete all its resources](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}



### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* A fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* A fee for load balancing (see [{{ alb-full-name }} pricing](../../application-load-balancer/pricing.md)).


## Prepare the network infrastructure {#prepare-network}

Before creating a VM:

1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder where you will perform the operations.

1. Make sure that the selected folder contains a network with subnets in the `{{ region-id }}-a`, `{{ region-id }}-b` and `{{ region-id }}-c` availability zones. To do this, select on the folder page **{{ vpc-name }}**. If the [subnets](../../vpc/operations/subnet-create.md) or [network](../../vpc/operations/network-create.md) you need are not listed, create them.

## Create security groups {#create-security-groups}

[Security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) include rules that let the load balancer receive incoming traffic and redirect it to the VMs so they can receive the traffic.

To create security groups for the load balancer and an instance group:

1. In the [management console]({{ link-console-main }}), open **{{ vpc-name }}**.
1. Open the **Security groups** tab.
1. Create a security group for the load balancer:
   1. Click **Create group**.
   1. Name the group, such as `alb-sg`.
   1. Select the network to assign the security group to.
   1. Under **Rules**, create the following rules using the instructions below the table:

      | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source/<br/>destination type | Source /<br/>destination |
      | --- | --- | --- | --- | --- | --- |
      | Outgoing | any | All | Any | CIDR | 0.0.0.0/0 |
      | Incoming | ext-http | 80 | TCP | CIDR | 0.0.0.0/0 |
      | Incoming | ext-https | 443 | TCP | CIDR | 0.0.0.0/0 |
      | Incoming | healthchecks | 30080 | TCP | CIDR | 198.18.235.0/24<br/>198.18.248.0/24 |

      1. Select the **Outgoing traffic** or **Incoming traffic** tab.
      1. Click **Add rule**.
      1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
      1. In the **Protocol** field, specify the desired protocol or leave **Any** to allow traffic transmission over any protocol.
      1. In the **Purpose** or **Source** field, select the purpose of the rule:
         * **CIDR**: The rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
         * **Security group**: The rule will apply to the VMs from the current group or the selected security group.
      1. Click **Save**. Repeat the steps to create all rules from the table.
   1. Click **Save**.

1. Similarly, create a security group named `alb-vm-sg` for an instance group, with the same network and the following rules:

   | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source type | Source |
   | --- | --- | --- | --- | --- | --- |
   | Incoming | balancer | 80 | TCP | Security group | `ddos-sg-balancer` |
   | Incoming | ssh | 22 | TCP | CIDR | 0.0.0.0/0 |


## Create an instance group {#create-vms}

Backends of your application are deployed on the VM instance of the [target group](../../application-load-balancer/concepts/target-group.md). The target group will be attached to the load balancer so that requests can be sent to the backend endpoints of your application.

To create an instance group with the minimum configuration:

1. In the [management console]({{ link-console-main }}), open **{{ compute-name }}**.
1. Open the **Instance groups** tab and click **Create group**.
1. Under **Basic parameters**:
   * Name the instance group like `alb-vm-group`.
   * Select a [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete group instances, assign the `editor` role to the service account. All operations in {{ ig-name }} are performed on behalf of the service account.

1. Under **Allocation**, select three availability zones (`{{ region-id }}-a`, `{{ region-id }}-b` and `{{ region-id }}-c`) to ensure fault tolerance of your hosting.
1. Under **Instance template**, click **Define** and set up the configuration for a basic instance:
   * Under **Basic parameters**, enter the template **Description**:
   * Under **Image/boot disk selection**, open the **Cloud Marketplace** tab and click **Show more**. Select **LEMP** and click **Use**.
   * Under **Disks**, specify:
      * Disk **type**: HDD.
      * **Size**: 3 GB.
   * Under **Computing resources**, specify:
      * **Platform**: Intel Cascade Lake.
      * **vCPU**: 2.
      * **Guaranteed vCPU share**: 5%
      * **RAM**: 1 GB.
   * Under **Network settings**:
      * Select a cloud network and its subnets.
      * In the **Public address** field, select **Auto**.
      * Select the `alb-vm-sg` security group.
   * Under **Access**, specify the data required to access the VM:
      * In the **Service account** field, select the service account to link the VM to.
      * Enter the username in the **Login** field.
      * In the **SSH key** field, paste the contents of the public key file.
         To establish an SSH connection, you need to create a key pair. For more information, see [Connecting to a Linux VM via SSH](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * Click **Save**.

1. Under **Scaling**, enter the **Size** of the instance group: 3.
1. Under **Integration with Application Load Balancer**, select **Create target group** and specify `alb-tg` as the group name.
1. Click **Create**.

It may take several minutes to create an instance group. Once all VMs change their status to `RUNNING`, you can [upload the website files to them](#upload-files).

#### See also

* [{#T}](../../compute/operations/vm-connect/ssh.md)

## Upload the website files {#upload-files}

To test the web server, upload the website files to each VM. For example, you can use the `index.html` file from the [archive](https://storage.yandexcloud.net/doc-files/index.html.zip).

Do the following for each VM instance in the [created group](#create-vms):

1. On the **Virtual machines** tab, click on the name of the desired VM in the list. Under **Network**, find the VM's public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM via SSH.
1. Grant your user write access to the directory `/var/www/html`:

   ```bash
   sudo chown -R "$USER":www-data /var/www/html
   ```

1. Upload the website files to the VM via [SCP](https://en.wikipedia.org/wiki/Secure_copy_protocol).

   {% list tabs %}

   - Linux/macOS

      Use the `scp` command-line utility:

      ```bash
      scp -r <path to the file directory> <VM username>@<VM IP address>:/var/www/html
      ```

   - Windows

      Use [WinSCP](https://winscp.net/eng/download.php) to copy the local file directory to `/var/www/html` on the VM.

   {% endlist %}

## Create a backend group {#create-backend-group}

You must link the target group created with the VM group to the [backend group](../../application-load-balancer/concepts/backend-group.md) that defines traffic allocation settings.

For the backends, groups will implement [health checks](../../application-load-balancer/concepts/backend-group.md#health-checks): the load balancer will periodically send health check requests to the VMs and expect a response after a certain delay.

To create a backend group:

1. Open **{{ alb-name }}** in the folder where the instance group was created.

1. Open the **Backend groups** tab.
1. Click **Create backend group**.
1. Name the backend group, such as `alb-bg`.
1. Under **Backends**, click **Add**.
1. Name the backend, such as `backend-1`.
1. In the **Target group** field, select the previously created `alb-tg` target group.
1. Specify the **Port** that the backend VMs will use to receive incoming traffic from the load balancer: `80`.
1. Click **Add health check**.
1. Enter the **Port** that the backend VMs will use to accept health check connections from the load balancer: `80`.
1. Enter the **Path** to be accessed by the load balancer's health checks: `/`.
1. Click **Create**.

## Create an HTTP router {#create-http-routers-sites}

The backend group should be linked to an [HTTP router](../../application-load-balancer/concepts/http-router.md) that defines HTTP routing rules.

To create an HTTP router and add a route to it:

1. Open the **HTTP routers** tab.

1. Click **Create HTTP router**.
1. Name the router, such as `alb-router`.
1. Click **Add virtual host**.
1. Name the virtual host, such as `alb-host`.
1. In the **Authority** field, specify the website's domain name: `alb-example.com`.
1. Click **Add route**.
1. Name it like `route-1`.
1. In the **Backend group** field, select the `alb-bg` group you created earlier.
1. Leave the other settings as they are and click **Create**.

## Create an L7 load balancer {#create-alb}

To create a load balancer:

1. Open the **Load balancers** tab.

1. Click **Create L7 load balancer**.
1. Name the load balancer like `alb-1`.
1. Under **network settings**, select the network that the instance group is connected to and the [previously created](#create-security-groups) `alb-sg` security group.
1. Under **Allocation**, select the subnets for the load balancer's nodes in each availability zone and enable traffic.
1. Click **Add listener** under **Listeners**.
1. Name the listener, such as `alb-listener`.
1. Under **Public IP address settings**, enable traffic.
1. Set the port to `80`.
1. In the **HTTP router** field, select `alb-router` created earlier.
1. Click **Create**.

## Configure the DNS {#configure-dns}

You need to link the domain name you wish to use for your website to the load balancer's IP address. You can use **{{ dns-name }}** to manage your domain.

The instructions below describe how to configure DNS for the `alb-example.com` domain name.

### Add a zone

1. Open **{{ dns-name }}** in the folder where the instance group was created.
1. Click **Create zone**.
1. Specify the zone settings:
   * **Zone**: `alb-example.com`. Specify your registered domain.
   * **Type**: **Public**.
   * **Name**: `alb-zone`.

1. Click **Create**.

### Add resource records

Create DNS records in the public zone:

1. Open **{{ alb-name }}**. Find the IP address of the previously created `alb-1` load balancer in the list of load balancers.
1. In **{{ dns-name }}**, select `alb-example.com.`. from the list.
1. Create an [A](../../dns/concepts/resource-record.md#a) record:
   1. Click **Create record**.
   1. Set the record parameters:
      * **Name**: Leave empty.
      * **Record type**: Keep `A` as the value.
      * **TTL** (record time to live): Leave the default.
      * **Value**: Enter the public IP address of `alb-1`.
   1. Click **Create**.

1. Create a [CNAME](../../dns/concepts/resource-record.md#cname) record:
   1. Click **Create record**.
   1. Set the record parameters:
      * **Name**: `www`.
      * **Record type**: Select `CNAME` as the value.
      * **TTL** (record time to live): Leave the default.
      * **Value**: Enter `alb-example.com`.
   1. Click **Create**.

## Test the fault tolerance {#test-ha}

1. In the [management console]({{ link-console-main }}), open **{{ compute-name }}**.
1. Go to the page of the VM from the previously created group. Under **Network**, find the VM's public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM via SSH.
1. Stop the web service to simulate a failure on the web server:

   ```bash
   sudo service nginx stop
   ```

1. Connect to your website through a browser. The connection should be successful, even though one of the web servers has failed.
1. After the check is complete, restart the web service:

   ```bash
   sudo service nginx start
   ```

## How to delete created resources {#clear-out}

To shut down the hosting and stop paying for the created resources:

1. Delete the **{{ alb-name }}** components:
   1. [Delete](../../application-load-balancer/operations/application-load-balancer-delete.md) the `alb-1` L7 load balancer.
   1. [Delete](../../application-load-balancer/operations/http-router-delete.md) the `alb-router` HTTP router.
   1. [Delete](../../application-load-balancer/operations/backend-group-delete.md) the `alb-bg` backend group.

1. [Delete](../../compute/operations/instance-groups/delete.md) the `alb-vm-group` instance group.
