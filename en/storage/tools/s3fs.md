# s3fs

[s3fs](https://github.com/s3fs-fuse/s3fs-fuse) is a utility that lets Linux and macOS mount {{ objstorage-name }} buckets via [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace).

{% note info %}

We recommend using s3fs version 1.84 or higher.

{% endnote %}

If you have any questions, see the [official documentation](https://github.com/s3fs-fuse/s3fs-fuse/wiki) of the project, in particular, [FAQ](https://github.com/s3fs-fuse/s3fs-fuse/wiki/FAQ). There you can learn how to fix problems that occur when using s3fs.

s3fs performance depends on the speed of your local disk. Use high-speed disks, especially if you store a lot of small files (several hundred kilobytes each or smaller). To increase s3fs performance, you can enable caching (via the `--use_cache <directory>` key). As the s3fs cache can grow indefinitely, please make sure to clear it regularly. Read more in the [s3fs documentation](https://github.com/s3fs-fuse/s3fs-fuse/wiki/Fuse-Over-Amazon#details).

## Before you start {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Installation {#installation}

To install s3fs, follow the [instructions](https://github.com/s3fs-fuse/s3fs-fuse#installation) in the project repository.

## Setup {#setup}

To configure s3fs, save the key ID and secret key to a `~/.passwd-s3fs` file in the format `<key ID>:<secret key>` and restrict access to the `~/.passwd-s3fs` file like this:

```
echo <key ID>:<secret key> > ~/.passwd-s3fs
chmod 600 ~/.passwd-s3fs
```

## Mounting a bucket {#mounting-bucket}

1. Select the folder where you want to mount a bucket and make sure you have permissions to perform the mounting operation.
2. Run a command in the format:

    ```
    s3fs <bucket name> /mount/<directory path> -o passwd_file=$HOME/.passwd-s3fs \
        -o url=http://{{ s3-storage-host }} -o use_path_request_style
    ```

You can configure mounting a bucket at system startup. To do this, open the `/etc/fstab` file and add a line in the following format:

```
s3fs#<bucket name> /mount/<directory path> fuse _netdev,allow_other,use_path_request_style,url=http://{{ s3-storage-host }},passwd_file=/home/<username>/.passwd-s3fs 0 0
```

For descriptions of all s3fs parameters, see the [project's wiki page](https://github.com/s3fs-fuse/s3fs-fuse/wiki/Fuse-Over-Amazon) on GitHub.

