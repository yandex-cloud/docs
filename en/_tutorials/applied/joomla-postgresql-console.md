1. [Prepare your cloud](#before-you-begin).
1. [Create a VM for Joomla](#create-vm).
1. [Create a {{ PG }} DB cluster](#create-cluster).
1. [Install Joomla and additional components](#install).
1. [Configure the Apache2 web server](#configure-apache2).
1. [Configure Joomla](#configure-joomla).
1. [Upload the website files](#upload-files).
1. [Configure the DNS](#configure-dns).
1. [Test the website](#test-site).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Make sure the selected [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) contains a [network](../../vpc/concepts/network.md#network) with [subnets](../../vpc/concepts/network.md#subnet) in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d` [availability zones](../../overview/concepts/geo-scope.md). To do this, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** on the folder page. If the list contains a network, click its name to see the list of subnets. If the subnets or network you need are not listed, [create them](../../vpc/quickstart.md).

### Required paid resources {#paid-resources}

{% include [joomla-postgresql-paid-resources](../_tutorials_includes/joomla-postgresql-paid-resources.md) %}

## Create a VM for Joomla {#create-vm}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
   1. In the **{{ ui-key.yacloud.common.name }}** field, enter the VM name: `joomla-pg-tutorial-web`.
   1. Select an availability zone to place your VM in.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select a public [CentOS Stream](/marketplace/products/yc/centos-stream-8) image.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}** on the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab:
      * Choose a [platform](../../compute/concepts/vm-platforms.md).
      * Specify the required number of vCPUs and the amount of RAM.

      This minimum configuration is enough for functional testing:
      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`
   1. In **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the subnet to connect the VM to once it is created.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the instance:
      * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file.

         You will need to create a key pair for the SSH connection yourself. To create keys, use third-party tools, such as `ssh-keygen` (on Linux or macOS) or [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) (on Windows).
   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   It may take a few minutes to create a VM.

   Once created, the VM is assigned an IP address and a [host name (FQDN)](../../compute/concepts/network.md#hostname). This data can be used for SSH access.

{% endlist %}

## Create a {{ PG }} DB cluster {#create-cluster}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the folder page, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_managed-postgresql }}**.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field, enter the cluster name: `joomla-pg-tutorial-db-cluster`.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select the appropriate [host](../../managed-postgresql/concepts/instance-types.md) class.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, enter `10 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify:
      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `joomla-pg-tutorial-db`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `joomla`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: Password you will use to access the DB.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the network your VM is connected to.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, add two more hosts in the other availability zones. When creating hosts, do not enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** for them.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

   Creating a DB cluster may take a few minutes.

{% endlist %}

## Install Joomla and additional components {#install}

{% include [joomla-postgresql-install](../_tutorials_includes/joomla-postgresql-install.md) %}

## Configure the Apache2 web server {#configure-apache2}

{% include [joomla-postgresql-configure-apache2](../_tutorials_includes/joomla-postgresql-configure-apache2.md) %}

## Configure Joomla {#configure-joomla}

{% include [joomla-postgresql-configure-joomla](../_tutorials_includes/joomla-postgresql-configure-joomla.md) %}

## Upload the website files {#upload-files}

{% include [joomla-postgresql-upload-files.md](../_tutorials_includes/joomla-postgresql-upload-files.md) %}

## Configure the DNS {#configure-dns}

You need to link the domain name you want to use for your website to the created `joomla-pg-tutorial-web` VM. You can use [{{ dns-full-name }}](../../dns/) to manage your domain.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [configure-a-record-and-cname](../../_tutorials/_tutorials_includes/configure-a-record-and-cname.md) %}

{% endlist %}

## Test the website {#test-site}

{% include [joomla-postgresql-test-site](../_tutorials_includes/joomla-postgresql-test-site.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.
* [Delete](../../vpc/operations/address-delete.md) the static public IP if you reserved one.
* [Delete](../../managed-postgresql/operations/cluster-delete.md) the {{ mpg-name }} cluster.
* If you used {{ dns-name }}, [delete](../../dns/operations/resource-record-delete.md) the DNS records and [delete](../../dns/operations/zone-delete.md) the DNS zone.

