# s3fs

[s3fs](https://github.com/s3fs-fuse/s3fs-fuse) is a utility that lets Linux and macOS mount an {{ objstorage-name }} bucket via [FUSE](https://en.wikipedia.org/wiki/Fuse_ESB).

{% note info %}

We recommend using s3fs version 1.84 or higher.

{% endnote %}

If you have any questions, see the [official documentation](https://github.com/s3fs-fuse/s3fs-fuse/wiki) of the project, in particular, [FAQ](https://github.com/s3fs-fuse/s3fs-fuse/wiki/FAQ). There you can learn how to fix problems that occur when using s3fs.

## Before you start {#preparations}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Installation {#installation}

To install s3fs, follow the [instructions](https://github.com/s3fs-fuse/s3fs-fuse#installation) in the project repository.

## Configuration {#setup}

To configure s3fs, save the key ID and secret key to a `~/.passwd-s3fs` file in the format `<key ID>:<secret key>` and restrict access to the `~/.passwd-s3fs` file like this:

```
echo  <key ID>:<secret key> >  ~/.passwd-s3fs
chmod 600  ~/.passwd-s3fs
```

## Mounting a bucket

1. Select the folder where you want to mount the bucket and make sure you have permissions to perform the mounting operation.

2. Run a command like:

    ```
    s3fs <bucket name> /mount/<folder path> -o passwd_file=~/.passwd-s3fs \
        -o url=http://storage.yandexcloud.net -o use_path_request_style
    ```

You can configure mounting a bucket at system startup. To do this, open the `/etc/fstab` file and add a line in the following format:

```
s3fs#<bucket name> /mount/<folder path> fuse _netdev,allow_other,use_path_request_style,url=http://storage.yandexcloud.net 0 0
```

For descriptions of all s3fs parameters, see the [project's wiki page](https://github.com/s3fs-fuse/s3fs-fuse/wiki/Fuse-Over-Amazon) on GitHub.

