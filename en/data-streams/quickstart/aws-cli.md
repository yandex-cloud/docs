---
title: Guide for collecting and delivering {{ ydb-full-name }} data using the AWS CLI
description: In this tutorial, you will learn how to collect and deliver {{ ydb-full-name }} data using the AWS CLI.
---

# AWS CLI

{% include [trigger](../../_includes/data-streams/trigger.md) %}

1. In the [management console]({{ link-console-main }}), select the folder containing your data stream.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
1. Select the data stream.
1. Click **{{ ui-key.yacloud.data-streams.button_connect }}** and navigate to the **AWS CLI** tab.
1. Copy and run the example command to send a message. Data delivery will be performed via AWS Kinesis Data Streams.

   Example command:

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
