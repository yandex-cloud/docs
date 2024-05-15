# Connecting a bucket as a disk in Windows

In this tutorial, you will use [rclone](https://rclone.org) to set up synchronization of data between an {{ objstorage-full-name }} bucket and your local desktop. The bucket will be mounted as a disk in Windows.

To mount your bucket as a disk:

1. [Prepare your cloud](#before-begin).
1. [Set up a work environment](#environment-prepare).
1. [Create a service account](#create-sa).
1. [Create a static access key](#create-static-key).
1. [Create a bucket](#bucket-create).
1. [Set up a connection to {{ objstorage-name }}](#rclone-config).
1. [Mount the bucket](#bucket-mount).
1. [Set up the mounting service](#mount-service).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}



### Required paid resources {#paid-resources}

The cost for bucket support includes:

* Fee for storing data in a bucket (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-storage)).
* Fee for data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-operations)).



## Set up a working environment {#environment-prepare}

1. Download and install the [winfsp distribution](https://winfsp.dev/rel/) from the developer site.
1. Download the [archive with sysinternals suite utilities](https://docs.microsoft.com/en-us/sysinternals/downloads/) from the developer's website and unpack it to your local working directory.
1. Download the [Windows Service Wrapper (WinSW) executable file](https://github.com/winsw/winsw/releases) depending on your OS configuration and save it to a separate directory.
1. Download the [archive with the rclone utility](https://rclone.org/downloads/) from the developer's website and unpack it to your local working directory.
1. Add the names of the directories with the utilities and the distribution to the `PATH` variable. To do this:

   1. Click **Start** and type **Change system environment variables** in the Windows search bar.
   1. Click **Environment Variables...** at the bottom right.
   1. In the window that opens, find the `PATH` parameter and click **Edit**.
   1. Add paths to the directories with the utilities to the list.
   1. Click **OK**.

## Create a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a folder where you want to create a service account.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. At the top right, click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, specify `sa-win-disk-connect`.
   1. Click ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `storage.editor` role.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Create a service account named `sa-win-disk-connect`:

   ```bash
   yc iam service-account create --name sa-win-disk-connect
   ```

   The name format requirements are as follows:

   {% include [name-format](../../_includes/name-format.md) %}

   For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/managed-services/iam/service-account/create.md).

- API {#api}

   To create the service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource.

{% endlist %}

## Create a static access key {#create-static-key}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Select the `sa-win-disk-connect` service account.
   1. In the top panel, click ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}**.
   1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
   1. Specify the key description and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
   1. Save the ID and private key. After you close the dialog, the private key value will become unavailable.

- {{ yandex-cloud }} CLI {#cli}

   1. Create an access key for `sa-win-disk-connect`:

      ```bash
      yc iam access-key create --service-account-name sa-win-disk-connect
      ```

      Result:

      ```
      access_key:
        id: aje6t3vsbj8l********
        service_account_id: ajepg0mjt06s********
        created_at: "2022-07-18T14:37:51Z"
        key_id: 0n8X6WY6S24N7Oj*****
      secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI9hx*****
      ```

      For more information about the `yc iam access-key create` command, see the [CLI reference](../../cli/cli-ref/managed-services/iam/access-key/create.md).

   1. Save the ID (`key_id`) and secret key (`secret`). You will not be able to get the key value again.

- API {#api}

   To create an access key, use the [create](../../iam/api-ref/AccessKey/create.md) method for the [AccessKey](../../iam/api-ref/AccessKey/index.md) resource.

{% endlist %}

## Create a bucket {#bucket-create}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. At the top right, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
   1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket following the [naming conventions](../../storage/concepts/bucket.md#naming).
   1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}**, and **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** fields, select **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
   1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- AWS CLI {#cli}

   1. If you do not have the AWS CLI yet, [install and configure it](../../storage/tools/aws-cli.md).
   1. Enter the bucket name following the [naming conventions](../../storage/concepts/bucket.md#naming):

      ```bash
      aws --endpoint-url https://{{ s3-storage-host }} \
        s3 mb s3://<bucket_name>
      ```

      Result:

      ```text
      make_bucket: <bucket_name>
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. Add a section with bucket parameters to the configuration file and enter the bucket name following the [naming conventions](../../storage/concepts/bucket.md#naming):

      ```hcl
      resource "yandex_storage_bucket" "<bucket_name>" {
        bucket = "<bucket_name>"
      }
      ```

      For more information about the `yandex_storage_bucket` resource, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/storage_bucket).

   1. Make sure the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

- API {#api}

   Use the [create](../../storage/api-ref/Bucket/create.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource, the [BucketService/Create](../../storage/api-ref/grpc/bucket_service.md#Create) gRPC API call, or the [create](../../storage/s3/api-ref/bucket/create.md) S3 API method.

{% endlist %}

## Set up a connection to {{ objstorage-name }} {#rclone-config}

1. Open the command prompt in your working directory as an admin user and run the following command:

   ```powershell
   .\psexec -i -s cmd.exe
   ```

1. In the console that opens, run `whoami` and make sure that the session has been started by the system user.
1. Go to the directory with the `rclone` utility and run a configuration session for it:

   ```powershell
   rclone.exe config
   ```

1. Follow the prompts to create a new connection profile:

   1. Select creation of a new profile: enter `n` in the terminal.
   1. Enter the connection name: `s3-connect`.
   1. Select the storage type: enter `4` in the terminal.
   1. Select a provider: enter `1` in the terminal.
   1. Select manual entry of credentials: enter `1` in the terminal.
   1. Enter the secret key ID in the terminal.
   1. Enter the secret key value in the terminal.
   1. Specify a region: enter `{{ region-id }}` in the terminal.
   1. Specify an endpoint: enter `{{ s3-storage-host }}` in the terminal.
   1. You can leave other settings at defaults: press **Enter** to skip them.

{% note info %}

If required, you can run an advanced connection setup. For this, at the `Edit advanced config?` prompt, enter `y` in the terminal. For more information about advanced settings, see the `rclone` [documentation](https://rclone.org/s3/).

{% endnote %}

## Mount a bucket {#bucket-mount}

1. Check the connection to the bucket. In the same terminal where you configured your connection, run the following command with the bucket name specified:

   ```powershell
   rclone.exe ls s3-connect:<bucket_name>
   ```

   If the configuration is set up correctly, the objects in the bucket will be listed in the console.

1. Mount the bucket to the file system specifying the bucket name and an available drive letter in the file system:

   ```powershell
   rclone.exe mount s3-connect:<bucket_name> <drive_letter>: --vfs-cache-mode full
   ```

   You will see a new disk with the objects from the bucket in Windows Explorer.

1. To mount the bucket, press **Ctrl** + **C**.

## Set up the mounting service {#mount-service}

To mount the bucket at your desktop startup, set up mounting on behalf of the system service.

1. In the `WinSW` utility folder, create a file called `WinSW-x64.xml` (`WinSW-x86.xml` if you have a 32-bit version of Windows) with the following contents:

   ```xml
   <service>
     <id>rclone</id>
     <name>rclone-s3-disk</name>
     <description>This service maps an S3 bucket as a system drive.</description>
     <executable>"<working_directory_path>\rclone.exe"</executable>
     <arguments>mount s3-connect:<bucket_name> <drive_letter>: --vfs-cache-mode full</arguments>
     <log mode="roll" />
     <onfailure action="restart" />
   </service>
   ```

1. In the same directory, open the command prompt as an admin user and run the following command:

   * If you have a 64-bit version of Windows:

      ```cmd
      .\WinSW-x64.exe install .\WinSW-x64.xml
      ```

   * If you have a 32-bit version of Windows:

   ```cmd
   .\WinSW-x86.exe install .\WinSW-x86.xml
   ```

1. Open the Windows services panel and make sure that `rclone-s3-disk` is listed:

   1. Click **Win**+**R**.
   1. In the window that opens, enter `services.msc` and click **OK**.
   1. In the service list, find `rclone-s3-disk`.

1. Reboot your desktop and check that the disk is available.

{% note info %}

You can also set up the service to start on behalf of the system user (for more information, see [Service account](https://github.com/winsw/winsw/blob/v3/docs/xml-config-file.md#service-account) in the `WinSW` utility documentation).

{% endnote %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete the objects](../../storage/operations/objects/delete-all.md) from the bucket.
* [Delete the bucket](../../storage/operations/buckets/delete.md).
