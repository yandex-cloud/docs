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

{% if audience != "internal" %}

{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки бакета входит:

* плата за хранение данных в бакете (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-storage));
* плата за операции с данными (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-operations)).

{% endif %}

{% endif %}

## Подготовьте рабочее окружение {#environment-prepare}

1. Скачайте и установите [дистрибутив winfsp](https://winfsp.dev/rel/) с сайта производителя.
1. Скачайте с сайта производителя [архив с утилитами sysinternals suite](https://docs.microsoft.com/en-us/sysinternals/downloads/) и распакуйте его в свою рабочую директорию на локальном компьютере.
1. Скачайте с сайта производителя [архив с утилитой Windows Service Wrapper (winsw)](https://github.com/winsw/winsw/releases) и распакуйте его в свою рабочую директорию на локальном компьютере.
1. Скачайте с сайта производителя [архив с утилитой rclone](https://rclone.org/downloads/) и распакуйте его в свою рабочую директорию на локальном компьютере.

## Создайте сервисный аккаунт {#create-sa}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
  1. Выберите вкладку **Сервисные аккаунты**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта: `sa-win-disk-connect`.
  1. Нажмите ![](../../_assets/plus-sign.svg) **Добавить роль** и выберите роль `storage.editor`.
  1. Нажмите кнопку **Создать**.

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

  Чтобы создать сервисный аккаунт, воспользуйтесь методом {% if audience != "internal" %}[create](../../iam/api-ref/ServiceAccount/create.md){% else %}create{% endif %} для ресурса {% if audience != "internal" %}[ServiceAccount](../../iam/api-ref/ServiceAccount/index.md){% else %}ServiceAccount{% endif %}.

{% endlist %}

## Создайте статический ключ доступа {#create-static-key}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. Перейдите на вкладку **Сервисные аккаунты**.
  1. Выберите сервисный аккаунт `sa-win-disk-connect` и нажмите на строку с его именем.
  1. Нажмите кнопку ![](../../_assets/plus-sign.svg) **Создать новый ключ** на верхней панели.
  1. Выберите **Создать статический ключ доступа**.
  1. Задайте описание ключа и нажмите кнопку **Создать**.
  1. Сохраните идентификатор и секретный ключ. После закрытия диалога значение ключа будет недоступно.

- CLI

  1. Создайте ключ доступа для сервисного аккаунта `sa-win-disk-connect`:

     ```bash
     yc iam access-key create --service-account-name sa-win-disk-connect
     ```

     Результат:

     ```
     access_key:
       id: aje6t3vsbj8lp9r4vk2u
       service_account_id: ajepg0mjt06siuj65usm
       created_at: "2022-07-18T14:37:51Z"
       key_id: 0n8X6WY6S24N7Oj*****
     secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI9hx*****
     ```

     Подробнее о команде `yc iam access-key create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/iam/access-key/create.md).

  1. Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.

- API

  Чтобы создать ключ доступа, воспользуйтесь методом {% if audience != "internal" %}[create](../../iam/api-ref/AccessKey/create.md){% else %}create{% endif %} для ресурса {% if audience != "internal" %}[AccessKey](../../iam/api-ref/AccessKey/index.md){% else %}AccessKey{% endif %}.

{% endlist %}

## Создайте бакет {#bucket-create}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
  1. В списке сервисов выберите **{{ objstorage-name }}**.
  1. Нажмите кнопку **Создать бакет**.
  1. Укажите **Имя** бакета: `bucket-for-win`.
  1. В полях **Доступ на чтение объектов** и **Доступ к списку объектов** выберите **Публичный**.
  1. Нажмите кнопку **Создать бакет**.
  
- AWS CLI
  
  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).
  1. Создайте бакет `bucket-for-win`:
  
     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3 mb s3://bucket-for-win
     ```
     
     Результат:
     
     ```
     make_bucket: bucket-for-win
     ```
     
  1. Включите публичный доступ к чтению объектов и их списка:
  
     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3api put-bucket-acl \
       --bucket bucket-for-win \
       --acl public-read
     ```
  
- {{ TF }}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Добавьте в конфигурационный файл параметры бакета `bucket-for-win`:
  
     ```
     resource "yandex_storage_bucket" "bucket-for-win" {
       bucket = "bucket-for-win"
       acl    = "public-read"
     }
     ```
     
     Подробнее о ресурсе `yandex_storage_bucket` см. в [документации]({{ tf-provider-link }}/storage_bucket) провайдера {{ TF }}.
     
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

  Используйте метод REST API [create](../../storage/s3/api-ref/bucket/create.md).
       
{% endlist %}

## Настройте подключение к {{ objstorage-name }} {#rclone-config}

1. В рабочей директории запустите командную строку и выполните команду:

   ```powershell
   psexec -i -s cmd.exe
   ```

1. В открывшейся консоли выполните команду `whoami` и убедитесь, что сессия запущена от имени системного пользователя.
1. Запустите конфигурацию утилиты `rclone`:

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

1. Проверьте подключение к бакету. В той же командной строке, где выполнялась настройка подключения, выполните команду:

   ```powershell
   rclone.exe ls s3-connect:bucket-for-win
   ```

   Если конфигурация настроена правильно, в консоль будет выведен список объектов бакета.

1. Смонтируйте бакет в файловую систему:

   ```powershell
   rclone.exe mount s3-connect:bucket-for-win <буква диска>: --vfs-cache-mode full
   ```
   
   В проводнике Windows появится новый диск с объектами из бакета.

1. Отмонтируйте бакет:

   ```powershell
   rclone.exe unmount s3-connect:bucket-for-win
   ```

## Настройте службу запуска монтирования {#mount-service}

Чтобы бакет монтировался сразу при запуске компьютера, необходимо настроить запуск монтирования от имени системной службы. 

1. В рабочей директории создайте файл `rclone.xml` со следующим содержимым:
   
   ```xml
   `<service>`
   `<id>rclone</id>`
   `<name>rclone-s3-disk</name>`
   `<description>This service maps an S3 bucket as a system drive.</description>`
   `<executable>"<расположение рабочей директории>\rclone.exe"</executable>`
   `<arguments>mount s3-connect:bucket-for-win <буква диска>: --vfs-cache-mode full</arguments>`
   `<log mode="roll" />`
   `<onfailure action="restart" />`
   `</service>`
   ```

1. Запустите командную строку от имени администратора и выполните команду:

   ```powershell
   WinSW-x64.exe install .\\rclone.xml
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

* [удалите объекты](../../storage/operations/objects/delete-all.md) из бакета `bucket-for-win`;
* [удалите бакет](../../storage/operations/buckets/delete.md) `bucket-for-win`.
