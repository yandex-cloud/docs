# rclone

[rclone](https://rclone.org) — программа для монтирования бакетов Object Storage через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)) в системах Linux, macOS и Windows.

# Подключение бакета как диска в Windows

Вы настроите синхронизацию данных в бакете Yandex Object Storage и на локальном компьютере с помощью утилиты [rclone](https://rclone.org). Бакет будет смонтирован как диск в файловой системе Windows.

{% note info %}

В этом разделе представлены шаги для подключения бакета в ОС Windows. Для подключения в других ОС смотрите официальную [документацию rclone](https://rclone.org/install/). Шаги по [конфигурации rclone](#rclone-config) и [монтированию бакета](#bucket-mount) аналогичны шагам в ОС Windows.

{% endnote %}

Чтобы смонтировать бакет как диск:

1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте рабочее окружение](#environment-prepare).


1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте статический ключ доступа](#create-static-key).


1. [Создайте бакет](#bucket-create).
1. [Настройте подключение к Object Storage](#rclone-config).
1. [Смонтируйте бакет](#bucket-mount).
1. [Настройте автоматическое монтирование](#auto-mount).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки бакета входит:

* плата за хранение данных в бакете ([тарифы Object Storage](../../storage/pricing.md#prices-storage));
* плата за операции с данными ([тарифы Object Storage](../../storage/pricing.md#prices-operations)).


## Подготовьте рабочее окружение {#environment-prepare}

1. Скачайте и установите [дистрибутив winfsp](https://winfsp.dev/rel/) с сайта производителя.
1. Скачайте с сайта производителя [архив с утилитами sysinternals suite](https://docs.microsoft.com/en-us/sysinternals/downloads/) и распакуйте его в свою рабочую папку на локальном компьютере.
1. Скачайте [исполняемый файл Windows Service Wrapper (WinSW)](https://github.com/winsw/winsw/releases) в соответствии с конфигурацией вашей ОС и поместите его в отдельную папку.
1. Скачайте с сайта производителя [архив с утилитой rclone](https://rclone.org/downloads/) и распакуйте его в свою рабочую папку на локальном компьютере.
1. Добавьте папки с утилитами и дистрибутивом в переменную `PATH`. Для этого:

    1. Нажмите кнопку **Пуск** и в строке поиска Windows введите **Изменение системных переменных среды**.
    1. Справа снизу нажмите кнопку **Переменные среды...**.
    1. В открывшемся окне найдите параметр `PATH` и нажмите **Изменить**.
    1. Добавьте путь к папке в список.
    1. Нажмите кнопку **ОК**.


## Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать сервисный аккаунт.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. В поле **Имя** укажите `sa-win-disk-connect`.
  1. Нажмите кнопку ![](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `storage.editor`.
  1. Нажмите кнопку **Создать сервисный аккаунт**.

- YC CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте сервисный аккаунт с именем `sa-win-disk-connect`:

      ```bash
      yc iam service-account create --name sa-win-disk-connect
      ```

      Требования к формату имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

      Подробнее о команде `yc iam service-account create` смотрите в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

  1. Назначьте роль сервисному аккаунту роль `storage.editor`:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role storage.editor \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```
  
      Подробнее о команде `yc resource-manager folder add-access-binding` смотрите в [справочнике CLI](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md)

- API {#api}

  1. Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md).

  1. [Назначьте](../../organization/operations/add-role.md) сервисному аккаунту роль `storage.editor`.
  
{% endlist %}

Чтобы работать с объектами в [зашифрованном](../concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вместе с [ролью](../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../kms/operations/key-access.md):

* `kms.keys.encrypter` — для чтения ключа, [шифрования](../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
* `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
* `kms.keys.encrypterDecrypter` — включает [разрешения](../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.

Подробнее смотрите [Сервисные роли Key Management Service](../../kms/security/index.md#service-roles).

## Создайте статический ключ доступа {#create-static-key}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. Перейдите в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. В открывшемся списке выберите сервисный аккаунт `sa-win-disk-connect`.
  1. На верхней панели нажмите кнопку ![](../../_assets/console-icons/plus.svg) **Создать новый ключ**.
  1. Выберите **Создать статический ключ доступа**.
  1. Задайте описание ключа и нажмите кнопку **Создать**.
  1. Сохраните идентификатор и секретный ключ. После закрытия диалога значение ключа будет недоступно.

- YC CLI {#cli}

  1. Создайте ключ доступа для сервисного аккаунта `sa-win-disk-connect`:

     ```bash
     yc iam access-key create --service-account-name sa-win-disk-connect
     ```

     Результат:

     ```
     access_key:
       id: aje6t3vsbj8l********
       service_account_id: ajepg0mjt06s********
       created_at: "2022-07-18T14:37:51Z"
       key_id: 0n8X6WY6S24N7Oj*****
     secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI9hx*****
     ```

     Подробнее о команде `yc iam access-key create` смотрите в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/access-key/create.md).

  1. Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.

- API {#api}

  Чтобы создать ключ доступа, воспользуйтесь методом [create](../../iam/awscompatibility/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../iam/awscompatibility/api-ref/AccessKey/index.md).

{% endlist %}

В результате вы получите данные статического ключа доступа. Для аутентификации в Object Storage вам понадобятся:

* `key_id` — идентификатор статического ключа доступа;
* `secret` — секретный ключ.

Сохраните `key_id` и `secret`, так как повторное получение значения ключа будет невозможно.


## Создайте бакет {#bucket-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать бакет.
  1. Перейдите в сервис **Object Storage**.
  1. Справа сверху нажмите кнопку **Создать бакет**.
  1. В поле **Имя** укажите имя бакета в соответствии с [правилами именования](../concepts/bucket.md#naming).
  1. В полях **Чтение объектов**, **Чтение списка объектов** и **Чтение настроек** выберите **С авторизацией**.
  1. Нажмите кнопку **Создать бакет**.
 
- AWS CLI {#aws-cli}
  
  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](aws-cli.md).
  1. Создайте бакет, указав имя бакета в соответствии с [правилами именования](../concepts/bucket.md#naming):
  
     ```bash
     aws --endpoint-url https://storage.yandexcloud.net \
       s3 mb s3://<имя_бакета>
     ```

     Результат:
     
     ```text
     make_bucket: <имя_бакета>
     ```


- Terraform {#tf}

  {% note info %}
  
  Если вы работаете с Object Storage через Terraform от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры для создания сервисного аккаунта и ключа доступа:

     ```hcl
     ...
     // Создание сервисного аккаунта
     resource "yandex_iam_service_account" "sa" {
       name = "<имя_сервисного_аккаунта>"
     }
     
     // Назначение роли сервисному аккаунту
     resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
       folder_id = "<идентификатор_каталога>"
       role      = "storage.admin"
       member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
     }
     
     // Создание статического ключа доступа
     resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
       service_account_id = yandex_iam_service_account.sa.id
       description        = "static access key for object storage"
     }
     ```

  1. Добавьте в конфигурационный файл блок с параметрами бакета, указав имя бакета в соответствии с [правилами именования](../concepts/bucket.md#naming):
  
     ```hcl
     resource "yandex_storage_bucket" "<имя_бакета>" {
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
       bucket     = "<имя_бакета>"
     }
     ```
     
     Подробнее о ресурсе `yandex_storage_bucket` смотрите в [документации](../../terraform/resources/storage_bucket.md) провайдера Terraform.
     
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

  1. Разверните облачные ресурсы.
  
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.


- API {#api}

  Используйте метод REST API [create](../api-ref/Bucket/create.md) для ресурса [Bucket](../api-ref/Bucket/index.md), вызов gRPC API [BucketService/Create](../api-ref/grpc/Bucket/create.md) или метод S3 API [create](../s3/api-ref/bucket/create.md).

{% endlist %}

## Настройте подключение к Object Storage {#rclone-config}

1. Запустите командную строку PowerShell, перейдите в папку с утилитой `rclone` и запустите ее конфигурацию:

   ```powershell
   ./rclone.exe config
   ```

1. Следуя запросам приложения, создайте новый профиль подключения:

   1. Выберите создание нового профиля: введите в терминал значение `n`.
   1. Введите имя подключения: `s3-connect`.
   1. Выберите тип хранилища: введите в терминал значение `4`.
   1. Выберите провайдера: введите в терминал значение `1`.
   1. Выберите ручной способ ввода учетных данных: введите в терминал значение `1`.

   
   1. Введите в терминале идентификатор секретного ключа, [полученный ранее](#create-static-key).
   1. Введите в терминале значение секретного ключа, [полученное ранее](#create-static-key).


   1. Укажите регион: введите в терминал значение `ru-central1`.
   1. Укажите эндпоинт: введите в терминал значение `storage.yandexcloud.net`.
   1. Остальные настройки можно оставить по умолчанию — нажмите **Enter**, чтобы их пропустить.

{% note info %}

При необходимости вы можете выполнить расширенную настройку подключения. Для этого на шаге `Edit advanced config?` введите в терминале `y`. Подробнее с расширенными настройками можно ознакомиться [на странице документации](https://rclone.org/s3/) утилиты `rclone`.

{% endnote %}

## Смонтируйте бакет {#bucket-mount}

1. Проверьте подключение к бакету. В том же окне командной строки, в котором выполнялась настройка подключения, выполните команду, указав имя бакета:

   ```powershell
   ./rclone.exe ls s3-connect:<имя_бакета>
   ```

   Если конфигурация настроена правильно, в консоль будет выведен список объектов бакета.

1. Смонтируйте бакет в файловую систему, указав имя бакета и свободную букву диска в файловой системе:

   ```powershell
   ./rclone.exe mount s3-connect:<имя_бакета> <буква_диска>: --vfs-cache-mode full --file-perms 0777 --dir-perms 0777
   ```

   В проводнике Windows появится новый диск с объектами из бакета.

1. Чтобы отмонтировать бакет, нажмите клавиши **Ctrl** + **C**.

## Настройте автоматическое монтирование {#auto-mount}

Чтобы бакет монтировался автоматически при входе пользователя, необходимо создать скрипт запуска [VBScript](https://ru.wikipedia.org/wiki/VBScript) и добавить его в системный реестр. 

1. В вашей рабочей папке на локальном компьютере создайте файл `bucket_mount.vbs` и добавьте в него следующий код:

    ```text
    Set WshShell = CreateObject("WScript.Shell")
    command = "<путь_к_папке_rclone>\rclone.exe mount s3-connect:<имя_бакета> <буква_диска>: --vfs-cache-mode full --file-perms 0777 --dir-perms 0777"
    WshShell.Run command, 0, False
    ```

    В файле укажите имя бакета, букву диска, а также полный путь к файлу `rclone.exe`. Например: `C:\bucket-mounter\rclone\rclone.exe`.

1. Откройте редактор системного реестра `regedit.exe` и в открывшемся окне редактора:

    1. Перейдите в ветку `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run` и в этой ветке создайте строковый параметр `bucket-mounter`.
    1. Измените значение созданного параметра `bucket-mounter` на полный путь к созданному ранее файлу с VBS-скриптом. Например: `C:\bucket-mounter\bucket_mount.vbs`

С этого момента ваш бакет будет автоматически монтироваться в операционную систему при каждом входе пользователя на компьютер.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [удалите объекты](../operations/objects/delete-all.md) из бакета;
* [удалите бакет](../operations/buckets/delete.md).