```php
$response = $client->createPlatformEndpoint(
    [
        'PlatformApplicationArn' => '<notification_channel_ARN>',
        'Token' => '<push_token>',
    ]
);

print($response->get('EndpointArn'));
```

Where:

* `PlatformApplicationArn`: Notification channel ID (ARN).
* `Token`: Unique push token for the app on the user’s device.

As a result, you will get a mobile endpoint ID (ARN).