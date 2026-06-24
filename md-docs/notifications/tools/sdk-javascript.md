# Как начать работать с AWS SDK для JavaScript в Yandex Cloud Notification Service

{% note info %}

Сервис находится на [стадии Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы начать работу с AWS SDK для JavaScript:

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

Пререквизиты и инструкция по установке AWS SDK для JavaScript также [описаны в документации AWS](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/setting-up.html).

1. [Установите](https://nodejs.org/en/download) Node.js.
1. Инициализируйте проект в выбранной директории:

    ```bash
    npm init -y
    ```

1. Установите пакет с AWS SNS клиентом:

    ```bash
    npm i @aws-sdk/client-sns
    ```

1. Добавьте `"type": "module"` в файл `package.json`, чтобы использовать ESM синтаксис.
1. Создайте клиент в файле `index.js`:

    ```javascript
    import * as AWS from "@aws-sdk/client-sns";
    
    const snsClient = new AWS.SNSClient({
        endpoint: "https://notifications.yandexcloud.net/",
        region: "ru-central1",
        credentials: {
            accessKeyId: "<идентификатор_статического_ключа>",
            secretAccessKey: "<секретный_ключ>",
        },
    })
    ```

1. Команда для запуска программы

    ```bash
    node index.js
    ```


## Создайте канал уведомлений {#create-channel}

```javascript
const response = await client.send(
    new AWS.CreatePlatformApplicationCommand({
        Name: "<имя_канала>",
        Platform: "<тип_платформы>",
        Attributes: { <тип_аутентификации>: "<ключ>" },
    })
);
console.log(`PlatformApplication ARN: ${response.PlatformApplicationArn}`);
```

Где:

* `Name` — имя канала уведомлений, задается пользователем.
  
    Имя должно быть уникальным для всего CNS. После создания канала изменить имя нельзя. Имя может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name), для RuStore — значение `packageName`.
    
* `Platform` — тип мобильной платформы:

    * `APNS` и `APNS_SANDBOX` — Apple Push Notification service (APNs). Для тестирования приложения используйте `APNS_SANDBOX`.
    * `GCM` — Firebase Cloud Messaging (FCM).
    * `HMS` — Huawei Mobile Services (HMS).
    * `RUSTORE` — RuStore Android.

* `Attributes` — параметры аутентификации на мобильной платформе в формате `ключ=значение`. Значения зависят от типа платформы:

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


## Получите список каналов уведомлений {#list-channel}

```javascript
const response = await client.send(new AWS.ListPlatformApplicationsCommand({}));
console.log(
    response.PlatformApplications.map(
        (t) => `Application ARN: ${t.PlatformApplicationArn}`
    ).join("\n")
);
```

В результате будет выведен список каналов уведомлений, размещенных в том же каталоге, в котором находится сервисный аккаунт.


## Создайте эндпоинт {#create-endpoint}

```javascript
const response = await client.send(
    new AWS.CreatePlatformEndpointCommand({
        PlatformApplicationArn: "<ARN_канала_уведомлений>",
        Token: "<Push-токен>",
    })
);
console.log(`Endpoint ARN: ${response.EndpointArn}`);
```

Где:

* `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.
* `Token` — уникальный Push-токен приложения на устройстве пользователя.


## Отправьте уведомление {#publish}

### Явные уведомления (Bright Push) {#bright-push}

{% list tabs %}

- Apple iOS (APNs)

  ```javascript
  const message = {
      default: "<текст_уведомления>",
      APNS: JSON.stringify({
          aps: {
              alert: "<текст_уведомления>",
          },
      }),
  };

  const response = await client.send(
      new AWS.PublishCommand({
          Message: JSON.stringify(message),
          TargetArn: "<ARN_эндпоинта>",
          MessageStructure: "json",
      })
  );
  console.log(`Message id: ${response.MessageId}`);
  ```

- Google Android (GCM)

  ```javascript
  const message = {
      default: "<текст_уведомления>",
      GCM: JSON.stringify({
          notification: {
              body: "<текст_уведомления>",
          },
      }),
  };
  const response = await client.send(
      new AWS.PublishCommand({
          Message: JSON.stringify(message),
          TargetArn: "<ARN_эндпоинта>",
          MessageStructure: "json",
      })
  );
  console.log(`Message id: ${response.MessageId}`);
  ```

{% endlist %}

Где:

* `message` — сообщение.
* `TargetArn` — идентификатор (ARN) мобильного эндпоинта.
* `MessageStructure` — формат сообщения.


### Тихие уведомления (Silent Push) {#silent-push}

{% list tabs %}

- Apple iOS (APNs)

  ```javascript
  const message = {
      default: "<текст_уведомления>",
      APNS: JSON.stringify({
          key: "value",
      }),
  };
  const response = await client.send(
      new AWS.PublishCommand({
          Message: JSON.stringify(message),
          TargetArn: "<ARN_эндпоинта>",
          MessageStructure: "json",
      })
  );
  console.log(`Message id: ${response.MessageId}`);
  ```

- Google Android (GCM)

  ```javascript
  const message = {
      default: "<текст_уведомления>",
      GCM: JSON.stringify({
          data: {
              key: "value",
          },
      }),
  };

  const response = await client.send(
      new AWS.PublishCommand({
          Message: JSON.stringify(message),
          TargetArn: "<ARN_эндпоинта>",
          MessageStructure: "json",
      })
  );
  console.log(`Message id: ${response.MessageId}`);
  ```

{% endlist %}

Где:

* `message` — сообщение.
* `TargetArn` — идентификатор (ARN) мобильного эндпоинта.
* `MessageStructure` — формат сообщения.


### SMS-сообщения {#sms-messages}

```javascript
const response = await client.send(
    new AWS.PublishCommand({
        PhoneNumber: "<номер_телефона>",
        Message: "<текст_уведомления>",
        MessageAttributes: {
            "AWS.SNS.SMS.SenderID": {
                DataType: "String",
                StringValue: "<текстовое_имя_отправителя>"
            }
        }
    })
);
console.log(`Message id: ${response.MessageId}`);
```

Где:

* `PhoneNumber` — номер телефона получателя.
* `Message` — текст уведомления.
* `StringValue` — текстовое имя отправителя.


#### Полезные ссылки {#see-also}

* [Начало работы](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Концепции](../concepts/index.md)
* [Документация AWS](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/getting-started-nodejs.html)