# CyberDuck

[CyberDuck](https://cyberduck.io/) is a GUI client that allows you to work with cloud storages, including those compatible with the Amazon S3 API. CyberDuck is available for macOS and Windows and as a [console client](https://duck.sh/) for Linux.

## Getting started {#before-you-begin}

{% include [aws-tools-prepare-with-bucket](../../_includes/aws-tools/aws-tools-prepare-with-bucket.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

[Download](https://cyberduck.io/download/) the CyberDuck distribution for your OS and run it.

## Connection {#connection}

1. Run CyberDuck.
1. Click **Open Connection**.
1. Select the **Amazon S3** connection type.
1. Specify the connection parameters:
    * **Server**: `{{ s3-storage-host }}`.

      To connect to a particular bucket, specify `<bucket_name>.{{ s3-storage-host }}` in the **Server** field.
    * **Port**: `443`.
    * **Access key ID**: ID of the static key you got earlier.
    * **Secret access key**: Secret key you got earlier.
1. Click **Connect**.

Once the connection is established, the bucket you created earlier will open.

{% note info %}

CyberDuck treats {{ objstorage-name }} as a hierarchical file system. This means that the keys of objects uploaded via CyberDuck will look like file paths, e.g., `prefix/subprefix/picture.jpg`.

{% endnote %}

Learn more about using CyberDuck with S3-compatible storages in the [CyberDuck documentation](https://docs.cyberduck.io/protocols/s3/).
