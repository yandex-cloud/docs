# Backup to {{ objstorage-full-name }} via Veritas Backup Exec

You can use {{ objstorage-full-name }} for backup and recovery via Veritas Backup Exec.

To set up backups in {{ objstorage-name }} via Veritas Backup Exec:

1. [Get your cloud ready](#before-begin).
1. [Create a bucket](#create-bucket).
1. [Set up a service account](#configure-service-account).
1. [Create a cloud instance on {{ objstorage-full-name }}](#new-becloudinstance)
1. [Configure a cloud storage](#setup-cloud).
1. [Add a server for backup](#add-source).
1. [Configure backup settings](#add-target).
1. [Test the backup process](#test-backup).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The price for backups via Veritas Backup Exec includes:

* Data storage fee.
* Fee for operations with data.
* Fee for outbound traffic from {{ yandex-cloud }} to the Internet.

Learn more about [{{ objstorage-full-name }} pricing plans](../../storage/pricing.md#prices).

## Create a bucket {#create-bucket}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [create-bucket](../_tutorials_includes/create-public-bucket.md) %}

{% endlist %}

## Set up a service account {#configure-service-account}

Backups in {{ objstorage-name }} are performed on behalf of a [service account](../../iam/concepts/users/service-accounts.md). If you do not have a service account, [create](../../iam/operations/sa/create.md) one.

To create a service account:

1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.admin` [role](../../storage/security/index.md#storage-admin) to the service account.
1. [Create](../../iam/operations/sa/create-access-key.md) static access keys. Save the ID and the secret key right away. After you close the window, the private key parameters will become unavailable.

## Create a cloud instance on {{ objstorage-full-name }} {#new-becloudinstance}

1. Start the Backup Exec Management Command Line Interface and run the command:

    ```bash
    BEMCLI> New-BECloudInstance
    ```

1. Enter the cloud instance parameters one by one:
    * `Provider:`: `compatible-with-s3`.
    * `ServiceHost:`: `{{ s3-storage-host }}`.
    * `SslMode:`: `disabled`.
    * `Name:`: `cloud`.

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
1. Select a vendor for the **S3** device and click **Next**.
1. Enter the connection information:
    * Select **Cloud storage** `cloud [ compatible-with-s3 ]`.
    * Next to **Logon account**, click **Add/Edit**.
    * In the **Logon account** selection window, click **Add**.
    * In the **User name** field, enter the key ID.
    * In the **Password** field, enter the secret key.
    * Enter the secret key once again to confirm it.
    * Enter an **Account name**, e.g., `Administrator of Bucket`.
    * Confirm the account name and click **OK**.
    * Click **Next**.
1. Select a backup bucket and click **Next**.
1. Select the number of parallel operations for the device and click **Next**.
1. Check the selected settings and click **Done**.

## Add a server for backup {#add-source}

1. Open the **Backup and restore** tab in Veritas Backup Exec.
1. In the **Servers and Virtual Hosts** drop-down list, select **Add**.
1. Select **Microsoft Windows computers and servers**, and then click **Next**.
1. Enable **Allow Backup Exec to establish a trust with the servers** and click **Next**.
1. Add the server and click **Next**.
1. (Optional) Select the options for the agent update and remote computer restart and click **Next**.
1. Check the selected settings and click **Install**.

## Configure backup settings {#add-target}

1. Open the **Backup and restore** tab in Veritas Backup Exec.
1. Select the server you added in the previous step.
1. In the **Backup** drop-down list, select **Back Up to Cloud**.
1. Double-check the backup settings and modify them if needed.

   Select the cloud device that you created earlier, as a storage.
1. Click **OK**.

## Test the backup procedure {#test-backup}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder the bucket with backups is in.
  1. Select **{{ objstorage-short-name }}**.
  1. Open the bucket with backups and check whether all the relevant files were copied.

{% endlist %}

## How to delete the resources you created {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}
