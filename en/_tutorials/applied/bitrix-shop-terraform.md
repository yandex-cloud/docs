1. [Prepare your cloud](#before-you-begin).
1. [Create an infrastructure](#deploy).
1. [Configure your VM for 1C-Bitrix](#configure-server).
1. [Configure 1C-Bitrix](#configure-bitrix).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [bitrix-shop-paid-resources](../_tutorials_includes/bitrix-shop-paid-resources.md) %}

## Create an infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To host your online store on 1C-Bitrix using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).

1. Prepare a file with the infrastructure description:

   {% list tabs %}

   - Ready-made configuration

      1. Clone the repository with configuration files:

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-bitrix-store.git
         ```

      1. Go to the directory with the repository. Make sure it contains the following files:
         * `bitrix-shop.tf`: New infrastructure configuration.
         * `bitrix-shop.auto.tfvars`: User data file.

   - Creating files manually

      1. Create a directory for configuration files.

      1. In the directory, create:

         1. `bitrix-shop.tf` file with the infrastructure description:

            {% cut "bitrix-shop.tf" %}

            {% include [bitrix-shop-tf-config](../../_includes/internet-store/bitrix-shop-tf-config.md) %}

            {% endcut %}

         1. `bitrix-shop.auto.tfvars` user data file:

            {% cut "bitrix-shop.auto.tfvars" %}

            {% include [bitrix-shop-tf-variables](../../_includes/internet-store/bitrix-shop-tf-variables.md) %}

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
   * {{ MY }} database user: [yandex_mdb_mysql_user]({{ tf-provider-link }}/mdb_mysql_user)

1. In the `bitrix-shop.auto.tfvars` file, specify the user-defined parameters:

   * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
   * `vm_user`: VM user name.
   * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `db_user`: DB username, e.g., `user1`.
   * `db_password`: Password for the database. The password must be 8 to 128 characters long.

1. Create resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

## Configure your VM for 1C-Bitrix {#configure-server}

{% include [bitrix-shop-configure-server](../_tutorials_includes/bitrix-shop-configure-server.md) %}

## Configure 1C-Bitrix {#configure-bitrix}

{% include [bitrix-shop-configure-bitrix](../_tutorials_includes/bitrix-shop-configure-bitrix.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `bitrix-shop.tf` configuration file and delete from it the description of the infrastructure you created.
1. Apply the changes:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}