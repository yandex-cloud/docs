


{% include [fault-tolerant-intro](../../_tutorials_includes/integrate-nextcloud/fault-tolerant-intro.md) %}

1. [Get your cloud ready](#before-you-begin).
1. [Deploy Nextcloud in a basic configuration](#the-basic-variant):
    1. [Create an infrastructure for the basic configuration](#create-basic-infrastructure).
    1. [Install and configure Nextcloud on the VM](#setup-nextcloud).
    1. [Test the solution in the basic configuration](#test-simple).
1. [Deploy Nextcloud in a fault-tolerant configuration](#the-redundant-variant):
    1. [Complete Nextcloud setup](#tune-nextcloud).
    1. [Scale the infrastructure for the fault-tolerant configuration](#create-failsafe-infrastructure).
    1. [Test the solution in the fault-tolerant configuration](#test-redundant).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [fault-tolerant-paid-resources](../../_tutorials_includes/integrate-nextcloud/fault-tolerant-paid-resources.md) %}

## Deploy Nextcloud in a basic configuration {#the-basic-variant}

You will deploy the basic Nextcloud configuration on a single VM with the Nextcloud service database created in a single-host {{ mmy-name }} cluster.

### Create an infrastructure for the basic configuration {#create-basic-infrastructure}

{% include [terraform-definition](../../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:
1. [Install {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the credentials](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing {{ yandex-cloud }} (see [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare your infrastructure description files:

    {% list tabs group=infrastructure_description %}

    - Ready-made configuration {#ready}

      1. Clone the repository with configuration files.

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-nextcloud-s3.git
         ```

      1. Navigate to the repository directory. Make sure it contains the following files and folders:
          * `nextcloud-integrate-storage-basic-config.tf`: Configuration file of the new basic infrastructure.
          * `nextcloud-integrate-storage.auto.tfvars`: File with the values of user-defined variables.
          * `failsafe`: Folder containing the fault-tolerant configuration:
              * `nextcloud-integrate-storage-failsafe-config.tf`: Configuration file of the new infrastructure in the fault-tolerant version.

    - Manually {#manual}

      1. Create a folder for configuration files.
      1. In the folder, create:

          1. `nextcloud-integrate-storage-basic-config.tf` configuration file:

              {% cut "nextcloud-integrate-storage-basic-config.tf" %}

              {% include [nextcloud-integrate-storage-basic-config](../../_tutorials_includes/integrate-nextcloud/nextcloud-integrate-storage-basic-config.md) %}

              {% endcut %}

          1. `nextcloud-integrate-storage.auto.tfvars` user data file:

              {% cut "nextcloud-integrate-storage.auto.tfvars" %}

              ```hcl
              folder_id     = "<folder_ID>"
              ssh_key_path  = "<path_to_public_SSH_key>"
              bucket_name   = "<bucket_name>"
              db_password   = "<database_user_password>"
              domain_name   = "<domain_name>"
              ```

              {% endcut %}

    {% endlist %}

    Learn more about the properties of {{ TF }} resources in the relevant provider guides:
    * [Network](../../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [NAT gateway](../../../vpc/concepts/gateways.md#nat-gateway): [yandex_vpc_gateway]({{ tf-provider-resources-link }}/vpc_gateway).
    * [Route table](../../../vpc/concepts/routing.md#rt-vpc): [yandex_vpc_route_table]({{ tf-provider-resources-link }}/vpc_route_table).
    * [Subnet](../../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Security group](../../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
    * [Service account](../../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * [Role](../../../iam/concepts/access-control/roles.md): [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member)
    * [Static access key](../../../iam/concepts/authorization/access-key.md): [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
    * [Bucket](../../../storage/concepts/bucket.md): [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).
    * VM [disk](../../../compute/concepts/disk.md): [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
    * [VM](../../../compute/concepts/vm.md) instance: [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
    * [{{ mmy-name }}](../../../managed-mysql/concepts/index.md) cluster: [yandex_mdb_mysql_cluster]({{ tf-provider-resources-link }}/mdb_mysql_cluster).
    * {{ MY }} database: [yandex_mdb_mysql_database]({{ tf-provider-resources-link }}/mdb_mysql_database).
    * {{ MY }} database user: [yandex_mdb_mysql_user]({{ tf-provider-resources-link }}/mdb_mysql_user).

1. In the `nextcloud-integrate-storage.auto.tfvars` file, set the values of the user-defined variables:
    * `folder_id`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
    * `ssh_key_path`: Path to the public SSH key file. For more information, see [{#T}](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `bucket_name`: Bucket name consistent with the [naming conventions](../../../storage/concepts/bucket.md#naming).
    * `db_password`: {{ MY }} database user password.
    * `domain_name`: Name of the domain to host the Nextcloud instance.

        To use domain names in the public DNS zone, you need to delegate it to authoritative name servers. Specify `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` server addresses in your registrar's account settings.

        {% note info %}

        If you only plan to create a basic Nextcloud instance without deploying a fault-tolerant solution, you do not have to change the value of the `domain_name` variable.

        {% endnote %}

1. Create the resources:

   {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}

This will create all the infrastructure you need to deploy Nextcloud in a basic configuration in the selected folder.

{{ TF }} will display the ID of the created [static access key](../../../iam/concepts/authorization/access-key.md). You will need this value later when setting up Nextcloud integration with {{ objstorage-name }}. You will also need a secret key. To get it, run the following command in the terminal:

```bash
terraform output Secret_key
```

Once you have the secret key value, proceed to configuring Nextcloud on your VM.

### Install and configure Nextcloud on the VM {#setup-nextcloud}

1. Install Nextcloud on `nextcloud-vm`:

    1. {% include [basic-nextcloud-vm-setup1-1](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-1.md) %}

        To do this, run this command in the VM terminal, specifying the public IP address of the VM:

        ```bash
        ssh yc-user@<VM_IP_address>
        ```

        You can look up the VM's public IP address in the [management console]({{ link-console-main }}) by checking the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section's **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** field on the VM information page.
    1. {% include [basic-nextcloud-vm-setup1-2](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-2.md) %}
    1. {% include [basic-nextcloud-vm-setup1-3](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-3.md) %}
    1. {% include [basic-nextcloud-vm-setup1-4](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-4.md) %}
    1. {% include [basic-nextcloud-vm-setup1-5](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-5.md) %}
    1. {% include [basic-nextcloud-vm-setup1-6](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-6.md) %}
    1. {% include [basic-nextcloud-vm-setup1-7](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-7.md) %}
    1. {% include [basic-nextcloud-vm-setup1-8](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-8.md) %}
    1. {% include [basic-nextcloud-vm-setup1-9](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-9.md) %}
    1. {% include [basic-nextcloud-vm-setup1-10](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup1-10.md) %}
1. Configure Nextcloud in the GUI:

    1. {% include [basic-nextcloud-vm-setup2-1](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup2-1.md) %}
    1. In the **Create an admin account** form that opens:

        1. In the **New admin account name** and **New admin password** fields, set the Nextcloud administrator credentials you will use to log in to the system.
        1. In the **Database account** field, specify `user`, which is the name of the database user created in the {{ MY }} cluster.
        1. In the **Database password** field, enter the database user password you specified in the `nextcloud-integrate-storage.auto.tfvars` file.
        1. In the **Database name** field, specify `nextcloud`, which is the name of the database created in the {{ MY }} cluster.
        1. In the **Database host** field, specify the FQDN of the {{ MY }} cluster’s [current master host](../../../managed-mysql/operations/connect/fqdn.md#fqdn-master) and port in this format:

            ```text
            c-<cluster_ID>.rw.{{ dns-zone }}:3306
            ```

            You can look up the cluster ID in the [management console]({{ link-console-main }}) by checking the **{{ ui-key.yacloud.common.id }}** field on the cluster information page.
        1. Click **Install**.

            This will start the deployment of the Nextcloud database in the {{ MY }} cluster. Wait for this process to complete.
    1. {% include [basic-nextcloud-vm-setup2-2](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup2-2.md) %}
    1. {% include [basic-nextcloud-vm-setup2-3](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup2-3.md) %}
    1. {% include [basic-nextcloud-vm-setup2-4](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup2-4.md) %}
    1. {% include [basic-nextcloud-vm-setup2-5](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup2-5.md) %}
    1. {% include [basic-nextcloud-vm-setup2-6](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup2-6.md) %}
    1. {% include [basic-nextcloud-vm-setup2-7](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup2-7.md) %}
    1. {% include [basic-nextcloud-vm-setup2-8](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-vm-setup2-8.md) %}

### Test the solution in the basic configuration {#test-simple}

{% include [basic-nextcloud-test](../../_tutorials_includes/integrate-nextcloud/basic-nextcloud-test.md) %}

The deployment of the Nextcloud basic configuration is now complete. You can now proceed to deploy the fault-tolerant configuration.

## Deploy Nextcloud in a fault-tolerant configuration {#the-redundant-variant}

{% include [failsafe-nextcloud-intro](../../_tutorials_includes/integrate-nextcloud/failsafe-nextcloud-intro.md) %}

### Complete Nextcloud setup {#tune-nextcloud}

Before you begin deploying a fault-tolerant configuration, add your domain to Nextcloud's list of trusted addresses and domains:

1. {% include [failsafe-nextcloud-vm-setup1](../../_tutorials_includes/integrate-nextcloud/failsafe-nextcloud-vm-setup1.md) %}
1. {% include [failsafe-nextcloud-vm-setup2](../../_tutorials_includes/integrate-nextcloud/failsafe-nextcloud-vm-setup2.md) %}
1. {% include [failsafe-nextcloud-vm-setup3](../../_tutorials_includes/integrate-nextcloud/failsafe-nextcloud-vm-setup3.md) %}

### Scale the infrastructure for the fault-tolerant configuration {#create-failsafe-infrastructure}

1. Set up your infrastructure description files:

    {% list tabs group=infrastructure_description %}

    - Ready-made configuration {#ready}

      1. In the folder with the downloaded repository, delete the `nextcloud-integrate-storage-basic-config.tf` file.
      1. From the `failsafe` folder, move the `nextcloud-integrate-storage-failsafe-config.tf` file to the repository’s root folder, i.e., the one you just deleted the file from.

    - Manually {#manual}

      1. In the previously created folder for configuration files, delete the `nextcloud-integrate-storage-basic-config.tf` file.
      1. Create a new `nextcloud-integrate-storage-failsafe-config.tf` configuration file in this folder:

          {% cut "nextcloud-integrate-storage-failsafe-config.tf" %}

          {% include [nextcloud-integrate-storage-failsafe-config](../../_tutorials_includes/integrate-nextcloud/nextcloud-integrate-storage-failsafe-config.md) %}

          {% endcut %}

    {% endlist %}

    For more information about the properties of resources added to {{ TF }}, refer to the relevant provider guides:
    * [Disk snapshot](../../../compute/concepts/snapshot.md): [yandex_compute_snapshot]({{ tf-provider-resources-link }}/compute_snapshot)
    * [DNS zone](../../../dns/concepts/dns-zone.md): [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone)
    * [TLS certificate](../../../certificate-manager/concepts/managed-certificate.md): [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate)
    * [DNS resource record](../../../dns/concepts/resource-record.md): [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset)
    * [Instance group](../../../compute/concepts/instance-groups/index.md): [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group)
    * [Backend group](../../../application-load-balancer/concepts/backend-group.md): [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group)
    * [HTTP router](../../../application-load-balancer/concepts/http-router.md): [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router)
    * [Virtual host](../../../application-load-balancer/concepts/http-router.md#virtual-host): [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host)
    * [L7 load balancer](../../../application-load-balancer/concepts/application-load-balancer.md): [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer)

1. Create the resources:

   {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}

As a result, a fault-tolerant Nextcloud solution will be deployed in the selected folder.

### Test the solution in the fault-tolerant configuration {#test-redundant}

{% include [failsafe-nextcloud-test](../../_tutorials_includes/integrate-nextcloud/failsafe-nextcloud-test.md) %}

## How to delete the resources you created {#clear-out}

{% note warning %}

Before deleting the infrastructure, [delete](../../../storage/operations/objects/delete.md) all objects in the created bucket.

{% endnote %}

To stop paying for the resources you created:

1. Open the `nextcloud-integrate-storage-failsafe-config.tf` file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}