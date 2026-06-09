# Отправить запрос HTTP API к {{ cns-full-name }}

HTTP API сервиса совместим с [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html).

Все поддерживаемые действия описаны в [Справочнике API](index.md).

Чтобы начать работу с HTTP API с помощью curl:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Получите данные для аутентификации](#get-key).
1. [Создайте канал уведомлений](#create-channel).
1. [Получите список каналов](#list-channel).
1. [Создайте эндпоинт](#create-endpoint).
1. [Отправьте уведомление](#publish).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

## Получите данные для аутентификации {#get-key}

Для аутентификации в API используются [статический ключ доступа](../../iam/concepts/authorization/access-key.md) или [IAM-токен](../../iam/concepts/authorization/iam-token.md).

{% note info %}

Запросы API к {{ cns-name }} со статическим ключом должны быть подписаны по алгоритму [AWS Signature V4](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html). Чтобы не подписывать запросы, используйте IAM-токен.

{% endnote %}

Как получить IAM-токен, см. в инструкциях:
* [{#T}](../../iam/operations/iam-token/create.md)
* [{#T}](../../iam/operations/iam-token/create-for-federation.md)
* [{#T}](../../iam/operations/iam-token/create-for-sa.md)

{% cut "Как получить статический ключ доступа" %}

Для аутентификации в {{ cns-name }} используется [статический ключ доступа](../../iam/concepts/authorization/access-key.md). Этот ключ выпускается на [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), и все действия выполняются от имени этого сервисного аккаунта.

Чтобы получить статический ключ доступа:
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../iam/roles-reference.md#editor) `{{ roles-editor }}` на каталог.
1. Для сервисного аккаунта [создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа.

    Сохраните идентификатор и секретный ключ.

{% endcut %}

Чтобы выполнять запросы API, у пользователя или сервисного аккаунта должна быть минимальная [роль](../../iam/roles-reference.md#editor) `editor` на каталог.

## Создайте канал уведомлений {#create-channel}

```bash
export IAM_TOKEN=<IAM-токен>
curl \
  --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "Action=CreatePlatformApplication" \
  --data-urlencode "ResponseFormat=JSON" \
  --data-urlencode "FolderId=<идентификатор_каталога>" \
  --data-urlencode "Name=<имя_канала>" \
  --data-urlencode "Platform=GCM" \
  --data-urlencode "Attributes.entry.1.key=PlatformCredential" \
  --data-urlencode "Attributes.entry.1.value=<API-ключ_FCM>"
  "https://{{ cns-host }}/"
```

Где:
* `IAM_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
* `Action` — [тип операции](index.md#actions).
* `ResponseFormat` — формат ответа: JSON или XML.
* `FolderId` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
* `Name` — имя канала уведомлений, задается пользователем.

  Имя должно быть уникальным для всего {{ cns-short-name }}. После создания канала изменить имя нельзя. Имя может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name), для RuStore — значение `packageName`.

* `Platform` — тип мобильной платформы:
  
  * `APNS` и `APNS_SANDBOX` — Apple Push Notification service (APNs). Для тестирования приложения используйте `APNS_SANDBOX`.
  * `GCM` — Firebase Cloud Messaging (FCM).
  * `HMS` — Huawei Mobile Services (HMS).
  * `RUSTORE` — RuStore Android.

* `Attributes.entry.N.key` — ключи атрибутов аутентификации на мобильной платформе. Значения зависят от типа платформы:
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
  * RuStore:
    * `PlatformPrincipal` — идентификатор проекта (ProjectID).
    * `PlatformCredential` — сервисный токен (ServiceToken).
* `Attributes.entry.N.value` — значения атрибутов аутентификации на мобильной платформе.

В результате вы получите идентификатор (ARN) канала уведомлений.

Подробнее см. на странице [{#T}](create-platform-application.md).

## Получите список каналов {#list-channel}

```bash
export IAM_TOKEN=<IAM-токен>
curl \
  --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "Action=ListPlatformApplications" \
  --data-urlencode "ResponseFormat=JSON" \
  --data-urlencode "FolderId=<идентификатор_каталога>" \
  "https://{{ cns-host }}/"
```

Где:
* `IAM_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
* `Action` — [тип операции](index.md#actions).
* `ResponseFormat` — формат ответа: JSON или XML.
* `FolderId` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).

Подробнее см. на странице [{#T}](list-platform-applications.md).

## Создайте эндпоинт {#create-endpoint}

```bash
export IAM_TOKEN=<IAM-токен>
curl \
  --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "Action=CreatePlatformEndpoint" \
  --data-urlencode "ResponseFormat=JSON" \
  --data-urlencode "PlatformApplicationArn=<ARN_канала_уведомлений>" \
  --data-urlencode "Token=<Push-токен>" \
  "https://{{ cns-host }}/"
```

Где:
* `IAM_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
* `Action` — [тип операции](index.md#actions).
* `ResponseFormat` — формат ответа: JSON или XML.
* `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.
* `Token` — уникальный Push-токен приложения на устройстве пользователя.

В результате вы получите идентификатор (ARN) мобильного эндпоинта.

Подробнее см. на странице [{#T}](create-platform-endpoint.md).

## Отправьте уведомление {#publish}

### Явные уведомления (Bright Push) {#bright-push}

```bash
export IAM_TOKEN=<IAM-токен>
curl \
  --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "Action=Publish" \
  --data-urlencode "ResponseFormat=JSON" \
  --data-urlencode "TargetArn=<идентификатор_эндпоинта>" \
  --data-urlencode "Message={"default": "<текст_уведомления>", "GCM": "{ \"notification\": { \"body\": \"<текст_уведомления>\"} }" }" \
  --data-urlencode "MessageStructure=json" \
  "https://{{ cns-host }}/"
```

Где:
* `IAM_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
* `Action` — [тип операции](index.md#actions).
* `ResponseFormat` — формат ответа: JSON или XML.
* `TargetArn` — идентификатор (ARN) мобильного эндпоинта.
* `Message` — сообщение.
* `MessageStructure` — формат сообщения.

### Тихие уведомления (Silent Push) {#silent-push}

```bash
export IAM_TOKEN=<IAM-токен>
curl \
  --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "Action=Publish" \
  --data-urlencode "ResponseFormat=JSON" \
  --data-urlencode "TargetArn=<идентификатор_эндпоинта>" \
  --data-urlencode "Message={\"data\": { \"key\": \"value\" } }" \
  --data-urlencode "MessageStructure=json" \
  "https://{{ cns-host }}/"
```

Где:
* `IAM_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
* `Action` — [тип операции](index.md#actions).
* `ResponseFormat` — формат ответа: JSON или XML.
* `TargetArn` — идентификатор (ARN) мобильного эндпоинта.
* `Message` — сообщение.
* `MessageStructure` — формат сообщения.

Подробнее см. на странице [{#T}](publish.md).