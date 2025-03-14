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

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/forms-and-datalens-paid-resources.md) %}

## Подготовьте инфраструктуру {#prepare-infrastructure}

### Создайте сервисный аккаунт {#create-service-account}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md): `forms-integration-sa`.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роли: 
      * [lockbox.payloadViewer](../../iam/roles-reference.md#lockbox-payloadViewer) — для чтения секретов {{ lockbox-full-name }}.
      * [functions.functionInvoker](../../iam/roles-reference.md#functions-functionInvoker) — для вызова функции {{ sf-name }}.
      * [storage.editor](../../iam/roles-reference.md#storage-editor) — для чтения и записи данных в бакет {{ objstorage-name }}.
      * [yq.viewer](../../iam/roles-reference.md#query-viewer) и [yq.invoker](../../iam/roles-reference.md#query-invoker) — для интеграции {{ datalens-name }} и {{ yq-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Создайте бакет {{ objstorage-name }} {#create-s3-bucket}

В [бакете](../../storage/concepts/bucket.md) {{ objstorage-name }} будут сохраняться данные из {{ forms-name }}. 

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. Введите **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** бакета.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

### Назначьте сервисному аккаунту права доступа на бакет {#assign-access-rights-for-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Откройте [созданный ранее](#create-s3-bucket) бакет.
  1. Перейдите в раздел **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Нажмите на кнопку ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.storage.buckets.button_permissions }}**.
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
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Выберите сервисный аккаунт `forms-integration`.
  1. Перейдите в раздел **{{ ui-key.yacloud.iam.folder.service-account.switch_overview }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.  
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. В открывшемся окне **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_label_title }}** отобразятся **{{ ui-key.yacloud.iam.folder.service-account.overview.label_id-title }}** и **{{ ui-key.yacloud.iam.folder.service-account.overview.label_secret-key-title }}**. Сохраните их — они понадобятся в дальнейшем.

{% endlist %}

### Создайте секрет {{ lockbox-name }} для статического ключа {#create-lockbox-secret}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. Введите **{{ ui-key.yacloud.common.name }}** секрета — `static-key`.
  1. В блоке **{{ ui-key.yacloud.lockbox.forms.title_secret-data-section }}**:
      1. Выберите **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}** — **{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}**.
      1. Создайте следующие пары ключ-значение:
          * Идентификатор статического ключа:

              * **{{ ui-key.yacloud.lockbox.label_password-key }}** — `static-key-id`.
              * **{{ ui-key.yacloud.lockbox.forms.title_version-payload-entries-value-placeholder }}** — выберите **{{ ui-key.yacloud.lockbox.forms.value_payload-entry-value-type-text }}** и введите идентификатор статического ключа, созданного ранее.

          * Значение статического ключа:

              * **{{ ui-key.yacloud.lockbox.label_password-key }}** — `static-key-value`.
              * **{{ ui-key.yacloud.lockbox.forms.title_version-payload-entries-value-placeholder }}** — выберите **{{ ui-key.yacloud.lockbox.forms.value_payload-entry-value-type-text }}** и введите значение статического ключа, созданного ранее.

{% endlist %}

## Создайте и настройте функцию {{ sf-name }} {#set-up-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Создайте функцию:
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}** в правом верхнем углу.
      1. Введите **{{ ui-key.yacloud.common.name }}** функции — `forms-function`.  
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  1. Создайте версию функции:  
      1. В открывшемся окне **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите среду исполнения — **Python**.
      1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. Выберите **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** создания функции — **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}**.
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

      1. После создания функции на вкладке **{{ ui-key.yacloud.common.overview }}** включите опцию **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}**:
          

{% endlist %}

## Создайте и настройте форму {{ forms-name }} {#set-up-form}

{% include [set-up-form](../_tutorials_includes/forms-and-datalens-set-up-form.md) %}

## Настройте подключение и привязку к данным в сервисе {{ yq-name }} {#yq-integration}

{% include [yq-integration](../_tutorials_includes/forms-and-datalens-yq-integration.md) %}

## Настройте получение данных в {{ datalens-name }} {#set-up-datalens}

{% include [yq-integration](../_tutorials_includes/forms-and-datalens-set-up-datalens.md) %}

## Протестируйте интеграцию созданных ресурсов {#test-forms-integration}

{% include [yq-integration](../_tutorials_includes/forms-and-datalens-test-integration.md) %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. Чарт {{datalens-name }}.
1. Датасет {{datalens-name }}.
1. Подключение {{datalens-name }}.
1. [Привязку {{ yq-name }}](../../query/operations/binding.md#delete).
1. [Соединение {{ yq-name }}](../../query/operations/connection.md#delete).
1. [Функцию {{ sf-name }}](../../functions/operations/function/function-delete.md).
1. [Секрет {{ lockbox-name }}](../../lockbox/operations/secret-delete.md).
1. [Бакеты {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
