# Поставка данных из {{ forms-full-name }} в {{ datalens-full-name }} с использованием {{ sf-full-name }} и {{ yq-full-name }} при помощи консоли управления

# Поставка данных из {{ forms-full-name }} в {{ datalens-full-name }} с использованием {{ sf-full-name }} и {{ yq-full-name }} при помощи консоли управления


Чтобы настроить интеграцию {{ forms-name }} и {{ datalens-name }} через консоль управления:

1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Создайте функцию {{ sf-full-name }}](#create-function).
1. [Создайте форму в {{ forms-name }}](#create-form).
1. [Настройте подключение и привязку к данным в сервисе {{ yq-full-name }}](#yq-integration).
1. [Настройте получение данных в {{ datalens-name }}](#set-up-datalens).
1. [Протестируйте интеграцию созданных ресурсов](#test-forms-integration).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за использование бакета {{ objstorage-full-name }} (см. [тарифы {{ objstorage-name }}](../../../storage/pricing.md));
* плата за хранение и запросы секретов {{ lockbox-full-name }} (см. [тарифы {{ lockbox-name }}](../../../lockbox/pricing.md));
* плата за вызовы функций и вычислительные ресурсы, выделенные для выполнения функций (см. [тарифы {{ sf-name }}](../../../functions/pricing.md));
* плата за объем считанных из источников данных при исполнении запросов {{ yq-name }} (см. [тарифы {{ yq-name }}](../../../query/pricing.md));
* плата за использование {{ datalens-name }} в соответствии с тарифным планом (см. [тарифы {{ datalens-name }}](../../../datalens/pricing.md)).

## Подготовьте инфраструктуру {#prepare-infrastructure}

### Создайте сервисный аккаунт {#create-service-account}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md): `forms-integration-sa`.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роли: 
      * [lockbox.payloadViewer](../../../iam/roles-reference.md#lockbox-payloadViewer) — для чтения секретов {{ lockbox-full-name }}.
      * [functions.functionInvoker](../../../iam/roles-reference.md#functions-functionInvoker) — для вызова функции {{ sf-name }}.
      * [storage.editor](../../../iam/roles-reference.md#storage-editor) — для чтения и записи данных в бакет {{ objstorage-name }}.
      * [yq.viewer](../../../iam/roles-reference.md#query-viewer) и [yq.invoker](../../../iam/roles-reference.md#query-invoker) — для интеграции {{ datalens-name }} и {{ yq-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Создайте бакет {{ objstorage-name }} {#create-s3-bucket}

В [бакете](../../../storage/concepts/bucket.md) {{ objstorage-name }} будут сохраняться данные из {{ forms-name }}. 

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. Введите **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** бакета.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

### Назначьте сервисному аккаунту права доступа на бакет {#assign-access-rights-for-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Откройте [созданный ранее](#create-s3-bucket) бакет.
  1. Перейдите в раздел **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Нажмите на кнопку ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.storage.buckets.button_permissions }}**.
  1. В открывшемся окне **{{ ui-key.yacloud.component.acl-dialog.label_title }}**:

      1. Начните вводить имя сервисного аккаунта `forms-integration` и выберите его из выпадающего списка.
      1. Выберите права доступа {{ ui-key.yacloud.storage.permissions-dialog.label_role-write }}.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Создайте статический ключ для сервисного аккаунта {#create-static-key-for-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Выберите сервисный аккаунт `forms-integration`.
  1. Перейдите в раздел **{{ ui-key.yacloud.common.overview }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.  
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. В открывшемся окне **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_label_title }}** отобразятся **{{ ui-key.yacloud.iam.folder.service-account.overview.label_id-title }}** и **{{ ui-key.yacloud.iam.folder.service-account.overview.label_secret-key-title }}**. Сохраните их — они понадобятся в дальнейшем.

{% endlist %}

### Создайте секрет {{ lockbox-name }} для статического ключа {#create-lockbox-secret}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.lockbox.SecretsPage.button_create-secret }}**.
  1. Введите **{{ ui-key.yacloud.common.name }}** секрета — `static-key`.
  1. В блоке **{{ ui-key.yacloud.lockbox.SecretInfoSection.title_secret-data-section }}**:
      1. Выберите **{{ ui-key.yacloud.lockbox.SecretInfoSection.title_secret-type }}** — **{{ ui-key.yacloud.lockbox.FormFields.title_secret-type-custom }}**.
      1. Создайте следующие пары ключ-значение:
          * Идентификатор статического ключа:

              * **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }}** — `static-key-id`.
              * **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_value }}** — выберите **{{ ui-key.yacloud.lockbox.SecretVersionsInputs.value_payload-entry-value-type-text }}** и введите идентификатор статического ключа, созданного ранее.

          * Значение статического ключа:

              * **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }}** — `static-key-value`.
              * **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_value }}** — выберите **{{ ui-key.yacloud.lockbox.SecretVersionsInputs.value_payload-entry-value-type-text }}** и введите значение статического ключа, созданного ранее.

