```bash
aws sns create-platform-endpoint \
  --platform-application-arn <notification_channel_ARN> \
  --token <push_token>
```

Where:

* `--platform-application-arn`: Notification channel ID (ARN).
* `--token`: Unique push token for the application on the user’s device.

As a result, you will get a mobile endpoint ID (ARN). Save it for future use.

For more information about the `aws sns create-platform-endpoint` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/create-platform-endpoint.html).