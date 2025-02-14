# Как начать работать с AWS SDK для Python (boto3) в {{ cns-full-name }}

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

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

{% include [push-channel-create-python](../../_includes/notifications/push-channel-create-python.md) %}

## Получите список каналов уведомлений {#list-channel}

```python
response = client.list_platform_applications()
for app in response["PlatformApplications"]:
    print("Application ARN:", app["PlatformApplicationArn"])
```

В результате будет выведен список каналов уведомлений, размещенных в том же каталоге, в котором находится сервисный аккаунт.

## Создайте эндпоинт {#create-endpoint}

{% include [endpoint-create-python](../../_includes/notifications/endpoint-create-python.md) %}


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
