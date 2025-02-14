```php
$response = $client->createPlatformEndpoint(
    [
        'PlatformApplicationArn' => '<ARN_канала_уведомлений>',
        'Token' => '<Push-токен>',
    ]
);

print($response->get('EndpointArn'));
```

Где:

* `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.
* `Token` — уникальный Push-токен приложения на устройстве пользователя.

В результате вы получите идентификатор (ARN) мобильного эндпоинта.