# Backing up to {{ objstorage-name }} with GeeseFS

In this tutorial, you will configure backup of local files to [{{ objstorage-full-name }}](../../storage/) with [GeeseFS](../../storage/tools/geesefs.md).

GeeseFS enables mounting a [bucket](../../storage/concepts/bucket.md) as a regular folder, so you can use familiar tools for copying and synchronization. Backup essentially involves copying and synchronizing data between the local folder and the bucket as if these are two directories, one hosted in the cloud. The process is optimized with synchronization tools, e.g., `rsync` or `robocopy`, which move only new and updated files.

To configure backup using GeeseFS:

1. [Get your cloud ready](#before-begin).
1. [Create a bucket](#create-bucket).
1. [Create a service account](#create-sa).
1. [Create a static access key](#create-static-key).
1. [Set up your environment](#prepare-env).
1. [Mount your bucket](#mount-bucket).
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

### Install GeeseFS {#install-geesefs}

{% include [geesefs-installation](../../_includes/storage/geesefs-installation.md) %}


### Get authenticated in GeeseFS {#auth-geesefs}

GeeseFS uses the static access key to {{ objstorage-name }} you [got earlier](#create-static-key). You can set it using one of the following methods:

{% include [geesefs-authentication](../../_includes/storage/geesefs-authentication.md) %}


## Mount a bucket {#mount-bucket}

Select the folder or disk where you want to mount the bucket. Make sure you have sufficient permissions to perform this operation.

When mounting a bucket, you can also configure GeeseFS settings for system [performance](../../storage/tools/geesefs.md#performance) and object access permissions. To view the list of options and their descriptions, run `geesefs --help`.

{% include [geesefs-bucket-mounting](../../_includes/storage/geesefs-bucket-mounting.md) %}


## Synchronize the local folder with the bucket {#sync}

As the final backup configuration step, set up [manual](#manual-sync) or [automatic](#auto-sync) synchronization between the local folder and the bucket.


### Manual synchronization {#manual-sync}

{% list tabs group=operating_system %}

- Linux {#linux}

  For a one-off synchronization, run this command:

  ```bash
  rsync -av \
    --no-owner \
    --no-group \
    --no-perms \
    --no-times \
    --delete \
    <local_folder_path>/ \
    <mount_folder_path>/
  ```

  Where `--delete` is a flag to delete files from the bucket when they are deleted from the local folder.

  {% include [note-full-path](../_tutorials_includes/storage-backup/note-full-path.md) %}

  This command copies all contents from your local folder to the bucket using the folder mounted with GeeseFS. It only moves new and modified files.

  The GeeseFS folder is not a proper POSIX-compliant file system, so ownership, permissions, and timestamps are not copied.

- Windows {#windows}

  For a one-off synchronization, use the command line (`CMD`) to run the following:

  ```bash
  robocopy "<local_folder_path>" "<mount_folder_path>" /MIR
  ```

  Where `/MIR` indicates full folder synchronization, including deletion of missing files.

  {% include [note-full-path](../_tutorials_includes/storage-backup/note-full-path.md) %}

  Result:

  ```text
  -------------------------------------------------------------------------------
    ROBOCOPY     ::     Robust File Copy for Windows
  -------------------------------------------------------------------------------

        Start : October 6, 2025, 21:16:36
      Source : C:\Users\username\geesefs\local\
    Target : C:\Users\username\geesefs\mount\

      Files: *.*
  Parameters: *.* /S /E /DCOPY:DA /COPY:DAT /PURGE /MIR /R:1000000 /W:30

  ------------------------------------------------------------------------------

  1    C:\Users\username\geesefs\local\
  100%        New file             13793        image.PNG

  ------------------------------------------------------------------------------

                TotalCopied SkippedMismatch      FAILEDExtras
  Folders :         1         0         1         0         0         0
     Files :         1         1         0         0         0         0
       Bytes :    13.4 k    13.4 k         0         0         0         0
      Time :   0:00:00   0:00:00                       0:00:00   0:00:00

  Speed :         13793000 Bytes/sec.
  Speed :            789.241 MB/min.
  Ended : October 6, 2025, 21:16:36
  ```

  {% note tip %}

  To avoid running the command manually each time, you can create a BAT file:

  1. Open **Notepad** and add the following contents:

      ```text
      @echo off
      robocopy "<local_folder_path>" "<mount_folder_path>" /MIR
      ```

  1. Save the file, e.g., as `sync_to_s3.bat`.
  1. To synchronize folders, run the BAT file.

  {% endnote %}

{% endlist %}


### Automatic synchronization {#auto-sync}

{% list tabs group=operating_system %}

- Linux {#linux}

  To automatically synchronize your local folder with the GeeseFS folder:

  1. Make sure the user who will schedule the `cron` job has access to both folders.
  1. Open the current user's scheduler file by running this command:

      ```bash
      crontab -e
      ```

  1. Add a line to the file to trigger autosync, e.g., every 10 minutes:

      ```text
      */10 * * * * rsync -av --no-owner --no-group --no-perms --no-times --delete <local_folder_path>/ <mount_folder_path>/ --log-file=<log_file_path>
      ```

      Where:

      * `--delete`: Flag to delete files from the bucket when they are deleted from the local folder.
      * `--log-file`: Optional parameter for writing logs. Specify the full path.

      {% include [note-full-path](../_tutorials_includes/storage-backup/note-full-path.md) %}

  The job will run at the specified frequency and synchronize the folders.

  The command in the `cron` job copies all contents from your local folder to the bucket using the folder mounted with GeeseFS. It only moves new and modified files.

  The GeeseFS folder is not a proper POSIX-compliant file system, so ownership, permissions, and timestamps are not copied.

- Windows {#windows}

  {% include [auto-sync-windows](../_tutorials_includes/storage-backup/auto-sync-windows.md) %}

{% endlist %}


## How to delete the resources you created {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-backup/clear-out.md) %}