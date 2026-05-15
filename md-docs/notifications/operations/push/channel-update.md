# Изменить канал push-уведомлений

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится канал уведомлений.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Cloud Notification Service**.
  1. Напротив нужного канала push-уведомлений нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. На вкладке **Мобильные Push-уведомления** в зависимости от платформы измените параметры аутентификации:

      **Apple iOS**
      
      * Выберите **Метод аутентификации**: `Токен` или `Сертификат`.
      
          * Для аутентификации с помощью токена понадобятся:
            * **Ключ подписи** — файл с ключом подписи, которым будет заверяться токен аутентификации.
                
                Создайте и скачайте ключ подписи в своей учетной записи разработчика Apple: **Certificates, Identifiers & Profiles** → **Keys** → ![image](../../../_assets/console-icons/circle-plus-fill.svg). Скачать файл ключа можно только один раз.
            * **Идентификатор ключа** (Key ID) — узнайте идентификатор в учетной записи разработчика Apple: **Certificates, Identifiers & Profiles** → **Keys**. Убедитесь, что идентификатор соответствует ключу подписи, который вы загрузили на предыдущем шаге. Должен содержать 10 символов.
            * **Идентификатор разработчика** (Team ID) — указан в правом верхнем углу вашей учетной записи разработчика Apple. Должен содержать 10 символов: только цифры и буквы латинского алфавита.
            * **Идентификатор приложения (Bundle ID)** — узнайте [Bundle ID](https://developer.apple.com/documentation/appstoreconnectapi/list_bundle_ids) в учетной записи разработчика Apple: **Certificates, Identifiers & Profiles** → **Identifiers** или в приложении Xcode: **Target** → **General** → **Identity**. Может содержать только цифры, буквы латинского алфавита, дефисы и точки.
             
             Подробнее о токене см. в [документации Apple](https://developer.apple.com/documentation/usernotifications/establishing-a-token-based-connection-to-apns).
          
          * Для аутентификации с помощью сертификата понадобятся:
            * **Сертификат** — файл сертификата SSL в формате `.pem`.
            * **Закрытый ключ сертификата** — файл ключа в формате `.pem`. 
          
            Подробнее о сертификате см. в [документации Apple](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_certificate-based_connection_to_apns#2947597).
          
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
      
      Подробнее см. в [документации Firebase](https://firebase.google.com/docs/cloud-messaging/android/client).
      
      **Huawei Android**
      
      Познакомьтесь с [документацией HMS](https://developer.huawei.com/consumer/en/doc/hmscore-common-Guides/get-started-hmscore-0000001212585589) и получите параметры для аутентификации:
      * **Идентификатор ключа**.
      * **API-ключ**.
      
      **RuStore Android**
      
      Познакомьтесь с [документацией RuStore](https://www.rustore.ru/help/sdk/push-notifications/send-push-notifications) и получите параметры для аутентификации:
      * **ID проекта**.
      * **Сервисный токен**.
      
      Параметры аутентификации можно получить в консоли разработчика RuStore: **Push-уведомления** → **Проекты**.

  1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **Добавить описание** и введите описание для канала уведомлений.
  1. Нажмите **Сохранить**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws sns set-platform-application-attributes \
        --platform-application-arn <ARN_канала_уведомлений> \
        --attributes <параметр1>=<новое_значение1>, ... <параметрN>=<новое_значениеN>
      ```

      Где:

      * `--platform-application-arn` — идентификатор (ARN) канала уведомлений.
      * `--attributes` — параметры канала уведомлений, которые вы хотите изменить, через запятую в формате `<параметр1>=<новое_значение1>`.

      Подробнее о команде `aws sns set-platform-application-attributes` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/set-platform-application-attributes.html).

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы изменить канал push-уведомлений, используйте следующий код:

      ```python
      response = client.set_platform_application_attributes(
          PlatformApplicationArn="<ARN_канала_уведомлений>",
          Attributes={
              "<параметр1>": "<новое_значение1>",
              ...
              "<параметрN>": "<новое_значениеN>"
          }
      )
      print("Attributes updated successfully.")
      ```

      Где:

      * `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.
      * `Attributes` —  параметры, которые вы хотите изменить, через запятую в формате `"<параметрN>": "<новое_значениеN>"`.

- AWS SDK для PHP {#php}

  1. Если у вас еще нет AWS SDK для PHP, [установите и настройте его](../../tools/sdk-php.md#aws-sdk).
  1. Чтобы изменить канал push-уведомлений, используйте следующий код:

      ```php
      $response = $client->setPlatformApplicationAttributes([
          'PlatformApplicationArn' => '<ARN_канала_уведомлений>',
          'Attributes' => [
              '<параметр1>' => '<новое_значение1>',
              ...
              '<параметрN>' => '<новое_значениеN>'
          ],
      ]);

      echo "Platform application attributes updated successfully.\n";
      ```

      Где:

      * `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.
      * `Attributes` —  параметры, которые вы хотите изменить, через запятую в формате `'<параметр>' => '<новое_значение>'`.


- API {#api}

  Воспользуйтесь методом HTTP API [setAttributes](../../api-ref/set-platform-application-attributes.md) для ресурса PlatformApplications сервиса Yandex Cloud Notification Service.

{% endlist %}

Изменение канала уведомлений может занять некоторое время.