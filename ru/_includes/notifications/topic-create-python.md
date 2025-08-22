```python
response = client.create_topic(
    Name="<имя_топика>"
)

print (f"Topic ARN:", response['TopicArn'])
```

Где:

* `Name` — произвольное имя топика, должно быть уникальным в {{ cns-name }}.