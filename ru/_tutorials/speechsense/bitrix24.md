# Интеграция с Битрикс24

Чтобы настроить интеграцию {{ speechsense-name }} с Битрикс24:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте API-ключ для сервисного аккаунта](#create-key).
1. [Создайте пространство и привяжите платежный аккаунт](#create-space).
1. [Добавьте сервисный аккаунт в пространство](#add-sa-to-space).
1. [Создайте подключение](#create-connection).
1. [Создайте проект](#create-project).
1. [Настройте окружение в Битрикс24](set-bitrix24).

## Подготовьте облако к работе {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы. О том, как начать работать с {{ yandex-cloud }}, см. в документе [Начало работы с {{ yandex-cloud }}](../../getting-started/).
1. Примите пользовательское соглашение.
1. В сервисе [{{ billing-name }}]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account), если платежный аккаунт находится в статусе `TRIAL_ACTIVE`, [активируйте платную версию](../../billing/operations/activate-commercial.md) аккаунта.
1. [Назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль `speech-sense.spaces.creator`.

    {% include [note-managing-roles](../../_includes/mdb/note-managing-roles.md) %}

### Создайте сервисный аккаунт {#create-sa}

Создайте сервисный аккаунт с именем `speechsense`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md): `speechsense`.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `speech-sense.data.editor`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Создайте API-ключ для сервисного аккаунта {#create-key}

Создайте API-ключ для сервисного аккаунта `speechsense`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Выберите сервисный аккаунт `speechsense`.
  1. На панели сверху нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. В поле **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** нажмите кнопку **Выбрать все**, остальные поля оставьте пустыми.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните идентификатор и секретный ключ. Этот секретный ключ будет использоваться при заполнении формы с настройками приложения в Битрикс24.

  {% note alert %}

   После закрытия диалога значение ключа будет недоступно.

   {% endnote %}

{% endlist %}  

### Создайте пространство и привяжите платежный аккаунт {#create-space}

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

  1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
  1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.spaces.create-space }}**.
  1. Введите название [пространства](../../speechsense/concepts/resources-hierarchy.md#space).
  1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.create }}**.
  1. К пространству [привяжите платежный аккаунт](../../speechsense/operations/space/link-ba.md), с которого будет оплачиваться использование {{ speechsense-name }}.

     {% note tip %}

     Управлять платежным аккаунтом могут только пользователи с [аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport). Если вы работаете с {{ yandex-cloud }} через [федерацию удостоверений](../../organization/concepts/add-federation.md), [обратитесь]({{ link-console-support }}) в техническую поддержку.

     {% endnote %}

{% endlist %}

### Добавьте сервисный аккаунт в пространство {#add-sa-to-space}

Добавьте сервисный аккаунт `speechsense` в пространство {{ speechsense-name }}.

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

  1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
  1. Перейдите в [новое пространство](#create-space).
  1. Нажмите кнопку ![image](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yc-ui-talkanalytics.projects.add-participant }}** → ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yc-ui-talkanalytics.team.add-from-organization-key-value }}**.
  1. Скопируйте идентификатор [созданного ранее сервисного аккаунта](#create-sa) `speechsense` и вставьте в строку поиска.
  1. Выберите сервисный аккаунт `speechsense` и укажите роль [{{ roles-speechsense-data-editor }}](../../speechsense/security/index.md#speechsense-data-editor). Эта роль позволит сервисному аккаунту `speechsense` загружать данные в {{ speechsense-name }}.
  1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.add }}**.

{% endlist %}

### Создайте подключение {#create-connection}

В зависимости от типа файлов, которые будут загружаться в {{ speechsense-name }}, создайте подключение для аудио или для чата.

