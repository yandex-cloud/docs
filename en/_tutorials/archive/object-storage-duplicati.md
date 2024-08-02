# Backup to {{ objstorage-full-name }} via Duplicati

You can use {{ objstorage-full-name }} for backup and recovery via the [Duplicati](https://www.duplicati.com/) utility.

To set up backups in {{ objstorage-name }} via Duplicati:

1. [Prepare your cloud](#before-begin).
1. [Create a bucket](#create-bucket).
1. [Set up a service account](#configure-service-account).
1. [Install Duplicati](#install-duplicati).
1. [Set up Duplicati](#configure-duplicati).
1. [Test the backup process](#test-backup).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of backup via Duplicati includes:

* Data storage fee (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-storage)).
* Fee for operations with data (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-operations)).
* Fee for outbound traffic from {{ yandex-cloud }} to the internet (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-traffic)).


## Create a bucket {#create-bucket}

To create a bucket for backups:

{% list tabs group=instructions %}

- Management console {#console}

   {% include [create-bucket](../_tutorials_includes/create-public-bucket.md) %}

{% endlist %}

## Set up a service account {#configure-service-account}

Backups in {{ objstorage-name }} are performed on behalf of a [service account](../../iam/concepts/users/service-accounts.md). If you do not have a service account, [create](../../iam/operations/sa/create.md) one.

To create a service account:

1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.editor` [role](../../iam/concepts/access-control/roles.md) to the service account.
1. [Create](../../iam/operations/sa/create-access-key.md) a static access key. Save the ID and private key. After closing the window, the private key parameters will be unavailable.

## Install Duplicati {#install-duplicati}

{% list tabs group=operating_system %}

- Windows {#windows}

   1. [Install](https://dotnet.microsoft.com/en-us/download) Microsoft .NET Framework version 4.6.2 or higher.
   1. [Install](https://www.duplicati.com/download) Duplicati.

- Linux/macOS {#linux-macos}

   1. [Install](https://www.mono-project.com/download/stable/) the Mono framework.
   1. [Install](https://www.duplicati.com/download) Duplicati.

{% endlist %}

## Configure Duplicati {#configure-duplicati}

To configure Duplicati to work with {{ objstorage-name }}:

1. Run Duplicati. If required, set a password for your account.
1. Click **Add backup**.
1. Select **Configure a new backup** and click **Next**.
1. Enter the backup plan name: `{{ yandex-cloud }}`. If you chose to encrypt the backup (`AES-256 encryption` or `GNU Privacy Guard`), enter the password and confirm it. Click **Next**.
1. In the **Storage Type** field, select `S3 compatible`.
1. In the **Server** field, select `Custom server URL`. In the field that appeared, enter the address `{{ s3-storage-host }}/`.
1. In the **Bucket name** field, enter a name for your bucket.
1. In the **AWS Access ID** field, enter the static access key ID.
1. In the **AWS Access Key** field, enter the secret key.
1. To make sure the settings are correct, click **Test connection**. In the window that opens, click **No**.
1. If successful, a window will appear saying **Connection worked!**. After you check the settings, click **Next**.
1. Select the files you want to back up from your computer. Click **Next**.
1. Set the backup schedule or deselect the **Automatically run backups** option to create backups manually. Click **Next**.
1. Specify the volume size and set the storage duration. Click **Save**.

## Test the backup procedure {#test-backup}

To test a backup:

1. In the Duplicati interface, click **Home**.
1. In the list of backup plans next to the `{{ yandex-cloud }}` plan, click **Run now**. Wait for the operation to complete.
1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), select the folder where the backup bucket is located.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
1. Open the bucket with backups and check whether all the relevant were copied.

For more information about restoring from a backup, see the [Duplicati documentation](https://duplicati.readthedocs.io/en/latest/03-using-the-graphical-user-interface/#restoring-files-from-a-backup).

## How to delete the resources you created {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}
