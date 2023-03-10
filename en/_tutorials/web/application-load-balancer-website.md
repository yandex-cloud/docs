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

You can also deploy the infrastructure for hosting a website via {{ TF }} using a [ready-made configuration file](#terraform).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* A fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* A fee for load balancing (see [{{ alb-full-name }} pricing](../../application-load-balancer/pricing.md)).


## Prepare the network infrastructure {#prepare-network}

Before creating a VM:

1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder where you will perform the operations.

1. Make sure that the selected folder contains a network with subnets in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-c` availability zones. To do this, select **{{ vpc-name }}** on the folder page. If the [subnets](../../vpc/operations/subnet-create.md) or [network](../../vpc/operations/network-create.md) you need are not listed, create them.

## Create security groups {#create-security-groups}

{% include [security-groups-note](../../application-load-balancer/_includes_service/security-groups-note.md) %}

[Security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) include rules that let the load balancer receive incoming traffic and redirect it to the VMs so they can receive the traffic.

To create security groups for the load balancer and an instance group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
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
         | Incoming | healthchecks | 30080 | TCP | Load balancer health checks | — |

         1. Select the **Outgoing traffic** or **Incoming traffic** tab.
         1. Click **Add rule**.
         1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
         1. In the **Protocol** field, specify the desired protocol or leave **Any** to allow traffic transmission over any protocol.
         1. In the **Purpose** or **Source** field, select the purpose of the rule:
            * **CIDR**: The rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
            * **Security group**: The rule will apply to the VMs from the current group or the selected security group.
            * **Load balancer health checks** is a rule that allows a load balancer to check the health of VMs.
         1. Click **Save**. Repeat the steps to create all rules from the table.
      1. Click **Save**.

   1. Similarly, create a security group named `alb-vm-sg` for an instance group, with the same network and the following rules:

      | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source type | Source |
      | --- | --- | --- | --- | --- | --- |
      | Incoming | balancer | 80 | TCP | Security group | `alb-sg` |
      | Incoming | ssh | 22 | TCP | CIDR | 0.0.0.0/0 |

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Create an instance group {#create-vms}

Backends of your application are deployed on the VM instance of the [target group](../../application-load-balancer/concepts/target-group.md). The target group will be attached to the load balancer so that requests can be sent to the backend endpoints of your application.

To create an instance group with the minimum configuration:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ compute-name }}**.
   1. Open the **Instance groups** tab and click **Create group**.
   1. Under **Basic parameters**:
      * Name the instance group like `alb-vm-group`.
      * Select a [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete group instances, assign the `editor` role to the service account. All operations in {{ ig-name }} are performed on behalf of the service account.
   1. Under **Allocation**, select three availability zones (`{{ region-id }}-a`, `{{ region-id }}-b` and `{{ region-id }}-c`) to ensure fault tolerance of your hosting.
   1. Under **Instance template**, click **Define** and set up the configuration for a basic instance:
      * Under **Basic parameters**, enter the template **Description**:
      * Under **Image/boot disk selection**, go to the **{{ marketplace-name }}** tab, select the [LEMP](/marketplace/products/yc/lemp) product, and click **Use**.
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

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

It may take several minutes to create an instance group. Once all VMs change their status to `RUNNING`, you can [upload the website files to them](#upload-files).

#### See also

* [{#T}](../../compute/operations/vm-connect/ssh.md)

## Upload the website files {#upload-files}

To test the web server, upload the website files to each VM. For example, you can use the `index.html` file from the [archive](https://{{ s3-storage-host }}/doc-files/index.html.zip).

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

{% list tabs %}

- Management console

   1. Select **{{ alb-name }}** in the folder where the instance group was created.

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

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Create an HTTP router {#create-http-routers-sites}

The backend group should be linked to an [HTTP router](../../application-load-balancer/concepts/http-router.md) that defines HTTP routing rules.

To create an HTTP router and add a route to it:

{% list tabs %}

- Management console

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

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Create an L7 load balancer {#create-alb}

To create a load balancer:

{% list tabs %}

- Management console

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

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Configure the DNS {#configure-dns}

You need to link the domain name you wish to use for your website to the load balancer's IP address. You can use **{{ dns-name }}** to manage your domain.

The instructions below describe how to configure DNS for the `alb-example.com` domain name.

### Add a zone

{% list tabs %}

- Management console

   1. Select **{{ dns-name }}** in the folder where the instance group was created.
   1. Click **Create zone**.
   1. Specify the zone settings:
      * **Zone**: `alb-example.com`. Specify your registered domain.
      * **Type**: **Public**.
      * **Name**: `alb-zone`.

   1. Click **Create**.

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

### Add resource records

Create DNS records in the public zone:

{% list tabs %}

- Management console

   1. Select **{{ alb-name }}**. Find the IP address of the previously created `alb-1` load balancer in the list of load balancers.
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

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Test the fault tolerance {#test-ha}

1. In the [management console]({{ link-console-main }}), select **{{ compute-name }}**.
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

## How to create an infrastructure using {{ TF }} {#terraform}

{% include [terraform-definition](../terraform-definition.md) %}

To deploy an infrastructure to host a fault-tolerant load-balanced website in an instance group via {{ alb-name }} using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

   This tutorial uses [security groups](#create-security-groups). If you don't have access to them, write to support or remove from the configuration file the `yandex_vpc_security_group` section and other mentions of `security_group`.

   {% list tabs %}

   - Ready-made archive

      1. Create a directory for files:
      1. Download the [archive](https://{{ s3-storage-host }}/doc-files/application-load-balancer.zip) (2 KB).
      1. Unpack the archive to the directory. As a result, the `application-load-balancer.tf` configuration file should be added to it.

   - Creating files manually

      1. Create a directory for files:
      1. Create a configuration file named `application-load-balancer.tf` in the directory:

         {% cut "application-load-balancer.tf" %}

         {% include [application-load-balancer-tf-config](../../_includes/web/application-load-balancer-tf-config.md) %}

         {% endcut %}

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

   * [yandex_iam_service_account]({{ tf-provider-link }}/iam_service_account)
   * [yandex_resourcemanager_folder_iam_binding]({{ tf-provider-link }}/resourcemanager_folder_iam_binding)
   * [yandex_vpc_network]({{ tf-provider-link }}/vpc_network)
   * [yandex_vpc_subnet]({{ tf-provider-link }}/vpc_subnet)
   * [yandex_vpc_security_group]({{ tf-provider-link }}/vpc_security_group)
   * [yandex_compute_image]({{ tf-provider-link }}/compute_image)
   * [yandex_compute_instance_group]({{ tf-provider-link }}/compute_instance_group)
   * [yandex_alb_backend_group]({{ tf-provider-link }}/alb_backend_group)
   * [yandex_alb_http_router]({{ tf-provider-link }}/alb_http_router)
   * [yandex_alb_virtual_host]({{ tf-provider-link }}/alb_virtual_host)
   * [yandex_alb_load_balancer]({{ tf-provider-link }}/alb_load_balancer)
   * [yandex_dns_zone]({{ tf-provider-link }}/dns_zone)
   * [yandex_dns_recordset]({{ tf-provider-link }}/dns_recordset)

1. In the `variable` section, enter the value for the `folder_id` variable, that is, the ID of the folder where the resources are created.

1. Under `metadata`, enter your username and the contents of your SSH key. For more information, see [{#T}](../../compute/concepts/vm-metadata.md).

1. Create resources:

   {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

1. [Upload the website files](#upload-files).

1. [Test the fault tolerance](#test-ha).
