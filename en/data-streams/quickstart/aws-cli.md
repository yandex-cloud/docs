---
title: Tutorial on collecting and delivering data to {{ ydb-full-name }} using the AWS CLI
description: In this tutorial, you'll learn how to collect and deliver data to {{ ydb-full-name }} using the AWS CLI.
---

# AWS CLI

{% include [trigger](../../_includes/data-streams/trigger.md) %}

1. In the [management console]({{ link-console-main }}), select the folder with the stream.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
1. Select the data stream.
1. Click **{{ ui-key.yacloud.data-streams.button_connect }}** and go to the **AWS CLI** tab.
1. Copy the example of the command for sending messages and run it. Data will be delivered over the AWS Kinesis Data Streams protocol.

   Command example:

   ```bash
   aws kinesis \
     --endpoint https://yds.serverless.yandexcloud.net \
     put-record \
     --stream-name /{{ region-id }}/aoegtvhtp8ob********/cc8004q4lbo6********/test \
     --cli-binary-format raw-in-base64-out \
     --data '{"user_id":"user1", "score": 100}' \
     --partition-key 1
   ```

   Result:

   ```json
   {
      "ShardId": "shard-000001",
      "SequenceNumber": "3130",
      "EncryptionType": "NONE"
   }
   ```
