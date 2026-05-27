# Как начать работать с Yandex Cloud Notification Service с помощью AWS CLI

{% note info %}

Сервис находится на [стадии Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы начать работу с AWS CLI:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Получите статический ключ доступа](#static-key).
1. [Настройте AWS CLI](#aws-cli).
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

## Настройте AWS CLI {#aws-cli}

[AWS CLI](https://aws.amazon.com/ru/cli/) — это интерфейс командной строки для работы с сервисами AWS. HTTP API Cloud Notification Service совместим с [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html). Общий [порядок вызова команд](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html) смотрите в официальной документации Amazon.

Чтобы настроить AWS CLI:
1. [Установите](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) AWS CLI.
1. Введите команду для настройки AWS CLI:

   ```bash
   aws configure
   ```

1. Введите значения для параметров:
    * `AWS Access Key ID` — идентификатор статического ключа.
    * `AWS Secret Access Key` — секретный ключ.
    * `Default region name` — регион `ru-central1`.

      {% note info %}

      Для работы с Cloud Notification Service всегда указывайте регион — `ru-central1`. Другие значения региона могут привести к ошибке авторизации.

      {% endnote %}

1. Значения остальных параметров оставьте без изменений.
1. Задайте эндпоинт Cloud Notification Service:

    ```bash
    aws configure set endpoint_url https://notifications.yandexcloud.net/
    ```
   Значение эндпоинта в настройках можно проверить командой:

    ```bash
    aws configure get endpoint_url
    ```
   
   Команды `configure set` и `configure get` работают с настройками в конфигурационном файле `~/.aws/config`. Также можно задать параметры в [переменных окружения](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-endpoints.html#endpoints-global).

    {% note warning %}

     Поскольку эндпоинт можно задать разными способами, каждый из способов имеет свой [приоритет](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html#envvars-list-AWS_ENDPOINT_URL). Переменная окружения имеет больший приоритет, чем значение в файле конфигурации.
     
     Чтобы исключить конфликты параметров, проверьте переменную окружения с помощью команды `echo $AWS_ENDPOINT_URL` и параметр в конфигурации — `aws configure get endpoint_url`.

     Также проверьте отсутствие конфликтов в конфигурации (файл `~/.aws/credentials`) с переменными окружения `AWS_DEFAULT_REGION`, `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`.
     
     {% endnote %}

{% cut "Пример конфигурационных файлов" %}

* `~/.aws/config`:

  ```text
  [default]
  region = ru-central1
  endpoint_url = https://notifications.yandexcloud.net/
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
  --platform <тип_платформы> \
  --attributes <параметр1>=<значение1>, ... <параметрN>=<значениеN>
```

Где:

* `--name` — имя канала уведомлений, задается пользователем.
  
  Имя должно быть уникальным для всего CNS. После создания канала изменить имя нельзя. Имя может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name), для RuStore — значение `packageName`.

* `--platform` — тип мобильной платформы:

  * `APNS` и `APNS_SANDBOX` — Apple Push Notification service (APNs). Для тестирования приложения используйте `APNS_SANDBOX`.
  * `GCM` — Firebase Cloud Messaging (FCM).
  * `HMS` — Huawei Mobile Services (HMS).
  * `RUSTORE` — RuStore Android.

* `--attributes` — параметры аутентификации на мобильной платформе в формате `<параметр>=<значение>` через запятую. Значения зависят от типа платформы:

  * APNs:

    * Аутентификация с токеном:

      * `PlatformPrincipal` — путь к файлу с ключом подписи, полученный в Apple.
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

    Рекомендуется экранировать содержимое файла с помощью команды `jq @json <<< cat private_key.json`, так как AWS CLI принимает данный параметр в строковом формате.

    Версия HTTP v1 API является предпочтительной, так как с июня 2024 года Legacy API [не будет поддерживаться FCM](https://firebase.google.com/docs/cloud-messaging/migrate-v1).

  * HMS:

    * `PlatformPrincipal` — идентификатор ключа.
    * `PlatformCredential` — API-ключ.

  * RuStore:
  
    * `PlatformPrincipal` — идентификатор проекта (ProjectID).
    * `PlatformCredential` — сервисный токен (ServiceToken).

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

## Примеры {#examples}

### Отправка SMS {#sms-sending}

```bash
aws sns publish \
  --phone-number "<номер_получателя>" \
  --message "<текст_уведомления>" \
  --message-attributes '{"AWS.SNS.SMS.SenderID": {"DataType": "String", "StringValue": "<текстовое_имя_отправителя>"} }'
```

Где:
* `--phone-number` — российский телефонный номер в формате [E.164](https://ru.wikipedia.org/wiki/E.164).
* `--message` — текст SMS.
* `--message-attributes` — атрибуты SMS, где `AWS.SNS.SMS.SenderID.StringValue` — текстовое имя отправителя.

## См. также {#see-also}

* [Начало работы](../quickstart.md)
* [AWS SDK для Python (boto3)](sdk-python.md)
* [Концепции](../concepts/index.md)