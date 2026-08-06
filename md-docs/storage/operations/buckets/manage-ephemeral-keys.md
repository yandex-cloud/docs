[Документация Yandex Cloud](../../../index.md) > [Yandex Object Storage](../../index.md) > [Пошаговые инструкции](../index.md) > Бакеты > Доступ в бакет с помощью эфемерного ключа доступа

# Доступ к бакету с помощью эфемерного ключа доступа

[Эфемерные ключи доступа](../../../iam/concepts/authorization/ephemeral-keys.md) — это временные ключи с ограниченным сроком действия, которые предоставляют безопасный способ доступа к ресурсам [Yandex Object Storage](../../index.md) без необходимости хранить [статические ключи](../../../iam/concepts/authorization/access-key.md). В этом руководстве вы научитесь создавать эфемерные ключи с помощью скрипта и использовать их для создания [бакетов](../../concepts/bucket.md) и загрузки [объектов](../../concepts/object.md) с помощью [AWS CLI](https://aws.amazon.com/ru/cli/).

Чтобы загрузить объекты в бакет Object Storage с помощью эфемерного ключа доступа:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте эфемерный ключ доступа](#prepare-script).
1. [Проверьте настройку AWS CLI](#setup-aws-cli).
1. [Создайте бакет](#create-bucket).
1. [Загрузите объект в бакет](#upload-files).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).



### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* плата за хранение данных в бакете ([тарифы Object Storage](../../pricing.md#prices-storage));
* плата за операции с данными ([тарифы Object Storage](../../pricing.md#prices-operations)).



### Настройте окружение {#setup-environment}


* Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
* Установите и настройте интерфейс командной строки [AWS CLI](../../tools/aws-cli.md).
* Скачайте и установите утилиту [jq](https://stedolan.github.io/jq/download/).


## Создайте сервисный аккаунт {#create-sa}

Создайте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), от имени которого вы будете создавать бакет и загружать объекты. Назначьте ему [роль](../../security/index.md#storage-editor) `storage.editor` на каталог.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. [Перейдите](https://console.yandex.cloud/link/iam) в сервис **Identity and Access Management**.
  1. Нажмите **Создать сервисный аккаунт**.
  1. В поле **Имя** укажите `ephemeral-sa`.
  1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `storage.editor`.
  1. Нажмите **Создать**.

- Yandex Cloud CLI {#cli}

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

  1. Создайте сервисный аккаунт `ephemeral-sa`. Для этого воспользуйтесь методом REST API [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../../iam/api-ref/grpc/ServiceAccount/create.md).
  1. Назначьте сервисному аккаунту в текущем каталоге роль `storage.editor`. Для этого воспользуйтесь методом REST API [setAccessBindings](../../../resource-manager/api-ref/Folder/setAccessBindings.md) для ресурса [Folder](../../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/SetAccessBindings](../../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md).

{% endlist %}

Чтобы управлять [доступом](../../security/overview.md) к бакету, у сервисного аккаунта должна быть [роль](../../security/index.md#storage-admin) `storage.admin`.

Чтобы работать с объектами в [зашифрованном](../../concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) вместе с [ролью](../../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../../kms/operations/key-access.md):

* `kms.keys.encrypter` — для чтения ключа, [шифрования](../../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
* `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
* `kms.keys.encrypterDecrypter` — включает [разрешения](../../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.

Подробнее смотрите [Сервисные роли Key Management Service](../../../kms/security/index.md#service-roles).


## Создайте эфемерный ключ доступа {#prepare-script}

Эфемерный ключ доступа можно записать напрямую в файл учетных данных AWS CLI. Как управлять эфемерными ключами вручную, смотрите в документе [Управление эфемерными ключами доступа](../../../iam/operations/authentication/manage-ephemeral-keys.md).

Чтобы создать эфемерный ключ доступа, пользователю необходима [роль](../../../iam/security/index.md#iam-serviceAccounts-ephemeralAccessKeyAdmin) `iam.serviceAccounts.ephemeralAccessKeyAdmin` или выше на каталог.

{% list tabs group=instructions %}

- Yandex Cloud CLI {#cli}

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите идентификатор сервисного аккаунта `ephemeral-sa`:

      ```bash
      yc iam service-account get --name ephemeral-sa --format json | jq -r .id
      ```

  1. Создайте эфемерный ключ доступа и запишите его в файл учетных данных AWS CLI:

      ```bash
      yc iam access-key issue-ephemeral \
        --subject-id <идентификатор_сервисного_аккаунта> \
        --session-name ephemeral-sa-1 \
        --aws-profile ephemeral-profile \
        --aws-credentials-file ~/.aws/credentials
      ```

      Где:

      * `--subject-id` — идентификатор сервисного аккаунта `ephemeral-sa`.
      * `--session-name` — имя сессии длиной от 1 до 64 символов. Необходимо для идентификации сессии в случае, если сервисный аккаунт [имперсонирован](../../../iam/concepts/access-control/impersonation.md) для нескольких пользователей.
      * `--aws-profile` — имя профиля AWS CLI, в который будет записан эфемерный ключ. Если профиль с таким именем уже существует, его данные будут перезаписаны.
      * `--aws-credentials-file` — путь к файлу учетных данных AWS CLI. По умолчанию используется `~/.aws/credentials`.

      После выполнения команды в файле `~/.aws/credentials` появится профиль `ephemeral-profile` с данными эфемерного ключа. Значения ключа в консоль не выводятся.

{% endlist %}


## Проверьте настройку AWS CLI {#setup-aws-cli}

Убедитесь, что AWS CLI использует созданный эфемерный ключ.

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  1. При необходимости добавьте в профиль `ephemeral-profile` в файле `~/.aws/credentials` параметры региона и эндпоинта Object Storage:

      ```text
      [ephemeral-profile]
      region = ru-central1
      endpoint_url = https://storage.yandexcloud.net
      ```

  1. Проверьте конфигурацию профиля:

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

  Подробности в документе [Создание бакета](create.md).

{% endlist %}


## Загрузите объект в бакет {#upload-files}

Загрузите объект в созданный бакет.

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  1. Создайте тестовый файл:

      ```bash
      echo "Hello, Yandex Cloud!" > test-file.txt
      ```

  1. Выполните команду для загрузки файла, указав путь к локальному файлу, имя вашего бакета и [ключ](../../concepts/object.md#key), по которому объект будет храниться в бакете:

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

  Подробности в документе [Загрузить объект](../objects/upload.md).

{% endlist %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [удалите объекты](../objects/delete-all.md) из бакета;
* [удалите бакет](delete.md).


#### Полезные ссылки {#see-also}

* [Обзор способов управления доступом в Object Storage](../../security/overview.md)
* [Доступ в бакет с помощью Security Token Service](create-sts-key.md)
* [Управление эфемерными ключами доступа](../../../iam/operations/authentication/manage-ephemeral-keys.md)