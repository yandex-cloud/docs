```python
try:
    response = client.subscribe(
        TopicArn = "<topic_ARN>",
        Protocol = "<channel_type>",
        Endpoint = "<endpoint_ARN_or_phone_number_or_queue_URL>"
    )
    print(f"Topic ARN: {response['TopicArn']}")
except botocore.exceptions.ClientError as error:
    print(f"Error: {error}")
```

Where:

* `TopicArn`: Topic ARN.
* `Protocol`: Notification channel type, e.g., `sms`, `application`, or `sqs`.
* `Endpoint`: Endpoint subscribing to the topic:

    {% include [subscribe-endpoint-types](subscribe-endpoint-types.md) %}

	For a topic to be able to send messages to a queue, it must have the `SQSServiceAccountId` attribute set. For details, see the guides on [creating](../../notifications/operations/topics/topic-create.md#python) and [managing](../../notifications/operations/topics/topic-manage.md#python) a topic.
