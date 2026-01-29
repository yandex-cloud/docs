# Backing up to {{ objstorage-full-name }} with AWS S3 Sync

In this tutorial, you will set up backup of local files to [{{ objstorage-full-name }}](../../storage/) using [AWS S3 Sync](https://docs.aws.amazon.com/cli/latest/reference/s3/sync.html).

AWS S3 Sync is a standard [AWS CLI](../../storage/tools/aws-cli.md) command for syncing content between a local folder and a [bucket](../../storage/concepts/bucket.md). This is a simple and reliable way to back up your files to S3-compatible cloud object storage.

Features of AWS S3 Sync:

* Requires no additional software other than the AWS CLI.
* Supported on Linux, Windows, and macOS.
* Easy setup and direct access to the S3 API.
* Simple automation with a task scheduler or scripts.

To configure backup with AWS S3 Sync:

1. [Get your cloud ready](#before-begin).
1. [Create a bucket](#create-bucket).
1. [Create a service account](#create-sa).
1. [Create a static access key](#create-static-key).
1. Install the [AWS CLI](#install-aws).
1. [Synchronize the local folder with the bucket](#sync).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/storage-backup/paid-resources.md) %}


## Create a bucket {#create-bucket}

{% include [versioning-warning](../_tutorials_includes/storage-backup/versioning-warning.md) %}

{% include [create-bucket](../_tutorials_includes/storage-backup/create-bucket.md) %}


## Create a service account {#create-sa}

{% include [create-sa](../_tutorials_includes/storage-backup/create-sa.md) %}


## Create a static access key {#create-static-key}

{% include [create-static-key](../_tutorials_includes/storage-backup/create-static-key.md) %}


## Install the AWS CLI {#install-aws}

{% include [aws-cli-install](../../_includes/aws-cli-install.md) %}


## Synchronize the local folder with the bucket {#sync}

To complete the backup setup, configure [manual](#manual-sync) or [automatic](#auto-sync) synchronization of the local folder with the bucket.


### Manual synchronization {#manual-sync}

{% list tabs group=operating_system %}

- Linux {#linux}

  {% include [aws-manual-sync](../_tutorials_includes/storage-backup/aws-manual-sync.md) %}

- Windows {#windows}

  {% include [aws-manual-sync](../_tutorials_includes/storage-backup/aws-manual-sync.md) %}

  {% note tip %}

  To avoid running the command manually each time, you can create a BAT file:

  1. Open **Notepad** and add the following contents:

      ```text
      @echo off
      aws s3 sync "<local_folder_path>" s3://<bucket_name> ^
        --endpoint-url=https://{{ s3-storage-host }} ^
        --delete
      ```

      Where `--delete` is a flag to delete files from the bucket when they are deleted from the local folder.

  1. Save the file, e.g., as `sync_to_s3.bat`.
  1. To synchronize folders, run the BAT file.

  {% endnote %}

{% endlist %}


### Automatic synchronization {#auto-sync}

{% list tabs group=operating_system %}

- Linux {#linux}

  To automatically synchronize your local folder with the bucket:

  1. Make sure the user who will schedule the `cron` job has access to the local folder.
  1. Open the current user's scheduler file by running this command:

      ```bash
      crontab -e
      ```

  1. Add a line to the file to trigger autosync, e.g., every 10 minutes:

      ```text
      */10 * * * * aws s3 sync <local_folder_path> <connection_name>:<bucket_name> --delete --log-file=<log_file_path>
      ```

      Where:

      * `--delete`: Flag to delete files from the bucket when they are deleted from the local folder.
      * `--log-file`: Optional parameter for writing logs. Specify the full path.

      {% include [note-full-path](../_tutorials_includes/storage-backup/note-full-path.md) %}

  The job will run at the specified frequency and synchronize the folders.

- Windows {#windows}

  {% include [auto-sync-windows](../_tutorials_includes/storage-backup/auto-sync-windows.md) %}

{% endlist %}


## How to delete the resources you created {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-backup/clear-out.md) %}