To set up a WordPress website with a {{ MY }} cluster:
1. [Prepare your cloud](#before-you-begin).
1. [Create a VM for WordPress](#create-vm).
1. [Create a {{ MY }} DB cluster](#create-cluster).
1. [Configure Nginx web server](#configure-nginx).
1. [Install WordPress and additional components](#install-wordpress).
1. [Complete WordPress configuration](#configure-wordpress).
1. [Configure the DNS](#configure-dns).
1. [Test the website](#test-site).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/wordpress-mysql/paid-resources.md) %}

## Create a VM for WordPress {#create-vm}

To create a VM for WordPress:

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
   1. In the **{{ ui-key.yacloud.common.name }}** field, enter the VM name: `wp-mysql-tutorial-web`.
   1. Select an [availability zone](../../overview/concepts/geo-scope.md) to place your VM in.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select a [Debian 11](/marketplace/products/yc/debian-11), [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts), or [CentOS 7](/marketplace/products/yc/centos-7) public image.
   1. Under **{{ ui-key.yacloud.compute.group.overview.label_instance-resource }}** on the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab:
      * Choose a [platform](../../compute/concepts/vm-platforms.md).
      * Specify the required number of vCPUs and the amount of RAM:
         * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
         * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
         * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      * Select the [network](../../vpc/concepts/network.md#network) and [subnet](../../vpc/concepts/network.md#subnet) to connect your VM to. If you have no network or subnet, create them directly on the VM creation page.
      * Under **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, keep `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign your VM a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the instance:
      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the username, e.g., `yc-user`.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file.

         You need to create a key pair for the SSH connection yourself. To learn how, see [Connecting to a VM via SSH](../../compute/operations/vm-connect/ssh.md).

      {% note alert %}

      Once created, the VM gets an IP address and a [host name (FQDN)](../../compute/concepts/network.md#hostname) for connections. If you selected `{{ ui-key.yacloud.component.compute.network-select.switch_none }}` in the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, you will not be able to access the VM from the internet.

      {% endnote %}

   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

It may take a few minutes to create a VM. When the VM [status](../../compute/concepts/vm-statuses.md) changes to `RUNNING`, you can proceed to the next step.

Once created, the VM is assigned an IP address and a host name (FQDN). This data can be used for SSH access.

## Create a {{ MY }} DB cluster {#create-cluster}

To create a {{ MY }} DB cluster:

{% list tabs group=instructions %}

- Management console {#console}

   1. On the folder page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_managed-mysql }}**.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field, enter the name: `wp-mysql-tutorial-db-cluster`.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select `s3-c2-m8`.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, enter `10 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**:
      * In the **{{ ui-key.yacloud.mdb.forms.database_field_name }}** field, enter `wp-mysql-tutorial-db`.
      * In the **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** field, enter `wordpress`.
      * In the **{{ ui-key.yacloud.mdb.forms.config_field_password }}** field, enter the password you will use to access the DB.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select the network your cluster will be connected to.


   1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, add two more [hosts](../../managed-mysql/concepts/instance-types.md) in the other availability zones. When creating hosts, do not enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** for them.


   1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.

      In the **default_authentication_plugin** field, select `mysql_native_password` and click **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

Creating a DB cluster may take a few minutes.

## Configure Nginx web server {#configure-nginx}

{% include [configure-nginx](../_tutorials_includes/wordpress-mysql/configure-nginx.md) %}

## Install WordPress and additional components {#install-wordpress}

{% include [install-wordpress](../_tutorials_includes/wordpress-mysql/install-wordpress.md) %}

## Complete WordPress configuration {#configure-wordpress}

{% include [configure-wordpress](../_tutorials_includes/wordpress-mysql/configure-wordpress.md) %}

## Configure the DNS {#configure-dns}

If you have a registered domain name, use the {{ dns-name }} service to manage the domain.

{% include [configure-a-record-and-cname](../_tutorials_includes/configure-a-record-and-cname.md) %}

## Test the website {#test-site}

{% include [test-site](../_tutorials_includes/wordpress-mysql/test-site.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../../dns/operations/zone-delete.md) the DNS zone.
1. [Delete](../../managed-mysql/operations/cluster-delete.md) the {{ MY }} cluster.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.

If you reserved a static public IP address for the VM, [delete it](../../vpc/operations/address-delete.md).
