---
title: Creating a stream in the AWS CLI
description: Follow this guide to create a stream in the AWS CLI.
---

# Creating a stream in the AWS CLI

{% list tabs group=instructions %}

- CLI {#cli}

  To create a [stream](../../concepts/glossary.md#stream-concepts), run this command:

  ```bash
  aws kinesis create-stream \
    --endpoint <endpoint> \
    --stream-name <stream_ID> \
    --shard-count <number_of_shards>
  ```

  * `--endpoint`: Specify the `https://yds.serverless.yandexcloud.net` endpoint to create a stream that will receive data over the AWS Kinesis Data Streams protocol.
  * `--stream-name`: Consists of the availability zone, folder ID, {{ ydb-full-name }} database ID, and stream name.

     >For example, your stream ID will appear as `/{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream` if:
     >* `aws_stream`: Stream name.
     >* `{{ region-id }}`: Region.
     >* `aoeu1kuk2dht********`: Folder ID.
     >* `cc8029jgtuab********`: {{ ydb-short-name }} database ID.
  * `--shard-count`: Number of [stream shards](../../concepts/glossary.md#shard).

  {% note info %}

  Since you cannot specify the data stream rate in Amazon Kinesis, all data streams are created with a shard throughput of 1 MB/s and a retention period of 24 hours for compatibility purposes.

  {% endnote %}

  Command example:

  ```bash
  aws kinesis create-stream \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream \
    --shard-count 1
  ```

{% endlist %}
