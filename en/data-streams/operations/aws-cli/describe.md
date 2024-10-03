---
title: Getting stream information
description: Follow this guide to get information about a stream.
---

# Getting stream information

{% list tabs group=instructions %}

- CLI {#cli}

   To get a description of the created [stream](../../concepts/glossary.md#stream-concepts), run the command:

   ```bash
   aws kinesis describe-stream \
     --endpoint <endpoint> \
     --stream-name <stream_ID>
   ```

   * `--endpoint`: Specify the `https://yds.serverless.yandexcloud.net` endpoint to get information about the stream that data is sent to over the AWS Kinesis Data Streams protocol.
   * `--stream-name`: Consists of the availability zone, cloud ID, {{ ydb-full-name }} database ID, and stream name.

      {% include [stream-name-example](../../../_includes/data-streams/stream-name-example.md) %}

   Command example:

   ```bash
   aws kinesis describe-stream \
     --endpoint https://yds.serverless.yandexcloud.net \
     --stream-name /{{ region-id }}/b1gvlrnlei4l********/etn780rpm7e5********/default
   ```

   Result:

   ```json
   {
     "StreamDescription": {
       "Shards": [
       {
         "ShardId": "shard-000000",
         "ParentShardId": "",
         "AdjacentParentShardId": "",
         "HashKeyRange": {
           "StartingHashKey": "0",
           "EndingHashKey": "113427455640312821154458202477256070484"
         },
         "SequenceNumberRange": {
           "StartingSequenceNumber": "0",
           "EndingSequenceNumber": ""
         }
       }],
       "StreamARN": null,
       "StreamName": "aws_stream",
       "StreamStatus": "ACTIVE",
       "RetentionPeriodHours": 24,
       "EnhancedMonitoring": null,
       "EncryptionType": "ENCRYPTION_UNDEFINED",
       "KeyId": "",
       "StreamCreationTimestamp": ""
     }
   }
   ```

{% endlist %}
