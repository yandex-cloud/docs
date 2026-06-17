# Как начать работать с push-уведомлениями в Yandex Cloud Notification Service

{% note info %}

Сервис находится на [стадии Preview](../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы включить Cloud Notification Service, запросите доступ к сервису у вашего аккаунт-менеджера или в [технической поддержке](https://center.yandex.cloud/support).

Cloud Notification Service (CNS) — сервис для мультиканальной отправки уведомлений пользователям. HTTP API сервиса совместим с [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html).

С помощью Cloud Notification Service вы можете отправлять push-уведомления в приложения, зарегистрированные в следующих сервисах:
* [Apple Push Notification service](https://developer.apple.com/notifications/) (APNs).
* [Firebase Cloud Messaging](https://firebase.google.com/) (FCM).
* [Huawei Mobile Services](https://developer.huawei.com/consumer/) (HMS).
* [RuStore](https://www.rustore.ru/help/sdk/push-notifications/).

Чтобы начать работу с push-уведомлениями:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте канал push-уведомлений](#create-channel).
1. [Создайте эндпоинт](#create-endpoint).
1. [Отправьте уведомление](#publish).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md) и [привяжите](../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../resource-manager/concepts/resources-hierarchy.md).

## Создайте канал push-уведомлений {#create-channel}

В Cloud Notification Service сообщения конечным пользователям отправляются через [каналы уведомлений](concepts/index.md#channels).

Чтобы создать канал:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите создать канал уведомлений.
  1. Перейдите в сервис **Cloud Notification Service**.
  1. Нажмите **Создать канал уведомлений**.
  1. На вкладке **Мобильные Push-уведомления** выберите платформу для отправки:
  
      * `Apple iOS` — для iOS-устройств.
      * `Google Android` — для Android-устройств c установленными сервисами Google Play.
      * `Huawei Android` — для Android-устройств c установленными сервисами Huawei.
      * `RuStore Android` — для Android-устройств c установленным магазином приложений RuStore.
  
  1. В зависимости от платформы задайте параметры аутентификации:
  
      **Apple iOS**
      
      * Выберите **Метод аутентификации**: `Токен` или `Сертификат`.
      
          * Для аутентификации с помощью токена понадобятся:
            * **Ключ подписи** — файл с ключом подписи, которым будет заверяться токен аутентификации.
                
                Создайте и скачайте ключ подписи в своей учетной записи разработчика Apple: **Certificates, Identifiers & Profiles** → **Keys** → ![image](../_assets/console-icons/circle-plus-fill.svg). Скачать файл ключа можно только один раз.
            * **Идентификатор ключа** (Key ID) — узнайте идентификатор в учетной записи разработчика Apple: **Certificates, Identifiers & Profiles** → **Keys**. Убедитесь, что идентификатор соответствует ключу подписи, который вы загрузили на предыдущем шаге. Должен содержать 10 символов.
            * **Идентификатор разработчика** (Team ID) — указан в правом верхнем углу вашей учетной записи разработчика Apple. Должен содержать 10 символов: только цифры и буквы латинского алфавита.
            * **Идентификатор приложения (Bundle ID)** — узнайте [Bundle ID](https://developer.apple.com/documentation/appstoreconnectapi/list_bundle_ids) в учетной записи разработчика Apple: **Certificates, Identifiers & Profiles** → **Identifiers** или в приложении Xcode: **Target** → **General** → **Identity**. Может содержать только цифры, буквы латинского алфавита, дефисы и точки.
             
             Подробнее о токене смотрите в [документации Apple](https://developer.apple.com/documentation/usernotifications/establishing-a-token-based-connection-to-apns).
          
          * Для аутентификации с помощью сертификата понадобятся:
            * **Сертификат** — файл сертификата SSL в формате `.pem`.
            * **Закрытый ключ сертификата** — файл ключа в формате `.pem`. 
          
            Подробнее о сертификате смотрите в [документации Apple](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_certificate-based_connection_to_apns#2947597).
          
            Чтобы сохранить сертификат и закрытый ключ в отдельных файлах формата `.pem`, вы можете воспользоваться утилитой [openssl](https://docs.openssl.org/1.1.1/man1/pkcs12) в Linux:
            
            ```bash
            openssl pkcs12 -in Certificates.p12 -nokeys -nodes -out certificate.pem
            openssl pkcs12 -in Certificates.p12 -nocerts -nodes -out privatekey.pem
            ```
          
          Аутентификация с токеном является предпочтительной, как более современная, быстрая и безопасная.
      
      * Выберите **Окружение**: `Development` или `Production`. Для тестирования приложения используйте `Development`.
      
      **Google Android**
      
      Укажите, какая **Версия FCM API** будет использоваться: `HTTP v1` или `Legacy`.
      
      Вы можете аутентифицироваться на мобильной платформе FCM через API:
      * _HTTP v1 API_ — понадобится **Ключ сервисного аккаунта Google Cloud в формате JSON**. С помощью ключа генерируются временные токены OAuth 2.0 для аутентификации запросов в FCM HTTP v1 API. Можно получить в консоли управления Google Cloud.
      * _Legacy API_ — понадобится **API-ключ** (server key). Можно получить в консоли управления Firebase.
      
      {% note info %}
      
      С июня 2024 года Legacy API [не поддерживается FCM](https://firebase.google.com/docs/cloud-messaging/migrate-v1).
      
      {% endnote %}
      
      Подробнее в [документации Firebase](https://firebase.google.com/docs/cloud-messaging/android/client).
      
      **Huawei Android**
      
      Познакомьтесь с [документацией HMS](https://developer.huawei.com/consumer/en/doc/hmscore-common-Guides/get-started-hmscore-0000001212585589) и получите параметры для аутентификации:
      * **Идентификатор ключа**.
      * **API-ключ**.
      
      **RuStore Android**
      
      Познакомьтесь с [документацией RuStore](https://www.rustore.ru/help/sdk/push-notifications/send-push-notifications) и получите параметры для аутентификации:
      * **ID проекта**.
      * **Сервисный токен**.
      
      Параметры аутентификации можно получить в консоли разработчика RuStore: **Push-уведомления** → **Проекты**.
  
  1. Введите **Имя** канала уведомлений. Имена каналов уникальны для всего CNS. Может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Допустимая длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name), для RuStore — значение `packageName`.
  1. (опционально) Нажмите ![image](../_assets/console-icons/plus.svg) **Добавить описание** и введите описание для канала уведомлений.
  1. Нажмите **Создать**.

{% endlist %}

Создание канала уведомлений может занять некоторое время.

## Создайте эндпоинт {#create-endpoint}

Каждый канал имеет свою базу [эндпоинтов](concepts/index.md#mobile-endpoints) для отправки уведомлений напрямую в приложение на устройства пользователей.

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
  1. В блоке **Отправка сообщений** выберите формат уведомления: `Текст` или `JSON`.
  1. Введите текст уведомления или JSON-объект, содержащий данные уведомления.
  1. Нажмите кнопку **Отправить**.
  
  Каждому отправленному уведомлению присваивается уникальный идентификатор. Чтобы сохранить его, нажмите кнопку **Скопировать идентификатор**.

  Вы можете сразу же отправить новое уведомление или повторить предыдущее.

{% endlist %}

## Полезные ссылки {#see-also}

* [Как начать работать с SMS](quickstart-sms.md)
* [Как начать работать с сервисом с помощью AWS CLI](tools/aws-cli.md)
* [Обзор сервиса](concepts/index.md)
* [Канал мобильных Push-уведомлений](concepts/push.md)