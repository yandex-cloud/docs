# Backing up to {{ objstorage-full-name }} with rclone

In this tutorial, you will set up backup of local files to [{{ objstorage-full-name }}](../../storage/) using [rclone](../../storage/tools/rclone.md).

[Rclone](https://rclone.org/) is a versatile command-line tool for managing files in S3 cloud storage, including {{ objstorage-name }}. You can use it to copy and synchronize files between your local machine and a [bucket](../../storage/concepts/bucket.md).

Features of rclone:

* Connects directly to the S3 API so you do not need to mount a bucket.
* Supported on Linux, Windows, and macOS.
* Supports copy, sync, filtering, checks, and automation with scripts.
* Easy setup and integration with task schedulers.

To set up backup with rclone:

1. [Get your cloud ready](#before-begin).
1. [Create a bucket](#create-bucket).
1. [Create a service account](#create-sa).
1. [Create a static access key](#create-static-key).
1. [Set up your environment](#prepare-env).
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


## Set up your environment {#prepare-env}

### Install rclone {#install-rclone}

{% list tabs group=operating_system %}

- Linux {#linux}

  1. Install the latest version of rclone using the following command:

      ```bash
      sudo -v ; curl https://rclone.org/install.sh | sudo bash
      ```

      Result:

      ```text
      ...
      rclone v1.71.1 has successfully installed.
      Now run "rclone config" for setup. Check https://rclone.org/docs/ for more details.
      ```

      For more information about the command, see [this rclone guide](https://rclone.org/install/).

  1. Make sure rclone is installed:

     ```bash
     rclone version
     ```

      Result:

      ```text
      rclone v1.71.1
      - os/version: ubuntu 24.04 (64 bit)
      - os/kernel: 6.14.0-29-generic (x86_64)
      - os/type: linux
      - os/arch: amd64
      - go/version: go1.25.1
      - go/linking: static
      - go/tags: none
      ```

- Windows {#windows}

  1. Download the [rclone archive](https://rclone.org/downloads/) from the vendor website and unpack it to a local folder.
  1. Add the folder to the `PATH` variable to make the utility CLI-accessible from anywhere. To do this:

      1. Click **Start** and type **Change system environment variables** in the Windows search bar.
      1. Click **Environment variables...** at the bottom right.
      1. In the window that opens, find the `PATH` parameter and click **Edit**.
      1. Add your folder path to the list.
      1. Click **OK**.

  1. Make sure rclone is installed:

      ```bash
      rclone version
      ```

      Result:

      ```text
      rclone v1.71.1
      - os/version: Microsoft Windows 10 Pro 22H2 22H2 (64 bit)
      - os/kernel: 10.0.19045.4046 (x86_64)
      - os/type: windows
      - os/arch: amd64
      - go/version: go1.25.1
      - go/linking: static
      - go/tags: cmount
      ```

{% endlist %}


### Set up a connection to {{ objstorage-name }} {#connect-rclone}

1. Run a configuration session for rclone using this command:

    ```bash
    rclone config
    ```

1. Follow the prompts to create a new connection profile:

    1. Start creating a new profile by entering `n` in the terminal.
    1. Enter a connection name, e.g., `yandex-s3`.
    1. Select the storage type by entering `4` (Amazon S3 Compliant Storage) in the terminal.
    1. Select the provider by entering `1` (Amazon Web Services S3) in the terminal.
    1. Select manual entry of credentials by typing `1` in the terminal.
    1. In the terminal, enter the secret key ID you got previously.
    1. In the terminal, enter the secret key value you got previously.
    1. Specify the region by entering `{{ region-id }}` in the terminal.
    1. Specify the endpoint by entering `{{ s3-storage-host }}` in the terminal.
    1. You can leave all other settings at their defaults by pressing **Enter** to skip them; at the last item, select `q` (`Quit config`).

    {% note info %}

    You can perform advanced connection setup if required. To do this, type `y` at the `Edit advanced config?` step. For more information about advanced settings, see [this `rclone` guide](https://rclone.org/s3/).

    {% endnote %}

    Also, you can configure connections by manually editing the `rclone.conf` configuration file. To get the configuration file location, run this command:

    ```bash
    rclone config file
    ```

1. Check your connection to the bucket by running this command:

    ```bash
    rclone ls <connection_name>:<bucket_name>
    ```

    If your configuration is correct, in your terminal, you will see a list of objects in the bucket.


## Synchronize the local folder with the bucket {#sync}

To complete the backup setup, configure [manual](#manual-sync) or [automatic](#auto-sync) synchronization of the local folder with the bucket.

{% note info %}

Files deleted from your local folder will also be deleted from the bucket. If you do not want to delete files from the bucket when they are deleted from the local folder, run the `copy` command instead of `sync`.

{% endnote %}


### Manual synchronization {#manual-sync}

{% list tabs group=operating_system %}

- Linux {#linux}

  {% include [rclone-manual-sync](../_tutorials_includes/storage-backup/rclone-manual-sync.md) %}

- Windows {#windows}

  {% include [rclone-manual-sync](../_tutorials_includes/storage-backup/rclone-manual-sync.md) %}

  {% note tip %}

  To avoid running the command manually each time, you can create a BAT file:

  1. Open **Notepad** and add the following contents:

      ```bash
      @echo off
      rclone sync <local_folder_path> <connection_name>:<bucket_name>
      ```

      Where `sync` creates an exact copy, including deletion of files from the bucket when they are deleted from the local folder. To copy files without deletion, use the `copy` command.

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
      */10 * * * * rclone sync <local_folder_path> <connection_name>:<bucket_name> --log-file=<log_file_path>
      ```

      Where:

      * `sync`: Command for an exact copy, including deletion of files from the bucket when they are deleted from the local folder. To copy files without deletion, use the `copy` command.
      * `--log-file`: Optional parameter for writing logs. Specify the full path.

      {% include [note-full-path](../_tutorials_includes/storage-backup/note-full-path.md) %}

  The job will run at the specified frequency and synchronize the folders.

- Windows {#windows}

  {% include [auto-sync-windows](../_tutorials_includes/storage-backup/auto-sync-windows.md) %}

{% endlist %}


## How to delete the resources you created {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-backup/clear-out.md) %}