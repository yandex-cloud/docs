# {{ objstorage-full-name }} backup with Veritas Backup Exec

You can use {{ objstorage-full-name }} for backup and recovery using Veritas Backup Exec.

To set up {{ objstorage-name }} backup using Veritas Backup Exec:

1. [Get your cloud ready](#before-begin).
1. [Create a bucket](#create-bucket).
1. [Set up a service account](#configure-service-account).
1. [Create a cloud instance on {{ objstorage-full-name }}](#new-becloudinstance).
1. [Configure cloud storage](#setup-cloud).
1. [Add a server for backup](#add-source).
1. [Configure the backup settings](#add-target).
1. [Test backup](#test-backup).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of backup using Veritas Backup Exec includes:

* Fee for data storage.
* Fee for data operations.
* Fee for outbound traffic from {{ yandex-cloud }} to the internet.

Learn more about the [{{ objstorage-full-name }} pricing plans](../../storage/pricing.md#prices).

## Create a bucket {#create-bucket}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [create-bucket](../_tutorials_includes/create-public-bucket.md) %}

{% endlist %}

## Set up a service account {#configure-service-account}

In {{ objstorage-name }}, you back up data under a [service account](../../iam/concepts/users/service-accounts.md). If you do not have a service account, [create](../../iam/operations/sa/create.md) one.

To create a service account:

1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.admin` [role](../../storage/security/index.md#storage-admin) to the service account.
1. [Create](../../iam/operations/authentication/manage-access-keys.md#create-access-key) static access keys. Save the ID and the secret key right away. After you close the window, the private key properties will no longer be available.

## Create a cloud instance on {{ objstorage-full-name }} {#new-becloudinstance}

1. Start the Backup Exec Management Command Line Interface and run this command:

    ```bash
    BEMCLI> New-BECloudInstance
    ```

1. Enter the cloud instance properties one by one:
    * `Provider:`: `compatible-with-s3`
    * `ServiceHost:`: `{{ s3-storage-host }}`
    * `SslMode:`: `disabled`
    * `Name:`: `cloud`

    Result:

    ```text
    cmdlet New-BECloudInstance at command pipeline position 1
    Supply values for the following parameters:
      Provider: compatible-with-s3
      ServiceHost: {{ s3-storage-host }}
      SslMode: disabled
      Name: cloud


    Name        : cloud
    Id          : 12436533-a39e-4df6-81db-f836********
    Provider    : compatible-with-s3
    ServiceHost : {{ s3-storage-host }}
    SslMode     : Disabled
    UrlStyle    : Path
    HttpPort    : 80
    HttpsPort   : 443
    Endpoint    :
    ```

## Configure cloud storage {#setup-cloud}

1. Run Veritas Backup Exec.
1. On the **Storage** panel, select **Configure cloud storage**.
1. Enter a **Name** for the cloud storage device and click **Next**.
1. Select a vendor for **S3** and click **Next**.
1. Enter the connection info:
    * Select **Cloud storage** `cloud [ compatible-with-s3 ]`.
    * Next to **Logon account**, click **Add/Edit**.
    * In the **Logon account** selection window, click **Add**.
    * In the **Username** field, enter the key ID.
    * In the **Password** field, enter the secret key.
    * Enter the secret key once again to confirm it.
    * Enter an **Account name**, e.g., `Administrator of Bucket`.
    * Confirm the name of your account and click **OK**.
    * Click **Next**.
1. Select a bucket for backup and click **Next**.
1. Select the number of parallel operations for the device and click **Next**.
1. Double-check the settings you selected and click **Done**.

## Add a server for backup {#add-source}

1. Open the **Backup and restore** tab in Veritas Backup Exec.
1. From the **Servers and Virtual Hosts** drop-down list, select **Add**.
1. Select **Microsoft Windows computers and servers** and click **Next**.
1. Enable **Allow Backup Exec to establish a trust with the servers** and click **Next**.
1. Add the server and click **Next**.
1. Optionally, enable the settings for updating the agent and restarting a remote computer and click **Next**.
1. Double-check the settings you selected and click **Install**.

## Configure the backup settings {#add-target}

1. Open the **Backup and restore** tab in Veritas Backup Exec.
1. Select the server you added at the previous step.
1. From the **Backup** drop-down list, select **Back Up to Cloud**.
1. Double-check the backup settings and modify them if required.

   Select the cloud device you created earlier as the storage.
1. Click **OK**.

## Test backup {#test-backup}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder with backups.
  1. Select **{{ objstorage-short-name }}**.
  1. Open the bucket with backups and check whether all relevant files were copied.

{% endlist %}

## How to delete the resources you created {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}
