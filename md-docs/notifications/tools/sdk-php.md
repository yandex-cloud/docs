[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Notification Service](../index.md) > [Инструменты](index.md) > AWS SDK для PHP

# Как начать работать с AWS SDK для PHP в Yandex Cloud Notification Service


Чтобы начать работу с AWS SDK для PHP:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Получите статический ключ доступа](#static-key).
1. [Настройте AWS SDK](#aws-sdk).
1. [Создайте канал уведомлений](#create-channel).
1. [Получите список каналов](#list-channel).
1. [Создайте эндпоинт](#create-endpoint).
1. [Отправьте уведомление](#publish).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

## Получите статический ключ доступа {#static-key}

Для аутентификации в Cloud Notification Service используется [статический ключ доступа](../../iam/concepts/authorization/access-key.md). Этот ключ выпускается на [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), и все действия выполняются от имени этого сервисного аккаунта.

Чтобы получить статический ключ доступа:
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../iam/roles-reference.md#editor) `editor` на каталог.
1. Для сервисного аккаунта [создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа.

    Сохраните идентификатор и секретный ключ.

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

    Другие способы установки описаны в [документации AWS](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/getting-started_installation.html).

1. Создайте клиент:

    ```php
    <?php

    require '/<путь_до_каталога>/vendor/autoload.php';

    use Aws\Sns\SnsClient;

    $client = new SnsClient(
        [
            'endpoint' => 'https://notifications.yandexcloud.net/',
            'version' => 'latest',
            'region' => 'ru-central1',
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

```php
$response = $client->createPlatformApplication(
    [
        'Name' => '<имя_канала>',
        'Platform' => '<тип_платформы>',
        'Attributes' => [
            '<параметр1>' => '<значение1>',
            ...
            '<параметрN>' => '<значениеN>'
        ],
    ]
);

print($response->get('PlatformApplicationArn'));
```

Где:

* `Name` — имя канала уведомлений, задается пользователем.
  
  Имя должно быть уникальным для всего CNS. После создания канала изменить имя нельзя. Имя может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name), для RuStore — значение `packageName`.

* `Platform` — тип мобильной платформы:

  * `APNS` и `APNS_SANDBOX` — Apple Push Notification service (APNs). Для тестирования приложения используйте `APNS_SANDBOX`.
  * `GCM` — Firebase Cloud Messaging (FCM).
  * `HMS` — Huawei Mobile Services (HMS).
  * `RUSTORE` — RuStore Android.

* `Attributes` — параметры аутентификации на мобильной платформе в формате `'<параметр1>' => '<значение1>'` через запятую. Значения зависят от типа платформы:

  * APNs:

    * Аутентификация с токеном:

      * `PlatformPrincipal` — путь к файлу с ключом подписи токена, полученный в Apple.
      * `PlatformCredential` — идентификатор ключа подписи (Key ID).
      * `ApplePlatformTeamID` — идентификатор разработчика (Team ID).
      * `ApplePlatformBundleID` — идентификатор приложения (Bundle ID).

    * Аутентификация с сертификатом:

      * `PlatformPrincipal` — SSL-сертификат в формате `.pem`.
      * `PlatformCredential` — закрытый ключ сертификата в формате `.pem`.

          Чтобы сохранить сертификат и закрытый ключ в отдельных файлах формата `.pem`, вы можете воспользоваться утилитой [openssl](https://docs.openssl.org/1.1.1/man1/pkcs12) в Linux:
          
          ```bash
          openssl pkcs12 -in Certificates.p12 -nokeys -nodes -out certificate.pem
          openssl pkcs12 -in Certificates.p12 -nocerts -nodes -out privatekey.pem
          ```

    Аутентификация с токеном — более современный и безопасный метод.

  * FCM: `PlatformCredential` — ключ сервисного аккаунта Google Cloud в формате JSON для аутентификации с помощью HTTP v1 API или API-ключ (server key) для аутентификации с помощью Legacy API.

    Используйте HTTP v1 API, так как с июля 2024 года [FCM legacy API не поддерживается](https://firebase.google.com/docs/cloud-messaging/migrate-v1).

  * HMS:

    * `PlatformPrincipal` — идентификатор ключа.
    * `PlatformCredential` — API-ключ.
  
  * RuStore:
  
    * `PlatformPrincipal` — идентификатор проекта (ProjectID).
    * `PlatformCredential` — сервисный токен (ServiceToken).

В результате вы получите идентификатор (ARN) канала уведомлений.


## Получите список каналов уведомлений {#list-channel}

```php
$response = $client->listPlatformApplications();

var_dump($response->get('PlatformApplications'));
```

В результате будет выведен список каналов уведомлений, размещенных в том же каталоге, в котором находится сервисный аккаунт.

## Создайте эндпоинт {#create-endpoint}

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

#### Полезные ссылки {#see-also}

* [Начало работы](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Концепции](../concepts/index.md)