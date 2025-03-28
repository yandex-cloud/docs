# Backing up to {{ objstorage-full-name }} with Veeam Backup

You can use {{ objstorage-name }} to backup and restore data using [Veeam Backup & Replication](https://en.wikipedia.org/wiki/Veeam_Backup_%26_Replication) as well as back up data under the 3-2-1 rule.

Why use {{ objstorage-name }} for backups with Veeam:

* S3 protocol-compatible.
* Support for [locking](../../storage/concepts/object-lock.md) files with `s3 object lock`
* Allows restricting data access using an [ACL](../../storage/concepts/acl.md) and a [bucket policy](../../storage/concepts/policy.md).

To configure {{ objstorage-name }} for Veeam backup:

1. [Get your cloud ready](#before-you-begin).
1. [Create a bucket](#create-bucket).
1. [Set up a service account](#configure-service-account).
1. [Configure a backup job](#configure-veeam).
1. [Run a backup job](#start-veeam-backup-job).
1. [Run a restore job](#start-veeam-restore-job).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of Veeam backup includes:

* Fee for data storage (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-storage)).
* Fee for data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-operations)).
* Fee for outbound traffic from {{ yandex-cloud }} to the internet (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-traffic)).


## Create a bucket {#create-bucket}

{% note info %}

{{ objstorage-name }} only supports Veeam backup to buckets of the [default storage type](../../storage/concepts/storage-class.md#default-storage-class): **Regular**.

{% endnote %}

To create a backup bucket:

{% list tabs group=instructions %}

- Management console {#console}
 
  {% include [create-bucket](../_tutorials_includes/create-public-bucket.md) %}

{% endlist %}

## Set up a service account {#configure-service-account}

In {{ objstorage-name }}, you back up data under a [service account](../../iam/concepts/users/service-accounts.md). If you do not have a service account, [create](../../iam/operations/sa/create.md) one.

To create a service account:

1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.editor` [role](../../iam/concepts/access-control/roles.md) to the service account.
1. [Create](../../iam/operations/authentication/manage-access-keys.md#create-access-key) a static access key. Save the ID and secret key: you will need them later on to configure Veeam access to the {{ objstorage-name }} bucket. After closing the window, the private key properties will no longer be available.


## Configure a backup job {#configure-veeam}

{% note info %}

Make sure the system with Veeam can access the `{{ s3-storage-host }}` endpoint through ports `80` and `443`.

{% endnote %}

To configure Veeam for {{ objstorage-name }}:

1. Run Veeam.
1. In the left-hand control panel, select **Backup Infrastructure** → **Backup Repositories**.
1. In the window that opens, select the `S3 Compatible` storage type.
1. Enter a name for the repository you are creating.
1. Specify the endpoint for connecting to {{ objstorage-name }}: `https://{{ s3-storage-host }}`.
1. Enter `{{ region-id }}` and click **Add**.
1. In the **Access Key** field, specify the static access key ID.
1. In the **Secret Key** field, paste the secret key.
1. From the list of available {{ objstorage-name }} buckets, select the target bucket to store your backups in.


## Run a backup job {#start-veeam-backup-job}

To back up data to the {{ objstorage-name }} bucket you created earlier:

1. In the Veeam window, find the server whose backup you want to create. Right-click it and select **Add to backup job** → **New job**.
1. In the window that opens, select **Type Server** → **Mode Managed by backup server**.
1. In the backup repository selection window, select the one you created earlier in {{ objstorage-name }}.
1. From the list of backup jobs, select the one you created earlier. Right-click it and select **Start**.
1. Once the backup is complete, you will get a complete report.


## Run a restore job {#start-veeam-restore-job}

To restore a file or directory from a backup:

1. In the left-hand control panel, select **Home** → **Backups** → **Object Storage**.
1. Right-click the backup you created earlier and select **Restore guest files**.
1. In the window for selecting files and directories to restore, click **Browse**. 
1. In the file manager that opens, select a file or directory to restore and click **Restore**.
1. Once restoring is complete, you will get a complete report.


## How to delete the resources you created {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}
