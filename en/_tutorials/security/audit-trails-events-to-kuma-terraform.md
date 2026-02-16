# Uploading {{ at-full-name }} audit logs to KUMA SIEM through {{ TF }}

To configure delivery of audit log files to [KUMA](https://www.kaspersky.com/enterprise-security/unified-monitoring-and-analysis-platform):

1. [Prepare your cloud environment](#before-begin).
1. [Create an infrastructure](#deploy).
1. [Mount the bucket on a server](#mount-bucket).
1. [Configure the KUMA collector](#setup-collector).

If you no longer need the resources you created, [delete them](#clear-out).


## Prepare your cloud environment{#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/audit-trails-events-to-kuma/paid-resources.md) %}


## Create an infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), Step 1).
1. Prepare the infrastructure description file:

    {% list tabs group=infrastructure_description %}

    - Ready-made configuration {#ready}

      1. Clone the repository with configuration files:

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-audit-trails-kuma-integration
          ```

      1. Navigate to the repository directory. Make sure it contains the following files:

          * `at-events-to-kuma.tf`: Your infrastructure configuration.
          * `at-events-to-kuma.auto.tfvars`: User data.

    - Manually {#manual}

      1. Create a folder for the infrastructure description file.
      1. Create a configuration file named `at-events-to-kuma.tf` in the folder:

          {% cut "at-events-to-kuma.tf" %}

          {% include [at-events-to-kuma-tf-config](../../_includes/web/at-events-to-kuma-tf-config.md) %}

          {% endcut %}

      1. In the directory, create a user data file named `at-events-to-kuma.auto.tfvars`:

          {% cut "at-events-to-kuma.auto.tfvars" %}

          {% include [at-events-to-kuma-tf-variables](../../_includes/web/at-events-to-kuma-tf-variables.md) %}

          {% endcut %}

    {% endlist %}

    For more information about the properties of {{ TF }} resources, see the provider documentation:

    * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account)
    * [Static access key](../../iam/concepts/authorization/access-key.md): [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key)
    * [Symmetric encryption key](../../kms/concepts/key.md): [yandex_kms_symmetric_key]({{ tf-provider-resources-link }}/kms_symmetric_key)
    * [Role](../../iam/concepts/access-control/roles.md): [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member)
    * [Bucket](../../storage/concepts/bucket.md): [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket)
    * [Trail](../../audit-trails/concepts/trail.md): [yandex_audit_trails_trail]({{ tf-provider-resources-link }}/audit_trails_trail)
    * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
    * [Subnet](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
    * [Disk](../../compute/concepts/disk.md): [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk)
    * [VM](../../compute/concepts/vm.md): [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)

1. In the `at-events-to-kuma.auto.tfvars` file, set the following user-defined properties:

    * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
    * `vm_user`: Username of the user you are going to create on the VM, e.g., `yc-user`.

        {% include [dont-use-root-name](../../_includes/dont-use-root-name.md) %}

    * `ssh_key_path`: Path to the public SSH key file and its name, e.g., `~/.ssh/id_ed25519.pub`. You need to create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection to a VM yourself.
    * `bucket_name`: [Name of the bucket](../../storage/concepts/bucket.md#naming) you want to upload audit logs to, e.g., `my-audit-logs-for-kuma`.

        {% include [bucket-name-note](../_tutorials_includes/audit-trails-events-to-kuma/bucket-name-note.md) %}

    * `object_prefix`: [Prefix](../../storage/concepts/object.md#folder) that will be added to the names of the audit log objects in the bucket, e.g., `/`. The prefix forms a part of the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file. 

1. Create resources:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. Get the [key ID](../../iam/concepts/authorization/access-key.md#key-id) and [secret key](../../iam/concepts/authorization/access-key.md#private-key) (you will need them later when mounting the bucket on the server):

    ```hcl
    terraform output access_key
    terraform output secret_key
    ```

    Result:

    ```text
    "YCAJE0tO1Q4zO7bW4********"
    "YCNpH34y9fzL6xEap3wkuxYfkc1PTNvr********"
    ```

Once the infrastructure is created, [mount the bucket on a server](#mount-bucket) and [set up the KUMA collector](#setup-collector).


## Mount the bucket on a server {#mount-bucket}

{% include [about-server](../_tutorials_includes/audit-trails-events-to-kuma/about-server.md) %}

{% include [mount-bucket](../_tutorials_includes/audit-trails-events-to-kuma/mount-bucket.md) %}


## Configure the KUMA collector {#setup-collector}

{% include [setup-collector](../_tutorials_includes/audit-trails-events-to-kuma/setup-collector.md) %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `at-events-to-kuma.tf` configuration file and delete your infrastructure description.
1. [Delete](../../storage/operations/objects/delete-all.md) all objects from the bucket you created earlier. Otherwise, the bucket and some of the infrastructure will not be deleted, and the `terraform apply` command will terminate with an error.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}