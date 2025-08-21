# Push-уведомления в браузере

_Push-уведомления в браузере_ — это сообщения, всплывающие в браузере.

Push-уведомления могут сообщать о новом контенте, специальных предложениях и других значимых событиях. Браузерные уведомления будут работать на разных платформах: на настольных компьютерах, смартфонах и планшетах с любой операционной системой. Чтобы получать уведомления, пользователю не требуется ставить определенное ПО, достаточно стандартного браузера на его устройстве.

Push-уведомления также поддерживаются в прогрессивных веб-приложениях — [PWA](https://ru.wikipedia.org/wiki/Прогрессивное_веб-приложение). PWA — веб-приложение, которое работает в браузере, но сохраняет функции мобильного приложения. Например, PWA может работать офлайн, но при этом не потребуется скачивать обновления — они выполняются на стороне сервера.

Чтобы уведомление отправлялось в браузер по защищенному каналу, пользователь должен подписаться на уведомления через сервер уведомлений, который используется его браузером. Затем в канале уведомления {{ cns-short-name }} надо создать эндпоинт для этого пользователя.

{% include [limits-warning](../../_includes/notifications/limits-warning.md) %}

Порядок настройки Push-уведомлений:

1. В сервисе {{ cns-short-name }} создайте канал **{{ ui-key.yacloud.cns.type_web }}**.
1. Из браузера пользователя с помощью [Service Worker](https://developer.mozilla.org/ru/docs/Web/API/Service_Worker_API/Using_Service_Workers) вызовите метод JavaScript [subscribe](https://developer.mozilla.org/en-US/docs/Web/API/PushManager/subscribe#applications).

   При вызове метода браузер отправляет запрос на свой сервер отправки уведомлений. Например, Google Chrome отправляет запрос на Firebase Cloud Messaging (FCM), Safari — на Apple Push Notification Service (APNs). В ответ вернется объект [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription).

1. Преобразуйте полученный объект в JSON, вызвав метод [toJSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON).

1. Используйте полученный JSON при создании эндпоинта. Через этот эндпоинт пользователю будут отправляться уведомления.

1. Чтобы отправить уведомление, создайте сообщение в {{ cns-short-name }} и укажите в качестве получателя идентификатор (ARN) эндпоинта.

Чтобы отправлять уведомления разным пользователям, создайте базу эндпоинтов для всех пользователей.

Порядок отправки push-уведомлений:

1. Ваше веб-приложение инициирует отправку уведомления через канал push-уведомлений в браузере.
1. Команда на отправку поступает в {{ cns-short-name }}.
1. {{ cns-short-name }} отправляет уведомления на серверы, заданные в эндпоинтах.
1. Серверы уведомлений (FCM, APNs) отправляют уведомления в браузеры пользователей.

## Особенности работы с push-уведомлениями в браузере {#browser-features}

Работа с push-уведомлениями в браузере аналогична работе с мобильными push-уведомлениями, но обладает некоторыми особенностями.

### Создание канала push-уведомлений {#create-channel}

Создать канал уведомлений можно с помощью метода HTTP API [create](../api-ref/create-platform-application.md) для ресурса PlatformApplications сервиса {{ cns-full-name }} или аналога метода для CLI или SDK.

В параметр `Platform` нужно передать значение `WEB`. Значения атрибутов `PlatformPrincipal` и `PlatformCredential` не используются.

Пример создания канала push-уведомлений в браузере для HTTP API:

```bash
export IAM_TOKEN=<IAM_token>
curl \
  --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "Action=CreatePlatformApplication" \
  --data-urlencode "ResponseFormat=JSON" \
  --data-urlencode "FolderId=b1g85uk96h3f********" \
  --data-urlencode "Name=test" \
  --data-urlencode "Platform=WEB" \
  "https://{{ cns-host }}/"
```

Где:
* `IAM_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
* `Action` — тип операции.
* `ResponseFormat` — формат ответа: JSON или XML.
* `FolderId` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
* `Name` — имя канала уведомлений, задается пользователем.

Также вы можете создать канал уведомлений [через консоль управления](../quickstart-browser.md#create-channel).

### Получение VAPID-ключа {#get-key}

Одним из шагов для создания эндпоинта является вызов метода JavaScript subscribe из браузера пользователя. Чтобы вызвать метод subscribe, необходим публичный VAPID-ключ. VAPID-ключ можно получить в атрибуте `VAPIDPublicKey` метода HTTP API [getAttributes](../api-ref/get-platform-application-attributes.md) для ресурса PlatformApplications сервиса {{ cns-full-name }} или аналога метода для CLI или SDK.

Пример получения параметров канала push-уведомлений в браузере для HTTP API:

```bash
export IAM_TOKEN=<IAM_token>
curl \
  --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "PlatformApplicationArn=arn:aws:sns::b1g7gh04hiav********:app/WEB/test" \
  --data-urlencode "Action=GetPlatformApplicationAttributes" \
  --data-urlencode "ResponseFormat=JSON" \
  "https://{{ cns-host }}/"
```

Где:
* `IAM_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
* `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.
* `Action` — тип операции.
* `ResponseFormat` — формат ответа: JSON или XML.

{% cut "Пример успешного ответа в JSON" %}

  ```json
  {
    "GetPlatformApplicationAttributesResponse": {
      "ResponseMetadata": {
        "RequestId":"1lOn********"
      },
      "GetPlatformApplicationAttributesResult": {
        "Attributes": {
          "CreatedAt": 1744743751,
          "Description": "",
          "LoggingPath": "",
          "Name": "test",
          "Platform": "WEB",
          "VAPIDPublicKey": "BCyZSlvKpYoRx_SaFpHtqyryq9lmutEyJ-hpeh_1jEcwTPvcJRtpv0VGw_zfOSZVjIzLCj5ggWgIyfW********"
        }
      }
    }
  }
  ```
{% endcut %}

Также вы можете узнать VAPID-ключ с помощью консоли управления. Для этого:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится канал уведомлений.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
1. Выберите нужный канал.
1. Значение VAPID-ключа будет указано в поле **{{ ui-key.yacloud.cns.field_vapid }}** секции **{{ ui-key.yacloud.common.overview }}**.

### Создание эндпоинта {#create-endpoint}

Создать эндпоинт можно с помощью метода HTTP API [create](../api-ref/create-platform-endpoint.md) для ресурса Endpoint сервиса {{ cns-full-name }} или аналога метода для CLI или SDK.

Для создания эндпоинта необходим объект PushSubscription в формате JSON, полученный в браузере пользователя. Объект PushSubscription нужно передать в параметре `Token`.

{% cut "Пример объекта PushSubscription в JSON" %}

   ```json
   {
    "endpoint": "https://fcm.googleapis.com/fcm/send/abcdef123456",
    "expirationTime": 1704093740000,
    "keys": {
      "p256dh": "BOrLkr7sEt8tERyAv6c8ZG5UC********",
      "auth": "aBcDeFg12345"
    }
   }
   ```
{% endcut %}

Пример создания эндпоинта для HTTP API:

```bash
export IAM_TOKEN=<IAM_token>
curl \
  --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "PlatformApplicationArn=arn:aws:sns::b1g7gh04hiav********:app/WEB/test" \
  --data-urlencode "Action=CreatePlatformEndpoint" \
  --data-urlencode "Token=<pushSubscription_JSON>" \
  --data-urlencode "CustomUserData=<данные_пользователя>" \
  --data-urlencode "ResponseFormat=JSON" \
  "https://{{ cns-host }}/"
```

Где:
* `IAM_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
* `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.
* `Action` — тип операции.
* `Token` — объект PushSubscription в формате JSON, который получен в браузере пользователя.
* `CustomUserData` — прочие пользовательские данные, которые можно сохранить вместе с эндпоинтом.
* `ResponseFormat` — формат ответа: JSON или XML.

Создать эндпоинт можно [через консоль управления](../quickstart-browser.md#create-endpoint). В процессе создания также необходимо будет передать объект PushSubscription в JSON, полученный в браузере пользователя.

### Отправка уведомлений {#publish}

Отправить уведомление можно с помощью метода HTTP API [publish](../api-ref/publish.md) для ресурса Endpoint сервиса {{ cns-full-name }} или аналога метода для CLI или SDK.

Отправить уведомление можно двумя способами:

1. Отправить текст сообщения в параметре `Message` без передачи текста для конкретной платформы.

    Пример отправки сообщения в виде простого текста для HTTP API:
    ```bash
    export IAM_TOKEN=<IAM_token>
    curl \
      --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
      --header "Authorization: Bearer ${IAM_TOKEN}" \
      --data-urlencode "TargetArn=<идентификатор_эндпоинта>" \
      --data-urlencode "Action=Publish" \
      --data-urlencode "Message=<текст_сообщения>" \
      --data-urlencode "ResponseFormat=JSON" \
      "https://{{ cns-host }}/"
    ```

    Где:
    * `IAM_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
    * `TargetArn` — идентификатор (ARN) эндпоинта.
    * `Action` — тип операции.
    * `Message` — сообщение, которое вы хотите отправить в эндпоинт.
    * `ResponseFormat` — формат ответа: JSON или XML.

1. Передать и дефолтное сообщение, и текст для платформы. Для этого сообщения потребуется передать в формате JSON через параметр `Message` и указать значение `json` в параметре `MessageStructure`. Ключом для платформы при отправке уведомления в браузер будет строка `WEB`.

    Пример отправки сообщения в формате JSON для HTTP API:
    ```bash
    export IAM_TOKEN=<IAM_token>
    curl \
      --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
      --header "Authorization: Bearer ${IAM_TOKEN}" \
      --data-urlencode "TargetArn=<идентификатор_эндпоинта>" \
      --data-urlencode "Action=Publish" \
      --data-urlencode "Message={ "default": "<дефолтное_сообщение>", "WEB": "<сообщение>" }" \
      --data-urlencode "MessageStructure=json" \
      --data-urlencode "ResponseFormat=JSON" \
      "https://{{ cns-host }}/"
    ```

    Где:
    * `IAM_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
    * `TargetArn` — идентификатор (ARN) мобильного эндпоинта.
    * `Action` — тип операции.
    * `Message` — сообщение, которое вы хотите отправить в эндпоинт.
    * `MessageStructure` — формат сообщения.
    * `ResponseFormat` — формат ответа: JSON или XML.

Также вы можете отправить уведомление без передачи текста для конкретной платформы [через консоль управления](../quickstart-browser.md#publish).

#### См. также {#see-also}

* [Обзор сервиса](index.md)
* [Как начать работать с push-уведомлениями](../quickstart-push.md)
* [Как начать работать с сервисом с помощью AWS CLI](../tools/aws-cli.md)
* [SMS](sms.md)