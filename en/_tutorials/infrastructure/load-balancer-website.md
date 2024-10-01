# Fault-tolerant website with load balancing with {{ network-load-balancer-full-name }}


Create and set up a website on a [LAMP](https://en.wikipedia.org/wiki/LAMP_(software_bundle)) ([Linux](https://www.linux.org/), [Apache HTTP Server](https://httpd.apache.org/), [{{ MY }}](https://www.mysql.com/), [PHP](https://www.php.net/)) or LEMP stack (Apache web server is replaced by [Nginx](https://www.nginx.com/)) with load balancing with [{{ network-load-balancer-name }}](../../network-load-balancer/) between two [availability zones](../../overview/concepts/geo-scope.md) and fault tolerance in one of the zones.
1. [Prepare your cloud](#before-you-begin).
1. [Prepare the network infrastructure](#prepare-network).
1. [Create an instance group](#create-vms).
1. [Upload the website files](#upload-files).
1. [Create a network load balancer](#create-load-balancer).
1. [Test the fault tolerance](#test-availability).

If you no longer need the website, [delete all its resources](#clear-out).

You can also deploy the infrastructure to host a load-balanced fault-tolerant website in an [instance group](../../compute/concepts/instance-groups/index.md) via {{ TF }} using a [ready-made configuration file](#terraform).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of hosting a website includes:
* Fee for [disks](../../compute/concepts/disk.md) and continuously running [VMs](../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for [network load balancers](../../network-load-balancer/concepts/index.md) and traffic balancing (see [{{ network-load-balancer-name }} pricing](../../network-load-balancer/pricing.md)).

## Prepare the network infrastructure {#prepare-network}

Before creating a VM:
1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to perform your steps in.
1. Make sure that the selected folder contains a [network](../../vpc/concepts/network.md#network) with [subnets](../../vpc/concepts/network.md#subnet) in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones. To do this, select **{{ vpc-name }}** on the folder page. If the [subnets](../../vpc/operations/subnet-create.md) or [network](../../vpc/operations/network-create.md) you need are not listed, create them.

## Create an instance group {#create-vms}

To create an instance group with a pre-installed web server:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ compute-name }}**.
   1. Open the **Instance groups** tab and click **Create group**.
   1. Under **Basic parameters**:
      * Give your instance group a name, such as `nlb-vm-group`.
      * Select a [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete instances in the instance group, assign the `editor` [role](../../iam/concepts/access-control/roles.md) to the service account. By default, all operations with instance groups are performed on behalf of the service account.
   1. Under **Allocation**, select three availability zones (`{{ region-id }}-a` and `{{ region-id }}-b`) to ensure fault tolerance of your hosting.
   1. Under **Instance template**, click **Define** and set up the configuration for a basic instance:
      * Under **Basic parameters**, enter the [template](../../compute/concepts/instance-groups/instance-template.md) **Description**.
      * Under **Image/boot disk selection**, open the **{{ marketplace-full-name }}** tab and click **Show more**. Choose a product:
         * [LEMP](/marketplace/products/yc/lemp) for Linux, Nginx, {{ MY }}, and PHP.
         * [LAMP](/marketplace/products/yc/lamp) for Linux, Apache, {{ MY }}, and PHP.

         Click **Use**.
      * Under **Disks**, specify:
         * [Disk](../../compute/concepts/disk.md) **type**: HDD
         * **Size**: 3 GB
      * Under **Computing resources**, specify:
         * **Platform**: Intel Ice Lake
         * **vCPU**: 2
         * **Guaranteed vCPU share**: 20%
         * **RAM**: 1 GB
      * Under **Network settings**:
         * Select a cloud network and its subnets.
         * In the **Public address** field, select **Auto**.
      * Under **Access**, specify the information required to access the VM:
         * In the **Service account** field, select the service account to link the VM to.
         * Enter the username in the **Login** field.
         * In the **SSH key** field, paste the contents of the public key file.

         To establish an SSH connection, you need to create a key pair. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
      * Click **Save**.
   1. Under **Scaling**, enter the **Size** of the instance group: 2.
   1. Under **Integration with {{ network-load-balancer-name }}**, select **Create target group** and specify `nlb-tg` as the group name.
   1. Click **Create**.

   It may take a few minutes to create an instance group. As soon as all VMs change their [status](../../compute/concepts/vm-statuses.md) to `RUNNING`, you can [upload the website files to them](#upload-files).

- {{ TF }} {#tf}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

#### See also

* [{#T}](../../compute/operations/vm-connect/ssh.md).

## Upload the website files {#upload-files}

To test the web server, upload the website files to each VM. For example, you can use the `index.html` file from [this archive](https://{{ s3-storage-host }}/doc-files/index.html.zip).

For each VM in the [created group](#create-vms), do the following:
1. On the **Virtual machines** tab, click the name of the VM in the list. Under **Network**, find the VM's public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM via SSH.
1. Grant your user write access to the `/var/www/html` directory:

   ```bash
   sudo chown -R "$USER":www-data /var/www/html
   ```

1. Upload the website files to the VM via [SCP](https://en.wikipedia.org/wiki/Secure_copy_protocol).

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

      Use the `scp` command-line utility:

      ```bash
      scp -r <path_to_file_directory> <VM_username>@<VM_IP_address>:/var/www/html
      ```

   - Windows {#windows}

      Use [WinSCP](https://winscp.net/eng/download.php) to copy the local file directory to `/var/www/html` on the VM.

   {% endlist %}

## Create a network load balancer {#create-load-balancer}

When creating a network load balancer, you need to add a [listener](../../network-load-balancer/concepts/listener.md) that the load balancer will use to receive traffic, attach the [target group](../../network-load-balancer/concepts/target-resources.md) created together with the instance group, and configure resource health checks in it.

To create a network load balancer:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), open **{{ network-load-balancer-short-name }}**.
   1. Click **Create a network load balancer**.
   1. Name the load balancer, e.g., `nlb-1`.
   1. Under **Listeners**, click **Add listener** and specify the parameters:
      * **Listener name**: `nlb-listener`
      * **Port**: `80`
      * **Target port**: `80`
   1. Click **Add**.
   1. Under **Target groups**:
      1. Click **Add target group** and choose the [previously created](#create-vms) `nlb-tg` target group. If there is only one target group, it is selected automatically.
      1. Under **Health check**, click **Configure** and edit the parameters:
         * **Name** of the check: `health-check-1`.
         * **Healthy threshold**: Number of successful checks required to consider the VM ready to receive traffic: `5`.
         * **Unhealthy threshold**: Number of failed checks after which no traffic will be routed to the VM: `5`.
      1. Click **Apply**.
   1. Click **Create**.

- {{ TF }} {#tf}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Test the fault tolerance {#test-availability}

1. In the [management console]({{ link-console-main }}), select **{{ compute-name }}**.
1. Go to the page of the VM from the previously created group. Under **Network**, find the VM's public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM via SSH.
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

## How to delete the resources you created {#clear-out}

To shut down the hosting and stop paying for the created resources:
1. [Delete](../../network-load-balancer/operations/load-balancer-delete.md) the `nlb-1` network load balancer.
1. [Delete](../../compute/operations/instance-groups/delete.md) `nlb-vm-group`.

## How to create an infrastructure using {{ TF }} {#terraform}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To host a fault-tolerant website in a VM group with load balancing using {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

   {% list tabs group=infrastructure_description %}

   - Ready-made archive {#ready}

      1. Create a directory for files.
      1. Download the [archive](https://{{ s3-storage-host }}/doc-files/load-balancer.zip) (2 KB).
      1. Unpack the archive to the directory. The `load-balancer.tf` configuration file will be added to it.

   - Manually {#manual}

      1. Create a directory for files.
      1. Create the `load-balancer.tf` configuration file in the directory:

         {% cut "load-balancer.tf" %}

         {% include [load-balancer-tf-config](../../_includes/web/load-balancer-tf-config.md) %}

         {% endcut %}

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:
   * [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account)
   * [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member)
   * [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group)
   * [yandex_lb_network_load_balancer]({{ tf-provider-resources-link }}/lb_network_load_balancer)
   * [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
   * [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
1. In the `variable` section, enter the value for the `folder_id` variable, i.e., the ID of the folder where the resources are created.
1. Under `metadata`, specify the [metadata](../../compute/concepts/vm-metadata.md) for creating a VM and the contents of the SSH key. Specify the key in `<any_name>:<SSH_key_contents>` format. Regardless of the username specified, the key is assigned to the user set in the LAMP (LEMP) image configuration. Such users vary depending on an image. For more information, see [{#T}](../../compute/concepts/vm-metadata.md#keys-processed-in-public-images).
1. Under `boot_disk`, specify the ID of a VM [image](../../compute/operations/images-with-pre-installed-software/get-list.md) with a relevant set of components:
   * [LAMP](/marketplace/products/yc/lamp) (Linux, Apache, {{ MY }}, PHP)
   * [LEMP](/marketplace/products/yc/lemp) (Linux, Nginx, {{ MY }}, PHP)
1. Create resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Test the fault tolerance](#test-availability).