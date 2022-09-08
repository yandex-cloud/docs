# AWS CLI

{% include [trigger](../../_includes/data-streams/trigger.md) %}

1. In the [management console]({{ link-console-main }}), select the folder where the stream is located.

1. Select **{{ yds-full-name }}**.

1. Select the stream.

1. Click **Connect** and go to the **AWS CLI** tab.

1. Copy the example of the command for sending messages and run it. The data will be delivered over the AWS Kinesis Data Streams protocol.

   Command example:

   ```bash
   aws kinesis \
     --endpoint https://yds.serverless.yandexcloud.net \
     put-record \
     --stream-name /{{ region-id }}/aoegtvhtp8ob9rqq8sto/cc8004q4lbo6bv9iivr0/test \
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

