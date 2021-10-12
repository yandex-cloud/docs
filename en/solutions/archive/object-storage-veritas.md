# Backup to {{ objstorage-full-name }} via Veritas Backup Exec

To set up backups in {{ objstorage-name }} via Veritas Backup Exec:

1. [{#T}](#before-you-begin)
1. [{#T}](#create-bucket)
1. [{#T}](#create-service-account)
1. [{#T}](#create-access-key)
1. [{#T}](#new-becloudinstance)
1. [{#T}](#setup-cloud)
1. [{#T}](#add-source)
1. [{#T}](#add-target)

## Before you start {#before-you-begin}

Before using {{ objstorage-full-name }}, sign up for {{ yandex-cloud }} and create a billing account:

{% include [prepare-register-billing](../../_includes/solutions/_common/prepare-register-billing.md) %}

If you have an active billing account, you can create or select a folder to place your bucket in. Go to the [Yandex.Cloud homepage](https://console.cloud.yandex.com/cloud) and select or create a folder where you want to create a bucket. [Learn more about the resource hierarchy in {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md).

### Required paid resources {#paid-resources}

The cost for backup and recovery includes:

* A fee for data storage (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-storage)).
* A fee for data operations (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-operations)).
* The cost of outgoing traffic from {{ yandex-cloud }} to the internet (see [{{ objstorage-full-name }} pricing](../../storage/pricing#prices-storage.md#prices-traffic)).

## Create a bucket {#create-bucket}

To create a bucket for backups:

{% include [create-bucket](../_solutions_includes/create-public-bucket.md) %}

## Create a service account {#create-service-account}

Create a [service account](../../iam/operations/sa/create.md) with the role `storage.admin`.

## Create a static access key {#create-access-key}

Create [static access keys](../../iam/operations/sa/create-access-key.md). Save the ID and secret key: you'll need them in the next steps. You won't be able to access the private key parameters again after you close the window.

## Create a cloud instance on {{ objstorage-full-name }} {#new-becloudinstance}

Start the **Backup Exec Management Command Line Interface** and run the command:

```bash
BEMCLI> New-BECloudInstance
```

Enter the cloud instance parameters one-by-one:

* `Provider:` `compatible-with-s3`.
* `ServiceHost:` `storage.yandexcloud.net`.
* `SslMode:` `disabled`.
* `Name:` `Yandex-Cloud`.

Command execution result:

```text
cmdlet New-BECloudInstance at command pipeline position 1
Supply values for the following parameters:
Provider: compatible-with-s3
ServiceHost: storage.yandexcloud.net
SslMode: disabled
Name: Yandex-Cloud


Name        : yandex-cloud
Id          : 12436533-a39e-4df6-81db-f8365eb4178d
Provider    : compatible-with-s3
ServiceHost : storage.yandexcloud.net
SslMode     : Disabled
UrlStyle    : Path
HttpPort    : 80
HttpsPort   : 443
Endpoint    :
```

## Configure cloud storage {#setup-cloud}

1. Start **Veritas Backup Exec**.
1. On the **Storage** panel, select **Configure cloud storage**.
1. Enter a **Name** for the cloud storage device and click **Next**.
1. Select a vendor for the **S3** device and click **Next**.
1. Enter the connection information:
    * Select **Cloud storage** `yandex-cloud [ compatible-with-s3 ]`.
    * Next to **Logon account**, click **Add/Edit**.
    * In the **Logon account selection** window, click **Add**.
    * In the **User name** field, enter the key ID.
    * In the **Password** field, enter the secret key.
    * Repeat the password in the **Confirm password** field.
    * Set an **Account name**, for example, `Administrator of Bucket`.
    * Click **OK**, **OK**.
    * Click **Next**.
1. Select a backup bucket and click **Next**.
1. Select the number of parallel operations for the device and click **Next**.
1. Check the selected settings and click **Done**.

## Add a server for backup {#add-source}

1. Start **Veritas Backup Exec**.
1. Open the **Backup and Restore** panel.
1. In the **Servers and Virtual Hosts** drop-down list, select **Add**.
1. Select **Microsoft Windows computer**, click **Next**.
1. Enable **Allow Backup Exec to establish a trust with the servers** and click **Next**.
1. Add a server and click **Next**.
1. (optional) Select the options for the agent update and remote computer restart and click **Next**.
1. Check the selected settings and click **Install**.

## Configure the backup task {#add-target}

1. Start **Veritas Backup Exec**.
1. Open the **Backup and Restore** panel.
1. Select the server you added in the previous step.
1. In the **Backup** drop-down list, select **Back Up to Cloud**.
1. (optional) Check and edit the backup settings.
    Be sure to select the cloud device you created earlier as a storage.
1. Click **OK**.

