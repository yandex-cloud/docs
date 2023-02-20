# Backup to {{ objstorage-full-name }} via Duplicati

To set up backups in {{ objstorage-name }} via Duplicati:

1. [Before you start](#before-you-begin)
1. [Create a bucket](#create-bucket)
1. [Create a service account](#create-service-account)
1. [Create a static access key](#create-access-key)
1. [Install Duplicati](#install-duplicati)
1. [Configure Duplicati](#configure-duplicati)
1. [Test your backup](#test-backup)
1. [Delete the created cloud resources](#clear-out)

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost for backup and recovery includes:

* A fee for data storage (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-storage)).
* A fee for data operations (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-operations)).
* The cost of outgoing traffic from {{ yandex-cloud }} to the internet (see [{{ objstorage-full-name }} pricing](../../storage/pricing#prices-storage.md#prices-traffic)).

{% endif %}

## Create a bucket {#create-bucket}

To create a bucket for backups:

{% include [create-bucket](../_tutorials_includes/create-public-bucket.md) %}

## Create a service account {#create-service-account}

Create a [service account](../../iam/operations/sa/create.md) with the `editor` role.

## Create a static access key {#create-access-key}

Create [static access keys](../../iam/operations/sa/create-access-key.md). Save the ID and secret access key right away. You won't be able to access the private key parameters again after you close the window.

## Install Duplicati {#install-duplicati}

{% list tabs %}

- Windows/Linux

  [Download](https://www.duplicati.com/download) and install Duplicati.

- macOS

  To use Duplicati on macOS, you need the [Mono framework](https://www.mono-project.com/download/stable/#download-mac).

  Once you have installed the Mono framework, [download](https://www.duplicati.com/download) and install Duplicati.

{% endlist %}

## Configure Duplicati {#configure-duplicati}

To configure Duplicati to work with {{ objstorage-name }}:

1. Run Duplicati. If required, set a password for your account.
1. Select the **Add backup** menu item.
1. Click **Configure a new backup**. Click **Next**.
1. Enter the backup plan name: `{{ yandex-cloud }}`. Enter the password and confirm if you chose to encrypt the backup. Click **Next**.
1. In the **Storage Type** field, specify `S3 compatible`.
1. In the **Server** list, specify `Custom server URL`. In the field below, enter the address `{{ s3-storage-host }}/`.
1. In the **Bucket name** field, enter the name of your bucket: `backup`.
1. In the **AWS Access ID** field, specify the ID of the static access key.
1. In the **AWS Access Key** field, enter the private key.
1. Click **Test connection** to make sure the settings are correct. A window opens prompting you to add the username to the bucket name. Click **No**.
1. After checking the settings, click **Next**.
1. Select the files that you want to back up.
1. Click **Next**.
1. Set the backup schedule or deselect the **Automatically run backups** option to create backups manually. Click **Next**.
1. Specify the volume size and set the storage duration. Click **Save**.

## Test the backup procedure {#test-backup}

To test a backup:

1. Open the **Home** menu item.
1. In the list of backup plans next to the `{{ yandex-cloud }}` plan, click **Run now**.
1. Open the [management console]({{ link-console-main }}).
1. Go to the folder containing the bucket where your backups are stored.
1. Select the **{{ objstorage-short-name }}** service.
1. Open the `backup` bucket and check whether all the necessary files have been copied.

## How to delete created resources {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}

