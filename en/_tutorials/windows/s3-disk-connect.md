# Mounting a bucket as a disk on Windows

In this tutorial, you'll use [rclone](https://rclone.org) to set up synchronization of data between an {{ objstorage-full-name }} bucket and your local desktop. The bucket will be mounted as a disk in Windows.

To mount your bucket as a disk:

1. [Prepare your cloud](#before-begin).
1. [Set up a work environment](#environment-prepare).
1. [Create a service account](#create-sa).
1. [Create a static access key](#create-static-key).
1. [Create a bucket](#bucket-create).
1. [Set up a connection to {{ objstorage-name }}](#rclone-config).
1. [Mount the bucket](#bucket-mount).
1. [Set up the mounting service](#mount-service).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if audience != "internal" %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost for bucket support includes:

* A fee for storing data in a bucket (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-storage)).
* A fee for data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-operations)).

{% endif %}

{% endif %}

## Set up a working environment {#environment-prepare}

1. Download and install the [winfsp distribution](https://winfsp.dev/rel/) from the developer site.
1. Download the [archive with sysinternals suite utilities](https://docs.microsoft.com/en-us/sysinternals/downloads/) and unpack it to your working directory on your local desktop.
1. From the developer's site, download an [archive with the Windows Service Wrapper (winsw)](https://github.com/winsw/winsw/releases) and unpack it to your local working directory.
1. From the developer's site, download an [archive with the rclone utility](https://rclone.org/downloads/) and unpack it to your local working directory.

## Create a service account {#create-sa}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder where you wish to create a service account.
   1. Go to the **Service accounts** tab.
   1. Click **Create service account**.
   1. Enter the service account name: `sa-win-disk-connect`.
   1. Click ![](../../_assets/plus-sign.svg) **Add role** and select the `storage.editor` role.
   1. Click **Create**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Create a service account named `sa-win-disk-connect`:

   ```bash
   yc iam service-account create --name sa-win-disk-connect
   ```

   Name format requirements:

   {% include [name-format](../../_includes/name-format.md) %}

   For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/managed-services/iam/service-account/create.md).

- API

   To create the service account, use the {% if audience != "internal" %}[create](../../iam/api-ref/ServiceAccount/create.md){% else %}create{% endif %} method for the {% if audience != "internal" %}[ServiceAccount](../../iam/api-ref/ServiceAccount/index.md){% else %}ServiceAccount{% endif %} resource.

{% endlist %}

## Create a static access key {#create-static-key}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. Go to the **Service accounts** tab.
   1. Choose `sa-win-disk-connect` and click the line with its name.
   1. Click ![](../../_assets/plus-sign.svg) **Create new key** in the top panel.
   1. Select **Create static access key**.
   1. Specify the key description and click **Create**.
   1. Save the ID and private key. After the dialog is closed, the private key value will be unavailable.

- CLI

   1. Create an access key for `sa-win-disk-connect`:

      ```bash
      yc iam access-key create --service-account-name sa-win-disk-connect
      ```

      Result:

      ```
      access_key:
        id: aje6t3vsbj8lp9r4vk2u
        service_account_id: ajepg0mjt06siuj65usm
        created_at: "2022-07-18T14:37:51Z"
        key_id: 0n8X6WY6S24N7Oj*****
      secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI9hx*****
      ```

      For more information about the `yc iam access-key create` command, see the [CLI reference](../../cli/cli-ref/managed-services/iam/access-key/create.md).

   1. Save the ID `key_id` and `secret` key. You will not be able to get the key value again.

- API

   To create an access key, use the {% if audience != "internal" %}[create](../../iam/api-ref/AccessKey/create.md){% else %}create{% endif %} method for the {% if audience != "internal" %}[AccessKey](../../iam/api-ref/AccessKey/index.md){% else %}AccessKey{% endif %} resource.

{% endlist %}

## Create a bucket {#bucket-create}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
   1. In the list of services, select **{{ objstorage-name }}**.
   1. Click **Create bucket**.
   1. Enter the **Name** of the bucket: `bucket-for-win`.
   1. In the **Object read access** and **Object listing access** fields, select **Public**.
   1. Click **Create bucket**.

- AWS CLI

   1. If you don't have the AWS CLI yet, [install and configure it](../../storage/tools/aws-cli.md).
   1. Create a bucket named `bucket-for-win`:

      ```bash
      aws --endpoint-url https://{{ s3-storage-host }} \
        s3 mb s3://bucket-for-win
      ```

      Result:

      ```
      make_bucket: bucket-for-win
      ```

   1. Enable public access to reading objects and their list:

      ```bash
      aws --endpoint-url https://{{ s3-storage-host }} \
        s3api put-bucket-acl \
        --bucket bucket-for-win \
        --acl public-read
      ```

- {{ TF }}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. Add the parameters of the `bucket-for-win` bucket to the configuration file:

      ```
      resource "yandex_storage_bucket" "bucket-for-win" {
        bucket = "bucket-for-win"
        acl    = "public-read"
      }
      ```

      For more information about the `yandex_storage_bucket` resource, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/storage_bucket).

   1. Make sure that the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contains errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```bash
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

- API

   Use the [create](../../storage/s3/api-ref/bucket/create.md) REST API method.

{% endlist %}

## Set up a connection to {{ objstorage-name }} {#rclone-config}

1. Open the command prompt in your working directory and run the command:

   ```powershell
   psexec -i -s cmd.exe
   ```

1. In the console that opens, run `whoami` and make sure that the session has been started by the system user.
1. Run a configuration session for `rclone`:

   ```powershell
   rclone.exe config
   ```

1. Follow the prompts to create a new connection profile:

   1. Select creation of a new profile: enter `n` in the terminal.
   1. Enter the connection name: `s3-connect`.
   1. Select the storage type: enter `5` in the terminal.
   1. Select a provider: enter `1` in the terminal.
   1. Select manual entry of credentials: enter `1` in the terminal.
   1. Enter the secret key ID in the terminal.
   1. Enter the secret key value in the terminal.
   1. Specify a region: enter `{{ region-id }}` in the terminal.
   1. Specify an endpoint: enter `{{ s3-storage-host }}` in the terminal.
   1. You can leave other settings at defaults: press **Enter** to skip them.

{% note info %}

If needed, you can run an advanced connection setup. For this, at the `Edit advanced config?` prompt, enter `y` in the terminal. For more about advanced settings, see the [documentation page](https://rclone.org/s3/) of the `rclone` utility.

{% endnote %}

## Mount a bucket {#bucket-mount}

1. Check the connection to the bucket. In the same terminal where you configured your connection, run the command:

   ```powershell
   rclone.exe ls s3-connect:bucket-for-win
   ```

   If the configuration is set up correctly, the objects in the bucket are listed in the console.

1. Mount the bucket to the file system:

   ```powershell
   rclone.exe mount s3-connect:bucket-for-win <disk letter>: --vfs-cache-mode full
   ```

   You'll see a new disk with the objects from the bucket in the Windows Explorer.

1. Unmount the bucket:

   ```powershell
   rclone.exe unmount s3-connect:bucket-for-win
   ```

## Set up the mounting service {#mount-service}

To mount the bucket at your desktop startup, set up mounting on behalf of the system service.

1. In the working directory, create `rclone.xml` with the following contents:

   ```xml
   `<service>`
   `<id>rclone</id>`
   `<name>rclone-s3-disk</name>`
   `<description>This service maps an S3 bucket as a system drive.</description>`
   `<executable>"<path to the working directory>\rclone.exe"</executable>`
   `<arguments>mount s3-connect:bucket-for-win <disk letter>: --vfs-cache-mode full</arguments>`
   `<log mode="roll" />`
   `<onfailure action="restart" />`
   `</service>`
   ```

1. Open the command prompt as a system administrator and execute the command:

   ```powershell
   WinSW-x64.exe install .\\rclone.xml
   ```

1. Open the Windows services panel and make sure that `rclone-s3-disk` is listed:

   1. Click **Win**+**R**.
   1. In the window that opens, enter `services.msc` and click **OK**.
   1. In the service list, find `rclone-s3-disk`.

1. Reboot your desktop and check that the disk is available.

{% note info %}

You can also set up the service to start on behalf of the system user (for more information, see [Service account](https://github.com/winsw/winsw/blob/v3/docs/xml-config-file.md#service-account) in the `WinSW` utility documentation).

{% endnote %}

## How to delete created resources {#clear-out}

To stop paying for the resources created:

* [Delete objects](../../storage/operations/objects/delete-all.md) from `bucket-for-win`.
* [Delete](../../storage/operations/buckets/delete.md) `bucket-for-win`.
