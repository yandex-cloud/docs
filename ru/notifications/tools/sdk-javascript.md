# Как начать работать с AWS SDK для JavaScript в {{ cns-full-name }}

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

Чтобы начать работу с AWS SDK для JavaScript:

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
        endpoint: "https://{{ cns-host }}/",
        region: "{{ region-id }}",
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
  
    {% include [channel-name](../../_includes/notifications/channel-name.md) %}
    
* `Platform` — тип мобильной платформы:

    {% include [platform-types](../../_includes/notifications/platform-types.md) %}

* `Attributes` — параметры аутентификации на мобильной платформе в формате `ключ=значение`. Значения зависят от типа платформы:

    {% include [auth-attributes](../../_includes/notifications/auth-attributes.md) %}


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


## См. также {#see-also}

* [Начало работы](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Концепции](../concepts/index.md)
* [Документация AWS](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/getting-started-nodejs.html)