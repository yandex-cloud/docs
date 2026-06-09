# Резервное копирование в Yandex Object Storage с помощью rclone

В этом практическом руководстве вы настроите резервное копирование файлов из локальной системы в облачное хранилище [Yandex Object Storage](../../storage/index.md) с помощью [rclone](../../storage/tools/rclone.md).

[Rclone](https://rclone.org/) — универсальная командная утилита для работы с облачными хранилищами по протоколу S3, включая Object Storage. С ее помощью можно напрямую копировать и синхронизировать файлы между локальным компьютером и [бакетом](../../storage/concepts/bucket.md).

Особенности использования rclone:

* Работа напрямую через S3 API без монтирования бакета.
* Поддерживается на Linux, Windows и macOS.
* Возможность копирования, синхронизации, фильтрации, проверки и автоматизации через скрипты.
* Простая настройка и интеграция с планировщиками задач.

Чтобы настроить резервное копирование с помощью rclone:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте бакет](#create-bucket).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте статический ключ доступа](#create-static-key).
1. [Подготовьте окружение](#prepare-env).
1. [Синхронизируйте локальный каталог с бакетом](#sync).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки бакета входит плата за хранение данных в бакете и операции с ними (см. [тарифы Yandex Object Storage](../../storage/pricing.md)).


## Создайте бакет {#create-bucket}

{% note info %}

Чтобы защитить резервные копии от случайного удаления файлов, включите [версионирование S3-бакета](../../storage/operations/buckets/versioning.md). В этом случае удаленные или перезаписанные файлы будут сохраняться в виде предыдущих версий, которые можно [восстановить](../../storage/operations/objects/restore-object-version.md) при необходимости. Подробнее о версионировании S3-бакетов можно прочитать в [документации](../../storage/concepts/versioning.md).

Без версионирования восстановить удаленные из S3 файлы невозможно, даже если они раньше копировались.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. Перейдите в сервис **Object Storage**.
  1. Нажмите **Создать бакет**.
  1. Укажите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
  1. В полях **Чтение объектов**, **Чтение списка объектов** и **Чтение настроек** выберите `С авторизацией`.
  1. Нажмите **Создать бакет**.

- AWS CLI {#cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).
  1. Создайте бакет, указав имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming):

      ```bash
      aws --endpoint-url=https://storage.yandexcloud.net \
        s3 mb s3://<имя_бакета>
      ```

      Результат:

      ```text
      make_bucket: backup-bucket
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) или методом S3 API [create](../../storage/s3/api-ref/bucket/create.md).

{% endlist %}


## Создайте сервисный аккаунт {#create-sa}

Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого будет выполняться резервное копирование.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите **Создать сервисный аккаунт**.
  1. В поле **Имя** укажите `sa-backup-to-s3`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../../storage/security/index.md#storage-editor) `storage.editor`.
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

  1. Назначьте сервисному аккаунту [роль](../../storage/security/index.md#storage-editor) `storage.editor` на каталог:

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
  1. Назначьте сервисному аккаунту в текущем каталоге [роль](../../storage/security/index.md#storage-editor) `storage.editor`. Для этого воспользуйтесь методом REST API [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/SetAccessBindings](../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md).

{% endlist %}

{% note info %}

Чтобы работать с объектами в [зашифрованном](../../storage/concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вместе с [ролью](../../storage/security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../kms/operations/key-access.md):

* `kms.keys.encrypter` — для чтения ключа, [шифрования](../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
* `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
* `kms.keys.encrypterDecrypter` — включает [разрешения](../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.

Подробнее см. [Сервисные роли Key Management Service](../../kms/security/index.md#service-roles).

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


## Подготовьте окружение {#prepare-env}

### Установите rclone {#install-rclone}

{% list tabs group=operating_system %}

- Linux {#linux}

  1. Установите последнюю версию rclone с помощью команды:

      ```bash
      sudo -v ; curl https://rclone.org/install.sh | sudo bash
      ```

      Результат:

      ```text
      ...
      rclone v1.71.1 has successfully installed.
      Now run "rclone config" for setup. Check https://rclone.org/docs/ for more details.
      ```

      Подробнее о команде см. в [документации rclone](https://rclone.org/install/).

  1. Убедитесь, что утилита rclone установлена:

     ```bash
     rclone version
     ```

      Результат:

      ```text
      rclone v1.71.1
      - os/version: ubuntu 24.04 (64 bit)
      - os/kernel: 6.14.0-29-generic (x86_64)
      - os/type: linux
      - os/arch: amd64
      - go/version: go1.25.1
      - go/linking: static
      - go/tags: none
      ```

- Windows {#windows}

  1. Скачайте с сайта производителя [архив с утилитой rclone](https://rclone.org/downloads/) и распакуйте его в удобную для вас папку на локальном компьютере.
  1. Добавьте папку с утилитой в переменную `PATH` для доступа к ней из любого места в командной строке. Для этого:

      1. Нажмите **Пуск** и в строке поиска Windows введите **Изменение системных переменных среды**.
      1. Справа снизу нажмите **Переменные среды...**.
      1. В открывшемся окне найдите параметр `PATH` и нажмите **Изменить**.
      1. Добавьте путь к папке в список.
      1. Нажмите **ОК**.

  1. Убедитесь, что утилита rclone установлена:

      ```bash
      rclone version
      ```

      Результат:

      ```text
      rclone v1.71.1
      - os/version: Microsoft Windows 10 Pro 22H2 22H2 (64 bit)
      - os/kernel: 10.0.19045.4046 (x86_64)
      - os/type: windows
      - os/arch: amd64
      - go/version: go1.25.1
      - go/linking: static
      - go/tags: cmount
      ```

{% endlist %}


### Настройте подключение к Object Storage {#connect-rclone}

1. Запустите конфигурацию утилиты rclone, выполнив команду:

    ```bash
    rclone config
    ```

1. Следуя запросам приложения, создайте новый профиль подключения:

    1. Выберите создание нового профиля: введите в терминал значение `n`.
    1. Введите имя подключения, например, `yandex-s3`.
    1. Выберите тип хранилища: введите в терминал значение `4` (Amazon S3 Compliant Storage).
    1. Выберите провайдера: введите в терминал значение `1` (Amazon Web Services S3).
    1. Выберите ручной способ ввода учетных данных: введите в терминал значение `1`.
    1. Введите в терминале идентификатор секретного ключа, полученный ранее.
    1. Введите в терминале значение секретного ключа, полученное ранее.
    1. Укажите регион: введите в терминал значение `ru-central1`.
    1. Укажите эндпоинт: введите в терминал значение `storage.yandexcloud.net`.
    1. Остальные настройки можно оставить по умолчанию — нажмите **Enter**, чтобы их пропустить, и на последнем пункте выберите `q` (`Quit config`).

    {% note info %}

    При необходимости вы можете выполнить расширенную настройку подключения. Для этого на шаге `Edit advanced config?` введите в терминале `y`. Подробнее с расширенными настройками можно ознакомиться в [документации](https://rclone.org/s3/) утилиты `rclone`.

    {% endnote %}

    Также возможна настройка подключений через ручное редактирование файла конфигурации `rclone.conf`. Расположение файла конфигурации можно узнать, выполнив команду:

    ```bash
    rclone config file
    ```

1. Проверьте подключение к бакету, выполнив команду:

    ```bash
    rclone ls <имя_подключения>:<имя_бакета>
    ```

    Если конфигурация настроена правильно, в терминал будет выведен список объектов бакета.


## Синхронизируйте локальный каталог с бакетом {#sync}

Чтобы завершить настройку резервного копирования, настройте [ручную](#manual-sync) или [автоматическую](#auto-sync) синхронизацию локального каталога с бакетом.

{% note info %}

Файлы, удаленные из локального каталога, будут удалены также и из бакета. Если вы не хотите, чтобы файлы удалялись из бакета при их удалении из локального каталога — вместо команды `sync` используйте команду `copy`.

{% endnote %}


### Ручная синхронизация {#manual-sync}

{% list tabs group=operating_system %}

- Linux {#linux}

  Для разовой синхронизации выполните команду:
  
  ```bash
  rclone sync <путь_к_локальному_каталогу> <имя_подключения>:<имя_бакета>
  ```
  
  Где `sync` — команда для точного копирования, включая удаление файлов из бакета при их удалении из локального каталога. Чтобы копировать файлы без удаления, используйте команду `copy`.

- Windows {#windows}

  Для разовой синхронизации выполните команду:
  
  ```bash
  rclone sync <путь_к_локальному_каталогу> <имя_подключения>:<имя_бакета>
  ```
  
  Где `sync` — команда для точного копирования, включая удаление файлов из бакета при их удалении из локального каталога. Чтобы копировать файлы без удаления, используйте команду `copy`.

  {% note tip %}

  Чтобы каждый раз не запускать команду, можно создать BAT-файл:

  1. Откройте **Блокнот** (**Notepad**) и добавьте следующее содержимое:

      ```bash
      @echo off
      rclone sync <путь_к_локальному_каталогу> <имя_подключения>:<имя_бакета>
      ```

      Где `sync` — команда для точного копирования, включая удаление файлов из бакета при их удалении из локального каталога. Чтобы копировать файлы без удаления, используйте команду `copy`.

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
      */10 * * * * rclone sync <путь_к_локальному_каталогу> <имя_подключения>:<имя_бакета> --log-file=<путь_к_файлу_логов>
      ```

      Где:

      * `sync` — команда для точного копирования, включая удаление файлов из бакета при их удалении из локального каталога. Чтобы копировать файлы без удаления, используйте команду `copy`.
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

1. [Удалите объекты](../../storage/operations/objects/delete-all.md) из бакета.
1. [Удалите бакет](../../storage/operations/buckets/delete.md).