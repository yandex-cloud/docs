# Как начать работать с AWS SDK для PHP в {{ cns-full-name }}

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

Чтобы начать работу с AWS SDK для PHP:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Получите статический ключ доступа](#static-key).
1. [Настройте AWS SDK](#aws-sdk).
1. [Создайте канал уведомлений](#create-channel).
1. [Получите список каналов](#list-channel).
1. [Создайте эндпоинт](#create-endpoint).
1. [Отправьте уведомление](#publish).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Получите статический ключ доступа {#static-key}

{% include [sa-role-static-key](../../_includes/notifications/sa-role-static-key.md) %}

## Настройте AWS SDK {#aws-sdk}

1. Ознакомьтесь с [системными требованиями](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/getting-started_requirements.html).
1. [Установите PHP](https://www.php.net/manual/en/install.php) версии 5.5 или выше.
 
    При работе с AWS SDK не отключайте расширение [SimpleXML PHP extension](https://www.php.net/manual/en/simplexml.installation.php).
1. [Установите Composer](https://getcomposer.org/download) для управления зависимостями PHP.
1. Добавьте библиотеку AWS SDK для PHP в ваш проект:
   * Если Composer установлен в системе глобально, то в корневом каталоге вашего проекта выполните команду:

        ```bash
        composer require aws/aws-sdk-php
        ```
    * Если Composer не установлен глобально, выполните команду:

        ```bash
        php composer.phar require aws/aws-sdk-php
        ```

    Другие способы установки см. в [документации AWS](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/getting-started_installation.html).

1. Создайте клиент:

    ```php
    <?php

    require '/<путь_до_каталога>/vendor/autoload.php';

    use Aws\Sns\SnsClient;

    $client = new SnsClient(
        [
            'endpoint' => 'https://{{ cns-host }}/',
            'version' => 'latest',
            'region' => '{{ region-id }}',
            'credentials' => [
                'key' => '<идентификатор_статического_ключа>',
                'secret' => '<секретный_ключ>',
            ],
        ]
    );

    ?>
    ```

    Где:
    * `/<путь_до_каталога>/vendor/autoload.php` — путь к файлу `autoload.php`, который создается при установке AWS SDK.
    * `key` — идентификатор статического ключа.
    * `secret` — секретный ключ.

## Создайте канал уведомлений {#create-channel}

{% include [push-channel-create-php](../../_includes/notifications/push-channel-create-php.md) %}


## Получите список каналов уведомлений {#list-channel}

```php
$response = $client->listPlatformApplications();

var_dump($response->get('PlatformApplications'));
```

В результате будет выведен список каналов уведомлений, размещенных в том же каталоге, в котором находится сервисный аккаунт.

## Создайте эндпоинт {#create-endpoint}

{% include [endpoint-create-php](../../_includes/notifications/endpoint-create-php.md) %}


## Отправьте уведомление {#publish}

### Мобильные Push-уведомления {#mobile-notifications}

{% list tabs %}

- Apple iOS (APNs)

  ```php
  $response = $client->publish(
    [
        'TargetArn' => '<идентификатор_эндпоинта>',
        'Message' => json_encode([
            'default' => '<текст_уведомления>',
            'APNS' => json_encode([
                'aps' => [
                    'alert' => '<текст_уведомления>',
                ],
            ])
        ]),
        'MessageStructure' => 'json',
    ]
  );

  print($response->get('MessageId'));
  ```

- Google Android (FCM)

  **Явные уведомления (Bright Push)**
  ```php
  $response = $client->publish(
    [
        'TargetArn' => '<идентификатор_эндпоинта>',
        'Message' => json_encode([
            'default' => '<текст_уведомления>',
            'GCM' => json_encode([
                'notification' => [
                    'title' => '<заголовок_уведомления>',
                    'body' => '<текст_уведомления>',
                ],
            ])
        ]),
        'MessageStructure' => 'json',
    ]
  );

  print($response->get('MessageId'));
  ```

  **Тихие уведомления (Silent Push)**
  ```php
  $response = $client->publish(
    [
        'TargetArn' => '<идентификатор_эндпоинта>',
        'Message' => json_encode([
            'default' => '<текст_уведомления>',
            'GCM' => json_encode([
                'data' => ['<ключ>' => '<значение>'],
            ])
        ]),
        'MessageStructure' => 'json',
    ]
  );

  print($response->get('MessageId'));
  ```

{% endlist %}

Где:
* `TargetArn` — идентификатор (ARN) мобильного эндпоинта.
* `MessageStructure` — формат сообщения.
* `Message` — сообщение.

### SMS-сообщения {#sms-messages}

  ```php
  $response = $client->publish(
    [
        'Message' => '<сообщение>',
        'PhoneNumber' => '<номер_телефона>',
    ]
  );

  print($response->get('MessageId'));
  ```

## См. также {#see-also}

* [Начало работы](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Концепции](../concepts/index.md)
