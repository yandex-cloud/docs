```bash
aws sns subscribe \
  --topic-arn <topic_ARN> \
  --protocol <channel_type> \
  --notification-endpoint <endpoint_ARN_or_phone_number>
```

Where:
  * `topic-arn`: Topic ARN.
  * `protocol`: Type of notification channel, e.g., `sms`, `application`.
  * `notification-endpoint`: ARN of the endpoint subscribing to the topic, in `arn:aws:sns::<cloud_id>:endpoint/<platform>/<channel_name>/<endpoint_unique_id>` format. For SMS, enter a phone number in [E.164](https://{{ lang }}.wikipedia.org/wiki/E.164) format, e.g., `+79991112233`.

For more information about the `aws sns subscribe` command, see the [AWS documentation](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-create-subscribe-endpoint-to-topic.html).