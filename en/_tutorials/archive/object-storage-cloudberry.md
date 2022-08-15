# Backup to {{ objstorage-full-name }} via CloudBerry Desktop Backup

To set up backups in {{ objstorage-name }} via CloudBerry Desktop Backup:

1. [Before you start](#before-you-begin)
1. [Create a bucket](#create-bucket)
1. [Create a service account](#create-service-account)
1. [Create a static access key](#create-access-key)
1. [Install CloudBerry Desktop Backup](#install-cloudberry)
1. [Configure CloudBerry Desktop Backup](#configure-cloudberry)
1. [Test your backup](#test-backup)
1. [Delete the created cloud resources](#clear-out)

The free version of CloudBerry Desktop Backup allows you to create a maximum of 200 GB of backups.

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

## Install CloudBerry Desktop Backup {#install-cloudberry}

{% list tabs %}

- Windows

  1. [Download](https://www.msp360.com/download.aspx?prod=cbbbm&p=backup) and install CloudBerry Backup. To download it, enter your email address in the field and click **Download**
  1. Run CloudBerry Backup and select **Use Home Edition (free)**. Click **Next**.
  1. Enter the key from the message or click **I do not have activation code** and enter your email address. Click **Start FreeTrial**.

- macOS

  1. [Download](https://www.msp360.com/download.aspx?prod=cbbmac&p=backup) and install CloudBerry Backup. To download it, enter your email address in the field and click **Download**
  1. Run CloudBerry Backup and select **Use Home Edition (free)**. Click **Next**.
  1. Enter your username and email address. The registration key will be sent to the specified address.
  1. Check your email and copy and paste the received key into the **Enter registration key** field.
  1. Click **Finish**.
  1. In the window that opens, click **OK**.

- Linux

  1. [Download](https://www.msp360.com/download.aspx?prod=cbbub1214&p=backup) and install CloudBerry Backup. To download it, select the version for your Linux distribution, enter your email address in the field, and click **Download**
  1. Run CloudBerry Backup and select **Use Home Edition (free)**. Click **Next**.
  1. Enter your username and email address. The registration key will be sent to the specified address.
  1. Check your email and copy and paste the received key into the **Enter registration key** field.
  1. Click **Finish**.
  1. In the window that opens, click **OK**.

{% endlist %}

## Configure CloudBerry Backup {#configure-cloudberry}

To configure CloudBerry Backup to work with {{ objstorage-name }}:

{% list tabs %}

- Windows

  1. Run CloudBerry Backup.

  1. Open the main menu by clicking the button with the app icon in the top left corner.

  1. Select **Add New Account**.

  1. Click **Show more**.

  1. In the list of providers that opens, select **S3 compatible**.

  1. Click **S3 compatible**. The storage parameters window opens.
     1. In the **Display Name** field, enter `{{ yandex-cloud }}`.
     1. In the **Access Key** field, specify the ID of the static access key.
     1. In the **Secret Key** field, specify the private key.
     1. In the **Service point** field, specify `http://{{ s3-storage-host }}/`. The `Bucket name` field should display a list of your buckets.
     1. In the **Bucket name** field, select the bucket where your backups will be stored.
     1. Click **OK**. If everything is configured correctly, the `{{ yandex-cloud }}` storage will appear in the **Registered accounts** window. Close the window.

  1. Open the **Home** tab. The backup wizard opens.

  1. Choose **Local or Cloud Backup** and click **Next**.

  1. Select the `{{ yandex-cloud }}` storage and click **Next**.

  1. Enter the backup plan name: `yc-backup-plan`. Click **Next**.

  1. Select **Simple Mode** to create a simple non-encrypted copy and enable access to backups through any client apps. Click **Next**.

  1. Do not set any additional flags. Click **Next**.

  1. In the file tree, specify the directories and files that you want to back up. Click **Next**.

  1. Choose **Backup all files in selected folders** to make a copy of all files in the selected folders. Click **Next**.

  1. On the warning screen saying that you cannot encrypt your backups in the trial version, click **Next**.

  1. Do not change the file deletion settings. Click **Next**.

  1. Do not set any backup schedules. Click **Next**.

  1. Do not configure any additional actions. Click **Next**.

  1. If you want to get notifications about the progress of backups, select the **I want to receive a notification email when plan completes** option.

     If you only want to get notifications about failed backups, select the **When the plan fails** option. To get notifications about all events, select the **In all cases** option. Specify your email address in the **Email** field, name in the **User name** field, and the subject of the message from CloudBerry in the **Email subject** field. If this is the first time you are setting up notifications, you will receive a message asking you to confirm your email address. Follow the link in the message to enableget notifications. Click **Next**.

  1. Check the backup plan and click **Next**.

  1. Click **Finish**.

- macOS/Linux

  1. Run CloudBerry Backup.

  1. Click **Backup files**.

  1. Click **+**.

  1. Click **S3 compatible**. The storage parameters window opens.
     1. In the **Display Name** field, enter `{{ yandex-cloud }}`.
     1. In the **Access Key** field, specify the ID of the static access key.
     1. In the **Secret Key** field, specify the private key.
     1. In the **Endpoint** field, specify `http://{{ s3-storage-host }}/`. The `Bucket` field should display a list of your buckets.
     1. In the **Bucket** field, select the bucket where your backups will be stored.
     1. Click **OK**. If everything is configured correctly, the `{{ yandex-cloud }}` storage will appear in the list.

  1. Select the `{{ yandex-cloud }}` storage and click **Continue**.

  1. Enter the backup plan name: `yc-backup-plan`. Click **Continue**.

  1. In the file tree, specify the directories and files that you want to back up. Click **Continue**.

  1. Leave the option set to **Backup all files in selected folders** in order to make a copy of all files in the selected folders. Click **Continue**.

  1. Encryption is not available in the free version. Click **Continue**.

  1. Set the duration of file storage and the number of copies. By default, the three most recent backups are stored simultaneously. Select the **Use default** option to use the default settings. Click **Continue**.

  1. By default, backups are made manually. If you need to set a backup schedule, select the **Enable schedule** option and set the schedule. Click **Continue**.

  1. If you want to get notifications about the progress of backups, select the **I want to receive a notification email when plan completes** option.

     If you only want to get notifications about failed backups, select the **When the plan fails** option. To get notifications about all events, select the **In all cases** option. Specify your email address in the **Email** field, name in the **User name** field, and the subject of the message from CloudBerry in the **Email subject** field. If this is the first time you are setting up notifications, you will receive a message asking you to confirm your email address. Follow the link in the message to enableget notifications. Click **Continue**.

  1. Check the backup plan and click **Done**.

{% endlist %}

## Test the backup procedure {#test-backup}

To test a backup:

{% list tabs %}

- Windows

  1. Open the **Backup plans** tab.
  1. Next to the `yc-backup-plan` name, click the arrow button to manually start a backup.
  1. Open the [management console]({{ link-console-main }}).
  1. Go to the folder containing the bucket where your backups are stored.
  1. Select the **{{ objstorage-short-name }}** service.
  1. Open the `backup` bucket and check whether all the necessary files have been copied.

- macOS/Linux

  1. In the **Backup plans** section, select the `yc-backup-plan`.
  1. Click **Start** to manually start a backup.
  1. Open the [management console]({{ link-console-main }}).
  1. Go to the folder containing the bucket where your backups are stored.
  1. Select the **{{ objstorage-short-name }}** service.
  1. Open the `backup` bucket and check whether all the necessary files have been copied.

{% endlist %}

## How to delete created resources {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}

