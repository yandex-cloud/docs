# Backup to {{ objstorage-full-name }} using MSP360 Backup (CloudBerry Desktop Backup)

You can use {{ objstorage-full-name }} to backup and restore data via [MSP360 Backup](https://www.msp360.com/msp360-free-backup/).

MSP360 Backup (formerly CloudBerry Desktop Backup) is designed to backup and restore data, including in cloud storages. The free version of MSP360 Backup allows you to create a maximum of 200 GB of backups.

To set up backup in {{ objstorage-name }} using MSP360 Backup:
1. [Get your cloud ready](#prepare-cloud).
1. [Set up a service account](#prepare-service-account).
1. [Create a bucket](#create-bucket).
1. [Install MSP360 Backup](#install-cloudberry).
1. [Configure MSP360 Backup](#configure-cloudberry).
1. [Test the backup process](#test-backup).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of backup via MSP360 Backup includes:
* Data storage fee
* Fee for operations with data
* Fee for outbound traffic from {{ yandex-cloud }} to the Internet

Learn more about [{{ objstorage-full-name }} pricing plans](../../storage/pricing.md#prices).

## Set up a service account {#prepare-service-account}

Backups in {{ objstorage-name }} are performed on behalf of a [service account](../../iam/concepts/users/service-accounts.md). If you do not have a service account, [create](../../iam/operations/sa/create.md) one.

To create a service account:
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `editor` [role](../../iam/roles-reference.md#editor) to the service account.
1. [Create](../../iam/operations/sa/create-access-key.md) a static access key. Save the [ID and the secret key](../../iam/concepts/authorization/access-key.md#access-key-format) right away. After you close the window, the secret key will not be available.


## Create a bucket {#create-bucket}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [create-bucket](../_tutorials_includes/create-public-bucket.md) %}

{% endlist %}

## Install MSP360 Backup {#install-cloudberry}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. (Optional) [Install](https://dotnet.microsoft.com/en-us/download) Microsoft .NET Framework.
  1. [Install](https://www.msp360.com/cloudberry-backup/download/cbbbm/) MSP360 Backup Desktop Edition. To download, enter the required details and click **Download**.
  1. Run MSP360 Backup and select **Use Home Edition (free)**. Click **Next**.
  1. Click **Start Free Trial**.

- Linux/macOS {#linux-macos}

  1. Install MSP360 Backup. Select an OS to download:  
       * [macOS](https://www.msp360.com/cloudberry-backup/download/cbbmac/)
       * [Ubuntu, Debian](https://www.msp360.com/cloudberry-backup/download/cbbub1214/)
       * [SUSE, Red Hat, Fedora, CentOS](https://www.msp360.com/cloudberry-backup/download/cbbrh6/)
       
       Enter the required details and click **Download**.
  1. Run MSP360 Backup and select **Use Home Edition (free)**. Click **Next**.
  1. Enter your email address and click **Finish**.
  1. In the window that opens, click **OK**.

{% endlist %}

## Configure MSP360 Backup {#configure-cloudberry}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. Run MSP360 Backup.
  1. Click the MSP360 Backup logo in the upper left corner to open the main menu.
  1. Select **Add Storage Account**.
  1. In the list of providers, select **S3 Compatible**.
  1. In the window that opens, enter the storage parameters:
      * **Display Name**: `{{ yandex-cloud }}`.
      * **Access Key**: The ID of the static access key.
      * **Secret Key**: The private key.
      * **Service point**: `http://{{ s3-storage-host }}/`. The **Bucket name** field should display a list of your buckets.
      * **Bucket name**: The bucket where your backups will be stored.

      Click **OK**. If everything is configured correctly, the `{{ yandex-cloud }}` storage will appear in the **Storaged accounts** window. Close the window.
  1. Click **Home**.
  1. Select **Local to Cloud**. In the window that opens, click **Next**.
  1. Select the **{{ yandex-cloud }}** storage and click **Next**.
  1. Enter `cloud-backup-plan` for the backup plan name and click **Next**.
  1. Leave the default options and click **Next**.
  1. In the file tree, specify the directories and files that you want to back up. Click **Next**.
  1. To retain a copy of all files in the selected folders, click **Backup all files in selected folders**. Click **Next**.
  1. On the screen warning that you cannot compress and encrypt your backups in the free version, click **Next**.
  1. To check your backups for integrity, leave the **Enable Full Consistency Check** option enabled. Click **Next**.
  1. By default, backups are made manually. If you need to set a backup schedule, select **Enable schedule** and set up the schedule. Click **Next**.
  1. Set the file storage duration. By default, backups are stored permanently. Click **Next**.
  1. On the **Pre / Post Actions** (actions before and after the backup) screen, leave the default settings and click **Next**.
  1. To get notified about the copying results, enable **I want to receive a notification email** and specify the cases:
      * **When the backup plan fails or finished with warnings**.
      * **In all cases**.

      Enter the email address, recipient name, and email subject. Click **Next**. In the window with information that you need to confirm your email to receive notifications, click **Ok**. Check your mailbox. In the message that you received, click a link to confirm your email address. 
  1. Check the backup plan and click **Next**.
  1. Click **Finish**.

- Linux/macOS {#linux-macos}

  1. Run MSP360 Backup.
  1. Click **Backup files**.
  1. Click **+** and select **S3 Compatible**. 
  1. In the window that opens, enter the storage parameters:
     * **Display Name**: `{{ yandex-cloud }}`.
     * **Access Key**: The ID of the static access key.
     * **Secret Key**: The private key.
     * **Endpoint**: `http://{{ s3-storage-host }}/`. The **Bucket** field will display a list of your buckets.
     * **Bucket**: Bucket where your backups will be stored.
     * **Advanced settings**: Advanced settings. Leave the default values.

     Click **OK**. If everything is configured correctly, the `{{ yandex-cloud }}` storage will appear in the **Backup plan: cloud storage** window.
  1. Select the **{{ yandex-cloud }}** storage and click **Continue**.
  1. Enter the backup plan name: `cloud-backup-plan`. Click **Continue**.
  1. In the file tree, specify the directories and files that you want to back up. Click **Continue**.
  1. To add all files from the selected folders to the backup, leave the checkbox at **Backup all files in selected folders**. Click **Continue**.
  1. On the screen warning that you cannot compress and encrypt your backups in the free version, click **Continue**.
  1. To check your backups for integrity, leave the **Enable Full Consistency Check** option enabled. Click **Continue**.
  1. By default, backups are made manually. If you need to set a backup schedule, select **Enable schedule** and set up the schedule. Click **Continue**.
  1. Set the file storage duration. By default, backup storage is not limited in time. Click **Continue**.
  1. To get notified about the backup results, enable **I want to receive a notification email when plan completes** and specify the cases:
      * **In all cases**.
      * **When plan fails**: When the plan fails fatally or completes with warnings.

      Enter the email address, recipient name, and email subject. If you need a detailed report, select **Generate detailed report**. Click **Next**. Check your mailbox. In the message that you received, click a link to confirm your email address.
  1. Check the backup plan and click **Done**.

{% endlist %}

## Test the backup procedure {#test-backup}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. In the MSP360 Backup app, select the **Backup plans** tab.
  1. To start the backup, click ![image](../../_assets/console-icons/play-fill.svg) in the `cloud-backup-plan` row.
  1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), select the folder the backup bucket is in.
  1. Select **{{ objstorage-short-name }}**.
  1. In the list of buckets, select the bucket with your backups and check whether all the required files have been copied.

- Linux/macOS {#linux-macos}

  1. In the MSP360 Backup app, in the left panel, select the **Backup plans** tab.
  1. To start the backup, select `cloud-backup-plan` and click **Start**.
  1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), select the folder the backup bucket is in.
  1. Select **{{ objstorage-short-name }}**.
  1. In the list of buckets, select the bucket with your backups and check whether all the required files have been copied.

{% endlist %}

## How to delete the resources you created {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}
