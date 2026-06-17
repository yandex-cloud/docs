# Как начать работать с AWS SDK для Python (boto3) в Yandex Cloud Notification Service

{% note info %}

Сервис находится на [стадии Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

[boto3](https://github.com/boto/boto3) — это комплект средств разработки (SDK) для языка программирования Python 3.x. SDK предназначен для работы с сервисами, совместимыми с [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html).

Чтобы начать работу с AWS SDK для Python (boto3):
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

1. [Установите Python](https://wiki.python.org/moin/BeginnersGuide/Download).
1. Установите AWS SDK для Python (boto3) с помощью команды:

    ```bash
    pip install boto3
    ```

1. Создайте клиент:

    ```python
    import boto3

    client = boto3.client(
        "sns",
        endpoint_url="https://notifications.yandexcloud.net/",
        region_name="ru-central1",
        aws_access_key_id="<идентификатор_статического_ключа>",
        aws_secret_access_key="<секретный_ключ>",
        verify=False # Disable SSL verification for notifications.yandexcloud.net
    )
    ```

    Где:
    * `aws_access_key_id` — идентификатор статического ключа.
    * `aws_secret_access_key` — секретный ключ.

## Создайте канал уведомлений {#create-channel}

```python
response = client.create_platform_application(
    Name="<имя_канала>",
    Platform="<тип_платформы>",
    Attributes= {
         "<параметр1>": "<значение1>",
         ...
         "<параметрN>": "<значениеN>"
    }
)
print ("Platform application ARN:", response['PlatformApplicationArn'])
```

Где:

* `Name` — имя канала уведомлений, задается пользователем.
  
  Имя должно быть уникальным для всего CNS. После создания канала изменить имя нельзя. Имя может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name), для RuStore — значение `packageName`.

* `Platform` — тип мобильной платформы:

  * `APNS` и `APNS_SANDBOX` — Apple Push Notification service (APNs). Для тестирования приложения используйте `APNS_SANDBOX`.
  * `GCM` — Firebase Cloud Messaging (FCM).
  * `HMS` — Huawei Mobile Services (HMS).
  * `RUSTORE` — RuStore Android.

* `Attributes` — параметры аутентификации на мобильной платформе в формате `"<параметр>": "<значение>"` через запятую. Значения зависят от типа платформы:

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

    Аутентификация с токеном является предпочтительной, как более современная.

  * FCM: `PlatformCredential` — ключ сервисного аккаунта Google Cloud в формате JSON для аутентификации с помощью HTTP v1 API или API-ключ (server key) для аутентификации с помощью Legacy API.

    Версия HTTP v1 API является предпочтительной, так как с июня 2024 года Legacy API [не будет поддерживаться FCM](https://firebase.google.com/docs/cloud-messaging/migrate-v1).

  * HMS:

    * `PlatformPrincipal` — идентификатор ключа.
    * `PlatformCredential` — API-ключ.

  * RuStore:
  
    * `PlatformPrincipal` — идентификатор проекта (ProjectID).
    * `PlatformCredential` — сервисный токен (ServiceToken).

В результате вы получите идентификатор (ARN) канала уведомлений.

## Получите список каналов уведомлений {#list-channel}

```python
response = client.list_platform_applications()
for app in response["PlatformApplications"]:
    print("Application ARN:", app["PlatformApplicationArn"])
```

В результате будет выведен список каналов уведомлений, размещенных в том же каталоге, в котором находится сервисный аккаунт.

## Создайте эндпоинт {#create-endpoint}

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


## Отправьте уведомление {#publish}

### Явные уведомления (Bright Push) {#bright-push}

{% list tabs %}

- Apple iOS (APNs)

  ```python
  response = client.publish(
      TargetArn="<идентификатор_эндпоинта>",
      Message=json.dumps({
          "default": "<текст_уведомления>",
          "APNS": json.dumps({
              "aps": {
                  "alert": "<текст_уведомления>"
              }
          })
      }),
      MessageStructure="json"
  )
  print ("Message id:", response["MessageId"])
  ```

- Google Android (FCM)

  ```python
  response = client.publish(
      TargetArn="<идентификатор_эндпоинта>",
      Message=json.dumps({
          "default": "<текст_уведомления>",
          "GCM": json.dumps({
              "notification": {
                  "body": "<текст_уведомления>"
              }
          })
      }),
      MessageStructure="json"
  )
  print ("Message id:", response["MessageId"])
  ```

- RuStore Android

  ```python
  response = client.publish(
      TargetArn="<идентификатор_эндпоинта>",
      Message=json.dumps({
          "default": "<текст_уведомления_по_умолчанию>",
          "RUSTORE": json.dumps({
              "notification": {
                  "title": "<заголовок уведомления>",
                  "body": "<текст_уведомления>",
              }
          })
      }),
      MessageStructure="json"
  )
  message_id = response["MessageId"]
  print(f"Message id is: {message_id}")
  ```

{% endlist %}

Где:
* `TargetArn` — идентификатор (ARN) мобильного эндпоинта.
* `MessageStructure` — формат сообщения.
* `Message` — сообщение.

### Тихие уведомления (Silent Push) {#silent-push}

```python
response = client.publish(
    TargetArn="<endpoint ARN>",
    Message='{"data": { "key": "value" } }')
print ("Message id:", response["MessageId"])
```

Где:
* `TargetArn` — идентификатор (ARN) мобильного эндпоинта.
* `Message` — сообщение.

## Примеры {#examples}

### Отправка SMS {#sms-sending}

```python
client.publish(PhoneNumber="<номер_получателя>",
    Message="<текст_уведомления>",
    MessageAttributes={
        "AWS.SNS.SMS.SenderID": {
            "DataType": "String",
            "StringValue":"<текстовое_имя_отправителя>"
        }
    }
)
```

Где:
* `PhoneNumber` — российский телефонный номер в формате [E.164](https://ru.wikipedia.org/wiki/E.164).
* `Message` — текст SMS.
* `MessageAttributes` — атрибуты SMS, где `AWS.SNS.SMS.SenderID.StringValue` — текстовое имя отправителя.

## Полезные ссылки {#see-also}

* [Начало работы](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Концепции](../concepts/index.md)