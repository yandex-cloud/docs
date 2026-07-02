[Документация Yandex Cloud](../../index.md) > [Yandex Object Storage](../index.md) > [Практические руководства](index.md) > Резервное копирование > Резервное копирование в Object Storage с помощью aws s3 sync

# Резервное копирование в Yandex Object Storage с помощью AWS S3 Sync

В этом практическом руководстве вы настроите резервное копирование файлов из локальной системы в облачное хранилище [Yandex Object Storage](../index.md) с помощью [AWS S3 Sync](https://docs.aws.amazon.com/cli/latest/reference/s3/sync.html).

AWS S3 Sync — стандартная команда [AWS CLI](../tools/aws-cli.md) для синхронизации содержимого между локальным каталогом и [бакетом](../concepts/bucket.md). Это простой и надежный способ резервного копирования файлов в облачное объектное хранилище с поддержкой протокола S3.

Особенности использования AWS S3 Sync:

* Не требуется дополнительное программное обеспечение, кроме AWS CLI.
* Поддерживается на Linux, Windows и macOS.
* Простая настройка, работа напрямую с S3 API.
* Легкая автоматизация с помощью планировщика задач или скриптов.

Чтобы настроить резервное копирование с помощью AWS S3 Sync:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте бакет](#create-bucket).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте статический ключ доступа](#create-static-key).
1. [Установите AWS CLI](#install-aws).
1. [Синхронизируйте локальный каталог с бакетом](#sync).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки бакета входит плата за хранение данных в бакете и операции с ними ([тарифы Yandex Object Storage](../pricing.md)).


## Создайте бакет {#create-bucket}

{% note info %}

Чтобы защитить резервные копии от случайного удаления файлов, включите [версионирование S3-бакета](../operations/buckets/versioning.md). В этом случае удаленные или перезаписанные файлы будут сохраняться в виде предыдущих версий, которые можно [восстановить](../operations/objects/restore-object-version.md) при необходимости. Подробнее о версионировании S3-бакетов можно прочитать в [документации](../concepts/versioning.md).

Без версионирования восстановить удаленные из S3 файлы невозможно, даже если они раньше копировались.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. Перейдите в сервис **Object Storage**.
  1. Нажмите **Создать бакет**.
  1. Укажите имя бакета в соответствии с [правилами именования](../concepts/bucket.md#naming).
  1. В полях **Чтение объектов**, **Чтение списка объектов** и **Чтение настроек** выберите `С авторизацией`.
  1. Нажмите **Создать бакет**.

- AWS CLI {#cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../tools/aws-cli.md).
  1. Создайте бакет, указав имя бакета в соответствии с [правилами именования](../concepts/bucket.md#naming):

      ```bash
      aws --endpoint-url=https://storage.yandexcloud.net \
        s3 mb s3://<имя_бакета>
      ```

      Результат:

      ```text
      make_bucket: backup-bucket
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/Bucket/create.md) для ресурса [Bucket](../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../api-ref/grpc/Bucket/create.md) или методом S3 API [create](../s3/api-ref/bucket/create.md).

{% endlist %}


## Создайте сервисный аккаунт {#create-sa}

Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого будет выполняться резервное копирование.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите **Создать сервисный аккаунт**.
  1. В поле **Имя** укажите `sa-backup-to-s3`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../security/index.md#storage-editor) `storage.editor`.
  1. Нажмите **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте сервисный аккаунт:

      ```bash
      yc iam service-account create --name sa-backup-to-s3 \
        --folder-name <имя_каталога>
      ```

      Результат:

      ```yaml
      id: ajeab0cnib1p********
      folder_id: b0g12ga82bcv********
      created_at: "2025-10-03T09:44:35.989446Z"
      name: sa-backup-to-s3
      ```

  1. Назначьте сервисному аккаунту [роль](../security/index.md#storage-editor) `storage.editor` на каталог:

      ```bash
      yc resource-manager folder add-access-binding <имя_каталога> \
        --service-account-name sa-backup-to-s3 \
        --role storage.editor \
        --folder-name <имя_каталога>
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

  1. Создайте сервисный аккаунт `sa-backup-to-s3`. Для этого воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).
  1. Назначьте сервисному аккаунту в текущем каталоге [роль](../security/index.md#storage-editor) `storage.editor`. Для этого воспользуйтесь методом REST API [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/SetAccessBindings](../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md).

{% endlist %}

{% note info %}

Чтобы работать с объектами в [зашифрованном](../concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вместе с [ролью](../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../kms/operations/key-access.md):

* `kms.keys.encrypter` — для чтения ключа, [шифрования](../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
* `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
* `kms.keys.encrypterDecrypter` — включает [разрешения](../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.

Подробнее смотрите [Сервисные роли Key Management Service](../../kms/security/index.md#service-roles).

{% endnote %}


## Создайте статический ключ доступа {#create-static-key}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. Перейдите в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. Выберите сервисный аккаунт `sa-backup-to-s3`.
  1. На панели сверху нажмите ![image](../../_assets/console-icons/plus.svg) **Создать новый ключ** и выберите **Создать статический ключ доступа**.
  1. Задайте описание ключа и нажмите **Создать**.
  1. Сохраните полученные идентификатор и секретный ключ — они понадобятся позднее при монтировании бакета.

      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

- CLI {#cli}

  1. Выполните команду:

      ```bash
      yc iam access-key create \
        --service-account-name sa-backup-to-s3
      ```

      Где `--service-account-name` — имя сервисного аккаунта, для которого создается ключ.

      Результат:

      ```text
      access_key:
        id: aje726ab18go********
        service_account_id: ajecikmc374i********
        created_at: "2024-11-28T14:16:44.936656476Z"
        key_id: YCAJEOmgIxyYa54LY********
      secret: YCMiEYFqczmjJQ2XCHMOenrp1s1-yva1********
      ```

  1. Сохраните идентификатор (`key_id`) и секретный ключ (`secret`) — они понадобятся позднее при монтировании бакета.

- API {#api}

  Чтобы создать ключ доступа, воспользуйтесь методом REST API [create](../../iam/awscompatibility/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../iam/awscompatibility/api-ref/AccessKey/index.md) или вызовом gRPC API [AccessKeyService/Create](../../iam/awscompatibility/api-ref/grpc/AccessKey/create.md).

  Сохраните идентификатор (`key_id`) и секретный ключ (`secret`) — они понадобятся позднее при монтировании бакета.

{% endlist %}


## Установите AWS CLI {#install-aws}

Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../tools/aws-cli.md).


## Синхронизируйте локальный каталог с бакетом {#sync}

Чтобы завершить настройку резервного копирования, настройте [ручную](#manual-sync) или [автоматическую](#auto-sync) синхронизацию локального каталога с бакетом.


### Ручная синхронизация {#manual-sync}

{% list tabs group=operating_system %}

- Linux {#linux}

  Для разовой синхронизации выполните команду:
  
  ```bash
  aws s3 sync <путь_к_локальному_каталогу> s3://<имя_бакета> \
  --endpoint-url=https://storage.yandexcloud.net \
  --delete
  ```
  
  Где:
  
  * `--endpoint-url` — эндпоинт Object Storage.
  * `--delete` — флаг для удаления файлов из бакета при их удалении из локального каталога.
  
  Данная команда копирует все содержимое из локального каталога в S3-бакет, при этом перенося только новые и измененные файлы.

- Windows {#windows}

  Для разовой синхронизации выполните команду:
  
  ```bash
  aws s3 sync <путь_к_локальному_каталогу> s3://<имя_бакета> \
  --endpoint-url=https://storage.yandexcloud.net \
  --delete
  ```
  
  Где:
  
  * `--endpoint-url` — эндпоинт Object Storage.
  * `--delete` — флаг для удаления файлов из бакета при их удалении из локального каталога.
  
  Данная команда копирует все содержимое из локального каталога в S3-бакет, при этом перенося только новые и измененные файлы.

  {% note tip %}

  Чтобы каждый раз не запускать команду, можно создать BAT-файл:

  1. Откройте **Блокнот** (**Notepad**) и добавьте следующее содержимое:

      ```text
      @echo off
      aws s3 sync "<путь_к_локальному_каталогу>" s3://<имя_бакета> ^
        --endpoint-url=https://storage.yandexcloud.net ^
        --delete
      ```

      Где `--delete` — флаг для удаления файлов из бакета при их удалении из локального каталога.

  1. Сохраните файл, например, как `sync_to_s3.bat`.
  1. Чтобы синхронизировать каталоги, запустите BAT-файл.

  {% endnote %}

{% endlist %}


### Автоматическая синхронизация {#auto-sync}

{% list tabs group=operating_system %}

- Linux {#linux}

  Для автоматической синхронизации локального каталога с бакетом:

  1. Убедитесь, что у пользователя, от имени которого будет ставиться задание в `cron`, есть доступ к локальному каталогу.
  1. Откройте файл планировщика текущего пользователя, выполнив команду:

      ```bash
      crontab -e
      ```

  1. Добавьте в файл строку для автоматической синхронизации, например, каждые 10 минут:

      ```text
      */10 * * * * aws s3 sync <путь_к_локальному_каталогу> <имя_подключения>:<имя_бакета> --delete --log-file=<путь_к_файлу_логов>
      ```

      Где:

      * `--delete` — флаг для удаления файлов из бакета при их удалении из локального каталога.
      * `--log-file` — опциональный параметр для записи логов. Указывайте полный путь.

      {% note info %}
      
      Указывайте полный абсолютный путь к каталогам без `~`. Например: `/home/user/`.
      
      {% endnote %}

  Задание будет запускаться с заданной периодичностью и выполнять синхронизацию каталогов.

- Windows {#windows}

  Для автоматической синхронизации настройте задачу в **Планировщике задач**:
  
  1. Откройте **Планировщик задач** Windows:
  
      * **Пуск** → **Планировщик задач**.
      * Или выполните в **Выполнить** → `taskschd.msc`.
  
  1. Нажмите **Создать задачу... (Create Task…)**
  1. Во вкладке **Действия (Actions)** добавьте новое действие, указав абсолютный путь до исполняемого скрипта (например, BAT-файла) в поле **Программа или сценарий**.
  1. Во вкладке **Триггеры** добавьте расписание.
  1. Нажмите **OK.**

{% endlist %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите объекты](../operations/objects/delete-all.md) из бакета.
1. [Удалите бакет](../operations/buckets/delete.md).