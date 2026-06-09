# Создать канал push-уведомлений

В {{ cns-name }} сообщения конечным пользователям отправляются через [каналы уведомлений](../../concepts/index.md#channels).

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
                
                Создайте и скачайте ключ подписи в своей учетной записи разработчика Apple: **Certificates, Identifiers & Profiles** → **Keys** → ![image](../../../_assets/console-icons/circle-plus-fill.svg). Скачать файл ключа можно только один раз.
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
  1. (опционально) Нажмите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.cns.button_add-description }}** и введите описание для канала уведомлений.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws sns create-platform-application \
        --name <имя_канала> \
        --platform <тип_платформы> \
        --attributes <параметр1>=<значение1>, ... <параметрN>=<значениеN>
      ```
      
      Где:
      
      * `--name` — имя канала уведомлений, задается пользователем.
        
        Имя должно быть уникальным для всего {{ cns-short-name }}. После создания канала изменить имя нельзя. Имя может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name), для RuStore — значение `packageName`.
      
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

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы создать канал push-уведомлений, используйте следующий код:

      ```python
      response = client.create_platform_application(
          Name="<имя_канала>",
          Platform="<тип_платформы>",
          Attributes= {
               "<параметр1>": "<значение1>",
               ...
               "<параметрN>": "<значениеN>"
          }
      )
      print ("Platform application ARN:", response['PlatformApplicationArn'])
      ```
      
      Где:
      
      * `Name` — имя канала уведомлений, задается пользователем.
        
        Имя должно быть уникальным для всего {{ cns-short-name }}. После создания канала изменить имя нельзя. Имя может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name), для RuStore — значение `packageName`.
      
      * `Platform` — тип мобильной платформы:
      
        * `APNS` и `APNS_SANDBOX` — Apple Push Notification service (APNs). Для тестирования приложения используйте `APNS_SANDBOX`.
        * `GCM` — Firebase Cloud Messaging (FCM).
        * `HMS` — Huawei Mobile Services (HMS).
        * `RUSTORE` — RuStore Android.
      
      * `Attributes` — параметры аутентификации на мобильной платформе в формате `"<параметр>": "<значение>"` через запятую. Значения зависят от типа платформы:
      
        * APNs:
      
          * Аутентификация с токеном:
      
            * `PlatformPrincipal` — путь к файлу с ключом подписи токена, полученный в Apple.
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
      
          Версия HTTP v1 API является предпочтительной, так как с июня 2024 года Legacy API [не будет поддерживаться FCM](https://firebase.google.com/docs/cloud-messaging/migrate-v1).
      
        * HMS:
      
          * `PlatformPrincipal` — идентификатор ключа.
          * `PlatformCredential` — API-ключ.
      
        * RuStore:
        
          * `PlatformPrincipal` — идентификатор проекта (ProjectID).
          * `PlatformCredential` — сервисный токен (ServiceToken).
      
      В результате вы получите идентификатор (ARN) канала уведомлений.

- AWS SDK для PHP {#php}

  1. Если у вас еще нет AWS SDK для PHP, [установите и настройте его](../../tools/sdk-php.md#aws-sdk).
  1. Чтобы создать канал push-уведомлений, используйте следующий код:

      ```php
      $response = $client->createPlatformApplication(
          [
              'Name' => '<имя_канала>',
              'Platform' => '<тип_платформы>',
              'Attributes' => [
                  '<параметр1>' => '<значение1>',
                  ...
                  '<параметрN>' => '<значениеN>'
              ],
          ]
      );
      
      print($response->get('PlatformApplicationArn'));
      ```
      
      Где:
      
      * `Name` — имя канала уведомлений, задается пользователем.
        
        Имя должно быть уникальным для всего {{ cns-short-name }}. После создания канала изменить имя нельзя. Имя может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name), для RuStore — значение `packageName`.
      
      * `Platform` — тип мобильной платформы:
      
        * `APNS` и `APNS_SANDBOX` — Apple Push Notification service (APNs). Для тестирования приложения используйте `APNS_SANDBOX`.
        * `GCM` — Firebase Cloud Messaging (FCM).
        * `HMS` — Huawei Mobile Services (HMS).
        * `RUSTORE` — RuStore Android.
      
      * `Attributes` — параметры аутентификации на мобильной платформе в формате `'<параметр1>' => '<значение1>'` через запятую. Значения зависят от типа платформы:
      
        * APNs:
      
          * Аутентификация с токеном:
      
            * `PlatformPrincipal` — путь к файлу с ключом подписи токена, полученный в Apple.
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
      
          Аутентификация с токеном — более современный и безопасный метод.
      
        * FCM: `PlatformCredential` — ключ сервисного аккаунта Google Cloud в формате JSON для аутентификации с помощью HTTP v1 API или API-ключ (server key) для аутентификации с помощью Legacy API.
      
          Используйте HTTP v1 API, так как с июля 2024 года [FCM legacy API не поддерживается](https://firebase.google.com/docs/cloud-messaging/migrate-v1).
      
        * HMS:
      
          * `PlatformPrincipal` — идентификатор ключа.
          * `PlatformCredential` — API-ключ.
        
        * RuStore:
        
          * `PlatformPrincipal` — идентификатор проекта (ProjectID).
          * `PlatformCredential` — сервисный токен (ServiceToken).
      
      В результате вы получите идентификатор (ARN) канала уведомлений.

- API {#api}

  Воспользуйтесь методом HTTP API [create](../../api-ref/create-platform-application.md) для ресурса PlatformApplications сервиса {{ cns-full-name }}.

{% endlist %}

Создание канала уведомлений может занять некоторое время.