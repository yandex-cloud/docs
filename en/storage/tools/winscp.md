---
title: What is WinSCP?
description: WinSCP is a Windows graphical client for network storage. WinSCP treats {{ objstorage-name }} as a hierarchical file system.
keywords:
  - winscp
  - win scp
  - what is winscp
---

# WinSCP

[WinSCP](https://winscp.net/eng/docs/introduction) is a GUI client for Windows that allows you to work with cloud storages, including those compatible with the Amazon S3 API.

{% note info %}

To work with {{ objstorage-name }}, use version 5.14 or later.

{% endnote %}

## Getting started {#before-you-begin}

{% include [aws-tools-prepare-with-bucket](../../_includes/aws-tools/aws-tools-prepare-with-bucket.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

[Download](https://winscp.net/eng/download.php) the WinSCP distribution and run it.

## Connection {#connection}

1. Run WinSCP.
1. In the **Sessions** tab, select **New Session...**.
1. Under **Sessions**, specify the following parameters:
    * **File protocol**: **Amazon S3**.
    * **Host name**: `{{ s3-storage-host }}`.
    * **Port number**: `443`.
    * **Access key ID**: Static key ID you got earlier.
    * **Secret access key**: Secret key you got earlier.

   To connect to a particular bucket, click **Advanced...**. In the **Advanced Site Settings** window, select **Directories** in the left-hand menu, under **Environment**. In the **Remote directory:** field, specify the bucket name and click **OK**.
1. Click **Login**.

Once the connection is established, the right-hand panel will show the bucket you created earlier.

{% note info %}

WinSCP treats {{ objstorage-name }} as a hierarchical file system. This means that the keys of objects uploaded via WinSCP look like file paths, e.g., `prefix/subprefix/picture.jpg`.

{% endnote %}

Learn more about using WinSCP with an S3-compatible storage in the [WinSCP documentation](https://winscp.net/eng/docs/guide_amazon_s3#buckets).
