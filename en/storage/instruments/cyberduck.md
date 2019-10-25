# CyberDuck

CyberDuck is a GUI-based cloud storage client for Mac and Windows that is available as a console client for all operating systems.

## Before you start {#preparations}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Installation {#installation}

To install CyberDuck, go to the [manufacturer's website](https://cyberduck.io) and download the required distribution.

## Connections {#connection}

Create a connection with the following parameters:

  - Connection type: `Amazon S3`.
  - Server and port: `{{ s3-storage-host }}:443`.
  - Access Key ID: the `id` that you received when generating the static key.
  - Password: the `secretKey` that you received when generating the static key.

{% note info %}

CyberDuck treats {{ objstorage-name }} as a hierarchical file system. This means that keys for objects uploaded via CyberDuck will look like a file path. For example, `prefix/subprefix/picture.jpg`.

{% endnote %}

