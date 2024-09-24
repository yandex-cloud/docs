# Как начать работать с push-уведомлениями в {{ cns-full-name }}

{% include [preview-stage](../_includes/notifications/preview-stage.md) %}

{% include [ask-for-turning-on](../_includes/notifications/ask-for-turning-on.md) %}

{% include [about-service](../_includes/notifications/about-service.md) %}

С помощью {{ cns-name }} вы можете отправлять push-уведомления в приложения, зарегистрированные в следующих сервисах:
* [Apple Push Notification service](https://developer.apple.com/notifications/) (APNs).
* [Firebase Cloud Messaging](https://firebase.google.com/) (FCM).
* [Huawei Mobile Services](https://developer.huawei.com/consumer/) (HMS).

Позднее также будет реализована отправка push-уведомлений через платформу [RuStore](https://www.rustore.ru/help/sdk/push-notifications).

Чтобы начать работу с push-уведомлениями:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте канал push-уведомлений](#create-channel).
1. [Создайте эндпоинт](#create-endpoint).
1. [Отправьте уведомление](#publish).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте канал push-уведомлений {#create-channel}

В {{ cns-name }} сообщения конечным пользователям отправляются через [каналы уведомлений](./concepts/index.md#channels).

Чтобы создать канал:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать канал уведомлений.
  1. В списке сервисов выберите **{{ cns-name }}**.
  1. Нажмите кнопку **Создать канал уведомлений**.
  1. На вкладке **Мобильные Push-уведомления** выберите платформу для отправки:
      * `Apple iOS` — для iOS-устройств.
      * `Google Android` — для Android-устройств c установленными сервисами Google Play.
      * `Huawei Android` — для Android-устройств c установленными сервисами Huawei.
  1. В зависимости от платформы задайте параметры аутентификации:

      **Apple iOS**

      * Выберите **Метод аутентификации**: `Токен` или `Сертификат`.

        {% include [auth-apns](../_includes/notifications/auth-apns.md) %}

      * Выберите **Окружение**: `Development` или `Production`. Для тестирования приложения используйте `Development`.

      **Google Android**

      Укажите, какая **Версия FCM API** будет использоваться: `HTTP v1` или `Legacy`.

      {% include [auth-fcm](../_includes/notifications/auth-fcm.md) %}

      **Huawei Android**

      {% include [auth-hms](../_includes/notifications/auth-hms.md) %}

  1. Введите **Имя** канала уведомлений. Должно быть уникальным в [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud). Может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Допустимая длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name).
  1. (опционально) Нажмите кнопку ![image](../_assets/console-icons/plus.svg) **Добавить описание** и введите описание для канала уведомлений.
  1. Нажмите кнопку **Создать**.

  Создание канала уведомлений может занять некоторое время.

{% endlist %}

## Создайте эндпоинт {#create-endpoint}

Каждый канал имеет свою базу [эндпоинтов](./concepts/index.md#mobile-endpoints) для отправки уведомлений напрямую в приложение на устройства пользователей.

Чтобы создать эндпоинт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите канал уведомлений, созданный ранее.
  1. Перейдите на вкладку ![image](../_assets/console-icons/layers-3-diagonal.svg) **Эндпоинты**.
  1. Нажмите кнопку **Создать эндпоинт**.
  1. Введите **Токен устройства** — уникальный токен на устройстве пользователя, созданный сервисом уведомлений для приложения.
  1. (опционально) Введите **Данные пользователя** — текст длиной до 2048 символов в кодировке [UTF-8](https://ru.wikipedia.org/wiki/UTF-8).
  1. Нажмите кнопку **Создать**.

  Создание эндпоинта может занять некоторое время.

{% endlist %}

## Отправьте уведомление {#publish}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите эндпоинт, созданный ранее.
  1. В блоке **Отправка уведомлений** выберите формат уведомления: `Текст` или `JSON`.
  1. Введите текст уведомления или JSON-объект, содержащий данные уведомления.
  1. Нажмите кнопку **Отправить**.
  
  Каждому отправленному уведомлению присваивается уникальный идентификатор. Чтобы сохранить его, нажмите кнопку **Скопировать идентификатор**.

  Вы можете сразу же отправить новое уведомление или повторить предыдущее.

{% endlist %}

## См. также {#see-also}

* [Как начать работать с SMS](quickstart-sms.md)
* [Как начать работать с сервисом с помощью AWS CLI](./tools/aws-cli.md)
* [Обзор сервиса](./concepts/index.md)
* [Канал мобильных Push-уведомлений](./concepts/push.md)
