# Backup to {{ objstorage-full-name }} via Duplicati

You can use {{ objstorage-full-name }} for backup and recovery via the [Duplicati](https://www.duplicati.com/) utility.

To set up backups in {{ objstorage-name }} via Duplicati:

1. [Prepare your cloud](#before-begin).
1. [Create a bucket](#create-bucket).
1. [Set up a service account](#configure-service-account).
1. [Install Duplicati](#install-duplicati).
1. [Set up Duplicati](#configure-duplicati).
1. [Test the backup process](#test-backup).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The price for backups via Duplicati includes:

* Data storage fees (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-storage)).
* Fee for data operations (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-operations)).
* The cost of outgoing traffic from {{ yandex-cloud }} to the internet (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-traffic)).

{% endif %}

## Create a bucket {#create-bucket}

To create a bucket for backups:

{% list tabs %}

- Management console

   {% include [create-bucket](../_tutorials_includes/create-public-bucket.md) %}

{% endlist %}

## Set up a service account {#configure-service-account}

Backups in {{ objstorage-name }} are performed on behalf of a [service account](../../iam/concepts/users/service-accounts.md). If you don't have a service account, [create](../../iam/operations/sa/create.md) one.

To create a service account:

1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `editor` [role](../../iam/concepts/access-control/roles.md) to your service account.
1. [Create](../../iam/operations/sa/create-access-key.md) static access keys. Save the ID and secret access key right away. You won't be able to access the private key parameters again after you close the window.

## Install Duplicati {#install-duplicati}

{% list tabs %}

- Windows

   1. [Install](https://dotnet.microsoft.com/en-us/download) Microsoft .NET Framework version 4.6.2 or higher.
   1. [Install](https://www.duplicati.com/download) Duplicati.

- Linux/macOS

   1. [Install](https://www.mono-project.com/download/stable/) the Mono framework.
   1. [Install](https://www.duplicati.com/download) Duplicati.

{% endlist %}

## Configure Duplicati {#configure-duplicati}

To configure Duplicati to work with {{ objstorage-name }}:

1. Run Duplicati. If required, set a password for your account.
1. Click **Add backup**.
1. Select **Configure a new backup** then click **Next**.
1. Enter the backup plan name: `{{ yandex-cloud }}`. If you selected to encrypt the backup (`AES-256 encryption`), enter the password and confirm it. Click **Next**.
1. Under **Storage Type**, select`S3 compatible`.
1. In the **Server** list, specify `Custom server URL`. In the field below, enter the address `{{ s3-storage-host }}/`.
1. In the **Bucket name** field, enter the name of your bucket: `backup`.
1. In the **AWS Access ID** field, specify the ID of the static access key.
1. In the **AWS Access Key** field, enter the private key.
1. To double-check the settings, click **Test connection**. In the window that opens, click **No**.
1. After checking the settings, click **Next**.
1. Select the files that you want to back up.
1. Click **Next**.
1. Set the backup schedule or deselect the **Automatically run backups** option to create backups manually. Click **Next**.
1. Specify the volume size and set the storage duration. Click **Save**.

## Test the backup procedure {#test-backup}

To test a backup:

1. In the Duplicati interface, click **Home**.
1. In the list of backup plans next to the `{{ yandex-cloud }}` plan, click **Run now**.
1. Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).
1. Go to the folder hosting your bucket with backups.
1. Select **{{ objstorage-short-name }}**.
1. Open the bucket with backups and check whether all the relevant were copied.

For more information about restoring from a backup, see the [Duplicati documentation](https://duplicati.readthedocs.io/en/latest/03-using-the-graphical-user-interface/#restoring-files-from-a-backup).

## How to delete created resources {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}
