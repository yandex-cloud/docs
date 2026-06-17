# Резервное копирование в Yandex Object Storage с помощью GeeseFS

В этом практическом руководстве вы настроите резервное копирование файлов из локальной системы в облачное хранилище [Yandex Object Storage](../index.md) с помощью [GeeseFS](../tools/geesefs.md).

GeeseFS позволяет монтировать [бакет](../concepts/bucket.md) как обычную папку. Это дает возможность использовать привычные инструменты копирования и синхронизации. Резервное копирование выполняется путем копирования и синхронизации данных между локальным каталогом и бакетом. Это выглядит как работа с двумя папками, одна из которых находится в облаке. Для оптимизации процесса применяются инструменты синхронизации, которые передают только новые и измененные файлы — например, `rsync` или `robocopy`.

Чтобы настроить резервное копирование с помощью GeeseFS:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте бакет](#create-bucket).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте статический ключ доступа](#create-static-key).
1. [Подготовьте окружение](#prepare-env).
1. [Смонтируйте бакет](#mount-bucket).
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


## Подготовьте окружение {#prepare-env}

### Установите GeeseFS {#install-geesefs}

{% list tabs group=operating_system %}

- Debian/Ubuntu {#linux}

  1. Проверьте, что в дистрибутиве установлены утилиты для работы с FUSE:

     ```bash
     apt list --installed | grep fuse
     ```

     {% note warning %}
     
     Во многих дистрибутивах Linux утилиты для работы с FUSE уже установлены по умолчанию. Их переустановка или удаление могут привести к нарушению работы операционной системы.
     
     {% endnote %}

  1. Если утилиты для работы с FUSE не установлены, то выполните команду:

     ```bash
     sudo apt-get install fuse
     ```

  1. Скачайте и установите GeeseFS:

     ```bash
     wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-linux-amd64
     chmod a+x geesefs-linux-amd64
     sudo cp geesefs-linux-amd64 /usr/bin/geesefs
     ```

- CentOS {#centos}

  1. Проверьте, что в дистрибутиве установлены утилиты для работы с FUSE:

     ```bash
     yum list installed | grep fuse
     ```

     {% note warning %}
     
     Во многих дистрибутивах Linux утилиты для работы с FUSE уже установлены по умолчанию. Их переустановка или удаление могут привести к нарушению работы операционной системы.
     
     {% endnote %}

  1. Если утилиты для работы с FUSE не установлены, то выполните команду:

     ```bash
     sudo yum install fuse
     ```

  1. Скачайте и установите GeeseFS:

     ```bash
     wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-linux-amd64
     chmod a+x geesefs-linux-amd64
     sudo cp geesefs-linux-amd64 /usr/bin/geesefs
     ```

- macOS {#macos}

  1. Установите пакет [macFUSE](https://osxfuse.github.io/).
  1. [Включите](https://github.com/macfuse/macfuse/wiki/Getting-Started#enabling-support-for-third-party-kernel-extensions-apple-silicon-macs) поддержку сторонних расширений ядра. Этот шаг необходим только при первом использовании MacFUSE на Apple Silicon Mac.
  1. [Разрешите](https://github.com/macfuse/macfuse/wiki/Getting-Started#allow-the-macfuse-kernel-extension-to-load-apple-silicon-and-intel-macs) загрузку расширения ядра MacFUSE (Apple Silicon и Intel Mac).

      Подробнее об установке macFUSE смотрите в [инструкции по установке](https://github.com/osxfuse/osxfuse/wiki/FAQ#2-installuninstall-questions) в репозитории macFUSE на GitHub.

  1. Скачайте и установите GeeseFS:

     ```bash
     platform='arm64'
     if [[ $(uname -m) == 'x86_64' ]]; then platform='amd64'; fi
     wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-mac-$platform
     chmod a+x geesefs-mac-$platform
     sudo cp geesefs-mac-$platform /usr/local/bin/geesefs
     ```

- Windows {#windows}

  1. [Скачайте](https://winfsp.dev/rel/) и установите WinFSP.
  1. [Скачайте](https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-win-x64.exe) файл `geesefs-win-x64.exe`.
  1. Для удобства работы переименуйте файл `geesefs-win-x64.exe` в `geesefs.exe`.
  1. Создайте папку `geesefs` и перенесите в нее файл `geesefs.exe`.
  1. Добавьте папку `geesefs` в переменную `PATH`:

      1. Нажмите кнопку **Пуск** и в строке поиска Windows введите **Изменение системных переменных среды**.
      1. Справа снизу нажмите кнопку **Переменные среды...**.
      1. В открывшемся окне найдите параметр `PATH` и нажмите **Изменить**.
      1. Добавьте путь к папке в список.
      1. Нажмите кнопку **ОК**.

{% endlist %}

Также вы можете самостоятельно собрать GeeseFS из исходного кода. Подробнее в [инструкции](https://github.com/yandex-cloud/geesefs#installation) в репозитории GeeseFS на GitHub.


### Аутентифицируйте GeeseFS {#auth-geesefs}

GeeseFS использует статический ключ доступа к Object Storage, [полученный ранее](#create-static-key). Он задается несколькими способами:

{% list tabs group=operating_system %}

- Linux/macOS {#linux}

  * С помощью [файла](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) `credentials`, который нужно поместить в директорию `~/.aws/`:

      1. Создайте директорию:

          ```bash
          mkdir ~/.aws
          ```

      1. Создайте файл `credentials` со следующим содержимым:

          ```text
          [default]
          aws_access_key_id = <идентификатор_ключа>
          aws_secret_access_key = <секретный_ключ>
          ```

          Если файл с ключом находится в другом месте, передайте путь к нему в параметре `--shared-config` при монтировании бакета:

          ```bash
          geesefs \
            --shared-config <путь_к_файлу_с_ключом> \
            <имя_бакета> <точка_монтирования>
          ```

          Структура файла с ключом должна быть аналогична `~/.aws/credentials`.

  * С помощью переменных окружения:

    ```bash
    export AWS_ACCESS_KEY_ID=<идентификатор_ключа>
    export AWS_SECRET_ACCESS_KEY=<секретный_ключ>
    ```

  {% note info %}

  Вы можете использовать команду `geesefs` с правами суперпользователя (`sudo`). В этом случае обязательно передавайте информацию о ключе либо в параметре `--shared-config`, либо с помощью переменных окружения.

  {% endnote %}

- Windows {#windows}

  * С помощью [файла](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) `credentials`, который нужно поместить в папку `users/<текущий_пользователь>/.aws/`:

    ```text
    [default]
    aws_access_key_id = <идентификатор_ключа>
    aws_secret_access_key = <секретный_ключ>
    ```

    Если файл с ключом находится в другом месте, передайте путь к нему в параметре `--shared-config` при монтировании бакета:

    ```cmd
    geesefs ^
      --shared-config <путь_к_файлу_с_ключом> ^
      <имя_бакета> <точка_монтирования>
    ```

    Структура файла с ключом должна быть аналогична `~/.aws/credentials`.

    В качестве точки монтирования укажите существующую папку.

  * С помощью переменных окружения:

    ```cmd
    set AWS_ACCESS_KEY_ID=<идентификатор_ключа>
    set AWS_SECRET_ACCESS_KEY=<секретный_ключ>
    ```

{% endlist %}

При работе с GeeseFS на виртуальной машине Compute Cloud, к которой [привязан сервисный аккаунт](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance), вы можете включить упрощенную аутентификацию, без статического ключа доступа. Для этого при монтировании бакета используйте параметр `--iam`.


## Смонтируйте бакет {#mount-bucket}

Выберите каталог или диск для монтирования бакета. Убедитесь, что у вас достаточно прав для этой операции.

При монтировании бакета также можно задать настройки GeeseFS, связанные с [производительностью](../tools/geesefs.md#performance) и правами доступа к объектам. Чтобы посмотреть список опций и их описания, выполните команду `geesefs --help`.

* Для разового монтирования бакета:

    {% list tabs group=operating_system %}

    - Linux/macOS {#linux}

      1. Создайте папку для монтирования:

          ```bash
          mkdir <точка_монтирования>
          ```

      1. Смонтируйте бакет:

          ```bash
          geesefs <имя_бакета> <точка_монтирования>
          ```

          В качестве точки монтирования укажите существующую папку.

    - Windows {#windows}

      Смонтируйте бакет:

      ```bash
      geesefs <имя_бакета> <точка_монтирования>
      ```

      В качестве точки монтирования укажите имя новой папки, которая будет создана при монтировании бакета. Нельзя указывать имя существующей папки.

      Результат:

      ```text
      2025/10/06 21:14:27.488504 main.INFO File system has been successfully mounted.
      The service geesefs has been started.
      ```

    {% endlist %}

* Для автоматического монтирования бакета при запуске системы:

    {% list tabs group=operating_system %}

    - Linux {#linux}

      1. Создайте папку для автоматического монтирования:
      
          ```bash
          mkdir <точка_монтирования>
          ```

      1. Откройте файл `/etc/fuse.conf`:

          ```bash
          sudo nano /etc/fuse.conf
          ```

      1. Добавьте в него строку:

          ```text
          user_allow_other
          ```

      1. Откройте файл `/etc/fstab`:

          ```bash
          sudo nano /etc/fstab
          ```

      1. Добавьте в файл `/etc/fstab` строку вида:

          ```text
          <имя_бакета>    /home/<имя_пользователя>/<точка_монтирования>    fuse.geesefs    _netdev,allow_other,--file-mode=0666,--dir-mode=0777,--shared-config=/home/<имя_пользователя>/.aws/credentials    0   0
          ```

          Если вы создавали файл `.aws/credentials` для пользователя `root`, то указывать параметр `--shared-config` не требуется.

          {% note info %}

          Чтобы бакет монтировался корректно, указывайте полный абсолютный путь к точке монтирования и файлу с ключом без `~`. Например: `/home/user/`.

          {% endnote %}

      1. Перезагрузите компьютер и проверьте, что бакет смонтирован в указанную папку.

      Чтобы отключить автоматическое монтирование, удалите из файла `/etc/fstab` строку с именем бакета.

    - macOS {#macos}

      1. Создайте папку для автоматического монтирования:

          ```bash
          mkdir <точка_монтирования>
          ```

      1. Создайте файл `com.geesefs.automount.plist` с конфигурацией агента автозапуска:

          ```bash
          nano /Users/<имя_пользователя>/Library/LaunchAgents/com.geesefs.automount.plist
          ```

      1. Задайте конфигурацию агента, указав имя бакета и абсолютный путь к точке монтирования:

          ```xml
          <?xml version="1.0" encoding="UTF-8"?>
          <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
          <plist version="1.0">
          <dict>
              <key>Label</key>
              <string>com.geesefs.automount</string>
              <key>ProgramArguments</key>
              <array>
                  <string>/usr/local/bin/geesefs</string>
                  <string><имя_бакета></string>
                  <string><абсолютный_путь_к_точке_монтирования></string>
              </array>
              <key>RunAtLoad</key>
              <true/>
              <key>KeepAlive</key>
              <dict>
                  <key>NetworkState</key>
                  <true/>
              </dict>
          </dict>
          </plist>
          ```

          {% note info %}

          В качестве точки монтирования укажите существующую пустую папку.

          Чтобы бакет монтировался корректно, указывайте полный абсолютный путь к точке монтирования и файлу с ключом без `~`. Например: `/home/user/`.

          {% endnote %}

      1. Включите созданный агент:

          ```bash
          launchctl load /Users/<имя_пользователя>/Library/LaunchAgents/com.geesefs.automount.plist
          ```

      1. Перезагрузите компьютер и проверьте, что бакет смонтирован в указанную папку.

      Чтобы отключить автозапуск агента, используйте команду:

      ```bash
      launchctl unload /Users/<имя_пользователя>/Library/LaunchAgents/com.geesefs.automount.plist
      ```

    - Windows {#windows}

      Создайте службу Windows, которая будет запускаться вместе с ОС:

      1. Запустите командную строку `CMD` от имени администратора.
      1. Выполните команду:

          ```cmd
          sc create <имя_службы> ^
            binPath="<команда_для_монтирования>" ^
            DisplayName= "<имя_службы>" ^
            type=own ^
            start=auto
          ```

          Где `binPath` — путь к файлу `geesefs.exe` с необходимыми параметрами монтирования. Например: `C:\geesefs\geesefs.exe <имя_бакета> <точка_монтирования>`. В качестве точки монтирования укажите имя новой папки, которая будет создана при монтировании бакета. Нельзя указывать имя существующей папки.

          Результат:

          ```text
          [SC] CreateService: успех
          ```

      1. Нажмите кнопку **Пуск** и в строке поиска Windows введите `Службы`. Запустите от имени администратора приложение **Службы**.
      1. В открывшемся окне найдите созданную ранее службу, нажмите на нее правой кнопкой мыши и выберите **Свойства**.
      1. На вкладке **Вход в систему** выберите опцию **С учетной записью** и укажите имя и пароль от вашей учетной записи Windows.

          При необходимости нажмите кнопку **Обзор** → **Дополнительно** → **Поиск**, чтобы найти нужного пользователя на компьютере.

      1. Нажмите кнопку **OK**.

      Чтобы удалить созданную службу, запустите командную строку `CMD` от имени администратора и выполните команду:

      ```cmd
      sc delete <имя_службы>
      ```

      Результат:

      ```text
      [SC] DeleteService: успех
      ```

    {% endlist %}


## Синхронизируйте локальный каталог с бакетом {#sync}

Чтобы завершить настройку резервного копирования, настройте [ручную](#manual-sync) или [автоматическую](#auto-sync) синхронизацию локального каталога с бакетом.


### Ручная синхронизация {#manual-sync}

{% list tabs group=operating_system %}

- Linux {#linux}

  Для разовой синхронизации выполните команду:

  ```bash
  rsync -av \
    --no-owner \
    --no-group \
    --no-perms \
    --no-times \
    --delete \
    <путь_к_локальному_каталогу>/ \
    <путь_к_каталогу_монтирования>/
  ```

  Где `--delete` — флаг для удаления файлов из бакета при их удалении из локального каталога.

  {% note info %}
  
  Указывайте полный абсолютный путь к каталогам без `~`. Например: `/home/user/`.
  
  {% endnote %}

  Данная команда копирует все содержимое из локального каталога в бакет через каталог, смонтированный с помощью GeeseFS. При этом переносит только новые и измененные файлы.

  Каталог GeeseFS не является полноценной POSIX-совместимой файловой системой, поэтому не переносятся владелец, права доступа и временные метки.

- Windows {#windows}

  Для разовой синхронизации выполните в командной строке (`CMD`):

  ```bash
  robocopy "<путь_к_локальному_каталогу>" "<путь_к_каталогу_монтирования>" /MIR
  ```

  Где `/MIR` — параметр для полной синхронизации каталогов, включая удаление отсутствующих файлов.

  {% note info %}
  
  Указывайте полный абсолютный путь к каталогам без `~`. Например: `/home/user/`.
  
  {% endnote %}

  Результат:

  ```text
  -------------------------------------------------------------------------------
    ROBOCOPY     ::     Robust File Copy for Windows
  -------------------------------------------------------------------------------

        Начало : 6 октября 2025 г. 21:16:36
      Источник : C:\Users\username\geesefs\local\
    Назначение : C:\Users\username\geesefs\mount\

      Файлы: *.*
  Параметры: *.* /S /E /DCOPY:DA /COPY:DAT /PURGE /MIR /R:1000000 /W:30

  ------------------------------------------------------------------------------

  1    C:\Users\username\geesefs\local\
  100%        Новый файл             13793        image.PNG

  ------------------------------------------------------------------------------

                ВсегоСкопировано ПропущеноНесоответствие      СБОЙДополнения
  Каталогов :         1         0         1         0         0         0
     Файлов :         1         1         0         0         0         0
       Байт :    13.4 k    13.4 k         0         0         0         0
      Время :   0:00:00   0:00:00                       0:00:00   0:00:00

  Скорость :         13793000 Байт/сек.
  Скорость :            789.241 МБ/мин.
  Окончание: 6 октября 2025 г. 21:16:36
  ```

  {% note tip %}

  Чтобы каждый раз не запускать команду, можно создать BAT-файл:

  1. Откройте **Блокнот** (**Notepad**) и добавьте следующее содержимое:

      ```text
      @echo off
      robocopy "<путь_к_локальному_каталогу>" "<путь_к_каталогу_монтирования>" /MIR
      ```

  1. Сохраните файл, например, как `sync_to_s3.bat`.
  1. Чтобы синхронизировать каталоги, запустите BAT-файл.

  {% endnote %}

{% endlist %}


### Автоматическая синхронизация {#auto-sync}

{% list tabs group=operating_system %}

- Linux {#linux}

  Для автоматической синхронизации локального каталога с каталогом GeeseFS:

  1. Убедитесь, что у пользователя, от имени которого будет ставиться задание в `cron`, есть доступ к обоим каталогам.
  1. Откройте файл планировщика текущего пользователя, выполнив команду:

      ```bash
      crontab -e
      ```

  1. Добавьте в файл строку для автоматической синхронизации, например, каждые 10 минут:

      ```text
      */10 * * * * rsync -av --no-owner --no-group --no-perms --no-times --delete <путь_к_локальному_каталогу>/ <путь_к_каталогу_монтирования>/ --log-file=<путь_к_файлу_логов>
      ```

      Где:

      * `--delete` — флаг для удаления файлов из бакета при их удалении из локального каталога.
      * `--log-file` — опциональный параметр для записи логов. Указывайте полный путь.

      {% note info %}
      
      Указывайте полный абсолютный путь к каталогам без `~`. Например: `/home/user/`.
      
      {% endnote %}

  Задание будет запускаться с заданной периодичностью и выполнять синхронизацию каталогов.

  Команда в задании `cron` копирует все содержимое из локального каталога в бакет через каталог, смонтированный с помощью GeeseFS. При этом переносит только новые и измененные файлы.

  Каталог GeeseFS не является полноценной POSIX-совместимой файловой системой, поэтому не переносятся владелец, права доступа и временные метки.

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