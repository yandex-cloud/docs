# goofys

[goofys](https://github.com/kahing/goofys) is a utility for Linux and macOS to mount {{ objstorage-name }} buckets via [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace).

## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

To install `goofys`, follow [this guide](https://github.com/kahing/goofys#installation) in the project repository.

## Configuration {#setup}

`goofys` uses the secret key from the [AWS CLI](aws-cli.md) settings stored in the `.aws/credentials` file. You can also put the key in the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables.

## Mounting a bucket {#bucket-mounting}

1. Select the folder where you want to mount a bucket and make sure you have permissions for this operation.
1. For one-time bucket mounting, run this command:

    ```
    goofys --endpoint=https://{{ s3-storage-host }} <bucket_name> <mount_point>
    ```

To set a bucket to mount at system startup, add the following line to the `/etc/fstab` file:

```
goofys#<bucket_name>  <mount_point>  fuse  _netdev,allow_other,--file-mode=0666,--dir-mode=0777,--endpoint=https://{{ s3-storage-host }}  0  0
```
