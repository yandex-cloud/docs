# Backing up to {{ objstorage-full-name }} with Duplicati

You can use {{ objstorage-full-name }} for data backup and recovery using [Duplicati](https://www.duplicati.com/).

To configure backing up to {{ objstorage-name }} with Duplicati:

1. [Get your cloud ready](#before-begin).
1. [Create a bucket](#create-bucket).
1. [Set up a service account](#configure-service-account).
1. [Install Duplicati](#install-duplicati).
1. [Set up Duplicati](#configure-duplicati).
1. [Test your backup](#test-backup).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of Duplicati backup includes:

* Fee for data storage (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-storage)).
* Fee for data operations (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-operations)).
* Fee for outbound traffic from {{ yandex-cloud }} to the internet (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-traffic)).

## Create a bucket {#create-bucket}

To create a bucket for backups:

{% list tabs group=instructions %}

- Management console {#console}
 
  {% include [create-bucket](../_tutorials_includes/create-public-bucket.md) %}

{% endlist %}

## Set up a service account {#configure-service-account}

In {{ objstorage-name }}, you back up data under a [service account](../../iam/concepts/users/service-accounts.md). If you do not have a service account, [create](../../iam/operations/sa/create.md) one.

To create a service account:

1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.editor` [role](../../iam/concepts/access-control/roles.md) to the service account.
1. [Create](../../iam/operations/authentication/manage-access-keys.md#create-access-key) a static access key. Save the ID and secret key. After closing the window, the private key properties will no longer be available.

## Install Duplicati {#install-duplicati}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. [Install](https://dotnet.microsoft.com/en-us/download) Microsoft .NET Framework, version 4.6.2 or higher.
  1. [Install](https://www.duplicati.com/download) Duplicati.

- Linux/macOS {#linux-macos}

  1. [Install](https://www.mono-project.com/download/stable/) Mono.
  1. [Install](https://www.duplicati.com/download) Duplicati.

{% endlist %}

## Configure Duplicati {#configure-duplicati}

To configure Duplicati to work with {{ objstorage-name }}:

1. Run Duplicati. If required, set a password for your account.
1. Click **Add backup**.
1. Select **Add a new backup** ![image](../../_assets/plus.svg).
1. At the **General** step, enter the backup plan name: `{{ yandex-cloud }}`. If you chose to encrypt the backup (`AES-256 encryption` or `GNU Privacy Guard`), enter the password and confirm it. Click **Continue**.
1. At the **Destination** step, select `S3 Compatible` and click **Choose**:
   1. In the **Bucket name** field, enter your bucket name.
   1. In the **Folder path** field, specify the path inside the bucket (prefix). If you need the bucket root, leave this field empty.
   1. In the **Server** field, enter this address: `{{ s3-storage-host }}/`. If there is a bucket connection error, try specifying the address without the slash: `{{ s3-storage-host }}`.
   1. In the **Access Key ID** field, specify the static access key ID.
   1. In the **Secret Access Key** field, paste the secret key. Click **Continue**.
1. To make sure the settings are correct, click **Test now** in the window that opens.
1. If successful, it will take you to the next step, **Source Data**. At this step:
   1. In the **Source Data** field, select the local files you want to back up.
   1. Optionally, configure filters in the **Filters** field.
   1. Optionally, under **Exclude**, configure backup exclusions.
   1. Click **Continue**.
1. At the **Schedule** step, choose a backup schedule from the list or set a custom one by selecting **Custom** and enabling **Automatically run backups**. To create backups manually, select **Don't run automatically**. Click **Continue**.
1. At the **Options** step, specify the volume size and set the storage duration. Click **Submit**.

## Test your backup {#test-backup}

To test your backup:

1. In the list of backup plans, next to the `{{ yandex-cloud }}` plan, click **Start**. Wait for the operation to complete.
1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), select the folder with the backup bucket.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
1. Open the bucket with backups and check whether all the relevant were copied.

For more information about restoring data from a backup, see [this Duplicati article](https://duplicati.readthedocs.io/en/latest/03-using-the-graphical-user-interface/#restoring-files-from-a-backup).

## How to delete the resources you created {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}
