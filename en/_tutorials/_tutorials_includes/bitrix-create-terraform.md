{% include [terraform-definition](./terraform-definition.md) %}

To create an infrastructure using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

   {% list tabs group=infrastructure_description %}

   - Ready-made configuration {#ready}
 
     1. Clone the repository with configuration files.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-bitrix-website.git
        ```

     1. Navigate to the repository directory. Make sure it contains the following files:
        * `bitrix-website.tf`: Your infrastructure configuration.
        * `bitrix-website.auto.tfvars`: User data file.

   - Manually {#manual}

     1. Create a directory for configuration files.
     1. In the directory, create:
        1. `bitrix-website.tf` configuration file:

           {% cut "bitrix-website.tf" %}

           {% include [bitrix-tf-config](../../_includes/web/bitrix-tf-config.md) %}

           {% endcut %}

        1. `bitrix-website.auto.tfvars` user data file:

           {% cut "bitrix-website.auto.tfvars" %}

           ```hcl
           folder_id      = "<folder_ID>"
           vm_user        = "<VM_username>"
           ssh_key_path   = "<path_to_file_with_public_SSH_key>"
           mysql_user     = "<DB_username>"
           mysql_password = "<DB_user_password>"
           ```

           {% endcut %}

   {% endlist %}

   For more information about the properties of {{ TF }} resources, see the provider documentation:

   * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Security groups](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [Image](../../compute/concepts/image.md): [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
   * [Disk](../../compute/concepts/disk.md): [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
   * [VM instance](../../compute/concepts/vm.md): [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
   * [MySQL cluster: [yandex_mdb_mysql_cluster]({{ tf-provider-resources-link }}/mdb_mysql_cluster).
   * Database: [yandex_mdb_mysql_database]({{ tf-provider-resources-link }}/mdb_mysql_database).
   * DB user: [yandex_mdb_mysql_user]({{ tf-provider-resources-link }}/mdb_mysql_user).

1. In the `bitrix-website.auto.tfvars` file, set the following user-defined properties:
   * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
   * `vm_user`: VM username.
   * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `mysql_user`: Username for connecting to the {{ MY }} DB. To complete this tutorial, specify `user1`.
   * `mysql_password`: User password to access the {{ MY }} DB. To complete this tutorial, specify `p@s$woRd!`.
1. Create the resources:

   {% include [terraform-validate-plan-apply](./terraform-validate-plan-apply.md) %}