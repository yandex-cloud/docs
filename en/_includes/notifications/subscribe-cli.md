```bash
aws sns subscribe \
  --topic-arn <topic_ARN> \
  --protocol <channel_type> \
  --notification-endpoint <endpoint_ARN_or_phone_number>
```

Where:
  * `topic-arn`: Topic ARN.
  * `protocol`: Type of notification channel, e.g., `sms`, `application`.
  * `notification-endpoint`: {% include [arn_or_number](arn_or_number.md) %}.

For more information about the `aws sns subscribe` command, see the [AWS documentation](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-create-subscribe-endpoint-to-topic.html).