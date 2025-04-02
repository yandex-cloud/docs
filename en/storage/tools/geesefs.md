# GeeseFS

[GeeseFS](https://github.com/yandex-cloud/geesefs) is a utility for mounting {{ objstorage-name }} buckets using [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) on Linux, MacOS, and Windows platforms. It was developed by the {{ yandex-cloud }} team as a [goofys](goofys.md) branch. It is a high-performance, POSIX-ish file system.

## Features {#features}

### Performance {#performance}

Compared to goofys and [s3fs](s3fs.md), GeeseFS handles large amounts of small files (up to 1 MB) much faster and achieves similar or higher performance with large files. For more information about benchmark tests, see the [GeeseFS repository on GitHub](https://github.com/yandex-cloud/geesefs/tree/master/bench).

To make GeeseFS run faster, it implements:

* Parallel readahead.
* Heuristic readahead for random access: if the size of multiple blocks requested in a row is below the threshold, GeeseFS downloads smaller blocks from storage for upcoming requests.
* Parallel [multipart uploads](../concepts/multipart.md) of objects to storage.
* Optimized object updates: the client and repository only exchange modified object parts.
* Background uploads of small object trees and [directories](../concepts/object.md#folder): when a directory is requested, GeeseFS downloads the whole tree per request to storage.
* Asynchronous object write, rename, and delete.
* Disk cache for reads and writes.

### POSIX compatibility {#posix-compatibility}

In addition to the basic functions of the POSIX standards (`open`, `read`, `write`, `close`, and so on), GeeseFS supports the following features:

* Read-after-write consistency.
* Partial writes (please note that partial writes in buckets with [versioning](../concepts/versioning.md) may result in intermediate object versions).
* `fsync`: Synchronization of the contents of an object or directory between the VM memory and storage.
* `truncate`: Changing object size at will.
* Soft links (symlinks).
* `xattr`: Extended file attributes.
* Directory renames.
* `readdir`: Reads of directory metadata.

### Partial updating and appending of objects data {#patch}

GeeseFS supports [partial updating and appending of objects data](../concepts/object-patch.md) to {{ objstorage-name }} buckets.

To enable partial object updates, use the `--enable-patch` option.

To learn more, see the GeeseFS repository on GitHub:
* [Partial object updates](https://github.com/yandex-cloud/geesefs#partial-object-updates-patch): Description of partial updating and appending of objects data.
* [Concurrent Updates](https://github.com/yandex-cloud/geesefs#concurrent-patch): Description of how an object can be partially updated by multiple concurrent requests.

### Limitations {#restrictions}

GeeseFS does not support the following:

* Working with file and directory access permissions, including the `chmod` and `chown` commands. 

  When mounting the file system, you can specify:

  * Access permissions to all files or directories in the `--file-mode` and `--dir-mode` option values, respectively.
  * ID of the owner of all files and directories in the `--uid` option value.
  * ID of the group all files and directories belong to in the `--gid` option value.

  Here is an example:

  ```bash
  geesefs \
    --file-mode=0666 \
    --dir-mode=0777 \
    --uid=1000 \
    <bucket_name> <mount_point>
  ```

* Hard links.
* File locking.
* Correct time of the last access to the file (`atime`) and the last change of the file's attributes (`ctime`). Both fields always contain the time of the file's last modification: same as in the `mtime` field.
* Creating files larger than 1 TB.

## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

{% list tabs group=operating_system %}

- Debian/Ubuntu {#ubuntu}

  1. Make sure the FUSE utilities are installed in the distribution:

     ```bash
     apt list --installed | grep fuse
     ```

     {% include [fuse-warning](../../_includes/storage/fuse-warning.md) %}

  1. If the FUSE utilities are not installed, run this command:

     ```bash
     sudo apt-get install fuse
     ```

  1. Download and install GeeseFS:

     {% include [geesefs-install-linux](../../_includes/storage/geesefs-install-linux.md) %}

- CentOS {#centos}

  1. Make sure the FUSE utilities are installed in the distribution:

     ```bash
     yum list installed | grep fuse
     ```

     {% include [fuse-warning](../../_includes/storage/fuse-warning.md) %}

  1. If the FUSE utilities are not installed, run this command:

     ```bash
     sudo yum install fuse
     ```

  1. Download and install GeeseFS:

     {% include [geesefs-install-linux](../../_includes/storage/geesefs-install-linux.md) %}

- macOS {#macos}

  1. Install the [macFUSE](https://osxfuse.github.io/) package.
  1. [Enable](https://github.com/macfuse/macfuse/wiki/Getting-Started#enabling-support-for-third-party-kernel-extensions-apple-silicon-macs) support for third-party core extensions. This step is only required the first time you use MacFUSE on an Apple Silicon Mac.
  1. [Allow](https://github.com/macfuse/macfuse/wiki/Getting-Started#allow-the-macfuse-kernel-extension-to-load-apple-silicon-and-intel-macs) loading the MacFUSE core extension (Apple Silicon and Intel Mac).

      For more information on installing macFUSE, see [this installation guide](https://github.com/osxfuse/osxfuse/wiki/FAQ#2-installuninstall-questions) in the macFUSE GitHub repository.

  1. Download and install GeeseFS:

     ```bash
     platform='arm64'
     if [[ $(uname -m) == 'x86_64' ]]; then platform='amd64'; fi
     wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-mac-$platform
     chmod a+x geesefs-mac-$platform
     sudo cp geesefs-mac-$platform /usr/local/bin/geesefs
     ```

- Windows {#windows}

  1. [Download](https://winfsp.dev/rel/) and install WinFSP.
  1. [Download](https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-win-x64.exe) the `geesefs-win-x64.exe` file.
  1. Rename `geesefs-win-x64.exe` to `geesefs.exe` for convenience.
  1. Сreate a folder named `geesefs` and move the `geesefs.exe` file there.
  1. Add `geesefs` to the `PATH` variable:

      {% include [windows-environment-vars](../../_includes/windows-environment-vars.md) %}

{% endlist %}

You can also build GeeseFS yourself using its source code. For more information, see the [guide](https://github.com/yandex-cloud/geesefs#installation) in the GeeseFS repository on GitHub.

## Authentication {#authentication}


GeeseFS uses the static access key to {{ objstorage-name }} you [got earlier](#before-you-begin). You can set it using one of the following methods:

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  * Using the `credentials` [file](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html), which you need to put into the `~/.aws/` folder:

      1. Create a directory:

          ```bash
          mkdir ~/.aws
          ```

      1. Create a file named `credentials` with the following contents:

          ```text
          [default]
          aws_access_key_id = <key_ID>
          aws_secret_access_key = <secret_key>
          ```

    If the key file is located elsewhere, specify its path in the `--shared-config` parameter when mounting the bucket:

    ```bash
    geesefs \
      --shared-config <path_to_key_file> \
      <bucket_name> <mount_point>
    ```

    The key file must have the same structure as `~/.aws/credentials`.

  * Using environment variables:

    ```bash
    export AWS_ACCESS_KEY_ID=<key_ID>
    export AWS_SECRET_ACCESS_KEY=<secret_key>
    ```

  {% note info %}

  You can run the `geesefs` command with superuser privileges (`sudo`). In which case make sure to send information about the key either in the `--shared-config` parameter or using environment variables.

  {% endnote %}

- Windows {#windows}

  * Using the `credentials` [file](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html), which you need to put into the `users/<current_user>/.aws/` folder:

    ```text
    [default]
    aws_access_key_id = <key_ID>
    aws_secret_access_key = <secret_key>
    ```

    If the key file is located elsewhere, specify its path in the `--shared-config` parameter when mounting the bucket:

    ```cmd
    geesefs ^
      --shared-config <path_to_key_file> ^
      <bucket_name> <mount_point>
    ```

    The key file must have the same structure as `~/.aws/credentials`.

    Specify an existing folder as the mount point.

  * Using environment variables:

    ```cmd
    set AWS_ACCESS_KEY_ID=<key_ID>
    set AWS_SECRET_ACCESS_KEY=<secret_key>
    ```

{% endlist %}

When using GeeseFS on a {{ compute-name }} VM that has a [linked service account](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance), you can enable simplified authentication that does not require a static access key. To do this, use the `--iam` option when mounting the bucket.

## Mounting a bucket {#bucket-mounting}

Select the folder or disk where you want to mount the bucket. Make sure you have sufficient rights to perform this operation.

When mounting a bucket, you can also configure GeeseFS settings related to system [performance](#performance) and object access rights. To view the list of options and their descriptions, run `geesefs --help`.

* For one-time bucket mounting:

  {% list tabs group=operating_system %}

  - Linux/macOS {#linux-macos}

    1. Make sure the `.aws/credentials` file contains the up-to-date static key data or provide the path to it in the `--shared-config` parameter.

    1. Create a folder for mounting:

        ```bash
        mkdir <mount_point>
        ```

    1. Mount the bucket:

        ```bash
        geesefs <bucket_name> <mount_point>
        ```

        You should specify an existing folder as the mount point.

  - Windows {#windows}

    1. Make sure the `.aws/credentials` file contains the up-to-date static key data or provide the path to it in the `--shared-config` parameter.

    1. Mount the bucket:

        ```bash
        geesefs <bucket_name> <mount_point>
        ```

        As the mount point, specify the name of the new folder that will be created when you mount the bucket. You cannot specify the name of an existing folder.

  {% endlist %}

* To automatically mount a bucket at system startup:

  {% list tabs group=operating_system %}

  - macOS {#macos}

    1. Create a folder for automatic mounting:

        ```bash
        mkdir <mount_point>
        ```

    1. Create a file named `com.geesefs.automount.plist` with the autorun agent configuration:

        ```bash
        nano /Users/<username>/Library/LaunchAgents/com.geesefs.automount.plist
        ```

    1. Set the agent configuration by specifying the name of the bucket and the absolute path to the mount point:

        ```xml
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>Label</key>
            <string>com.geesefs.automount</string>
            <key>ProgramArguments</key>
            <array>
                <string>/usr/local/bin/geesefs</string>
                <string><bucket_name></string>
                <string><absolute_path_to_mount_point></string>
            </array>
            <key>RunAtLoad</key>
            <true/>
            <key>KeepAlive</key>
            <dict>
                <key>NetworkState</key>
                <true/>
            </dict>
        </dict>
        </plist>
        ```

        {% note info %}

        Specify an existing empty folder as the mount point.

        For the bucket to be mounted correctly, provide the full absolute path to the mount point and to the key file without `~`. e.g., `/home/user/`.

        {% endnote %}

    1. Enable the agent you created:

        ```bash
        launchctl load /Users/<username>/Library/LaunchAgents/com.geesefs.automount.plist
        ```

    1. Reboot and check that the bucket has been mounted to the specified folder.

    To disable agent autorun, use this command:

    ```bash
    launchctl unload /Users/<username>/Library/LaunchAgents/com.geesefs.automount.plist
    ```

  - Linux {#linux}

    1. Create a folder for automatic mounting:
    
        ```bash
        mkdir <mount_point>
        ```

    1. Open the `/etc/fuse.conf` file:

        ```bash
        sudo nano /etc/fuse.conf
        ```

    1. Add the following line to it:

        ```text
        user_allow_other
        ```

    1.  Open the `/etc/fstab` file:

        ```bash
        sudo nano /etc/fstab
        ```

    1. Add the following line to the `/etc/fstab` file:

        ```text
        <bucket_name>    /home/<username>/<mount_point>    fuse.geesefs    _netdev,allow_other,--file-mode=0666,--dir-mode=0777,--shared-config=/home/<username>/.aws/credentials    0   0
        ```

        If you had created the `.aws/credentials` file for the `root` user, you do not need to specify the `--shared-config` parameter.

        {% note info %}

        For the bucket to be mounted correctly, provide the full absolute path to the mount point and to the key file without `~`, e.g., `/home/user/`.

        {% endnote %}

    1. Reboot and check that the bucket has been mounted to the specified folder.

    To disable automounting, remove the line with the bucket name from the `/etc/fstab` file.

  - Windows {#windows}

    Create a Windows service that will automatically run at system startup:

    1. Run `CMD` as an administrator.
    1. Run this command:

        ```cmd
        sc create <service_name> ^
          binPath="<command_for_mounting>" ^
          DisplayName= "<service_name>" ^
          type=own ^
          start=auto
        ```

        Where `binPath` is the path to the `geesefs.exe` file with the required mounting parameters. Here is an example: `C:\geesefs\geesefs.exe <bucket_name> <mount_point>`. As the mount point, specify the name of the new folder that will be created when you mount the bucket. You cannot specify the name of an existing folder.

        Result:

        ```text
        [SC] CreateService: Success
        ```

    1. Click **Start** and start typing `Services` in the Windows search bar. Run the **Services** application as an administrator.
    1. In the window that opens, find the service you created earlier, right-click it, and select **Properties**.
    1. On the **Log on** tab, select **This account** and specify your Windows account name and password.

        If necessary, click **Browse** → **Advanced** → **Search** to find the user you need on the computer.

    1. Click **OK**.

    To delete the created service, open `CMD` as an administrator and run the following command:

    ```cmd
    sc delete <service_name>
    ```

    Result:

    ```text
    [SC] DeleteService: Success
    ```

  {% endlist %}
