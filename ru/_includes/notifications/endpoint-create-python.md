```python
response = client.create_platform_endpoint(
    PlatformApplicationArn="<ARN_канала_уведомлений>",
    Token="<Push-токен>",
)
print ("Endpoint ARN:", response["EndpointArn"])
```

Где:

* `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.
* `Token` — уникальный Push-токен приложения на устройстве пользователя.

В результате вы получите идентификатор (ARN) мобильного эндпоинта.