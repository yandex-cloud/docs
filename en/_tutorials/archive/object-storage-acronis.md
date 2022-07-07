# Backup to {{ objstorage-full-name }} via Acronis Backup Gateway

To set up backups in {{ objstorage-name }} via [Acronis](https://www.acronis.com/en-us/products/backup/cloud-storage/) Backup Gateway:

1. [Before you start](#before-you-begin)
1. [Create a bucket](#create-bucket)
1. [Configure Acronis Backup Gateway](#configure-acronis)
1. [Test the backup procedure](#test-backup)

If you no longer need these resources, [delete them](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

To configure backups, you will need a service account with access keys:

1. [Create](../../iam/operations/sa/create.md) a service account with the `editor` role.
1. [Create](../../iam/operations/sa/create-access-key.md) static access keys. Save the ID and secret access key right away. You won't be able to access the private key parameters again after you close the window.

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost for backup and recovery includes:

* Data storage fees (see [prices {{ objstorage-full-name }}](../../storage/pricing.md#prices-storage)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

{% endif %}

## Create a bucket {#create-bucket}

To create a bucket for backups:

{% include [create-bucket](../_tutorials_includes/create-public-bucket.md) %}

## Configure Acronis Backup Gateway {#configure-acronis}

To configure Acronis Backup Gateway to work with {{ objstorage-name }}:

1. Create an [Acronis account](https://account.acronis.com/#/auth/signup).
1. In [Acronis Cloud Storage](https://www.acronis.com/en-us/products/backup/cloud-storage/), open the **Services** menu and select **Acronis Backup Gateway**.
1. Click **Create Gateway**.
1. Select the **Public Cloud** type of storage.
1. In the **ABGW private** list, select the network interface with the **ABGW private** role.
1. In the **Public cloud parameters** section, specify the following settings:
   1. Select the **AuthV2 compatible** provider type.
   1. In the **Endpoint URL** field, specify `{{ s3-storage-host }}`.
   1. Specify a static key for authentication.
   1. Specify the `backup` bucket for storing backups.
1. In the **Registration** section, enter your Acronis account details.
1. Click **DONE**.

## Test the backup procedure {#test-backup}

Configure and perform a backup in Acronis Backup by following the [instructions](https://www.acronis.com/en-us/support/documentation/BackupService/index.html#33507.html).

## How to delete created resources {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}
