# Storing application runtime logs

To analyze information about application events for any period, application runtime logs need to be stored securely.

Applications don't usually send their logs to storage systems directly. Instead, they use aggregators such as [fluentd](https://www.fluentd.org), [fluentbit](https://fluentbit.io), or [logstash](https://www.elastic.co/logstash/). Though aggregators can write data to storage systems directly, to enhance reliability, data is first sent to an intermediate buffer (a data streaming bus, [message broker](https://en.wikipedia.org/wiki/Message_broker)), and then to a storage system from it.

This approach lets developers focus on application functionality and delegate log delivery and storage to special systems.

Using this tutorial, you'll learn how to save application runtime logs to {{ objstorage-full-name }}.

To set up application runtime log storage:

1. [Before you start](#before-you-begin).
1. [Configure the environment](#setup).
1. [Create a bucket for storing logs](#create-bucket).
1. [Create a data stream](#create-stream).
1. [Create a transfer](#create-transfer).
1. [Install Fluentd](#install-fluentd).
1. [Connect Fluentd to your data stream](#connect).
1. [Test sending and receiving data](#test-ingestion).

If you no longer need to store any logs, [delete the resources in use](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of application log storage support includes:

* Data stream maintenance fees (see [{{ yds-full-name }} pricing](../../data-streams/pricing.md)).
* Fees for transmitting data between sources and targets (see [{{ data-transfer-full-name }} pricing](../../data-transfer/pricing.md)).
* Data storage fees (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).

## Configure the environment {#setup}

1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `editor` role for your folder.
1. [Create](../../iam/operations/sa/create-access-key.md) a static access key.

You'll need the ID and secret key in the next steps.

## Create a bucket for storing logs {#create-bucket}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
1. In the list of services, select **{{ objstorage-name }}**.
1. Click **Create bucket**.
1. Name the bucket.
1. In the **Storage class** field, select `Cold`.
1. Click **Create bucket**.

## Create a data stream {#create-stream}

1. In the [management console]({{ link-console-main }}), select the folder to create a data stream in.
1. Select **{{ yds-full-name }}**.
1. Click **Create stream**.
1. Specify an existing [serverless](../../ydb/concepts/serverless-and-dedicated.md#serverless) {{ ydb-short-name }} database or [create](../../ydb/quickstart.md#serverless) a new one. If you chose to create a new database, click ![refresh-button](../../_assets/data-streams/refresh-button.svg) **Update** after creating it to update the list of databases.
1. Enter the name of the stream.
1. Click **Create**.

Wait for the stream to start. Once the stream is ready for use, its status changes from `CREATING` to `ACTIVE`.

## Create a transfer {#create-transfer}

1. On the page of the created stream, click **Actions** and select **Create data transfer**.
1. Create a source endpoint:
   1. In the **Direction** field, select `Source`.
   1. Enter a name for the endpoint.
   1. In the **Database type** list, select `{{ yds-full-name }}`.
   1. Select a database for the source.
   1. Enter the name of the previously created stream.
   1. Select the service account you created earlier.
   1. Click **Create**.
1. Create a target endpoint:
   1. Click **Create endpoint**.
   1. In the **Direction** field, select `Target`.
   1. Enter a name for the endpoint.
   1. In the **Database type** list, select `{{ objstorage-name }}`.
   1. Enter the name of the previously created bucket.
   1. Select the service account you created earlier.
   1. Click **Create**.
1. Create a transfer:
   1. On the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **Transfers**.
   1. Click **Create transfer**.
   1. Name the transfer.
   1. Select the previously created source endpoint.
   1. Select the previously created target endpoint.
   1. Click **Create**.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the created transfer and select **Activate**.

Wait until the transfer is activated. Once the transfer is ready for use, its status changes from {{ dt-status-creation }} to {{ dt-status-repl }}.

## Install Fluentd {#install-fluentd}

1. Download and install [Fluentd](https://www.fluentd.org/download).
1. Install the Fluentd plugin to support the AWS Kinesis Data Streams protocol. This protocol will be used for streaming data.

```bash
sudo td-agent-gem install fluent-plugin-kinesis
```

## Connect Fluentd to your data stream {#connect}

1. On the page of the created stream, click **Connect** and go to the **Fluentd** tab.
1. Copy a sample configuration file and paste it into the `/etc/td-agent/td-agent.conf` file. Replace `<key_id>` and `<secret>` with the previously obtained ID and secret key.

{% cut "Sample configuration file" %}

```xml
<system>
  log_level debug
</system>
<source>
  @type http
  @id input_http
  port 8888
</source>
<match kinesis>
  @type copy
  <store>
    @type stdout
  </store>
  <store>
    @type kinesis_streams

    aws_key_id <key_id>
    aws_sec_key <secret>

    # kinesis stream name
    stream_name /{{ region-id }}/b1gia92mbaomkfvslsed/etnhstu01ninfu6631lk/my-stream

    # region
    region ru-central-1

    endpoint https://yds.serverless.yandexcloud.net

    <buffer>
      flush_interval 5s
    </buffer>
  </store>
</match>
```

{% endcut %}

## Test sending and receiving data {#test-ingestion}

To send data to the stream using Fluentd, run the command:

```bash
curl -X POST -d 'json={"user_id":"user1", "score": 100}' http://localhost:8888/kinesis
```

If the setup is successful, the Fluentd `/var/log/td-agent/td-agent.log` operation log will include messages about receiving the data and writing it to {{ yds-full-name }} over the AWS Kinesis Data Streams protocol:

```text
...
2022-04-20 19:36:37.770311035 +0000 kinesis: {"user_id":"user1","score":100}
2022-04-20 19:36:42 +0000 [debug]: #0 /{{ region-id }}/b1gia92mbaomkfvslsed/etnhstu01ninfu6631lk/my-stream: Write chunk 5dd1b1ca1bd788e49185aa681e8132b9 /   1 records /    0 KB
2022-04-20 19:36:42 +0000 [debug]: #0 /{{ region-id }}/b1gia92mbaomkfvslsed/etnhstu01ninfu6631lk/my-stream: Finish writing chunk
...
```

The created bucket will contain a file with the message sent.

## How to delete created resources {#clear-out}

To stop paying for the resources you used:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the endpoints](../../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the data stream](../../data-streams/operations/manage-streams.md#delete-data-stream).
1. [Delete the bucket](../../storage/operations/buckets/delete.md).
