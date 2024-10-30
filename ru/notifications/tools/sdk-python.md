# Как начать работать с AWS SDK для Python (boto3) в {{ cns-full-name }}

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

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Получите статический ключ доступа {#static-key}

{% include [sa-role-static-key](../../_includes/notifications/sa-role-static-key.md) %}

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
        endpoint_url="https://{{ cns-host }}/",
        region_name="{{ region-id }}",
        aws_access_key_id="<идентификатор_статического_ключа>",
        aws_secret_access_key="<секретный_ключ>",
        verify=False # Disable SSL verification for {{ cns-host }}
    )
    ```

    Где:
    * `aws_access_key_id` — идентификатор статического ключа.
    * `aws_secret_access_key` — секретный ключ.

## Создайте канал уведомлений {#create-channel}

```python
response = client.create_platform_application(
    Name="<имя_канала>",
    Platform="GCM",
    Attributes= {
         "PlatformCredential": "<API-ключ_FCM>"
    }
)
print ("Platform application ARN:", response['PlatformApplicationArn'])
```

Где:
* `Name` — имя канала уведомлений, задается пользователем. Должно быть уникальным в [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud). Может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Допустимая длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name).
* `Platform` — тип мобильной платформы:
  * `APNS` и `APNS_SANDBOX` — Apple Push Notification service (APNs). Для тестирования приложения используйте `APNS_SANDBOX`.
  * `GCM` — Firebase Cloud Messaging (FCM).
  * `HMS` — Huawei Mobile Services (HMS).
* `Attributes` — параметры аутентификации на мобильной платформе в формате `ключ=значение`. Значения зависят от типа платформы:
  * APNs:
    * Аутентификация с токеном:
      * `PlatformPrincipal` — токен в формате `.p8`.
      * `PlatformCredential` — идентификатор токена.
      * `ApplePlatformTeamID` — идентификатор разработчика.
      * `ApplePlatformBundleID` — идентификатор приложения (Bundle ID).
    * Аутентификация с сертификатом:
      * `PlatformPrincipal` — SSL-сертификат в формате `.p12`.
      * `PlatformCredential` — закрытый ключ сертификата.

    Аутентификация с токеном является предпочтительной, как более современная.
  * FCM: `PlatformCredential` — ключ сервисного аккаунта Google Cloud в формате JSON для аутентификации с помощью HTTP v1 API или API-ключ (server key) для аутентификации с помощью Legacy API.

    Версия HTTP v1 API является предпочтительной, так как с июня 2024 года Legacy API [не будет поддерживаться FCM](https://firebase.google.com/docs/cloud-messaging/migrate-v1).
  * HMS:
    * `PlatformPrincipal` — идентификатор ключа.
    * `PlatformCredential` — API-ключ.

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

## См. также {#see-also}

* [Начало работы](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Концепции](../concepts/index.md)
