# goofys

[goofys](https://github.com/kahing/goofys) is a utility that lets Linux and macOS mount {{ objstorage-name }} buckets via [FUSE]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Filesystem_in_Userspace){% endif %}.

## Before you start {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Installation {#installation}

To install `goofys`, follow the [instructions](https://github.com/kahing/goofys#installation) in the project repository.

## Setup {#setup}

`goofys` uses the secret key from the [AWS CLI](aws-cli.md) settings in the `.aws/credentials` file. You can also put the key in the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables.

## Mounting a bucket {#bucket-mounting}

1. Select the folder where you want to mount a bucket and make sure you have permissions to mount a bucket.

2. For one-time bucket mounting, run the command:

    ```
    goofys --endpoint=https://{{ s3-storage-host }} <bucket name> <mount point>
    ```

You can configure mounting a bucket at system startup. To do this, open the `/etc/fstab` file and add a line in the following format:

```
goofys#<bucket name>   <mount point>        fuse     _netdev,allow_other,--file-mode=0666,--dir-mode=0777,--endpoint=https://{{ s3-storage-host }}    0       0
```

