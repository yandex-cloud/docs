# Как начать работать с push-уведомлениями в {{ cns-full-name }}

{% note info %}

Сервис находится на [стадии Preview](../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы включить {{ cns-name }}, запросите доступ к сервису у вашего аккаунт-менеджера или в [технической поддержке]({{ link-console-support }}).

{{ cns-name }} ({{ cns-short-name }}) — сервис для мультиканальной отправки уведомлений пользователям. HTTP API сервиса совместим с [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html).

С помощью {{ cns-name }} вы можете отправлять push-уведомления в приложения, зарегистрированные в следующих сервисах:
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

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md) и [привяжите](../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../resource-manager/concepts/resources-hierarchy.md).

## Создайте канал push-уведомлений {#create-channel}

В {{ cns-name }} сообщения конечным пользователям отправляются через [каналы уведомлений](concepts/index.md#channels).

Чтобы создать канал:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать канал уведомлений.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Нажмите **{{ ui-key.yacloud.cns.action_create-channel }}**.
  1. На вкладке **{{ ui-key.yacloud.cns.type_mobile }}** выберите платформу для отправки:
  
      * `{{ ui-key.yacloud.cns.select_apns-title }}` — для iOS-устройств.
      * `{{ ui-key.yacloud.cns.select_gcm-title }}` — для Android-устройств c установленными сервисами Google Play.
      * `{{ ui-key.yacloud.cns.select_hms-title }}` — для Android-устройств c установленными сервисами Huawei.
      * `{{ ui-key.yacloud.cns.select_ru-store-title }}` — для Android-устройств c установленным магазином приложений RuStore.
  
  1. В зависимости от платформы задайте параметры аутентификации:
  
      **{{ ui-key.yacloud.cns.select_apns-title }}**
      
      * Выберите **{{ ui-key.yacloud.cns.field_apns-method }}**: `{{ ui-key.yacloud.cns.auth_token }}` или `{{ ui-key.yacloud.cns.auth_certificate }}`.
      
          * Для аутентификации с помощью токена понадобятся:
            * **{{ ui-key.yacloud.cns.field_apns-key }}** — файл с ключом подписи, которым будет заверяться токен аутентификации.
                
                Создайте и скачайте ключ подписи в своей учетной записи разработчика Apple: **Certificates, Identifiers & Profiles** → **Keys** → ![image](../_assets/console-icons/circle-plus-fill.svg). Скачать файл ключа можно только один раз.
            * **{{ ui-key.yacloud.cns.field_apns-key-id }}** (Key ID) — узнайте идентификатор в учетной записи разработчика Apple: **Certificates, Identifiers & Profiles** → **Keys**. Убедитесь, что идентификатор соответствует ключу подписи, который вы загрузили на предыдущем шаге. Должен содержать 10 символов.
            * **{{ ui-key.yacloud.cns.field_apns-team-id }}** (Team ID) — указан в правом верхнем углу вашей учетной записи разработчика Apple. Должен содержать 10 символов: только цифры и буквы латинского алфавита.
            * **{{ ui-key.yacloud.cns.field_apns-bundle-id }}** — узнайте [Bundle ID](https://developer.apple.com/documentation/appstoreconnectapi/list_bundle_ids) в учетной записи разработчика Apple: **Certificates, Identifiers & Profiles** → **Identifiers** или в приложении Xcode: **Target** → **General** → **Identity**. Может содержать только цифры, буквы латинского алфавита, дефисы и точки.
             
             Подробнее о токене см. в [документации Apple](https://developer.apple.com/documentation/usernotifications/establishing-a-token-based-connection-to-apns).
          
          * Для аутентификации с помощью сертификата понадобятся:
            * **{{ ui-key.yacloud.cns.field_apns-certificate }}** — файл сертификата SSL в формате `.pem`.
            * **{{ ui-key.yacloud.cns.field_apns-private-key }}** — файл ключа в формате `.pem`. 
          
            Подробнее о сертификате см. в [документации Apple](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_certificate-based_connection_to_apns#2947597).
          
            Чтобы сохранить сертификат и закрытый ключ в отдельных файлах формата `.pem`, вы можете воспользоваться утилитой [openssl](https://docs.openssl.org/1.1.1/man1/pkcs12) в Linux:
            
            ```bash
            openssl pkcs12 -in Certificates.p12 -nokeys -nodes -out certificate.pem
            openssl pkcs12 -in Certificates.p12 -nocerts -nodes -out privatekey.pem
            ```
          
          Аутентификация с токеном является предпочтительной, как более современная, быстрая и безопасная.
      
      * Выберите **{{ ui-key.yacloud.cns.field_apns-environment }}**: `{{ ui-key.yacloud.cns.env_development }}` или `{{ ui-key.yacloud.cns.env_production }}`. Для тестирования приложения используйте `{{ ui-key.yacloud.cns.env_development }}`.
      
      **{{ ui-key.yacloud.cns.select_gcm-title }}**
      
      Укажите, какая **{{ ui-key.yacloud.cns.field_gcm-version }}** будет использоваться: `{{ ui-key.yacloud.cns.switch_gcm-api-v1 }}` или `{{ ui-key.yacloud.cns.switch_gcm-api-legacy }}`.
      
      Вы можете аутентифицироваться на мобильной платформе FCM через API:
      * _HTTP v1 API_ — понадобится **{{ ui-key.yacloud.cns.field_gcm-file }}**. С помощью ключа генерируются временные токены OAuth 2.0 для аутентификации запросов в FCM HTTP v1 API. Можно получить в консоли управления Google Cloud.
      * _Legacy API_ — понадобится **{{ ui-key.yacloud.cns.field_gcm-api-key }}** (server key). Можно получить в консоли управления Firebase.
      
      {% note info %}
      
      С июня 2024 года Legacy API [не поддерживается FCM](https://firebase.google.com/docs/cloud-messaging/migrate-v1).
      
      {% endnote %}
      
      Подробнее см. в [документации Firebase](https://firebase.google.com/docs/cloud-messaging/android/client).
      
      **{{ ui-key.yacloud.cns.select_hms-title }}**
      
      Познакомьтесь с [документацией HMS](https://developer.huawei.com/consumer/en/doc/hmscore-common-Guides/get-started-hmscore-0000001212585589) и получите параметры для аутентификации:
      * **{{ ui-key.yacloud.cns.field_hms-client-id }}**.
      * **{{ ui-key.yacloud.cns.field_hms-client-secret }}**.
      
      **{{ ui-key.yacloud.cns.select_ru-store-title }}**
      
      Познакомьтесь с [документацией RuStore](https://www.rustore.ru/help/sdk/push-notifications/send-push-notifications) и получите параметры для аутентификации:
      * **{{ ui-key.yacloud.cns.field_rustore-project-id }}**.
      * **{{ ui-key.yacloud.cns.field_rustore-service-token }}**.
      
      Параметры аутентификации можно получить в консоли разработчика RuStore: **Push-уведомления** → **Проекты**.
  
  1. Введите **{{ ui-key.yacloud.cns.field_channel-name }}** канала уведомлений. Имена каналов уникальны для всего {{ cns-short-name }}. Может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Допустимая длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name), для RuStore — значение `packageName`.
  1. (опционально) Нажмите ![image](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.cns.button_add-description }}** и введите описание для канала уведомлений.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

Создание канала уведомлений может занять некоторое время.

## Создайте эндпоинт {#create-endpoint}

Каждый канал имеет свою базу [эндпоинтов](concepts/index.md#mobile-endpoints) для отправки уведомлений напрямую в приложение на устройства пользователей.

Чтобы создать эндпоинт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите канал уведомлений, созданный ранее.
  1. Перейдите на вкладку ![image](../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cns.action_create-endpoint }}**.
  1. Введите **{{ ui-key.yacloud.cns.field_token }}** — уникальный токен на устройстве пользователя, созданный сервисом уведомлений для приложения.
  1. (опционально) Введите **{{ ui-key.yacloud.cns.field_endpoint-user-data }}** — текст длиной до 2048 символов в кодировке [UTF-8](https://ru.wikipedia.org/wiki/UTF-8).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  Создание эндпоинта может занять некоторое время.

{% endlist %}

## Отправьте уведомление {#publish}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите эндпоинт, созданный ранее.
  1. В блоке **{{ ui-key.yacloud.cns.section_message-sending }}** выберите формат уведомления: `{{ ui-key.yacloud.cns.label_editor-text }}` или `{{ ui-key.yacloud.cns.label_editor-json }}`.
  1. Введите текст уведомления или JSON-объект, содержащий данные уведомления.
  1. Нажмите кнопку **{{ ui-key.yacloud.cns.action_send-msg }}**.
  
  Каждому отправленному уведомлению присваивается уникальный идентификатор. Чтобы сохранить его, нажмите кнопку **{{ ui-key.yacloud.cns.action_copy-msg-id }}**.

  Вы можете сразу же отправить новое уведомление или повторить предыдущее.

{% endlist %}

## См. также {#see-also}

* [Как начать работать с SMS](quickstart-sms.md)
* [Как начать работать с сервисом с помощью AWS CLI](tools/aws-cli.md)
* [Обзор сервиса](concepts/index.md)
* [Канал мобильных Push-уведомлений](concepts/push.md)