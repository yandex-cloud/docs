To set up a WordPress website with a {{ MY }} cluster:
1. [Prepare your cloud](#before-you-begin).
1. [Create an infrastructure](#deploy).
1. [Configure Nginx web server](#configure-nginx).
1. [Install WordPress and additional components](#install-wordpress).
1. [Complete WordPress configuration](#configure-wordpress).
1. [Test the website](#test-site).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/wordpress-mysql/paid-resources.md) %}

## Create an infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

   {% list tabs group=infrastructure_description %}

   - Ready-made archive {#ready}

      1. Create a directory for files.
      1. Download the [archive](https://{{ s3-storage-host }}/www.example.com/doc-files/wordpress-mysql.zip) (1 KB).
      1. Unpack the archive to the directory. The `wordpress-mysql.tf` file should be added to the directory.

   - Manually {#manual}

      1. Create a directory for files.
      1. Create the `wordpress.tf` configuration file in the directory:

         {% cut "wordpress-mysql.tf" %}

         {% include [wordpress-mysql-tf-config](../../_includes/web/wordpress-mysql-tf-config.md) %}

         {% endcut %}

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

   * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
   * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
   * [Security groups](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group)
   * [VM instance](../../compute/concepts/vm.md): [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)
   * [{{ MY }} cluster](../../managed-mysql/concepts/index.md): [yandex_mdb_mysql_cluster]({{ tf-provider-resources-link }}/mdb_mysql_cluster)
   * [{{ PG }} DB](../../managed-mysql/): [yandex_mdb_mysql_database]({{ tf-provider-resources-link }}/mdb_mysql_database)
   * [DB user](../../managed-mysql/concepts/user-rights.md) — [yandex_mdb_mysql_user]({{ tf-provider-resources-link }}/mdb_mysql_user)
   * [DNS zone](../../dns/concepts/dns-zone.md): [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone)
   * [DNS resource record](../../dns/concepts/resource-record.md): [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset)

1. Under `metadata`, enter the [metadata](../../compute/concepts/vm-metadata.md) for creating a VM instance: `<username>:<SSH_key_contents>`. Regardless of the username specified, the key is assigned to the user set in the image configuration. Such users vary depending on an image. For more information, see [{#T}](../../compute/concepts/vm-metadata.md#keys-processed-in-public-images).
1. Under `boot_disk`, specify the ID of a VM [image](../../compute/operations/images-with-pre-installed-software/get-list.md) with a relevant set of components:
   * [Debian 11](/marketplace/products/yc/debian-11).
   * [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts)
   * [CentOS 7](/marketplace/products/yc/centos-7)
1. Create resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

After creating the infrastructure, [configure the Nginx web server](#configure-nginx).
## Configure the Nginx web server {#configure-nginx}

{% include [configure-nginx](../_tutorials_includes/wordpress-mysql/configure-nginx.md) %}

## Install WordPress and additional components {#install-wordpress}

{% include [install-wordpress](../_tutorials_includes/wordpress-mysql/install-wordpress.md) %}

## Complete WordPress configuration {#configure-wordpress}

{% include [configure-wordpress](../_tutorials_includes/wordpress-mysql/configure-wordpress.md) %}

## Test the website {#test-site}

{% include [test-site](../_tutorials_includes/wordpress-mysql/test-site.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `single-node-file-server.tf` configuration file and delete from it the description of the infrastructure you created.
1. Apply the changes:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
