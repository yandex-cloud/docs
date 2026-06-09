# Изменить канал push-уведомлений

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится канал уведомлений.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Напротив нужного канала push-уведомлений нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. На вкладке **{{ ui-key.yacloud.cns.type_mobile }}** в зависимости от платформы измените параметры аутентификации:

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

  1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.cns.button_add-description }}** и введите описание для канала уведомлений.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

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

  Воспользуйтесь методом HTTP API [setAttributes](../../api-ref/set-platform-application-attributes.md) для ресурса PlatformApplications сервиса {{ cns-full-name }}.

{% endlist %}

Изменение канала уведомлений может занять некоторое время.