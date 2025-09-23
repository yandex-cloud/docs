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
* `Endpoint`: ARN of the endpoint subscribing to the topic, in `arn:aws:sns::<cloud_id>:endpoint/<platform>/<channel_name>/<endpoint_unique_id>` format. For SMS, enter a phone number in [E.164](https://{{ lang }}.wikipedia.org/wiki/E.164) format, e.g., `+79991112233`.