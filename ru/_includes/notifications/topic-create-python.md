```python
response = client.create_topic(
    Name="<имя_топика>",
    Attributes={
        "SQSServiceAccountId": "<идентификатор_сервисного_аккаунта>",
    },
)

print(f"Topic ARN:", response['TopicArn'])
```

Где:

* `Name` — произвольное имя топика, должно быть уникальным в {{ cns-name }}.

{% include [sqs-service-account-attribute](sqs-service-account-attribute.md) %}
