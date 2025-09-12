```python
try:
    response = client.subscribe(
        TopicArn = "<topic_ARN>",
        Protocol = "<channel_type>",
        Endpoint = "<endpoint_ARN_or_phone_number>"
    )
    print(f"Topic ARN: {response['TopicArn']}")
except botocore.exceptions.ClientError as error:
    print(f"Error: {error}")
```

Where:

* `TopicArn`: Topic ARN.
* `Protocol`: Notification channel type, e.g., `sms` or `application`.
* `Endpoint`: {% include [arn_or_number](arn_or_number.md) %}.