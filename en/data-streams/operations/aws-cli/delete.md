---
title: "Deleting a stream in the AWS CLI"
description: "This guide describes how you can delete a stream in the AWS CLI."
---

# Deleting a stream in the AWS CLI

{% list tabs %}

- CLI

  To delete a [stream](../../concepts/glossary.md#stream-concepts), run the command:

  ```bash
  aws kinesis delete-stream \
    --endpoint <endpoint> \
    --stream-name <stream_ID>
  ```

  * `--endpoint`: Specify the `https://yds.serverless.yandexcloud.net` endpoint to delete a stream that receives data over the AWS Kinesis Data Streams protocol.
  * `--stream-name`: Consists of the availability zone, the folder ID, the {{ ydb-full-name }} database ID, and the stream name.

     > For example, specify the stream ID `/{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream` if:
     > * `aws_stream`: Stream name.
     > * `{{ region-id }}`: Availability zone.
     > * `aoeu1kuk2dhtaupdb1es`: Folder ID.
     > * `cc8029jgtuabequtgtbv`: {{ ydb-short-name }} database ID.

  Command example:

  ```bash
  aws kinesis delete-stream \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream
  ```

{% endlist %}
