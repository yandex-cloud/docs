# Replicating logs to {{ objstorage-full-name }} using Fluent Bit


Data aggregators enable you to transmit data, e.g., logs, from [VM instances](../../compute/concepts/vm.md) to log monitoring and data storage services.

In this tutorial, you will learn how to replicate VM logs automatically to an {{ objstorage-name }} bucket using the [Fluent Bit](https://fluentbit.io) logging processor.

The solution described below works in the following way:
1. Fluent Bit runs on an active VM as a [systemd](https://ru.wikipedia.org/wiki/Systemd) module.
1. Fluent Bit collects logs as per the configuration settings and sends them to a {{ yds-name }}-enabled [stream](../../data-streams/concepts/glossary.md#stream-concepts) over the [Amazon Kinesis Data Streams](https://aws.amazon.com/ru/kinesis/data-streams/) protocol.
1. In your working folder, you set up a {{ data-transfer-name }}-enabled [transfer](../../data-transfer/concepts/#transfer) that fetches data from the stream and saves it to an {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md).

To set up log replication:

1. [Get your cloud ready](#before-you-begin).
1. [Set up your environment](#setup).
1. [Create an {{ objstorage-name }} bucket for storing your logs](#create-bucket).
1. [Create a {{ yds-name }}-enabled data stream](#create-stream).
1. [Create a {{ data-transfer-name }}-enabled transfer](#create-transfer).
1. [Install Fluent Bit](#install-fluent-bit).
1. [Connect Fluent Bit to your data stream](#connect).
1. [Test sending and receiving data](#check-ingestion).

If you no longer want to store logs, [delete the resources allocated to them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of data storage support includes:

* Fees for data stream maintenance (see [{{ yds-full-name }} pricing](../../data-streams/pricing.md)).
* Fees for transmitting data between sources and targets (see [{{ data-transfer-full-name }} pricing](../../data-transfer/pricing.md)).
* Fee for data storage (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).


## Set up your environment {#setup}

1. [Create a service account](../../iam/operations/sa/create.md), e.g., `logs-sa`, with the `editor` role for the folder.
1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the service account. Save the ID and secret key. You will need them to log in to AWS.
1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) from a public [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) image. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the service account you created at the previous step.
1. [Connect to the VM](../../compute/operations/vm-connect/ssh.md#vm-connect) over SSH.
1. Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) utility on your VM.
1. Run this command:

    ```bash
    aws configure
    ```
1. Enter the following, one by one:

    * `AWS Access Key ID [None]:`: Service account [key ID](../../iam/concepts/authorization/access-key.md).
    * `AWS Secret Access Key [None]:`: Service account [secret key](../../iam/concepts/authorization/access-key.md).
    * `Default region name [None]:`: `{{ region-id }}`.

{% include [create-bucket](../_tutorials_includes/create-bucket.md) %}

{% include [create-stream](../_tutorials_includes/create-stream.md) %}

{% include [create-transfer](../_tutorials_includes/create-transfer.md) %}

## Install Fluent Bit {#install-fluent-bit}

{% note info %}

This tutorial uses the current Fluent Bit version, 1.9.

{% endnote %}

1. To install Fluent Bit on your VM, run this command:
    ```bash
    curl https://raw.githubusercontent.com/fluent/fluent-bit/master/install.sh | sh
    ```
    For more information on how to install Fluent Bit, see [this Fluent Bit guide](https://docs.fluentbit.io/manual/installation/linux/ubuntu).

1. Start `fluent-bit`:
    ```bash
    sudo systemctl start fluent-bit
    ```
1. Make sure the `fluent-bit` status is active:
    ```bash
    sudo systemctl status fluent-bit
    ```

    The result should include the `active (running)` status and logs for the embedded `cpu` plugin that Fluent Bit starts collecting by default as soon as installation is complete:
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

## Connect Fluent Bit to your data stream {#connect}

{% note info %}

If running Fluent Bit version below 1.9, which comes with the `td-agent-bit` package, edit the `/etc/td-agent-bit/td-agent-bit.conf` and `/lib/systemd/system/td-agent-bit.service` files and restart `td-agent-bit`.

{% endnote %}


1. Open `/etc/fluent-bit/fluent-bit.conf`: 

   ```bash
   sudo vim  /etc/fluent-bit/fluent-bit.conf
   ```
1. Add the `OUTPUT` section with the `kinesis_streams` plugin settings:

    ```bash
    [OUTPUT]
        Name  kinesis_streams
        Match *
        region ru-central-1
        stream /<region>/<folder_ID>/<database_ID>/<stream_name>
        endpoint https://yds.serverless.yandexcloud.net
    ```
    Where:

    * `stream`: ID of the {{ yds-name }}-enabled data stream. 
        >For example, your stream ID will appear as `/{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/logs-stream` if:
        >* `logs-stream`: Stream name.
        >* `{{ region-id }}`: Region
        >* `aoeu1kuk2dht********`: Folder ID.
        >* `cc8029jgtuab********`: {{ ydb-short-name }} database ID.

    For more information on how to install Fluent Bit, see [this Fluent Bit guide](https://docs.fluentbit.io/manual/administration/configuring-fluent-bit/classic-mode/configuration-file).

1. Open `/lib/systemd/system/fluent-bit.service`: 
   ```bash
   sudo vim  /lib/systemd/system/fluent-bit.service
   ```
1. Add the environment variables that include paths to the access key files to the `SERVICE` section:
   ```bash
   Environment=AWS_CONFIG_FILE=/home/<username>/.aws/config
   Environment=AWS_SHARED_CREDENTIALS_FILE=/home/<username>/.aws/credentials
   ```

   Where `<username>` is the username you specified in the VM settings. 

1. Restart `fluent-bit`:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl restart fluent-bit
   ```
1. Check the `fluent-bit` status. It must not contain any error messages:
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

{% include [check-ingestion](../_tutorials_includes/check-ingestion.md) %}

## How to delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the endpoints](../../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the data stream](../../data-streams/operations/manage-streams.md#delete-data-stream).
1. [Delete the objects from the bucket](../../storage/operations/objects/delete.md).
1. [Delete the bucket](../../storage/operations/buckets/delete.md).
