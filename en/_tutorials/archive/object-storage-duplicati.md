# {{ objstorage-full-name }} backup with Duplicati

You can use {{ objstorage-full-name }} for data backup and recovery using [Duplicati](https://www.duplicati.com/).

To set up backup in {{ objstorage-name }} using Duplicati:

1. [Get your cloud ready](#before-begin).
1. [Create a bucket](#create-bucket).
1. [Set up a service account](#configure-service-account).
1. [Install Duplicati](#install-duplicati).
1. [Set up Duplicati](#configure-duplicati).
1. [Test backup](#test-backup).

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
1. Select **Configure a new backup** and click **Next**.
1. Enter the backup plan name: `{{ yandex-cloud }}`. If you chose to encrypt the backup (`AES-256 encryption` or `GNU Privacy Guard`), enter the password and confirm it. Click **Next**.
1. In the **Storage Type** field, select `S3 compatible`.
1. In the **Server** field, select `Custom server URL`. In the field that appears, enter the address: `{{ s3-storage-host }}/`.
1. In the **Bucket name** field, enter a name for your bucket.
1. In the **AWS Access ID** field, enter the static access key ID.
1. In the **AWS Access Key** field, enter the secret key.
1. To make sure the settings are correct, click **Test connection**. In the window that opens, click **No**.
1. If successful, a window will appear saying **Connection worked!**. After you check the settings, click **Next**.
1. Select the files you want to back up from your computer. Click **Next**.
1. Set the backup schedule or deselect the **Automatically run backups** option to create backups manually. Click **Next**.
1. Specify the volume size and set the storage duration. Click **Save**.

## Test backup {#test-backup}

To test backup:

1. In the Duplicati interface, click **Home**.
1. In the list of backup plans next to the `{{ yandex-cloud }}` plan, click **Run now**. Wait for the operation to complete.
1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), select the folder with the backup bucket.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
1. Open the bucket with backups and check whether all the relevant were copied.

For more information about restoring data from a backup, see [this Duplicati article](https://duplicati.readthedocs.io/en/latest/03-using-the-graphical-user-interface/#restoring-files-from-a-backup).

## How to delete the resources you created {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}
