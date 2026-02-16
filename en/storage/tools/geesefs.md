# GeeseFS

[GeeseFS](https://github.com/yandex-cloud/geesefs) is a utility for mounting {{ objstorage-name }} buckets using [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) on Linux, MacOS, and Windows platforms. It was developed by the {{ yandex-cloud }} team as a [goofys](goofys.md) branch. It is a high-performance, POSIX-ish file system.

## Features {#features}

### Performance {#performance}

Compared to goofys and [s3fs](s3fs.md), GeeseFS handles large amounts of small files (up to 1 MB) much faster and achieves similar or higher performance with large files. For more information about benchmark tests, see the [GeeseFS repository on GitHub](https://github.com/yandex-cloud/geesefs/tree/master/bench).

To run faster, GeeseFS implements:

* Parallel readahead.
* Heuristic readahead for random access: if the size of multiple blocks requested in a row is below the threshold, GeeseFS downloads smaller blocks from the storage for upcoming requests.
* Parallel [multipart uploads](../concepts/multipart.md) of objects to the storage.
* Optimized object updates: the client and repository only exchange modified object parts.
* Background uploads of small object trees and [directories](../concepts/object.md#folder): when a directory is requested, GeeseFS downloads the whole tree per request to the storage.
* Asynchronous object write, rename, and delete operations.
* Disk cache for reads and writes.

### POSIX compatibility {#posix-compatibility}

In addition to the basic functions of the POSIX standards (`open`, `read`, `write`, `close`, and so on), GeeseFS supports the following features:

* Read-after-write consistency.
* Partial writes (please note that partial writes in buckets with [versioning](../concepts/versioning.md) may result in intermediate object versions).
* `fsync`: Synchronization of the contents of an object or directory between the VM memory and storage.
* `truncate`: Changing object size arbitrarily.
* Soft links (symlinks).
* `xattr`: Extended file attributes.
* Directory renames.
* `readdir`: Reads of directory metadata.

### Partial updating and appending of object data {#patch}

GeeseFS supports [partial updating and appending of object data](../concepts/object-patch.md) in {{ objstorage-name }} buckets.

To enable partial object updates, use the `--enable-patch` option.

Learn more in the GeeseFS repository on GitHub:
* [Partial object updates](https://github.com/yandex-cloud/geesefs#partial-object-updates-patch): Description of partial updating and appending of object data.
* [Concurrent Updates](https://github.com/yandex-cloud/geesefs#concurrent-patch): Description of a partial object update using multiple concurrent requests.

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

## Installing {#installation}

{% include [geesefs-installation](../../_includes/storage/geesefs-installation.md) %}

## Authentication {#authentication}


GeeseFS uses the static access key to {{ objstorage-name }} you [got earlier](#before-you-begin). You can set it using one of the following methods:

{% include [geesefs-authentication](../../_includes/storage/geesefs-authentication.md) %}

## Mounting a bucket {#bucket-mounting}

Select the folder or disk where you want to mount the bucket. Make sure you have sufficient permissions to perform this operation.

When mounting a bucket, you can also configure GeeseFS settings related to system [performance](#performance) and object access permissions. To view the list of options and their descriptions, run `geesefs --help`.

{% include [geesefs-bucket-mounting](../../_includes/storage/geesefs-bucket-mounting.md) %}
