# Replicating logs to {{ objstorage-name }} using Fluent Bit


Data aggregators enable you to transmit data (for example, logs) from the [VM instances](../compute/concepts/vm.md) to the log monitoring and data storage services.

In this tutorial, you will learn how to replicate VM logs automatically to an {{ objstorage-name }} bucket using the [Fluent Bit](https://fluentbit.io) logging processor.

The solution described below works in the following way:
1. Fluent Bit runs on an active VM as a [systemd](https://ru.wikipedia.org/wiki/Systemd) module.
1. Fluent Bit collects logs according to the configuration settings and sends them to a {{ yds-name }} [stream](../data-streams/concepts/glossary.md#stream-concepts) via the [Amazon Kinesis Data Streams](https://aws.amazon.com/ru/kinesis/data-streams/) protocol.
1. In the working folder, you set up a {{ data-transfer-name }} [transfer](../data-transfer/concepts/#transfer) that fetches data from the stream and saves it to an {{ objstorage-name }} [bucket](../storage/concepts/bucket.md).

To set up log replication:

1. [Prepare your cloud](#before-you-begin).
1. [Configure the environment](#setup).
1. [Create an {{ objstorage-name }} bucket for storing your logs](#create-bucket).
1. [Create a data stream {{ yds-name }}](#create-stream).
1. [Create a transfer {{ data-transfer-name }}](#create-transfer).
1. [Install Fluent Bit](#install-fluent-bit).
1. [Connect Fluent Bit to a data stream](#connect).
1. [Test sending and receiving data](#check-ingestion).

If you no longer want to store logs, [delete the resources allocated to them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](./_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of data storage support includes:

* Data stream maintenance fees (see [{{ yds-full-name }} pricing](../data-streams/pricing.md)).
* Fees for transmitting data between sources and targets (see [{{ data-transfer-full-name }} pricing](../data-transfer/pricing.md)).
* Data storage fees (see [{{ objstorage-full-name }} pricing](../storage/pricing.md)).

## Configure the environment {#setup}

1. [Create a service account](../iam/operations/sa/create.md), e.g., `logs-sa`, with the `editor` role assigned for the folder.
1. [Create a static access key](../iam/operations/sa/create-access-key.md) for the service account. Save the ID and private key. You'll need them to log in to AWS.
1. [Create a VM](../compute/operations/vm-create/create-linux-vm.md) from a public [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) image. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the service account that you created in the previous step.
1. [Connect to the VM](../compute/operations/vm-connect/ssh.md#vm-connect) via SSH.
1. Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) utility on the VM.
1. Run this command:

   ```bash
   aws configure
   ```
1. Enter the following one by one:

   * `AWS Access Key ID [None]:`: Service account [key ID](../iam/concepts/authorization/access-key.md).
   * `AWS Secret Access Key [None]:`: [Secret access key](../iam/concepts/authorization/access-key.md) of the service account.
   * `Default region name [None]:` `{{ region-id }}` region.

{% include [create-bucket](_tutorials_includes/create-bucket.md) %}

{% include [create-stream](_tutorials_includes/create-stream.md) %}

{% include [create-transfer](_tutorials_includes/create-transfer.md) %}

## Install Fluent Bit {#install-fluent-bit}

{% note info %}

This tutorial uses the current Fluent Bit version 1.9.

{% endnote %}

1. To install Fluent Bit to your VM, run the command:
   ```bash
   curl https://raw.githubusercontent.com/fluent/fluent-bit/master/install.sh | sh
   ```
   For more information on how to install Fluent Bit, see the [official documentation](https://docs.fluentbit.io/manual/installation/linux/ubuntu).

1. Run the `fluent-bit` service:
   ```bash
   sudo systemctl start fluent-bit
   ```
1. Check the `fluent-bit` service status, it should be active:
   ```bash
   sudo systemctl status fluent-bit
   ```

   The result should include the status `active (running)` and logs for the embedded `cpu` plugin that Fluent Bit starts collecting once installation is complete (by default):
   ```bash
   ● fluent-bit.service - Fluent Bit
    Loaded: loaded (/lib/systemd/system/fluent-bit.service; disabled; vendor preset: enabled)
    Active: active (running) since Thu 2022-09-08 10:23:03 UTC; 10s ago
      Docs: https://docs.fluentbit.io/manual/
   Main PID: 1328 (fluent-bit)
     Tasks: 4 (limit: 2310)
    Memory: 2.8M
    CGroup: /system.slice/fluent-bit.service
            └─1328 /opt/fluent-bit/bin/fluent-bit -c //etc/fluent-bit/fluent-bit.conf

    Sep 08 10:23:03 ycl-20 fluent-bit[1328]: [2022/09/08 10:23:03] [ info] [output:stdout:stdout.0] worker #0 started
    Sep 08 10:23:05 ycl-20 fluent-bit[1328]: [0] cpu.local: [1662632584.114661597, {"cpu_p"=>1.000000, "user_p"=>0.000000, >
    Sep 08 10:23:06 ycl-20 fluent-bit[1328]: [0] cpu.local: [1662632585.114797726, {"cpu_p"=>0.000000, "user_p"=>0.000000, >
    ...

   ```

## Connect Fluent Bit to the data stream {#connect}

{% note info %}

If you are running Fluent Bit version below 1.9 that comes with the `td-agent-bit` package, edit the files `/etc/td-agent-bit/td-agent-bit.conf`, `/lib/systemd/system/td-agent-bit.service` and restart the `td-agent-bit` service.

{% endnote %}


1. Open the file `/etc/fluent-bit/fluent-bit.conf`:

   ```bash
   sudo vim  /etc/fluent-bit/fluent-bit.conf
   ```
1. Add the `OUTPUT` section with the `kinesis_streams` plugin settings:

   ```bash
   [OUTPUT]
       Name kinesis_streams
       Match *
       region ru-central-1
       stream /<region>/<folder_ID>/<database_ID>/<data_stream_ID>
       endpoint https://yds.serverless.yandexcloud.net
   ```
   Where:

   * `data-stream`: {{ yds-name }} data stream ID.
      > For example, your stream ID will appear as `/{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/logs-stream` if:
      > * `logs-stream`: Stream name
      > * `{{ region-id }}`: Region
      > * `aoeu1kuk2dht********`: Folder ID
      > * `cc8029jgtuab********`: {{ ydb-short-name }} Database ID

   For more information on how to install Fluent Bit, see the [official documentation](https://docs.fluentbit.io/manual/administration/configuring-fluent-bit/classic-mode/configuration-file).

1. Open the file `/lib/systemd/system/fluent-bit.service`:
   ```bash
   sudo vim  /lib/systemd/system/fluent-bit.service
   ```
1. To the `SERVICE` section, add the environment variables that include paths to files with access keys:
   ```bash
   Environment=AWS_CONFIG_FILE=/home/<username>/.aws/config
   Environment=AWS_SHARED_CREDENTIALS_FILE=/home/<username>/.aws/credentials
   ```

   where `<username>` is the username that you specified in the VM settings.

1. Restart the `fluent-bit` service:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl restart fluent-bit
   ```
1. Check the status of the `fluent-bit` service. It shouldn't include any error messages:
   ```bash
   sudo systemctl status fluent-bit
   ```

   Result:
   ```bash
   Sep 08 16:51:19 ycl-20 fluent-bit[3450]: Fluent Bit v1.9.8
   Sep 08 16:51:19 ycl-20 fluent-bit[3450]: * Copyright (C) 2015-2022 The Fluent Bit Authors
   Sep 08 16:51:19 ycl-20 fluent-bit[3450]: * Fluent Bit is a CNCF sub-project under the umbrella of Fluentd
   Sep 08 16:51:19 ycl-20 fluent-bit[3450]: * https://fluentbit.io
   Sep 08 16:51:19 ycl-20 fluent-bit[3450]: [2022/09/08 16:51:19] [ info] [fluent bit] version=1.9.8, commit=, pid=3450
   Sep 08 16:51:19 ycl-20 fluent-bit[3450]: [2022/09/08 16:51:19] [ info] [storage] version=1.2.0, type=memory-only, sync=normal, checksum=disabled, max_chunks_up=128
   Sep 08 16:51:19 ycl-20 fluent-bit[3450]: [2022/09/08 16:51:19] [ info] [cmetrics] version=0.3.6
   Sep 08 16:51:19 ycl-20 fluent-bit[3450]: [2022/09/08 16:51:19] [ info] [sp] stream processor started
   Sep 08 16:51:19 ycl-20 fluent-bit[3450]: [2022/09/08 16:51:19] [ info] [output:kinesis_streams:kinesis_streams.1] worker #0 started
   Sep 08 16:51:19 ycl-20 fluent-bit[3450]: [2022/09/08 16:51:19] [ info] [output:stdout:stdout.0] worker #0 started
   ```

{% include [check-ingestion](_tutorials_includes/check-ingestion.md) %}

## How to delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../data-transfer/operations/transfer.md#delete).
1. [Delete the endpoints](../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the data stream](../data-streams/operations/manage-streams.md#delete-data-stream).
1. [Delete objects from the bucket](../storage/operations/objects/delete.md).
1. [Delete the bucket](../storage/operations/buckets/delete.md).
