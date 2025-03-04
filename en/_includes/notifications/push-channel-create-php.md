```php
$response = $client->createPlatformApplication(
    [
        'Name' => '<channel_name>',
        'Platform' => '<platform_type>',
        'Attributes' => [
            '<parameter1>' => '<value1>',
            ...
            '<parameterN>' => '<valueN>'
        ],
    ]
);

print($response->get('PlatformApplicationArn'));
```

Where:

* `Name`: Notification channel name, user-defined. The name must be unique within the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud). It may contain lowercase and uppercase Latin letters, numbers, underscores, hyphens, and periods. It may be from 1 to 256 characters long. For APNs channels, we recommend specifying the bundle ID in the name, and for FCM and HMS, the full package name.
* `Platform`: Mobile platform type:

  * `APNS` and `APNS_SANDBOX`: Apple Push Notification service (APNs). Use `APNS_SANDBOX` to test the application.
  * `GCM`: Firebase Cloud Messaging (FCM).
  * `HMS`: Huawei Mobile Services (HMS).

* `Attributes`: Mobile platform authentication parameters in `'<parameter1>' => '<value1>'` format, comma-separated. The values depend on platform:

  * APNs:

    * Token-based authentication:

      * `PlatformPrincipal`: Path to the token signature key file from Apple.
      * `PlatformCredential`: Key ID.
      * `ApplePlatformTeamID`: Team ID.
      * `ApplePlatformBundleID`: Bundle ID.

    * Certificate-based authentication:

      * `PlatformPrincipal`: SSL certificate in `.pem` format.
      * `PlatformCredential`: Certificate private key in `.pem` format.

          {% include [convert-p12-to-pem](convert-p12-to-pem.md) %}

    Token-based authentication: The more modern and secure method.

  * FCM: `PlatformCredential` is the Google Cloud service account key in JSON format for authentication with the HTTP v1 API or API key (server key) for authentication with the legacy API.

    Use the HTTP v1 API because the [FCM legacy API is no longer supported](https://firebase.google.com/docs/cloud-messaging/migrate-v1) starting July 2024.

  * HMS:

    * `PlatformPrincipal`: Key ID
    * `PlatformCredential`: API key

As a result, you will get a notification channel ID (ARN).