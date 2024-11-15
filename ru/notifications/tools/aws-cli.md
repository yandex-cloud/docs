# Как начать работать с {{ cns-full-name }} с помощью AWS CLI

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

{% include [ask-for-turning-on](../../_includes/notifications/ask-for-turning-on.md) %}

{% include [about-service](../../_includes/notifications/about-service.md) %}

{% include [channels-push-preview](../../_includes/notifications/channels-push-preview.md) %}

С помощью {{ cns-name }} вы можете отправлять уведомления в приложения, зарегистрированные в следующих сервисах:
* [Apple Push Notification service](https://developer.apple.com/notifications/) (APNs).
* [Firebase Cloud Messaging](https://firebase.google.com/) (FCM).
* [Huawei Mobile Services](https://developer.huawei.com/consumer/) (HMS).

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

```bash
aws sns create-platform-application \
  --name <имя_канала> \
  --platform GCM \
  --attributes PlatformCredential=<API-ключ_FCM>
```

Где:
* `--name` — имя канала уведомлений, задается пользователем. Должно быть уникальным в [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud). Может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Допустимая длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name).
* `--platform` — тип мобильной платформы:
  * `APNS` и `APNS_SANDBOX` — Apple Push Notification service (APNs). Для тестирования приложения используйте `APNS_SANDBOX`.
  * `GCM` — Firebase Cloud Messaging (FCM).
  * `HMS` — Huawei Mobile Services (HMS).
* `--attributes` — параметры аутентификации на мобильной платформе в формате `ключ=значение`. Значения зависят от типа платформы:
  * APNs:
    * Аутентификация с токеном:
      * `PlatformPrincipal` — путь к файлу с ключом подписи, полученный в Apple.
      * `PlatformCredential` — идентификатор ключа подписи (Key ID).
      * `ApplePlatformTeamID` — идентификатор разработчика (TeamID).
      * `ApplePlatformBundleID` — идентификатор приложения (Bundle ID).
    * Аутентификация с сертификатом:
      * `PlatformPrincipal` — SSL-сертификат в формате `.pem`.
      * `PlatformCredential` — закрытый ключ сертификата в формате `.pem`.

        {% include [convert-p12-to-pem](../../_includes/notifications/convert-p12-to-pem.md) %}

    Аутентификация с токеном является предпочтительной, как более современная.
  * FCM: `PlatformCredential` — ключ сервисного аккаунта Google Cloud в формате JSON для аутентификации с помощью HTTP v1 API или API-ключ (server key) для аутентификации с помощью Legacy API.

    Рекомендуется экранировать содержимое файла с помощью команды `jq @json <<< cat private_key.json`, так как AWS CLI принимает данный параметр в строковом формате.

    Версия HTTP v1 API является предпочтительной, так как с июня 2024 года Legacy API [не будет поддерживаться FCM](https://firebase.google.com/docs/cloud-messaging/migrate-v1).
  * HMS:
    * `PlatformPrincipal` — идентификатор ключа.
    * `PlatformCredential` — API-ключ.

В результате вы получите идентификатор (ARN) канала уведомлений. Сохраните его для использования в дальнейшем.

Подробнее о команде `aws sns create-platform-application` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/create-platform-application.html).

## Получите список каналов уведомлений {#list-channel}

```bash
aws sns list-platform-applications
```

В результате будет выведен список каналов уведомлений, размещенных в том же каталоге, в котором находится сервисный аккаунт.

Подробнее о команде `aws sns list-platform-applications` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/list-platform-applications.html).

## Создайте эндпоинт {#create-endpoint}

Чтобы создать [мобильный эндпоинт](../concepts/index.md#mobile-endpoints), выполните команду:

```bash
aws sns create-platform-endpoint \
  --platform-application-arn <ARN_канала_уведомлений> \
  --token <Push-токен>
```

Где:
* `--platform-application-arn` — идентификатор (ARN) канала уведомлений.
* `--token` — уникальный Push-токен приложения на устройстве пользователя.

В результате вы получите идентификатор (ARN) мобильного эндпоинта. Сохраните его для дальнейшего использования.

Подробнее о команде `aws sns create-platform-endpoint` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/create-platform-endpoint.html).

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
