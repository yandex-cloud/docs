```python
response = client.create_topic(
    Name="<topic_name>"
)

print (f"Topic ARN:", response['TopicArn'])
```

Where:

* `Name`: Topic name, which can be any name unique within {{ cns-name }}.