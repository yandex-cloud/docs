# Backup to [!KEYREF objstorage-full-name] via Duplicati

To set up backups in [!KEYREF objstorage-name] via Duplicati:

1. [Create a public bucket](#create-public-bucket)
1. [Create a service account](#create-service-account)
1. [Create a static access key](#create-access-key)
1. [Install Duplicati](#install-duplicati)
1. [Configure Duplicati](#configure-duplicati)
1. [Test your backup](#test-backup)

The free version of Duplicati allows you to create a maximum of 200 GB of backups.

## 1. Create a public bucket {#create-public-bucket}

To create a bucket for backups:

[!INCLUDE [create-public-bucket](../_solutions_includes/create-public-bucket.md)]

## 2. Create a service account {#create-service-account}

Create a service account with the `editor` role.

## 3. Create a static access key {#create-access-key}

Create static access keys. Save the ID and private key right away. You won't be able to access the private key parameters again after you close the window.

## 4. Install Duplicati {#install-duplicati}

---

**[!TAB Windows/Linux]**

[Download](https://www.duplicati.com/download) and install Duplicati.

**[!TAB macOS]**

To use Duplicati on macOS, you need the [Mono framework](https://www.mono-project.com/download/stable/#download-mac).

Once you have installed the Mono framework, [download](https://www.duplicati.com/download) and install Duplicati.

---

## 5. Configure Duplicati {#configure-duplicati}

To configure Duplicati to work with [!KEYREF objstorage-name]:

1. Run Duplicati. If required, set a password for your account.
1. Select the **Add backup** menu item.
1. Click **Configure a new backup**. Click **Next**.
1. Enter the backup plan name: `Yandex Cloud`. Enter the password and confirm if you chose to encrypt the backup. Click **Next**.
1. In the **Storage Type** field, specify `S3 compatible`.
1. In the **Server** list, specify `Custom server URL`. In the field below, enter the address `storage.yandexcloud.net/`.
1. In the **Bucket name** field, enter the name of your public bucket: `backup`.
1. In the **AWS Access ID** field, specify the ID of the static access key.
1. In the **AWS Access Key** field, enter the private key.
1. Click **Test connection** to make sure the settings are correct. A window opens prompting you to add the username to the bucket name. Click **No**.
1. After checking the settings, click **Next**.
1. Select the files that you want to back up.
1. Click **Next**.
1. Set the backup schedule or deselect the **Automatically run backups** option to create backups manually. Click **Next**.
1. Specify the volume size and set the storage duration. Click **Save**.

## 6. Test your backup {#test-backup}

To test a backup:

1. Open the **Home** menu item.
1. In the list of backup plans next to the `Yandex Cloud` plan, click **Run now**.
1. Open the [management console](https://console.cloud.yandex.ru).
1. Go to the folder containing the bucket where your backups are stored.
1. Open the **Object Storage** service.
1. Open the `backup` bucket and check whether all the necessary files have been copied.

