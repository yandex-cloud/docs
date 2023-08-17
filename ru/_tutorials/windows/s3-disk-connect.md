# Подключение бакета как диска в Windows

Вы настроите синхронизацию данных в бакете {{ objstorage-full-name }} и на локальном компьютере с помощью утилиты [rclone](https://rclone.org). Бакет будет смонтирован как диск в файловой системе Windows.

Чтобы смонтировать бакет как диск:

1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте рабочее окружение](#environment-prepare).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте статический ключ доступа](#create-static-key).
1. [Создайте бакет](#bucket-create).
1. [Настройте подключение к {{ objstorage-name }}](#rclone-config).
1. [Смонтируйте бакет](#bucket-mount).
1. [Настройте службу запуска монтирования](#mount-service).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}



### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки бакета входит:

* плата за хранение данных в бакете (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-storage));
* плата за операции с данными (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-operations)).



## Подготовьте рабочее окружение {#environment-prepare}

1. Скачайте и установите [дистрибутив winfsp](https://winfsp.dev/rel/) с сайта производителя.
1. Скачайте с сайта производителя [архив с утилитами sysinternals suite](https://docs.microsoft.com/en-us/sysinternals/downloads/) и распакуйте его в свою рабочую директорию на локальном компьютере.
1. Скачайте с сайта производителя [архив с утилитой Windows Service Wrapper (winsw)](https://github.com/winsw/winsw/releases) и распакуйте его в свою рабочую директорию на локальном компьютере.
1. Скачайте с сайта производителя [архив с утилитой rclone](https://rclone.org/downloads/) и распакуйте его в свою рабочую директорию на локальном компьютере.

## Создайте сервисный аккаунт {#create-sa}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** укажите `sa-win-disk-connect`.
  1. Нажмите кнопку ![](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `storage.editor`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Создайте сервисный аккаунт с именем `sa-win-disk-connect`:

  ```bash
  yc iam service-account create --name sa-win-disk-connect
  ```

  Требования к формату имени:

  {% include [name-format](../../_includes/name-format.md) %}

  Подробнее о команде `yc iam service-account create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/iam/service-account/create.md).

- API

  Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md).

{% endlist %}

## Создайте статический ключ доступа {#create-static-key}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Выберите сервисный аккаунт `sa-win-disk-connect`.
  1. На верхней панели нажмите кнопку ![](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}**.
  1. Выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Задайте описание ключа и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните идентификатор и секретный ключ. После закрытия диалога значение ключа будет недоступно.

- CLI

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

     Подробнее о команде `yc iam access-key create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/iam/access-key/create.md).

  1. Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.

- API

  Чтобы создать ключ доступа, воспользуйтесь методом [create](../../iam/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../iam/api-ref/AccessKey/index.md).

{% endlist %}

## Создайте бакет {#bucket-create}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
  1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** выберите **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
  
- AWS CLI
  
  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).
  1. Создайте бакет, указав имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming):
  
     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3 mb s3://<имя_бакета>
     ```

     Результат:
     
     ```text
     make_bucket: <имя_бакета>
     ```
  
- {{ TF }}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Добавьте в конфигурационный файл блок с параметрами бакета, указав имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming):
  
     ```hcl
     resource "yandex_storage_bucket" "<имя_бакета>" {
       bucket = "<имя_бакета>"
     }
     ```
     
     Подробнее о ресурсе `yandex_storage_bucket` см. в [документации]({{ tf-provider-resources-link }}/storage_bucket) провайдера {{ TF }}.
     
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.
  
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.
     
- API

   Используйте метод REST API [create](../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызов gRPC API [BucketService/Create](../../storage/api-ref/grpc/bucket_service.md#Create) или метод S3 API [create](../../storage/s3/api-ref/bucket/create.md).

{% endlist %}

## Настройте подключение к {{ objstorage-name }} {#rclone-config}

1. В рабочей директории запустите командную строку от имени администратора и выполните команду:

   ```powershell
   psexec -i -s cmd.exe
   ```

1. В открывшейся консоли выполните команду `whoami` и убедитесь, что сессия запущена от имени системного пользователя.
1. Перейдите в рабочую директорию и запустите конфигурацию утилиты `rclone`:

   ```powershell
   rclone.exe config
   ```

1. Следуя запросам приложения, создайте новый профиль подключения:

   1. Выберите создание нового профиля: введите в терминал значение `n`.
   1. Введите имя подключения: `s3-connect`.
   1. Выберите тип хранилища: введите в терминал значение `5`.
   1. Выберите провайдера: введите в терминал значение `1`.
   1. Выберите ручной способ ввода учетных данных: введите в терминал значение `1`.
   1. Введите в терминале идентификатор секретного ключа.
   1. Введите в терминале значение секретного ключа.
   1. Укажите регион: введите в терминал значение `{{ region-id }}`.
   1. Укажите эндпоинт: введите в терминал значение `{{ s3-storage-host }}`.
   1. Остальные настройки можно оставить по умолчанию — нажмите **Enter**, чтобы их пропустить.

{% note info %}

При необходимости вы можете выполнить расширенную настройку подключения. Для этого на шаге `Edit advanced config?` введите в терминале `y`. Подробнее с расширенными настройками можно ознакомиться [на странице документации](https://rclone.org/s3/) утилиты `rclone`.

{% endnote %}

## Смонтируйте бакет {#bucket-mount}

1. Проверьте подключение к бакету. В той же командной строке, где выполнялась настройка подключения, выполните команду, указав имя бакета:

   ```powershell
   rclone.exe ls s3-connect:<имя_бакета>
   ```

   Если конфигурация настроена правильно, в консоль будет выведен список объектов бакета.

1. Смонтируйте бакет в файловую систему, указав имя бакета и свободную букву диска в файловой системе:

   ```powershell
   rclone.exe mount s3-connect:<имя_бакета> <буква_диска>: --vfs-cache-mode full
   ```
   
   В проводнике Windows появится новый диск с объектами из бакета.

1. Чтобы отмонтировать бакет, нажмите клавиши **Ctrl** + **C**.

## Настройте службу запуска монтирования {#mount-service}

Чтобы бакет монтировался сразу при запуске компьютера, необходимо настроить запуск монтирования от имени системной службы. 

1. В рабочей директории создайте файл `rclone.xml` со следующим содержимым:
   
   ```xml
   <service>
     <id>rclone</id>
     <name>rclone-s3-disk</name>
     <description>This service maps an S3 bucket as a system drive.</description>
     <executable>"<расположение_рабочей_директории>\rclone.exe"</executable>
     <arguments>mount s3-connect:<имя_бакета> <буква_диска>: --vfs-cache-mode full</arguments>
     <log mode="roll" />
     <onfailure action="restart" />
   </service>
   ```

1. Запустите командную строку от имени администратора и выполните команду:

   ```powershell
   WinSW-x64.exe install .\rclone.xml
   ```

1. Откройте панель управления службами Windows и убедитесь в наличии службы `rclone-s3-disk`:

   1. Нажмите сочетание клавиш **Win**+**R**.
   1. В открывшемся окне введите `services.msc` и нажмите **ОК**.
   1. В списке служб найдите `rclone-s3-disk`.
   
1. Перезагрузите компьютер и проверьте доступность диска.

{% note info %}

Также вы можете настроить запуск службы от имени служебного пользователя (подробнее в разделе [Service account](https://github.com/winsw/winsw/blob/v3/docs/xml-config-file.md#service-account) документации утилиты `WinSW`).

{% endnote %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [удалите объекты](../../storage/operations/objects/delete-all.md) из бакета;
* [удалите бакет](../../storage/operations/buckets/delete.md).