{% endlist %}

## Создайте и настройте функцию {{ sf-name }} {#set-up-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Создайте функцию:
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}** в правом верхнем углу.
      1. Введите **{{ ui-key.yacloud.common.name }}** функции — `forms-function`.  
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  1. Создайте версию функции:  
      1. В открывшемся окне **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите среду исполнения — **Python**.
      1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. Выберите **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}** создания функции — **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}**.
      1. В окне редактора функции нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}**.
      1. В открывшемся окне введите **{{ ui-key.yacloud.serverless-functions.item.editor.create-form-file-path }}** файла — `forms-integration.py` и нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
      1. Вставьте в созданный файл `forms-integration.py` код функции:
          
          ```python
          import boto3
          import os
          import json
          from botocore.config import Config

          def get_answers(raw_answers: json) -> json:
              result = {}
              for name, value in raw_answers.get('answer').get('data').items():
                  if name.startswith('answer_choices_'):
                      choices = []
                      for c in value.get('value'):
                          choices.append(c.get('text'))
                      result[name] = ','.join(choices)
                  else:
                      result[name] = value.get('value')
              return result

          def handler(event, context):
              headers = event.get('headers')
              form_id = headers.get('X-Form-Id')
              answer_id = headers.get('X-Form-Answer-Id')

              body_json = json.loads(event.get('body'))
              answers_json = get_answers(body_json)

              aws_access_key_id = os.environ['KEY']
              aws_secret_access_key = os.environ['SECRET_KEY']
              bucket_name = os.environ['BUCKET']

              s3 = boto3.client(service_name='s3',
                                aws_access_key_id=aws_access_key_id,aws_secret_access_key=aws_secret_access_key,
                                endpoint_url='https://storage.yandexcloud.net', region_name='ru-central1',
                                config=Config(request_checksum_calculation="when_required"))

              s3.put_object(Bucket=bucket_name, Key=f"{form_id}/{answer_id}.json", Body=json.dumps(answers_json))

              return {
                  'statusCode': 200,
                  'body': "OK",
                  'headers': {
                      'Content-Type': 'text/plain',
                  }
              }

          ```
          
      1. В окне редактора функции нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}**.
      1. В открывшемся окне введите **{{ ui-key.yacloud.serverless-functions.item.editor.create-form-file-path }}** файла — `requirements.txt` и нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

      1. Укажите в созданном файле `requirements.txt` библиотеку `boto3` для работы с {{ objstorage-name }} из функции:

         ```
         boto3
         ```

      1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** укажите `forms-integration.handler`.

      1. В поле **{{ ui-key.yacloud.forms.label_service-account-select }}** выберите созданный ранее аккаунт `forms-integration-sa`.

      1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}** создайте переменную с названием бакета, в который будут сохраняться результаты выполнения функции:

          1. **Ключ** — `BUCKET`.
          1. **Значение** — имя [созданного ранее](#create-s3-bucket) бакета.

      1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}**:

          1. Создайте переменную `KEY` для идентификатора статического ключа со следующими параметрами:

              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-env-key }}** — `KEY`.
              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret-id }}** — выберите секрет `static-key-id`.
              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-version-id }}** — выберите версию с пометкой `latest`.
              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret-key }}** — выберите `static-key-id`.

          1. Создайте переменную `SECRET_KEY` для идентификатора статического ключа со следующими параметрами:

              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-env-key }}** — `SECRET_KEY`.
              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret-id }}** — выберите секрет `static-key-value`.
              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-version-id }}** — выберите версию с пометкой `latest`.
              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret-key }}** — выберите `static-key-value`.  

      1. После создания функции на вкладке **{{ ui-key.yacloud.common.overview }}** включите опцию **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}**.
          

