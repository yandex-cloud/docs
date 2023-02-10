# Migrating databases between {{ mms-name }} using {{ objstorage-full-name }}

You can move databases between {{ mms-name }} clusters using {{ objstorage-name }}:

1. [Configure your clusters](#configure).
1. [Export the backups of the required databases to {{ objstorage-name }}](#backup-export).
1. [Restore your databases from the backups stored in {{ objstorage-name }}](#backup-import).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

Create the necessary resources:

{% list tabs %}

* Manually

   1. [Create a {{ mms-name }} target cluster](../../managed-sqlserver/operations/cluster-create.md).

   1. [Create a bucket](../../storage/operations/buckets/create.md) in {{ objstorage-name }}.

   1. [Create a service account](../../iam/operations/sa/create.md) to handle the {{ mms-name }} clusters and the {{ objstorage-name }} bucket.

   1. Grant the service account read and write permissions to the bucket using one of the methods below:

      * [Configure a bucket ACL](../../storage/operations/buckets/edit-acl.md) by adding a service account to the list and granting it `READ and WRITE` permissions (recommended).
      * [Assign the service account the following roles](../../iam/operations/sa/assign-role-for-sa.md): `storage.uploader` and `storage.viewer`.

* Using {{ TF }}

   1. If you don't have {{ TF }}, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [to-mms-with-bucket.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/sqlserver-migration/to-mms-with-bucket.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security group](../../vpc/concepts/security-groups.md) and rule enabling cluster connections.
      * [Service account](../../iam/concepts/users/service-accounts.md) to handle the {{ mms-name }} clusters and the {{ objstorage-name }} bucket.
      * [Bucket in {{ objstorage-name }}](../../storage/concepts/bucket.md) with `READ and WRITE` permissions in the service account [ACL](../../storage/concepts/acl.md).
      * {{ mms-name }} target cluster.

   1. Specify the infrastructure settings under `locals` in the `sqlserver-data-migration.tf` configuration file.

      * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create resources in.
      * `sql_server_version`: {{ MS }} version.
      * `db_name`: Target cluster database name.
      * `username` and `password`: Database owner username and password.
      * `storage_sa_id`: ID of the service account with the `storage.admin` role. It will be used to create a bucket in {{ objstorage-name }} with `READ and WRITE` permissions in the [ACL](../../storage/concepts/acl.md) for the new service account.
      * `cluster_sa`: Name of the {{ mms-name }} cluster service account. The name must be unique within the folder.
      * `bucket_name`: {{ objstorage-name }} bucket name. The name must be unique within the entire {{ objstorage-name }}.

   1. Run the command `terraform init` in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Configure your clusters {#configure}

1. Remove the load from the source cluster.
1. Switch the source cluster to <q>read-only</q> mode:

   * Using {{ ssms }}:

      1. Open {{ ssms }}.
      1. Open the context menu for the replicated database and select **Properties**.
      1. Select **Database Properties** → **Options** and under **State**, change the value of **Database Read Only** to **True**.

   * Using a query:

      ```sql
      ALTER DATABASE <database name> SET READ_ONLY
      ```

1. [Create a backup](../../managed-sqlserver/operations/cluster-backups.md#create-backup) of the source cluster. This is necessary for exporting backups of the cluster database.

1. [Bind the created service account](../../managed-sqlserver/operations/update.md#service-account) to the source and target clusters.

## Export the backups of the required databases to {{ objstorage-name }} {#backup-export}

{% include [database-backup-export](../../_includes/mdb/mms/database-backup-export.md) %}

## Restore your databases from the backups stored in {{ objstorage-name }} {#backup-import}

{% include [database-backup-import](../../_includes/mdb/mms/database-backup-import.md) %}

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:

{% list tabs %}

* Manually

   * [Delete the {{ mms-name }} target cluster](../../managed-sqlserver/operations/cluster-delete.md).
   * [Delete the bucket](../../storage/operations/buckets/delete.md) in {{ objstorage-name }}.
   * [Delete the service account](../../iam/operations/sa/delete.md).

* Using Terraform

   To delete the infrastructure created with {{ TF }}:

   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete the `to-mms-with-bucket.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `to-mms-with-bucket.tf` configuration will be deleted.

{% endlist %}
