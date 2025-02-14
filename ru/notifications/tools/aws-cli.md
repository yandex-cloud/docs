---
title: Как начать работать с {{ cns-full-name }} с помощью AWS CLI
description: HTTP API {{ cns-name }} совместим с Amazon SNS API.
---

# Как начать работать с {{ cns-full-name }} с помощью AWS CLI

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

Чтобы начать работу с AWS CLI:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Получите статический ключ доступа](#static-key).
1. [Настройте AWS CLI](#aws-cli).
1. [Создайте канал уведомлений](#create-channel).
1. [Получите список каналов](#list-channel).
1. [Создайте эндпоинт](#create-endpoint).
1. [Отправьте уведомление](#publish).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Получите статический ключ доступа {#static-key}

{% include [sa-role-static-key](../../_includes/notifications/sa-role-static-key.md) %}

## Настройте AWS CLI {#aws-cli}

[AWS CLI](https://aws.amazon.com/ru/cli/) — это интерфейс командной строки для работы с сервисами AWS. HTTP API {{ cns-name }} совместим с [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html). Общий [порядок вызова команд](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html) смотрите в официальной документации Amazon.

Чтобы настроить AWS CLI:
1. [Установите](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) AWS CLI.
1. Введите команду для настройки AWS CLI:

   ```bash
   aws configure
   ```

1. Введите значения для параметров:
    * `AWS Access Key ID` — идентификатор статического ключа.
    * `AWS Secret Access Key` — секретный ключ.
    * `Default region name` — регион `{{ region-id }}`.

      {% note info %}

      Для работы с {{ cns-name }} всегда указывайте регион — `{{ region-id }}`. Другие значения региона могут привести к ошибке авторизации.

      {% endnote %}

1. Значения остальных параметров оставьте без изменений.
1. Задайте эндпоинт {{ cns-name }}:

    ```bash
    aws configure set endpoint_url https://{{ cns-host }}/
    ```

{% cut "Пример конфигурационных файлов" %}

* `~/.aws/config`:

  ```text
  [default]
  region = {{ region-id }}
  endpoint_url = https://{{ cns-host }}/
  ```

* `~/.aws/credentials`:

  ```text
  [default]
  aws_access_key_id = <идентификатор_статического_ключа>
  aws_secret_access_key = <секретный_ключ>
  ```

{% endcut %}

Подробнее о настройке AWS CLI см. в [документации AWS](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).

## Создайте канал уведомлений {#create-channel}

Чтобы создать [канал уведомлений](../concepts/index.md#channels), выполните команду:

{% include [push-channel-create-aws](../../_includes/notifications/push-channel-create-aws.md) %}


## Получите список каналов уведомлений {#list-channel}

```bash
aws sns list-platform-applications
```

В результате будет выведен список каналов уведомлений, размещенных в том же каталоге, в котором находится сервисный аккаунт.

Подробнее о команде `aws sns list-platform-applications` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/list-platform-applications.html).

## Создайте эндпоинт {#create-endpoint}

Чтобы создать [мобильный эндпоинт](../concepts/index.md#mobile-endpoints), выполните команду:

{% include [endpoint-create-aws](../../_includes/notifications/endpoint-create-aws.md) %}


## Отправьте уведомление {#publish}

### Явные уведомления (Bright Push) {#bright-push}

{% list tabs %}

- Apple iOS (APNs)

  ```bash
  aws sns publish \
    --target-arn "<ARN_эндпоинта>" \
    --message-structure json \
    --message '{"default": "<текст_уведомления>", "APNS": "{ \"aps\": { \"alert\": \"<текст_уведомления>\"} }" }'
  ```

- Google Android (FCM)

  ```bash
  aws sns publish \
    --target-arn "<ARN_эндпоинта>" \
    --message-structure json \
    --message '{"default": "<текст_уведомления>", "GCM": "{ \"notification\": { \"body\": \"<текст_уведомления>\"} }" }'
  ```

{% endlist %}

Где:
* `--target-arn` — идентификатор (ARN) мобильного эндпоинта.
* `--message-structure` — формат сообщения.
* `--message` — сообщение.

### Тихие уведомления (Silent Push) {#silent-push}

```bash
aws sns publish \
  --target-arn <ARN_эндпоинта> \
  --message-structure json \
  --message '{"data": { "key": "value" } }'
```

Где:
* `--target-arn` — идентификатор (ARN) мобильного эндпоинта.
* `--message-structure` — формат сообщения.
* `--message` — сообщение.

Подробнее о команде `aws sns publish` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/publish.html).

## См. также {#see-also}

* [Начало работы](../quickstart.md)
* [AWS SDK для Python (boto3)](sdk-python.md)
* [Концепции](../concepts/index.md)
