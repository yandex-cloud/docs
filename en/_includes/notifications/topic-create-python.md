```python
response = client.create_topic(
    Name="<topic_name>",
    Attributes={
        "SQSServiceAccountId": "<service_account_ID>",
    },
)

print(f"Topic ARN:", response['TopicArn'])
```

Where:

* `Name`: Topic name, which can be any name unique within {{ cns-name }}.

{% include [sqs-service-account-attribute](sqs-service-account-attribute.md) %}
