# How to get started with the AWS SDK for PHP in {{ cns-full-name }}

To get started with the AWS SDK for PHP:
1. [Get your cloud ready](#before-you-begin).
1. [Get a static access key](#static-key).
1. [Configure the AWS SDK](#aws-sdk).
1. [Create a notification channel](#create-channel).
1. [Get a list of channels](#list-channel).
1. [Create an endpoint](#create-endpoint).
1. [Send a notification](#publish).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Get a static access key {#static-key}

{% include [sa-role-static-key](../../_includes/notifications/sa-role-static-key.md) %}

## Configure the AWS SDK {#aws-sdk}

1. Review the [system requirements](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/getting-started_requirements.html).
1. [Install PHP](https://www.php.net/manual/en/install.php) 5.5 or higher.
 
    When using the AWS SDK, do not disable the [SimpleXML PHP extension](https://www.php.net/manual/en/simplexml.installation.php).
1. [Install Composer](https://getcomposer.org/download) to manage PHP dependencies.
1. Add the AWS SDK library for PHP into your project:
   * If Composer in your system is installed globally, run this command in your project's root folder:

        ```bash
        composer require aws/aws-sdk-php
        ```
    * If Composer is not installed globally, run this command:

        ```bash
        php composer.phar require aws/aws-sdk-php
        ```

    For other installation methods, see the [AWS documentation](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/getting-started_installation.html).

1. Create a client:

    ```php
    <?php

    require '/<path_to_folder>/vendor/autoload.php';

    use Aws\Sns\SnsClient;

    $client = new SnsClient(
        [
            'endpoint' => 'https://notifications.yandexcloud.net/',
            'version' => 'latest',
            'region' => 'ru-central1',
            'credentials' => [
                'key' => '<static_key_ID>',
                'secret' => '<secret_key>',
            ],
        ]
    );

    ?>
    ```

    Where:
    * `/<path_to_folder>/vendor/autoload.php`: Path to the `autoload.php` file created when installing the AWS SDK.
    * `key`: Static key ID.
    * `secret`: Secret key.

## Create a notification channel {#create-channel}

```php
$response = $client->createPlatformApplication(
    [
        'Name' => '<channel_name>',
        'Platform' => 'GCM',
        'Attributes' => [
            'PlatformCredential' => '<FCM_API_key>',
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
* `Attributes`: Mobile platform authentication parameters in `key=value` format. The values depend on platform:
  * APNs:
    * Token-based authentication:
      * `PlatformPrincipal`: Path to the token signature key file from Apple.
      * `PlatformCredential`: Key ID.
      * `ApplePlatformTeamID`: Team ID.
      * `ApplePlatformBundleID`: Bundle ID.
    * Certificate-based authentication:
      * `PlatformPrincipal`: SSL certificate in `.pem` format.
      * `PlatformCredential`: Certificate private key in `.pem` format.
          
          {% include [convert-p12-to-pem](../../_includes/notifications/convert-p12-to-pem.md) %}

    Token-based authentication: The more modern and secure method.
  * FCM: `PlatformCredential` is the Google Cloud service account key in JSON format for authentication with the HTTP v1 API or API key (server key) for authentication with the legacy API.

    Use the HTTP v1 API because the [FCM legacy API is no longer supported](https://firebase.google.com/docs/cloud-messaging/migrate-v1) starting July 2024.
  * HMS:
    * `PlatformPrincipal`: Key ID
    * `PlatformCredential`: API key

As a result, you will get a notification channel ID (ARN).

## Get a list of notification channels {#list-channel}

```php
$response = $client->listPlatformApplications();

var_dump($response->get('PlatformApplications'));
```

You will get the list of notification channels located in the same folder as the service account.

## Create an endpoint {#create-endpoint}

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

## Send a notification {#publish}

### Mobile push notifications {#mobile-notifications}

{% list tabs %}

- Apple iOS (APNs)

  ```php
  $response = $client->publish(
    [
        'TargetArn' => '<endpoint_ID>',
        'Message' => json_encode([
            'default' => '<notification_text>',
            'APNS' => json_encode([
                'aps' => [
                    'alert' => '<notification_text>',
                ],
            ])
        ]),
        'MessageStructure' => 'json',
    ]
  );

  print($response->get('MessageId'));
  ```

- Google Android (FCM)

  **Explicit notifications (Bright Push)**
  ```php
  $response = $client->publish(
    [
        'TargetArn' => '<endpoint_ID>',
        'Message' => json_encode([
            'default' => '<notification_text>',
            'GCM' => json_encode([
                'notification' => [
                    'title' => '<notification_title>',
                    'body' => '<notification_text>',
                ],
            ])
        ]),
        'MessageStructure' => 'json',
    ]
  );

  print($response->get('MessageId'));
  ```

  **Silent notifications (Silent Push)**
  ```php
  $response = $client->publish(
    [
        'TargetArn' => '<endpoint_ID>',
        'Message' => json_encode([
            'default' => '<notification_text>',
            'GCM' => json_encode([
                'data' => ['<key>' => '<value>'],
            ])
        ]),
        'MessageStructure' => 'json',
    ]
  );

  print($response->get('MessageId'));
  ```

{% endlist %}

Where:
* `TargetArn`: Mobile endpoint ID (ARN)
* `MessageStructure`: Message format
* `Message`: Message

### Text message {#sms-messages}

  ```php
  $response = $client->publish(
    [
        'Message' => '<message>',
        'PhoneNumber' => '<phone_number>',
    ]
  );

  print($response->get('MessageId'));
  ```

## See also {#see-also}

* [Getting started](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Concepts](../concepts/index.md)
