---
title: "What is WinSCP?"
description: "WinSCP is a Windows graphical client for network storage. WinSCP treats {{ objstorage-name }} like a hierarchical file system."
keywords:
  - winscp
  - win scp
  - what is winscp
---

# WinSCP

WinSCP is a Windows graphical client for network storage.

{% note info %}

To work with {{ objstorage-name }}, use version 5.14 or later.

{% endnote %}

## Before you start {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Installation {#installation}

To install WinSCP, go to the [manufacturer's website](https://winscp.net) and download the necessary distribution.

## Connection {#connection}

Create a connection with the following parameters:

  - Transfer protocol: `Amazon S3`.
  - Hostname: `{{ s3-storage-host }}`.
  - Access key ID: The ID of the key that you received when generating the static key.
  - Secret access key: The key that you received when generating a static key.

{% note info %}

WinSCP treats {{ objstorage-name }} like a hierarchical file system. This means that keys for objects uploaded via WinSCP look like file paths. For example, `prefix/subprefix/picture.jpg`.

{% endnote %}
