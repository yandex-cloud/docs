1. [Prepare your cloud](#before-you-begin).
1. [Create an infrastructure](#deploy).
1. [Install Joomla and additional components](#install).
1. [Configure the Apache2 web server](#configure-apache2).
1. [Configure Joomla](#configure-joomla).
1. [Upload the website files](#upload-files).
1. [Create an infrastructure](#deploy).
1. [Check that the website is running](#test-site).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Make sure the selected [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) contains a [network](../../vpc/concepts/network.md#network) with [subnets](../../vpc/concepts/network.md#subnet) in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d` [availability zones](../../overview/concepts/geo-scope.md). To do this, select **{{ vpc-name }}** on the folder page. If the list contains a network, click its name to see the list of subnets. If the subnets or network you need are not listed, [create them](../../vpc/quickstart.md).

### Required paid resources {#paid-resources}

{% include [before-you-begin](../_tutorials_includes/joomla-postgresql-paid-resources.md) %}

## Create an infrastructure {#deploy}

{% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:
1. [Install](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) {{ TF }} and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare a file with the infrastructure description:

   {% list tabs group=infrastructure_description %}

   - Ready-made archive {#ready}

      1. Create a directory for the file with the infrastructure description.
      1. Download the [archive](https://{{ s3-storage-host }}/doc-files/joomla-postgresql-terraform.zip) (2 KB).
      1. Unpack the archive to the directory. As a result, it should contain the `joomla-postgresql-terraform.tf` configuration file and the `joomla-postgresql-terraform.auto.tfvars` file with user data.

   - Manually {#manual}

      1. Create a directory for the file with the infrastructure description.
      1. In the directory, create a configuration file named `joomla-postgresql-terraform.tf`:

         {% cut "joomla-postgresql-terraform.tf" %}

         {% include [joomla-postgresql-tf-config](../../_includes/web/joomla-postgresql-tf-config.md) %}

         {% endcut %}

      1. In the directory, create the `joomla-postgresql-terraform.auto.tfvars` file with user data:

         {% cut "joomla-postgresql-terraform.auto.tfvars" %}

         {% include [joomla-postgresql-tf-config](../../_includes/web/joomla-postgresql-tf-variables.md) %}

         {% endcut %}

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

   * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
   * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
   * [Security groups](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group)
   * [VM image](../../compute/concepts/image.md): [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image)
   * [Disk](../../compute/concepts/disk.md): [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk)
   * [VM instance](../../compute/concepts/vm.md): [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).yandex_mdb_postgresql_cluster
   * [{{ PG }} cluster](../../managed-postgresql/concepts/index.md): [yandex_mdb_postgresql_cluster]({{ tf-provider-resources-link }}/mdb_postgresql_cluster)
   * [{{ PG }} database](../../managed-postgresql/): [yandex_mdb_postgresql_database]({{ tf-provider-resources-link }}/mdb_postgresql_database)
   * [Database user](../../managed-postgresql/operations/cluster-users.md): [yandex_mdb_postgresql_user]({{ tf-provider-resources-link }}/mdb_postgresql_user)
   * [DNS zone](../../dns/concepts/dns-zone.md): [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone)
   * [DNS resource record](../../dns/concepts/resource-record.md): [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset)

1. In the `joomla-postgresql-terraform.auto.tfvars` file, set the user-defined parameters:
   * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
   * `vm_user`: VM user name.
   * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `db_user`: Database username, e.g., `joomla`.
* `db_password`: Password for the database. The password must be 8 to 128 characters long.
   * `dns_zone`: [DNS zone](../../dns/concepts/dns-zone.md). Specify your registered domain, e.g., `example.com.`.
   * `dns_recordset_name`: Name of the [record set](../../dns/concepts/resource-record.md), e.g., `example-recordset`.
      To get access to public zone domain names, you need to delegate the domain. Specify the addresses of the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` servers in your personal dashboard at your registrar.
1. Create resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

After creating the infrastructure, [install Joomla](#install).

## Install Joomla and additional components {#install}

{% include [joomla-postgresql-install](../_tutorials_includes/joomla-postgresql-install.md) %}

## Configure the Apache2 web server {#configure-apache2}

{% include [joomla-postgresql-configure-apache2](../_tutorials_includes/joomla-postgresql-configure-apache2.md) %}

## Configure Joomla {#configure-joomla}

{% include [joomla-postgresql-configure-joomla](../_tutorials_includes/joomla-postgresql-configure-joomla.md) %}

## Upload the website files {#upload-files}

{% include [joomla-postgresql-upload-files](../_tutorials_includes/joomla-postgresql-upload-files.md) %}

## Check that the website is running {#test-site}

{% include [joomla-postgresql-test-site](../_tutorials_includes/joomla-postgresql-test-site.md) %}

## How to delete the resources you created {#clear-out}

To shut down the website and stop paying for the resources you created:

1. Open the `joomla-postgresql-terraform.tf` configuration file and delete from it the description of the infrastructure you created.
1. Apply the changes:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
