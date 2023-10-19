---
title: "Getting stream information"
description: "This guide describes how you can get information about a stream."
---

# Getting stream information

{% list tabs %}

- CLI

   To get a description of the created [stream](../../concepts/glossary.md#stream-concepts), run the command:

   ```bash
   aws kinesis describe-stream \
     --endpoint <endpoint> \
     --stream-name <stream_ID>
   ```

   * `--endpoint`: Specify the `https://yds.serverless.yandexcloud.net` endpoint to get information about the stream that data is sent to over the AWS Kinesis Data Streams protocol.
   * `--stream-name`: Consists of the availability zone, the folder ID, the {{ ydb-full-name }} database ID, and the stream name.

      > For example, specify the stream ID `/{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream` if:
      > * `aws_stream`: Stream name.
      > * `{{ region-id }}`: Region.
      > * `aoeu1kuk2dhtaupdb1es`: Folder ID.
      > * `cc8029jgtuabequtgtbv`: {{ ydb-short-name }} database ID.

   Command example:

   ```bash
   aws kinesis describe-stream \
     --endpoint https://yds.serverless.yandexcloud.net \
     --stream-name /{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream
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
