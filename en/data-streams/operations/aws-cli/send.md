---
title: "Tutorial on sending the data from {{ ydb-full-name }} to an AWS CLI stream"
description: "In this tutorial, you'll learn how to send data from {{ ydb-full-name }} to an AWS CLI stream."
---

# Sending data to a stream in the AWS CLI

{% include [trigger](../../../_includes/data-streams/trigger.md) %}

{% list tabs %}

- CLI

  To send data to a [stream](../../concepts/glossary.md#stream-concepts), run the command:

  ```bash
  aws kinesis put-record \
    --endpoint <endpoint> \
    --stream-name <stream_ID> \
    --cli-binary-format <binary_format> \
    --data <message> \
    --partition-key <shard_key>
  ```

  Where:

  * `--endpoint`: Specify the endpoint `https://yds.serverless.yandexcloud.net` to send data to a stream over the AWS Kinesis Data Streams protocol.
  * `--stream-name`: Consists of the availability zone, the folder ID, the {{ ydb-full-name }} database ID, and the stream name.

    > For example, specify the stream ID `/{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream` if:
    > * `aws_stream`: Stream name.
    > * `{{ region-id }}`: Region.
    > * `aoeu1kuk2dhtaupdb1es`: Folder ID.
    > * `cc8029jgtuabequtgtbv`: {{ ydb-short-name }} database ID.
  * `--cli-binary-format`: Binary object format.
  * `--data`: Transmitted data.
  * `--partition-key`: [Shard](../../concepts/glossary.md#shard) in the stream where the data is sent.

  Command example:

  ```bash
  aws kinesis put-record \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream \
    --cli-binary-format raw-in-base64-out \
    --data '{"user_id":"user1", "score": 100}' \
    --partition-key 1
  ```

  Result example:

  ```json
  {
    "ShardId": "shard-000001",
    "SequenceNumber": "5851",
    "EncryptionType": "NONE"
  }
  ```

{% endlist %}
