# Fault-tolerant website with load balancing by {{ network-load-balancer-full-name }}

Create and set up a website on a [LAMP]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/LAMP){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/LAMP_(software_bundle)){% endif %} ([Linux](https://www.linux.org/), [Apache HTTP Server](https://httpd.apache.org/), [MySQL](https://www.mysql.com/), [PHP](https://www.php.net/)) or LEMP stack (with [Nginx](https://www.nginx.com/) used instead of Apache as its web server) with load balancing from [{{ network-load-balancer-short-name }}](../../network-load-balancer/concepts/index.md) between two availability zones. This protects the website from failures in one of the zones.

1. [Before you start](#before-you-begin).
1. [Prepare the network infrastructure](#prepare-network).
1. [Create an instance group](#create-vms).
1. [Upload the website files](#upload-files).
1. [Create a network load balancer](#create-load-balancer).
1. [Test the fault tolerance](#test-availability).

If you no longer need the website, [delete all its resources](#clear-out).

You can also use a [ready-made config file](#terraform) to deploy an infrastructure to host a fault-tolerant load-balanced site in a VM group via {{ TF }}.

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost of hosting a website includes:

* A fee for the disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using dynamic public IP addresses (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* A fee for network load balancers and traffic balancing (see [{{ network-load-balancer-full-name }} pricing](../../network-load-balancer/pricing.md)).

{% endif %}

## Prepare the network infrastructure {#prepare-network}

Before creating a VM:

1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder where you will perform the operations.

1. Make sure that the selected folder contains a network with subnets in the `{{ region-id }}-a` and `{{ region-id }}-b`availability zones. To do this, select **{{ vpc-name }}** on the folder page. If the [subnets](../../vpc/operations/subnet-create.md) or [network](../../vpc/operations/network-create.md) you need are not listed, create them.

## Create an instance group {#create-vms}

To create an instance group with a pre-installed web server:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ compute-name }}**.
   1. Open the **Instance groups** tab and click **Create group**.
   1. Under **Basic parameters**:
      * Name the instance group like `nlb-vm-group`.
      * Select a [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete group instances, assign the `editor` role to the service account.  All operations in {{ ig-name }} are performed on behalf of the service account.

   1. Under **Allocation**, select three availability zones (`{{ region-id }}-a` and `{{ region-id }}-b`) to ensure fault tolerance of your hosting.
   1. Under **Instance template**, click **Define** and set up the configuration for a basic instance:
      * Under **Basic parameters**, enter the template **Description**:
      * Under **Image/boot disk selection**, open the **Cloud Marketplace** tab and click **Show more**. Choose a product:
         * [LEMP](/marketplace/products/yc/lemp) for Linux, nginx, MySQL, and PHP
         * [LAMP](/marketplace/products/yc/lamp) for Linux, Apache, MySQL, and PHP

         Click **Use**.
      * Under **Disks**, specify:
         * Disk **type**: HDD.
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
   1. Under **Integration with Load Balancer**, select **Create target group** and specify `nlb-tg` as the group name.
   1. Click **Create**.

   It may take several minutes to create an instance group. Once all VMs change their status to `RUNNING`, you can [upload the website files to them](#upload-files).

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

#### See also

* [{#T}](../../compute/operations/vm-connect/ssh.md)

## Upload the website files {#upload-files}

To test the web server, upload the website files to each VM. For example, you can use the `index.html` file from the [archive](https://storage.yandexcloud.net/doc-files/index.html.zip).

Do the following for each VM instance in the [created group](#create-vms):

1. On the **Virtual machines** tab, click on the name of the desired VM in the list. Under **Network**, find the VM's public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM via SSH.
1. Grant your user write access to the directory `/var/www/html`:

   ```bash
   sudo chown -R "$USER":www-data /var/www/html
   ```

1. Upload the website files to the VM via [SCP]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/SCP){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Secure_copy_protocol){% endif %}.

   {% list tabs %}

   - Linux/macOS

      Use the `scp` command-line utility:

      ```bash
      scp -r <path to the file directory> <VM username>@<VM IP address>:/var/www/html
      ```

   - Windows

      Use [WinSCP](https://winscp.net/eng/download.php) to copy the local file directory to `/var/www/html` on the VM.

   {% endlist %}

## Create a network load balancer {#create-load-balancer}

When creating a network load balancer, you need to add a listener that the load balancer will use to receive traffic, attach the target group created together with the instance group, and set up health checks for resources in it.

To create a network load balancer:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open **{{ network-load-balancer-short-name }}**.
   1. Click **Create a network load balancer**.
   1. Name the load balancer, such as `nlb-1`.
   1. Under **Listeners**, click **Add listener** and specify the parameters:
      * **Listener name**: `nlb-listener`.
      * **Port**: `80`.
      * **Target port**: `80`.

   1. Click **Add**.
   1. Under **Target groups**:
      1. Click **Add target group** and choose the [previously created](#create-vms) target group `nlb-tg`. If there's only one target group, it's selected automatically.
      1. Under **Health check**, click **Configure** and edit the parameters:
         * **Name** of the check: `health-check-1`.
         * **Healthy threshold**: The number of successful checks required to consider the VM ready to receive traffic: `5`.
         * **Unhealthy threshold**: The number of failed checks after which no traffic will be routed to the VM: `5`.
      1. Click **Apply**.

   1. Click **Create**.

- {{ TF }}

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

## How to delete created resources {#clear-out}

To shut down the hosting and stop paying for the created resources:

1. [Delete](../../network-load-balancer/operations/load-balancer-delete.md) the `nlb-1` network load balancer.

1. [Delete](../../compute/operations/instance-groups/delete.md) the `nlb-vm-group` instance group.

## How to create an infrastructure using {{ TF }} {#terraform}

{% include [terraform-definition](../terraform-definition.md) %}

To deploy an infrastructure to host a fault-tolerant load-balanced site in a VM group via {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

   {% list tabs %}

   - Ready-made archive

      1. Create a directory for files:
      1. Download the [archive](https://{{ s3-storage-host }}/www.example.com/doc-files/load-balancer.zip) (1 KB).
      1. Unpack the archive to the directory. As a result, the`load-balancer.tf` configuration file will be added to it.

   - Creating files manually

      1. Create a directory for files:
      1. Create the `load-balancer.tf` configuration file in the directory:

         {% cut "load-balancer.tf" %}

         {% include [load-balancer-tf-config](../../_includes/web/load-balancer-tf-config.md) %}

         {% endcut %}

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

   * [yandex_iam_service_account]({{ tf-provider-link }}/iam_service_account)
   * [yandex_resourcemanager_folder_iam_binding]({{ tf-provider-link }}/resourcemanager_folder_iam_binding)
   * [yandex_compute_instance_group]({{ tf-provider-link }}/compute_instance_group)
   * [yandex_lb_network_load_balancer]({{ tf-provider-link }}/lb_network_load_balancer)
   * [yandex_vpc_network]({{ tf-provider-link }}/vpc_network)
   * [yandex_vpc_subnet]({{ tf-provider-link }}/vpc_subnet)

1. In the `variable` section, enter the value for the `folder_id` variable, that is, the ID of the folder where the resources are created.

1. Under `metadata`, enter the metadata for creating a VM instance, as well as the contents of the SSH key. Specify the key in the format `<any_name>:<SSH key contents>`. Regardless of the username specified, the key is assigned to the user set in the LAMP (LEMP) image configuration. In different images, these users differ. For more information, see [{#T}](../../compute/concepts/keys-processed-in-public-images).

1. Under `boot_disk`, specify the ID of a VM [image](../../compute/operations/images-with-pre-installed-software/get-list.md) with a relevant set of components:

   * [LAMP](/marketplace/products/yc/lamp) (Linux, Apache, MySQL, PHP).
   * [LEMP](/marketplace/products/yc/lemp) (Linux, Nginx, MySQL, PHP).

1. Create resources:

   {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

1. [Test the fault tolerance](#test-availability).
