# Backup to [!KEYREF objstorage-full-name] via Acronis Backup Gateway

To set up backups in [!KEYREF objstorage-name] via Acronis Backup Gateway:

* [Create a public bucket](#create-public-bucket)
* [Configure Acronis Backup Gateway](#configure-acronis)
* [Test your backup](#test-backup)

## Creating a public bucket {#create-public-bucket}

To create a bucket for backups:

1. Go to the Yandex.Cloud [management console](https://console.cloud.yandex.ru) and select the folder where you want to perform the operations.

1. On the folder page, click **Create resource** and select **Bucket**.

1. In the **Name** field, enter the bucket name, for example, `backup`.

   The name must meet the following requirements:

   [!INCLUDE [bucket-name-reqs](../../_includes/bucket-name-reqs.md)]

1. Specify the maximum bucket size in GB.

1. Select **Public** access to the bucket.

1. Click **Create bucket**.

## Configuring Acronis Backup Gateway {#configure-acronis}

To configure Acronis Backup Gateway to work with [!KEYREF objstorage-name]:

1. In Acronis Storage, open the **Services** menu and select **Acronis Backup Gateway**.
1. Click **Create Gateway**.
1. Select the **Public Cloud** type of storage.
1. In the **ABGW private** list, select the network interface with the **ABGW private** role.
1. In the **Public cloud parameters** section, specify the following settings:
    1. Select the **AuthV2 compatible** provider type.
    1. In the **Endpoint URL** field, specify `[!KEYREF s3-storage-host]`.
    1. Get a [static key](../../storage/operations/security/get-static-key.md) and enter it for authentication.
    1. Specify the `backup` bucket for storing backups.
1. In the **Registration** section, enter your Acronis account details.
1. Click **DONE**.

## Testing your backup {#test-backup}

1. Set up backups in Acronis Backup following the [instructions](https://www.acronis.com/ru-ru/support/documentation/BackupService/index.html#33507.html).
1. Run a backup following the [instructions](https://www.acronis.com/ru-ru/support/documentation/BackupService/index.html#33512.html).

