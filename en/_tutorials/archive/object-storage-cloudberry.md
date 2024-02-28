# Backup to {{ objstorage-full-name }} via CloudBerry Desktop Backup

You can use {{ objstorage-full-name }} for backup and recovery via [CloudBerry Desktop Backup](https://www.msp360.com/backup/).

The free version of CloudBerry Desktop Backup allows you to create a maximum of 200 GB of backups.

To set up backups in {{ objstorage-name }} via CloudBerry Desktop Backup:
1. [Prepare your cloud](#before-you-begin).
1. [Set up a service account](#prepare-service-account).
1. [Create a bucket](#create-bucket).
1. [Install CloudBerry Desktop Backup](#install-cloudberry).
1. [Configure CloudBerry Desktop Backup](#configure-cloudberry).
1. [Test the backup process](#test-backup).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The price for backups via CloudBerry Desktop Backup includes:
* Data storage fees.
* Data operations fees.
* Fees for the outbound traffic from {{ yandex-cloud }} to the Internet.

Learn more about [{{ objstorage-full-name }} pricing plans](../../storage/pricing.md#prices).


## Set up a service account {#prepare-service-account}

Backups in {{ objstorage-name }} are performed on behalf of a [service account](../../iam/concepts/users/service-accounts.md). If you do not have a service account, [create](../../iam/operations/sa/create.md) one.

To create a service account:
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `editor` [role](../../iam/roles-reference.md#editor) to your service account.
1. [Create](../../iam/operations/sa/create-access-key.md) static access keys. Save the ID and the secret key right away. After you close the window, the private key parameters will become unavailable.


## Create a bucket {#create-bucket}

{% list tabs group=instructions %}

- Management console {#console}

   {% include [create-bucket](../_tutorials_includes/create-public-bucket.md) %}

{% endlist %}

## Install CloudBerry Desktop Backup {#install-cloudberry}

{% list tabs group=operating_system %}

- Windows {#windows}

   1. [Install](https://dotnet.microsoft.com/en-us/download) the Microsoft .NET Framework.
   1. [Install](https://www.msp360.com/cloudberry-backup/download/cbbbm/) CloudBerry Backup. To download the program, enter the required parameters and click **Download**.
   1. Run CloudBerry Backup and select **Use Home Edition (free)**. Click **Next**.
   1. Click **Start Free Trial**.

- Linux/macOS {#linux-macos}

   1. Install CloudBerry Backup. To download the program, enter the required parameters and click **Download**.  
      [Installing on macOS](https://www.msp360.com/cloudberry-backup/download/cbbmac/)  
      [Installing on Linux](https://www.msp360.com/cloudberry-backup/download/cbbub1214/)
   1. Run CloudBerry Backup and select **Use Home Edition (free)**. Click **Next**.
   1. Enter your email address, then click **Finish**.
   1. In the window that opens, click **OK**.

{% endlist %}

## Configure CloudBerry Backup {#configure-cloudberry}

{% list tabs group=operating_system %}

- Windows {#windows}

   1. Run CloudBerry Backup.
   1. To open the main menu, click the CloudBerry Backup logo in the top-left corner.
   1. Select **Add Storage Account** and click **Show more**.
   1. In the list of providers, select **S3 compatible**.
   1. In the window that opens, enter the storage parameters:
      * **Display Name**: `{{ yandex-cloud }}`.
      * **Access Key**: The ID of the static access key.
      * **Secret Key**: The private key.
      * **Service point**: `http://{{ s3-storage-host }}/`. The **Bucket name** field should display a list of your buckets.
      * **Bucket name**: The bucket where your backups will be stored.

      Click **OK**. If everything is configured correctly, the `{{ yandex-cloud }}` storage will appear in the **Storaged accounts** window. Close the window.
   1. Click **Home**. The backup wizard opens.
   1. Select **Local to Cloud**. In the window that opens, click **Next**.
   1. Select the **{{ yandex-cloud }}** storage and click **Next**.
   1. Enter the `cloud-backup-plan` name for the backup plan and click **Next**.
   1. Don't change the default options, then click **Next**.
   1. In the file tree, specify the directories and files that you want to back up. Click **Next**.
   1. To retain a copy of all files in the selected folders, click **Backup all files in selected folders**. Click **Next**.
   1. On the warning screen saying that you cannot encrypt your backups, click **Next**.
   1. Do not change the default file deletion settings. Click **Next**.
   1. Do not change default settings for the backup schedules. Click **Next**.
   1. Do not change the default additional action settings. Click **Next**.
   1. To get notified about the copying results, enable **I want to receive a notification email** and specify the cases:
      * **When the backup plan fails or finished with warnings**.
      * **In all cases**.

      Enter the email address, recipient name, and email subject. Click **Next**. Check your mailbox. In the message that you received, click a link to confirm your email address.
   1. Check the backup plan and click **Next**.
   1. Click **Finish**.

- Linux/macOS {#linux-macos}

   1. Run CloudBerry Backup.
   1. Click **Backup files**.
   1. Click **+** and select **S3 compatible**.
   1. In the window that opens, enter the storage parameters:
      * **Display Name**: `{{ yandex-cloud }}`.
      * **Access Key**: The ID of the static access key.
      * **Secret Key**: The private key.
      * **Service point**: `http://{{ s3-storage-host }}/`. The **Bucket name** field should display a list of your buckets.
      * **Bucket name**: The bucket where your backups will be stored.

      Click **OK**. If everything is configured correctly, the `{{ yandex-cloud }}` storage will appear in the **Storaged accounts** window. Close the window.
   1. Select the **{{ yandex-cloud }}** storage and click **Continue**.
   1. Enter the backup plan name: `cloud-backup-plan`. Click **Continue**.
   1. In the file tree, specify the directories and files that you want to back up. Click **Continue**.
   1. To add all files from the selected folders to the backup, leave the checkbox at **Backup all files in selected folders**. Click **Continue**.
   1. On the warning screen saying that you cannot encrypt your backups, click **Continue**.
   1. Set the duration of file storage and the number of backups. By default, the three most recent backups are stored simultaneously. To use default settings, enable **Use default**. Click **Continue**.
   1. By default, backups are made manually. If you need to set a backup schedule, select **Enable schedule** and set up the schedule. Click **Continue**.
   1. To get notified about the backup results, enable **I want to receive a notification email when plan completes** and specify the cases:
      * **In all cases**.
      * **When plan fails**: When the plan fails fatally or completes with warnings.

      Enter the email address, recipient name, and email subject. Click **Next**. Check your mailbox. In the message that you received, click a link to confirm your email address.
   1. Check the backup plan and click **Done**.

{% endlist %}

## Test the backup procedure {#test-backup}

{% list tabs group=operating_system %}

- Windows {#windows}

   1. Open the **Backup plans** tab.
   1. To run a manual backup, next to `cloud-backup-plan`, click ![запуск копирования](../../_assets/tutorials/arrow-button.png =12x12).
   1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), go to the folder hosting the bucket with backups.
   1. Select **{{ objstorage-short-name }}**.
   1. In the list of buckets, select the bucket with your backups.
   1. Make sure that all the relevant files have been backed up.

- Linux/macOS {#linux-macos}

   1. Open the **Backup plans** tab.
   1. To run a manual backup, next to `cloud-backup-plan`, click **Start**.
   1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), go to the folder hosting the bucket with backups.
   1. Select **{{ objstorage-short-name }}**.
   1. In the list of buckets, select the bucket with your backups.
   1. Make sure that all the relevant files have been backed up.

{% endlist %}

## How to delete the resources you created {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}