{% endlist %}

## Создайте и настройте форму {{ forms-name }} {#set-up-form}

### Создайте API-ключ {#create-api-key}

[API-ключ](../../../iam/concepts/authorization/api-key.md) нужен для настройки интеграции с {{ forms-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Выберите сервисный аккаунт `forms-integration`.
  1. Перейдите в раздел **{{ ui-key.yacloud.common.overview }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.  
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. В открывшемся окне **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_label_title }}** отобразятся **{{ ui-key.yacloud.iam.folder.service-account.overview.label_id-title }}** и **{{ ui-key.yacloud.iam.folder.service-account.overview.label_secret-key-title }}**. Сохраните их — они понадобятся в дальнейшем.

{% endlist %}

### Создайте форму {#create-form}

{% list tabs group=instructions %}

- Интерфейс {{ forms-name }} {#forms}

  1. Перейдите в сервис [{{ forms-name }}]({{ link-forms-b2b }}).

  1. Нажмите кнопку **Создать форму**.

  1. Добавьте в форму хотя бы два любых поля и настройте произвольные вопросы в них.

  1. Нажмите кнопку **Опубликовать**.

  1. Сохраните ссылку на опубликованную форму — она понадобится позднее.

{% endlist %}

### Настройте интеграцию с функцией {{ sf-name }} {#set-up-integration}

{% list tabs group=instructions %}

- Интерфейс {{ forms-name }} {#forms}

  1. Перейдите в сервис [{{ forms-name }}]({{ link-forms-b2b }}).

  1. Откройте созданную ранее форму.

  1. Перейдите на вкладку **Настройки**.

  1. Откройте раздел **Дополнительно**.

  1. В блоке **Ключ для запуска облачных функций** введите данные [созданного ранее API-ключа](#create-api-key) и нажмите кнопку **Сохранить**.

  1. Откройте вкладку **Интеграции**.

  1. Нажмите кнопку **Cloud Functions**, чтобы добавить условие для интеграции.

  1. В поле **Код функции** введите идентификатор функции {{ sf-name }}. Вы можете скопировать идентификатор в разделе **{{ ui-key.yacloud.common.overview }}** функции {{ sf-name }} в [консоли управления]({{ link-console-main }}).

  1. В поле **Показывать сообщение о результате действия** выберите **Показывать**.

  1. Нажмите кнопку **Сохранить**.

{% endlist %}

### Проверьте работу созданной интеграции {#test-integration}

1. Перейдите по публичной ссылке созданной ранее формы.

1. Заполните форму и нажмите кнопку **Отправить**.

1. Перейдите в сервис [{{ forms-name }}]({{ link-forms-b2b }}).

1. Откройте созданную ранее форму.

1. Откройте вкладку **Интеграции**.

1. Перейдите на страницу **Выполненные интеграции**.

1. Откройте запись о выполненном действии и убедитесь, что в разделе **Ответ** получен HTTP-ответ `200 — ОК`.

1. Перейдите в [консоль управления]({{ link-console-main }}) и откройте [созданный ранее бакет](#create-s3-bucket). Убедитесь, что в нем появился JSON-файл с данными из заполненной формы.

   Название папки, в которой будет расположен файл, соответствует внутреннему идентификатору формы. Сохраните этот идентификатор — он понадобится для следующих шагов.

   Все последующие результаты заполнения формы будут сохраняться в этой папке.

1. Заполните форму еще несколько раз, причем одно из полей заполните одинаково хотя бы в двух формах. В дальнейшем это увеличит наглядность при тестировании интеграции.

## Настройте подключение и привязку к данным в сервисе {{ yq-name }} {#yq-integration}

{% list tabs group=instruction %}

- Интерфейс {{ yq-name }} {#yquery}

  1. Откройте [консоль управления]({{ link-console-main }}).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
  1. На вкладке **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** нажмите кнопку ![info](../../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
  1. Создайте соединение со следующими параметрами:
      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** — `forms-connection`.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** — `{{ objstorage-name }}`.
      * **{{ ui-key.yql.yq-binding-form.connection-bucket.title }}** — имя [созданного ранее](#create-s3-bucket) бакета.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** — `forms-integration-sa`.
  1. В открывшемся окне задайте параметры привязки к данным:
      * **{{ ui-key.yql.yq-binding-form.connection-type.title }}** — `{{ objstorage-name }}`.
      * **{{ ui-key.yql.yq-binding-form.connection.title }}** — `forms-connection`.
      * **{{ ui-key.yql.yq-binding-form.binding-path-pattern.title }}** — `/<идентификатор_формы>/`.
        Вы можете скопировать идентификатор:
          * В разделе **{{ ui-key.yacloud.storage.bucket.switch_files }}** бакета {{ objstorage-name }}. Название папки, в которой расположен файл с результатами заполнения формы, соответствует ее идентификатору.
          * В адресной строке [интерфейса {{ forms-name }}]({{ link-forms-b2b }}) на странице просмотра или редактирования формы.        
      * **{{ ui-key.yql.yq-binding-form.binding-format.title }}** — `json_each-row`.
      * **{{ ui-key.yql.yq-binding-form.binding-fields.title }}** — создайте колонки для полей, которые вы задали в форме.
        Чтобы {{ yq-name }} определил колонки самостоятельно, нажмите кнопку **{{ ui-key.yql.yq-binding-form.title_infer-columns }}**.

{% endlist %}

## Настройте получение данных в {{ datalens-name }} {#set-up-datalens}

{% list tabs group=instructions %}

- Интерфейс {{ datalens-name }} {#datalens}

  1. Перейдите в [сервис {{ datalens-name }}]({{ link-datalens-main-promo }}).
  1. Нажмите **Начать в облаке**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/thunderbolt.svg) **Подключения** и нажмите кнопку **Создать подключение**.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}** и задайте в открывшемся окне следующие параметры:
      * **Облако и каталог** — выберите облако и каталог, в котором вы создали остальные ресурсы.
      * **Сервисный аккаунт** — `forms-integration-sa`.
  1. Нажмите кнопку **Сохранить изменения** и в открывшемся окне задайте имя подключения — `forms-datalens-connection`, затем нажмите кнопку **Создать**.
  1. Вернитесь на главную страницу [сервиса {{ datalens-name }}]({{ link-datalens-main-skip-promo }}) и нажмите кнопку **Создать датасет**.
  1. На панели подключений нажмите ![icon](../../../_assets/console-icons/plus.svg) **Добавить** и выберите подключение `forms-datalens-connection`.
  1. В блоке **Таблицы** выберите нужную таблицу и перетащите ее в рабочую область {{ datalens-name }}.
      После загрузки данные из таблицы появятся на панели **Предпросмотр**.
  1. Нажмите кнопку **Сохранить** и введите имя датасета — `forms-integration-dataset`, затем нажмите кнопку **Создать**.

{% endlist %}

## Протестируйте интеграцию созданных ресурсов {#test-forms-integration}

Чтобы проверить совместную работу созданных ресурсов, откройте датасет `forms-integration-dataset` и нажмите кнопку **Создать чарт**. В открывшемся окне создайте произвольный чарт с данными, полученными из формы. Для большей наглядности постройте чарт по тому полю, в котором есть повторяющиеся значения.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. Чарт {{ datalens-name }}.
1. Датасет {{ datalens-name }}.
1. Подключение {{ datalens-name }}.
1. [Привязку {{ yq-name }}](../../../query/operations/binding.md#delete).
1. [Соединение {{ yq-name }}](../../../query/operations/connection.md#delete).
1. [Функцию {{ sf-name }}](../../../functions/operations/function/function-delete.md).
1. [Секрет {{ lockbox-name }}](../../../lockbox/operations/secret-delete.md).
1. [Бакеты {{ objstorage-name }}](../../../storage/operations/buckets/delete.md).