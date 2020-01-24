# goofys

[goofys](https://github.com/kahing/goofys) is a utility that lets Linux and macOS mount {{ objstorage-name }} buckets via [FUSE](https://en.wikipedia.org/wiki/Fuse_ESB).

## Before you start {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Installation {#installation}

To install `goofys`, follow the [instructions](https://github.com/kahing/goofys#installation) in the project repository.

## Configuration {#setup}

`goofys` uses the secret key from the [AWS CLI](aws-cli.md) settings in the `.aws/credentials` file. You can also put the key in the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables.

## Mounting a bucket {#bucket-mounting}

1. Select the folder where you want to mount the bucket and make sure you have permissions to perform the mounting operation.

2. For one-time bucket mounting, run the command:

    ```
    goofys --endpoint=https://{{ s3-storage-host }} <bucket name> <mount point>
    ```

You can configure mounting a bucket at system startup. To do this, open the `/etc/fstab` file and add a line in the following format:

```
goofys#<bucket name>   <mount point>        fuse     _netdev,allow_other,--file-mode=0666,--dir-mode=0777    0       0
```

