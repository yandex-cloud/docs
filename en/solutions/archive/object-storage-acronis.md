# Backup to {{ objstorage-full-name }} via Acronis Backup Gateway

To set up backups in {{ objstorage-name }} via Acronis Backup Gateway:

1. [Create a bucket](#create-bucket)
1. [Configure Acronis Backup Gateway](#configure-acronis)
1. [Test your backup](#test-backup)

## 1. Create a bucket {#create-bucket}

To create a bucket for backups:

{% include [create-bucket](../_solutions_includes/create-public-bucket.md) %}

## 2. Configure Acronis Backup Gateway {#configure-acronis}

To configure Acronis Backup Gateway to work with {{ objstorage-name }}:

1. In Acronis Storage, open the **Services** menu and select **Acronis Backup Gateway**.
1. Click **Create Gateway**.
1. Select the **Public Cloud** type of storage.
1. In the **ABGW private** list, select the network interface with the **ABGW private** role.
1. In the **Public cloud parameters** section, specify the following settings:
    1. Select the **AuthV2 compatible** provider type.
    1. In the **Endpoint URL** field, specify `{{ s3-storage-host }}`.
    1. Get a static key and enter it for authentication.
    1. Specify the `backup` bucket for storing backups.
1. In the **Registration** section, enter your Acronis account details.
1. Click **DONE**.

## 3. Test your backup {#test-backup}

1. Set up backups in Acronis Backup by following the [instructions](https://www.acronis.com/ru-RU/support/documentation/BackupService/index.html#33507.html).
1. Run a backup by following the [instructions](https://www.acronis.com/ru-RU/support/documentation/BackupService/index.html#33512.html).

