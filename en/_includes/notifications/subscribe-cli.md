```bash
aws sns subscribe \
  --topic-arn <topic_ARN> \
  --protocol <channel_type> \
  --notification-endpoint <endpoint_ARN_or_phone_number>
```

Where:
  * `topic-arn`: Topic ARN.
  * `protocol`: Notification channel type, e.g., `sms`, `application`, `sqs`.
  * `notification-endpoint`: Endpoint subscribing to the topic.

    {% include [subscribe-endpoint-types](subscribe-endpoint-types.md) %}

      For a topic to be able to send messages to a queue, it must have the `SQSServiceAccountId` attribute set. See the guide on [creating](../../notifications/operations/topics/topic-create.md#aws-cli) and [managing](../../notifications/operations/topics/topic-manage.md#aws-cli) a topic for more details.

Learn more about the `aws sns subscribe` command in [this AWS guide](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-create-subscribe-endpoint-to-topic.html).