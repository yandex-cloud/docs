# Website on LAMP or LEMP stack

[LAMP](https://en.wikipedia.org/wiki/LAMP_(software_bundle)) ([Linux](https://www.linux.org/), [Apache HTTP Server](https://httpd.apache.org/), [MySQL](https://www.mysql.com/), [PHP](https://www.php.net/)) and LEMP (its variation where Apache is replaced with [Nginx](https://www.nginx.com/)) are popular sets of components for deploying web applications and dynamic websites.

In this tutorial, you will learn to deploy LAMP (LEMP) in the {{ yandex-cloud }} infrastructure. At the end, you will launch a VM running your website's web server.

To set up a LAMP or LEMP-based website:
1. [Prepare your cloud](#before-you-begin).
1. [Create a cloud network](#create-network).
1. [Create a security group](#create-security-groups).
1. [Create a VM with a pre-installed web server](#create-vm).
1. [Upload the website files](#upload-files).
1. [Configure the DNS](#configure-dns).
1. [Check that the website is running](#test-site).

If you no longer need the website, [delete all its resources](#clear-out).

You can also deploy an infrastructure for a LAMP web server or a LEMP site in {{ TF }} using a [ready-made configuration file](#terraform).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost for maintaining a LAMP server includes:
* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for using DNS (see [{{ dns-full-name }} pricing](../../dns/pricing.md)).


## Create a cloud network {#create-network}

All resources you have created in the tutorial belong to the same [cloud network](../../vpc/concepts/network.md).

To create a network:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
   1. Click **Create network**.
   1. Specify the **Name** of the network: `web-network`.
   1. In the **Advanced** field, select **Create subnets**.
   1. Click **Create network**.

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Create a security group {#create-security-groups}

{% note info %}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

{% endnote %}

[Security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) include rules that allow accessing your VMs from the internet. In this tutorial, you will create a security group called `sg-web`.

To create a security group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
   1. Open the **Security groups** tab.
   1. Create a security group for the load balancer:

      1. Click **Create group**.
      1. Enter the **Name** of the group: `sg-web`.
      1. Select the **Network**: `web-network`.
      1. Under **Rules**, create the following rules using the instructions below the table:

         | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source/<br/>destination type | Source /<br/>destination |
         | --- | --- | --- | --- | --- | --- |
         | Outgoing | any | All | Any | CIDR | 0.0.0.0/0 |
         | Incoming | ext-http | 80 | TCP | CIDR | 0.0.0.0/0 |
         | Incoming | ext-https | 443 | TCP | CIDR | 0.0.0.0/0 |

         1. Select the **Outgoing traffic** or **Incoming traffic** tab.
         1. Click **Add rule**.
         1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
         1. In the **Protocol** field, specify the desired protocol or leave **Any** to allow traffic transmission over any protocol.
         1. In the **Purpose** or **Source** field, select the purpose of the rule:

            * **CIDR**: Rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
            * **Security group**: Rule will apply to the VMs from the current group or the selected security group.

         1. Click **Save**. Repeat the steps to create all rules from the table.

      1. Click **Save**.

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}


## Create a VM with a pre-installed web server {#create-vm}

{% list tabs %}

- Management console

   1. On the [management console]({{ link-console-main }}) folder page, click **Create resource** and select **Virtual machine**.
   1. In the **Name** field, enter `lamp-vm` or `lemp-vm` as the VM name.

      {% include [name-format](../../_includes/name-format.md) %}

   1. Select an [availability zone](../../overview/concepts/geo-scope.md) to place the VM in. If you do not know which availability zone you need, leave the default one.
   1. Under **Image/boot disk selection**, go to the **{{ marketplace-name }}** tab and select a VM image with the desired set of components:
      * [LAMP](/marketplace/products/yc/lamp) for Linux, Apache, MySQL, and PHP
      * [LEMP](/marketplace/products/yc/lemp) for Linux, Nginx, MySQL, and PHP.

         For static websites, we recommend using LEMP.
   1. Under **Computing resources**:
      * Choose a VM [platform](../../compute/concepts/vm-platforms.md).
      * Specify the required number of vCPUs and the amount of RAM.

      The minimum configuration is enough for functional website testing:
      * **Platform**: Intel Ice Lake.
      * **Guaranteed vCPU share**: 20%.
      * **vCPU**: 2.
      * **RAM**: 1 GB.
   1. In the **Network settings** section, select the `web-network` network and the subnet to connect the VM to.
   1. Under **Public address**, keep **Auto** to assign your VM a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.
   1. Enter the VM access information:
      * Enter the username in the **Login** field.
      * In the **SSH key** field, paste the contents of the public key file.

         You will need to create a key pair for the SSH connection yourself, see [{#T}](../../compute/operations/vm-connect/ssh.md).

      {% note alert %}

      Once created, the VM will be assigned an IP address and a host name (FQDN) for connections. If you selected **No address** in the **Public address** field, you won't be able to access the VM from the internet.

      {% endnote %}

   1. Click **Create VM**.

      It may take a few minutes to create the VM. When the VM status changes to `RUNNING`, you can [upload the website files](#upload-files).

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Upload the website files {#upload-files}

To test the web server, upload the `index.html` file to the VM. You can use a [test file](https://{{ s3-storage-host }}/doc-files/index.html.zip). Download and unzip the archive.
1. Under **Network** on the VM page in the [management console]({{ link-console-main }}) find the VM's public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM via SSH.
1. Grant your user write access to the directory `/var/www/html`:

   ```bash
   sudo chown -R "$USER":www-data /var/www/html
   ```

1. Upload the website files to the VM via [SCP](https://en.wikipedia.org/wiki/Secure_copy_protocol).

   {% list tabs %}

   - Linux/macOS

      Use the `scp` command-line utility:

      ```bash
      scp -r <path_to_file_directory> <VM_username>@<VM_IP_address>:/var/www/html
      ```

   - Windows

      Use [WinSCP](https://winscp.net/eng/download.php) to copy the local file directory to `/var/www/html` on the VM.

   {% endlist %}

## Configure the DNS (if you have a domain name) {#configure-dns}

If you have a registered domain name, use the {{ dns-name }} service to manage the domain.

You can also configure the DNS via {{ TF }}. For more information, see [How to create an infrastructure using {{ TF }}](#terraform).

{% include [configure-a-record-and-cname](../../_tutorials/web/configure-a-record-and-cname.md) %}

## Check that the website is running {#test-site}

To check that the site is up, enter its IP address or domain name in your browser:
* `http://<public_IP_of_VM>`.
* `http://www.example.com`.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
* [Delete the static public IP](../../vpc/operations/address-delete.md) if you reserved one specifically for this VM.
* Delete the [DNS zone](../../dns/operations/zone-delete.md) if you set up the DNS.


## How to create an infrastructure using {{ TF }} {#terraform}

{% include [terraform-definition](../terraform-definition.md) %}

To use {{ TF }} to deploy a LAMP or LEMP web server for your site running on a VM:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) and [get the authentication data](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).
1. Specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

   {% include [sg-note-tf](../../_includes/vpc/sg-note-tf.md) %}

   {% list tabs %}

   - Ready-made archive

      1. Create a directory for files:
      1. Download the [archive](https://{{ s3-storage-host }}/doc-files/lamp-lemp.zip) (1 KB).
      1. Unpack the archive to the directory. As a result, it should contain the `lamp-lemp.tf` configuration file and the `lamp-lemp.auto.tfvars` file with user data.

   - Creating files manually

      1. Create a directory for the file with the infrastructure description.
      1. Create the `lamp-lemp.tf` configuration file in the directory:

         {% cut "lamp-lemp.tf" %}

         {% include [lamp-lemp-tf-config](../../_includes/web/lamp-lemp-tf-config.md) %}

         {% endcut %}

      1. In the directory, create a `lamp-lemp.auto.tfvars` file with user data:

         {% cut "lamp-lemp.auto.tfvars" %}

         {% include [joomla-postgresql-tf-config](../../_includes/web/lamp-lemp-tf-variables.md) %}

         {% endcut %}

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

   * [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
   * [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
   * [yandex_vpc_security_group]({{ tf-provider-resources-link }}/yandex_vpc_security_group)
   * [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)
   * [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone)
   * [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset)

1. In the `lamp-lemp.auto.tfvars` file, set the user-defined parameters:
   * `zone`: [Availability zone](../../overview/concepts/geo-scope.md) that will host your VM.
   * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md).
   * `family_id`: Specify the family of a VM image with a relevant set of components:
      * `lamp`: [LAMP](/marketplace/products/yc/lamp) (Linux, Apache, MySQL, and PHP).
      * `lemp`: [LEMP](/marketplace/products/yc/lemp) (Linux, Nginx, MySQL, and PHP).
   * `vm_user`: VM username.
   * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. For details, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `dns_zone`: [DNS zone](../../dns/concepts/dns-zone.md). Specify your registered domain with a period at the end, e.g., `example.com.`.

1. Create resources:

   {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

1. [Check that the website is running](#test-site).
