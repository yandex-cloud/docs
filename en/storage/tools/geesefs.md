# GeeseFS

[GeeseFS](https://github.com/yandex-cloud/geesefs) is a utility that lets Linux and macOS mount {{ objstorage-name }} buckets via [FUSE]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Filesystem_in_Userspace){% endif %}. It was designed by the {{ yandex-cloud }} team as a fork of [goofys](goofys.md). It's a high-performance, POSIX-ish file system.

## Functionality {#features}

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
* `truncate`: Arbitrary change in the size of an object.
* Soft links (symlinks).
* `xattr`: Extended file attributes.
* Directory renames.
* `readdir`: Reads of directory metadata.

### Limitations {#restrictions}

GeeseFS does not support the following:

* Working with file and directory access rights, including `chmod` and `chown`.

  When mounting the file system, you can specify:
  * Access rights to all files or directories in the `--file-mode` and `--dir-mode` values, respectively.
  * The ID of the user that is the owner of all files and directories in the `--uid` value.
  * The ID of the group that all files and directories belong to in the `--gid` value.

  For example:

  ```bash
  geesefs <bucket name> <mount point> \
    --file-mode=0666 \
    --dir-mode=0777 \
    --uid=1000
  ```

* Hard links.
* File locking.
* The correct time that shows when a file was last accessed (`atime`) and when the file attributes were last changed (`ctime`). Both fields always contain the time of the file's last modification: the same as in the `mtime` field.
* Creating files larger than 1 TB.

## Before you start {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Installation {#installation}

To install GeeseFS, follow the [instructions](https://github.com/yandex-cloud/geesefs#installation) in the project repository.

## Authentication {#authentication}

GeeseFS uses a [static access key](../../iam/concepts/authorization/access-key.md) to {{ objstorage-name }}, which is stored in the `.aws/credentials` file. You can also put the key in the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables.

When using GeeseFS on a {{ compute-name }} VM that has a [linked service account](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance), you can enable simplified authentication that doesn't require a static access key. To do this, when mounting a bucket, use the `--iam` option.

## Mounting a bucket {#bucket-mounting}

1. Select the folder where you want to mount a bucket and make sure you have permissions to mount a bucket.

1. For one-time bucket mounting, run the command:

    ```
    geesefs <bucket name> <mount point>
    ```

To mount a bucket automatically at system startup, add a line to the `/etc/fstab` file in the following format:

```
<bucket name>    <mount point>    fuse.geesefs    _netdev,allow_other,--file-mode=0666,--dir-mode=0777    0   0
```

When mounting a bucket, you can specify the GeeseFS settings, including those related to system [performance](#performance) and object access rights, using command line options. To view the list of options and their descriptions, run `geesefs --help`.
