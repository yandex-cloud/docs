1. [Prepare your cloud](#before-you-begin).
1. [Create an infrastructure](#deploy).
1. [Configure OpenCart](#configure-opencart).

If you no longer need the resources you created, [delete them](#clear-out).


## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [opencart-paid-resources](../_tutorials_includes/opencart-paid-resources.md) %}

## Create an infrastructure {#deploy}

{% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

To host your OpenCart online store via {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).

1. Prepare files with the infrastructure description:

   {% list tabs %}

   - Ready-made configuration

      1. Clone the repository with configuration files:

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-opencart-store.git
         ```

      1. Go to the directory with the repository. Make sure it contains the following files:
         * `opencart.tf`: New infrastructure configuration.
         * `opencart.auto.tfvars`: User data file.

   - Creating files manually

      1. Create a directory for configuration files.

      1. In the directory, create:

         1. `opencart.tf` configuration file:

            {% cut "opencart.tf" %}

            {% include [opencart-tf-config](../../_includes/internet-store/opencart-tf-config.md) %}

            {% endcut %}

         1. `opencart.auto.tfvars` user data file:

            {% cut "opencart.auto.tfvars" %}

            {% include [opencart-tf-variables](../../_includes/internet-store/opencart-tf-variables.md) %}

            {% endcut %}

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

   * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-link }}/vpc_network)
   * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-link }}/vpc_subnet)
   * [Security groups](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-link }}/vpc_security_group)
   * [VM image](../../compute/concepts/image.md): [yandex_compute_image]({{ tf-provider-link }}/compute_image)
   * [VM instance](../../compute/concepts/vm.md): [yandex_compute_instance]({{ tf-provider-link }}/compute_instance)
   * [{{ MY }} cluster](../../managed-mysql/concepts/index.md): [yandex_mdb_mysql_cluster]({{ tf-provider-link }}/mdb_mysql_cluster)
   * {{ MY }} database: [yandex_mdb_mysql_database]({{ tf-provider-link }}/mdb_mysql_database)
   * {{ MY }} user: [yandex_mdb_mysql_user]({{ tf-provider-link }}/mdb_mysql_user)

1. In the `opencart.auto.tfvars` file, set the user-defined parameters:

   * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
   * `vm_user`: VM user name.
   * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `db_user`: DB username, e.g., `user1`.
   * `db_password`: Password for the database. Password length must be between 8 and 128 characters.

1. Create resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Get the public IP address of the VM](../../compute/operations/instance-groups/get-info.md): you will need it later to [configure OpenCart](#configure-opencart).

After creating the infrastructure, [configure OpenCart](#configure-opencart).

## Configure OpenCart {#configure-opencart}

{% include [opencart-configure](../_tutorials_includes/opencart-configure.md) %}

## Delete the resources you created {#clear-out}

How to delete the resources you created:

1. Open the `opencart.tf` configuration file and delete from it the description of the infrastructure you created.
1. Apply the changes:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}