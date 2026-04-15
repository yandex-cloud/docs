1. [Get your cloud ready](#before-you-begin).
1. [Create your infrastructure](#deploy).
1. [Set up your VM environment](#env-install).
1. [Configure Joomla](#configure-joomla).
1. [Test the website](#test-site).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [before-you-begin](../_tutorials_includes/joomla-postgresql/joomla-postgresql-paid-resources.md) %}


## Create your infrastructure {#deploy}

{% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:
1. [Install](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) {{ TF }} and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Set up your infrastructure description file:

   {% list tabs group=infrastructure_description %}

   - Ready-made configuration {#ready}

     1. Clone the repository with configuration files.

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-joomla-postgresql
         ```

     1. Navigate to the repository directory. It should now contain the following files:

         * `joomla-postgresql-terraform.tf`: New infrastructure configuration.
         * `joomla-postgresql-terraform.auto.tfvars`: User data file.

   - Manually {#manual}

     1. Create a folder for the infrastructure description file.
     1. Create a configuration file named `joomla-postgresql-terraform.tf` in the folder:

         {% cut "joomla-postgresql-terraform.tf" %}

         {% include [joomla-postgresql-tf-config](../../_includes/web/joomla-postgresql-tf-config.md) %}

         {% endcut %}

     1. In the folder, create a user data file named `joomla-postgresql-terraform.auto.tfvars`:

         {% cut "joomla-postgresql-terraform.auto.tfvars" %}

         {% include [joomla-postgresql-tf-config](../../_includes/web/joomla-postgresql-tf-variables.md) %}

         {% endcut %}

   {% endlist %}

   For more information about {{ TF }} resource properties, see the relevant provider guides:

   * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Security groups](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [VM image](../../compute/concepts/image.md): [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
   * [Disk](../../compute/concepts/disk.md): [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
   * [VM instance](../../compute/concepts/vm.md): [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
   * [{{ PG }} cluster](../../managed-postgresql/concepts/index.md): [yandex_mdb_postgresql_cluster]({{ tf-provider-resources-link }}/mdb_postgresql_cluster).
   * [{{ PG }} database](../../managed-postgresql/): [yandex_mdb_postgresql_database]({{ tf-provider-resources-link }}/mdb_postgresql_database).
   * [Database user](../../managed-postgresql/operations/cluster-users.md): [yandex_mdb_postgresql_user]({{ tf-provider-resources-link }}/mdb_postgresql_user).
   * [DNS zone](../../dns/concepts/dns-zone.md): [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
   * [DNS resource record](../../dns/concepts/resource-record.md): [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).
   * [TLS certificate](../../certificate-manager/concepts/managed-certificate.md): [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate).

1. In the `joomla-postgresql-terraform.auto.tfvars` file, set the following user-defined properties:
   * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
   * `ssh_key_path`: Path to the public SSH key required to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `db_password`: DB password (8 to 128 characters).
   * `domain_name`: Domain name. Specify your registered domain name delegated to {{ dns-full-name }}, e.g., `example.com`.

       To use domain names in the public DNS zone, you need to delegate it to authoritative name servers. Specify the addresses of the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` servers in your account on your domain name registrar's website.
1. Create the resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

After creating the infrastructure, [install Joomla](#env-install).

## Set up your VM environment {#env-install}

{% include [joomla-postgresql-install-and-configure](../_tutorials_includes/joomla-postgresql/joomla-postgresql-install-and-configure.md) %}

## Configure Joomla {#configure-joomla}

{% include [joomla-postgresql-setup-joomla](../_tutorials_includes/joomla-postgresql/joomla-postgresql-setup-joomla.md) %}

## Test the website {#test-site}

{% include [joomla-postgresql-test-site](../_tutorials_includes/joomla-postgresql/joomla-postgresql-test-site.md) %}

## How to delete the resources you created {#clear-out}

To shut down the website and stop paying for the resources you created:

1. Open the `joomla-postgresql-terraform.tf` configuration file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
