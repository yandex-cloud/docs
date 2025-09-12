To send a notification:

```bash
aws sns publish \
--topic-arn <topic_ARN> \
--message-structure json \
--message '{"default": "<notification_text>","APNS": {"aps":{"alert":"<notification_text>"}},"GCM": {"notification":{"body":"<notification_text>"}},"HMS": {"notification":{"body":"<notification_text>"}},"RUSTORE": {"notification":{"body":"<notification_text>"}},"WEB": "<notification_text>","sms": "<notification_text>"}'
```

Where:
  * `topic-arn`: Topic ARN.
  * `message-structure`: Message format (`json`).
  * `message`: Notification text or path to the notification file. To send different notifications depending on channel type, specify the channel and notification text: If some channel is not specified, the default message will be sent.

For more information about the `aws sns publish` command, see the [AWS documentation](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-publish-to-topic.html).