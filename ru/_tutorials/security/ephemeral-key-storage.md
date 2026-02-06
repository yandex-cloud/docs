[Эфемерные ключи доступа](../../iam/concepts/authorization/ephemeral-keys.md) — это временные ключи с ограниченным сроком действия, которые предоставляют безопасный способ доступа к ресурсам [{{ objstorage-full-name }}](../../storage/) без необходимости хранить [статические ключи](../../iam/concepts/authorization/access-key.md). В этом руководстве вы научитесь создавать эфемерные ключи и использовать их для создания [бакетов](../../storage/concepts/bucket.md) и загрузки [объектов](../../storage/concepts/object.md) с помощью [AWS CLI](https://aws.amazon.com/ru/cli/).

Чтобы загрузить объекты в бакет {{ objstorage-name }} с помощью эфемерного ключа доступа:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте эфемерный ключ доступа](#create-key).
1. [Настройте AWS CLI](#setup-aws-cli).
1. [Создайте бакет](#create-bucket).
1. [Загрузите объект в бакет](#upload-files).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}



### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* плата за хранение данных в бакете (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-storage));
* плата за операции с данными (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-operations)).



### Настройте окружение {#setup-environment}

Установите и настройте интерфейс командной строки [AWS CLI](../../storage/tools/aws-cli.md).


## Создайте сервисный аккаунт {#create-sa}

Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого вы будете создавать бакет и загружать объекты. Назначьте ему [роль](../../storage/security/index.md#storage-editor) `storage.editor` на каталог.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** укажите `ephemeral-sa`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `storage.editor`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте сервисный аккаунт:

      ```bash
      yc iam service-account create \
        --name ephemeral-sa
      ```

      Результат:

      ```text
      id: ajeab0cnib1p********
      folder_id: b0g12ga82bcv********
      created_at: "2025-10-03T09:44:35.989446Z"
      name: ephemeral-sa
      ```

  1. Назначьте сервисному аккаунту роль `storage.editor` на каталог:

      ```bash
      yc resource-manager folder add-access-binding <имя_каталога> \
        --service-account-name ephemeral-sa \
        --role storage.editor
      ```

      Результат:

      ```text
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: storage.editor
            subject:
              id: ajeab0cnib1p********
              type: serviceAccount
      ```

- API {#api}

  1. Создайте сервисный аккаунт `ephemeral-sa`. Для этого воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).
  1. Назначьте сервисному аккаунту в текущем каталоге роль `storage.editor`. Для этого воспользуйтесь методом REST API [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/SetAccessBindings](../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md).

{% endlist %}

Чтобы управлять [доступом](../../storage/security/overview.md) к бакету, у сервисного аккаунта должна быть [роль](../../storage/security/index.md#storage-admin) `storage.admin`.

{% include [encryption-roles](../../_includes/storage/encryption-roles.md) %}


## Создайте эфемерный ключ доступа {#create-key}

Создайте эфемерный ключ доступа для сервисного аккаунта `ephemeral-sa`.

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Получите идентификатор сервисного аккаунта:

      ```bash
      yc iam service-account get --name ephemeral-sa --format json | jq -r .id
      ```

  1. Создайте эфемерный ключ доступа:

      ```bash
      yc iam access-key issue-ephemeral \
        --subject-id <идентификатор_сервисного_аккаунта> \
        --session-name ephemeral-key-storage \
        --duration 2h
      ```

      Где:

      * `--subject-id` — идентификатор сервисного аккаунта `ephemeral-sa`, полученный на предыдущем шаге.
      * `--session-name` — имя сессии.
      * `--duration` — срок жизни ключа.

      Результат:

      ```text
      access_key_id: ajelprpohp8t********
      secret: YCOs05v-KRXqhYpUINdWArH4MINhMyJ6CGU********
      session_token: s1.9muilY********
      expires_at: "2025-12-16T06:23:51.383485065Z"
      ```

  1. Сохраните идентификатор ключа `access_key_id`, секретный ключ `secret` и токен сессии `session_token`.

      {% note alert %}

      Получить эти значения повторно будет невозможно.

      {% endnote %}

{% endlist %}


## Настройте AWS CLI {#setup-aws-cli}

Настройте AWS CLI для работы с эфемерным ключом доступа.

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  1. Создайте новый профиль в файле `~/.aws/credentials`:

      ```text
      [ephemeral-profile]
      aws_access_key_id     = <идентификатор_ключа>
      aws_secret_access_key = <секретный_ключ>
      aws_session_token     = <токен_сессии>
      ```

      Укажите в профиле значения, полученные при [создании](#create-key) эфемерного ключа:

      * `aws_access_key_id` — идентификатор ключа `access_key_id`.
      * `aws_secret_access_key` — секретный ключ `secret`.
      * `aws_session_token` — токен сессии `session_token`.

  1. Настройте эндпоинт {{ objstorage-name }} для нового профиля:

      ```bash
      aws configure set endpoint_url https://{{ s3-storage-host }}/ --profile ephemeral-profile
      ```

      {% note info %}

      Вместо настройки эндпоинта вы можете указывать его при выполнении команд с помощью параметра `--endpoint-url`.

      {% endnote %}

  1. Проверьте конфигурацию:

      ```bash
      aws s3 ls --profile ephemeral-profile
      ```

      Если конфигурация выполнена правильно, команда выполнится без ошибок.

{% endlist %}


## Создайте бакет {#create-bucket}

Создайте бакет для хранения объектов.

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  Выполните команду, указав имя бакета:

  ```bash
  aws s3 mb s3://<имя_бакета> \
    --profile ephemeral-profile
  ```

  Результат:

  ```text
  make_bucket: my-bucket
  ```

  Подробности см. в документе [{#T}](../../storage/operations/buckets/create.md).

{% endlist %}


## Загрузите объект в бакет {#upload-files}

Загрузите объект в созданный бакет.

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  1. Создайте тестовый файл:

      ```bash
      echo "Hello, {{ yandex-cloud }}!" > test-file.txt
      ```

  1. Выполните команду для загрузки файла, указав путь к локальному файлу, имя вашего бакета и [ключ](../../storage/concepts/object.md#key), по которому объект будет храниться в бакете:

      ```bash
      aws s3 cp test-file.txt \
        s3://<имя_бакета>/test-file.txt \
        --profile ephemeral-profile
      ```

      Результат:

      ```text
      upload: ./test-file.txt to s3://my-bucket/test-file.txt
      ```

  1. Проверьте, что объект успешно загружен:

      ```bash
      aws s3 ls s3://<имя_бакета>/ \
        --profile ephemeral-profile
      ```

      Результат:

      ```text
      2025-10-03 09:45:12         23 test-file.txt
      ```

  Подробности см. в документе [{#T}](../../storage/operations/objects/upload.md).

{% endlist %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [удалите объекты](../../storage/operations/objects/delete-all.md) из бакета;
* [удалите бакет](../../storage/operations/buckets/delete.md).