#### Создайте подключение для аудио {#create-audio-connection}

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

  1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
  1. Перейдите в нужное пространство.
  1. В правом верхнем углу нажмите **{{ ui-key.yc-ui-talkanalytics.common.more }}** → ![create](../../_assets/console-icons/thunderbolt.svg) **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
  1. Укажите название подключения.
  1. Выберите тип данных **{{ ui-key.yc-ui-talkanalytics.connections.type.two-channel-key-value }}**.
  1. В блоках **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}** укажите:

      1. Каналы, в которых записаны голос оператора и голос клиента.
      1. Ключи из файла метаданных для оператора и клиента. Этот файл содержит информацию о звонке, полученную из CRM-систем, АТС или других источников.

        По умолчанию в подключение добавлены ключи с именем и идентификатором оператора и клиента. В поле **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** введите название, под которым ключ будет отображаться в {{ speechsense-name }}.

        Чтобы указать дополнительные метаданные для оператора и клиента, нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**.

  1. В блоке **{{ ui-key.yc-ui-talkanalytics.connections.fields.metadata }}** укажите не связанные с оператором и клиентом ключи из файла метаданных.

      По умолчанию в подключение добавлены ключи с датой, направлением звонка и языком диалога. Дополнительно можно задать набор ключей, которые вы хотите получать из Битрикс24. В поле **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** введите название, под которым ключ будет отображаться в {{ speechsense-name }}.

      {% cut "Список доступных полей" %}

      Список актуален для текущей версии приложения.
   
      ```json
      {
         "id",
         "portal_user_id",
         "portal_number",
         "phone_number",
         "call_id",
         "external_call_id",
         "call_category",
         "call_duration",
         "call_start_date",
         "call_record_url",
         "call_vote",
         "cost",
         "cost_currency",
         "call_failed_code",
         "call_failed_reason",
         "crm_entity_type",
         "crm_entity_id",
         "crm_activity_id",
         "rest_app_id",
         "rest_app_name",
         "transcript_id",
         "transcript_pending",
         "session_id",
         "redial_attempt",
         "comment",
         "record_duration",
         "record_file_id",
         "call_type"
      }
      ```
   
      {% endcut %}

      Чтобы указать дополнительные метаданные, нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**.

  1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
  1. Скопируйте и сохраните идентификатор подключения. Для этого на странице подключения в левом верхнем углу нажмите кнопку **ID** ![image](../../_assets/console-icons/copy-transparent.svg). 

     Идентификатор подключения будет использоваться при заполнении формы с настройками приложения в Битрикс24.

{% endlist %}

### Создайте проект {#create-project}

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

  1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
  1. Перейдите в нужное пространство.
  1. Нажмите кнопку ![create](../../_assets/console-icons/folder-plus.svg) **{{ ui-key.yc-ui-talkanalytics.projects.create-project }}**.
  1. Введите имя проекта.
  1. В блоке **{{ ui-key.yc-ui-talkanalytics.connections.connection }}** нажмите **{{ ui-key.yc-ui-talkanalytics.projects.add-connection }}** и выберите подключение, созданное [ранее](#create-connection).
  1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.projects.create-project }}**.

{% endlist %}

## Настройте окружение в Битрикс24 {#set-bitrix24}

1. Перейдите в настройки приложения в Битрикс24 и нажмите кнопку **Редактировать** для изменения настроек.
1. Заполните форму настроек приложения:

   * **ID подключения SpeechSense**: идентификатор подключения в {{ speechsense-name }}, который был создан в разделе [Создайте подключение](#create-connection).
   * **API-ключ**: секретный API-ключ сервисного аккаунта `speechsense`, который был создан в разделе [Создайте API-ключ для сервисного аккаунта](#create-key).

   Нажмите кнопку **Проверить подключение**. Если подключение настроено успешно, отобразится сообщение «Успешный запрос к SpeechSense».

   * **С какой даты загружать звонки**: укажите дату. Если поле оставить пустым, то будут загружены все звонки из базы.

     {% note info %}
     
     В рамках тестирования интеграции рекомендуется указывать дату.
     
     {% endnote %}

   * **Список пользователей**: укажите идентификаторы пользователей Битрикс24 (список операторов), по которым будут загружены звонки. Если поле оставить пустым, то будут загружены звонки по всем пользователям из базы.

   * **Минимальная длина разговора**: длительность разговора в секундах. Рекомендуется отправлять звонки длительностью от 30 секунд.
   
   Нажмите кнопку **Запустить выгрузку**. Через несколько секунд в [интерфейсе {{ speechsense-name }}]({{ link-speechsense-main }}) в вашем проекте появятся загруженные звонки с расшифровками, и вы сможете начать [настраивать отчеты](../../speechsense/operations/data/manage-reports.md).
     
     
   

