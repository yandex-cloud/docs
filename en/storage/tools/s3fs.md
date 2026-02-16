# s3fs

[s3fs](https://github.com/s3fs-fuse/s3fs-fuse) is a utility for Linux and macOS to mount {{ objstorage-name }} buckets via [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace).

{% note info %}

We recommend using s3fs version 1.84 or higher.

{% endnote %}

If you experience any issues with s3fs, check the [official documentation](https://github.com/s3fs-fuse/s3fs-fuse/wiki) of the project, in particular, the [FAQ](https://github.com/s3fs-fuse/s3fs-fuse/wiki/FAQ).

s3fs performance depends on the speed of your local disk. Use high-speed disks, especially if you store a lot of small files a few hundred kilobytes in size or smaller. You can increase s3fs performance by enabling caching (`--use_cache <directory>` parameter). The s3fs cache grows indefinitely, so you need to clear it at regular intervals. You can read more in the [s3fs documentation](https://github.com/s3fs-fuse/s3fs-fuse/wiki/Fuse-Over-Amazon#details).

## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

To install s3fs, follow [this guide](https://github.com/s3fs-fuse/s3fs-fuse#installation) in the project repository.

## Setup {#setup}

To configure s3fs, save the [previously obtained](#before-you-begin) key ID and the secret key to the `~/.passwd-s3fs` file in `<key_ID>:<secret_key>` format and restrict access to the `~/.passwd-s3fs` file in the following way:

```bash
echo <key_ID>:<secret_key> > ~/.passwd-s3fs
chmod 600 ~/.passwd-s3fs
```

## Mounting a bucket {#mounting-bucket}

1. Select the folder where you want to mount your bucket and make sure you have permissions for this operation.
1. Run this command:

    ```bash
    s3fs <bucket_name> /mount/<folder_path> -o passwd_file=$HOME/.passwd-s3fs \
        -o url=https://{{ s3-storage-host }} -o use_path_request_style
    ```

   To allow other PC users to access the folder, specify the `-o allow_other` option.
   
   To set access permissions to the folder you are going to mount the bucket to, specify the `-o mp_umask=<required_permissions>` option.

You can configure mounting a bucket when starting the system. To do this, open the `/etc/fstab` file and add a line in the following format:

```bash
s3fs#<bucket_name> /mount/<folder_path> fuse _netdev,allow_other,use_path_request_style,url=https://{{ s3-storage-host }},passwd_file=/home/<username>/.passwd-s3fs 0 0
```

For descriptions of all s3fs parameters, see the [project's wiki page](https://github.com/s3fs-fuse/s3fs-fuse/wiki/Fuse-Over-Amazon) on GitHub.

