# {{ objstorage-full-name }} backup with Veeam Backup

You can use {{ objstorage-name }} to backup and restore data via [Veeam Backup & Replication](https://en.wikipedia.org/wiki/Veeam_Backup_%26_Replication), as well as implement backups under the 3-2-1 rule.

Why use {{ objstorage-name }} for backups with Veeam:

* Compatibility with S3
* Support for [locking](../../storage/concepts/object-lock.md) files with `s3 object lock`
* Ability to restrict access to data with [ACLs](../../storage/concepts/acl.md) and [bucket policies](../../storage/concepts/policy.md)

To configure {{ objstorage-name }} for backups with Veeam:

1. [Get your cloud ready](#before-you-begin).
1. [Create a bucket](#create-bucket).
1. [Set up a service account](#configure-service-account).
1. [Configure backups](#configure-veeam).
1. [Create a backup](#start-veeam-backup-job).
1. [Start restoring from a backup](#start-veeam-restore-job).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of backup via Veeam includes:

* Data storage fee (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-storage)).
* Fee for operations with data (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-operations)).
* Fee for outbound traffic from {{ yandex-cloud }} to the internet (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-traffic)).


## Create a bucket {#create-bucket}

{% note info %}

{{ objstorage-name }} only supports backups with Veeam to buckets with the **Standard** [default storage class](../../storage/concepts/storage-class.md#default-storage-class).

{% endnote %}

To create a bucket for backups:

{% list tabs group=instructions %}

- Management console {#console}
 
  {% include [create-bucket](../_tutorials_includes/create-public-bucket.md) %}

{% endlist %}

## Set up a service account {#configure-service-account}

Backups in {{ objstorage-name }} are performed on behalf of a [service account](../../iam/concepts/users/service-accounts.md). If you do not have a service account, [create](../../iam/operations/sa/create.md) one.

To create a service account:

1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.editor` [role](../../iam/concepts/access-control/roles.md) to the service account.
1. [Create](../../iam/operations/sa/create-access-key.md) a static access key. Save the ID and secret key: you will need them for configuring Veeam access to the {{ objstorage-name }} bucket. After closing the window, the private key parameters will be unavailable.


## Configure backups {#configure-veeam}

{% note info %}

Make sure the computer where Veeam is deployed has access to the `{{ s3-storage-host }}` endpoint through ports `80` and `443`.

{% endnote %}

To configure Veeam to work with {{ objstorage-name }}:

1. Launch Veeam.
1. In the left-hand control panel, select **Backup Infrastructure** → **Backup Repositories**.
1. In the window that opens, select `S3 Compatible` for object storage type.
1. Enter the name of the repository to create.
1. Specify the endpoint for connecting to {{ objstorage-name }}: `https://{{ s3-storage-host }}`.
1. Enter the region name, `{{ region-id }}`, and click **Add**.
1. In the **Access Key** field, paste the ID of the static access key.
1. In the **Secret Key** field, paste the secret key.
1. In the list of available {{ objstorage-name }} buckets, select the target bucket for storing your backups.


## Create a backup {#start-veeam-backup-job}

To back up to a previously created {{ objstorage-name }} bucket:

1. In the Veeam window, select the server to back up. Right-click it and select **Add to backup job** → **New job**.
1. In the window that opens, select **Type Server** → **Mode Managed by backup server**.
1. In the backup repository selection window, select the one you created earlier in {{ objstorage-name }}.
1. From the list of backup jobs, select the previously created one. Right-click it and select **Start**.
1. Once the backup process is complete, you will get a detailed report.


## Start restoring from a backup {#start-veeam-restore-job}

To restore a file or folder from a backup:

1. In the left-hand control panel, select **Home** → **Backups** → **Object Storage**.
1. Right-click the previously created backup and select **Restore guest files**.
1. In the window for selecting files and folders to restore, click **Browse**. 
1. In the file browser that opens, select the file or folder and click **Restore**.
1. Once the restore process is complete, you will get a detailed report.


## How to delete the resources you created {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}
