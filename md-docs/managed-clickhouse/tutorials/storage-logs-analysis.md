# Анализ логов Object Storage при помощи DataLens


Для бакета Yandex Object Storage можно включить [логирование действий](../../storage/concepts/server-logs.md). В логах хранится информация по операциям с [бакетом](../../storage/concepts/bucket.md) и [объектами](../../storage/concepts/object.md), которые в нем находятся. Анализ логов бакета может быть полезен, например, если вам нужно выявить причины резкого повышения нагрузки или понять общую картину распределения трафика.

Построить визуализации, необходимые для анализа, можно с помощью сервиса бизнес-аналитики [Yandex DataLens](../../datalens/index.md). Предварительно сохраненные логи необходимо перенести в БД ClickHouse®, которая будет использоваться в качестве источника для DataLens.

Чтобы проанализировать логи и представить результаты в виде интерактивных графиков:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бакет для хранения логов](#create-bucket).
1. [Включите экспорт логов](#logs-export).
1. [Подготовьте источник данных](#prepare-origin).
1. [Создайте подключение в DataLens](#create-connection).
1. [Создайте датасет в DataLens](#create-dataset).
1. [Создайте чарты в DataLens](#create-charts).
1. [Создайте дашборд в DataLens](#create-dashboard).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость входят:

* плата за хранение данных в Object Storage, операции с ними и исходящий трафик ([тарифы Object Storage](../../storage/pricing.md));
* плата за постоянно запущенный кластер Managed Service for ClickHouse® ([тарифы Managed Service for ClickHouse®](../pricing.md)).


## Создайте бакет для хранения логов {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать бакет.
  1. Перейдите в сервис **Object Storage**.
  1. Нажмите кнопку **Создать бакет**.
  1. В поле **Имя** укажите имя бакета.
  1. В полях **Чтение объектов** и **Чтение списка объектов** выберите **С авторизацией**.
  1. Нажмите кнопку **Создать бакет**.

- AWS CLI {#cli}
  
  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).
  1. Создайте бакет:
  
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
  
  Если вы работаете с Object Storage через Terraform от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../storage/security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

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

  1. Добавьте в конфигурационный файл параметры бакета:
  
     ```hcl
     resource "yandex_storage_bucket" "bucket-logs" {
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
       bucket     = "<имя_бакета>"
     }
     ```

     Подробнее о ресурсе смотрите `yandex_storage_bucket` в [документации](../../terraform/resources/storage_bucket.md) провайдера Terraform.
     
  1. Проверьте корректность настроек.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Создайте бакет.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.


- API {#api}

  Используйте метод REST API [create](../../storage/s3/api-ref/bucket/create.md).
       
{% endlist %}

## Включите экспорт логов {#logs-export}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите бакет, логи которого хотите записывать.
  1. На панели слева выберите **Настройки**.
  1. Откройте вкладку **Логирование**.  
  1. Включите опцию **Запись логов**.
  1. Выберите **Бакет для хранения логов**.
  1. В поле **Префикс** укажите префикс `s3-logs/`.
  1. Нажмите кнопку **Сохранить**.

- AWS CLI {#cli}

  1. Создайте файл `log-config.json` со следующим содержимым:

     ```json
     {
      "LoggingEnabled": {
         "TargetBucket": "<имя_бакета>",
         "TargetPrefix": "s3-logs/"
      }
     }
     ```

  1. Выполните команду:
     
     ```bash
     aws s3api put-bucket-logging \
       --endpoint-url https://storage.yandexcloud.net \
       --bucket <имя_бакета> \
       --bucket-logging-status file://log-config.json
     ```

     Где `--bucket` — имя бакета, для которого надо включить логирование действий.


- Terraform {#tf}
  
  Чтобы включить механизм логирования в бакете, который вы хотите отслеживать:

     1. Откройте файл конфигурации Terraform и добавьте блок `logging` во фрагмент с описанием бакета.

        ```hcl
        resource "yandex_storage_bucket" "bucket-logs" {
          access_key = "<идентификатор_статического_ключа>"
          secret_key = "<секретный_ключ>"
          bucket     = "<имя_бакета_для_хранения_логов>"
        }

        resource "yandex_storage_bucket" "bucket" {
          access_key = "<идентификатор_статического_ключа>"
          secret_key = "<секретный_ключ>"
          bucket     = "<имя_исходного_бакета>"
          acl        = "private"

          logging {
            target_bucket = yandex_storage_bucket.bucket-logs.id
            target_prefix = "s3-logs/"
          }
        }
        ```

        Где:
        * `access_key` — идентификатор статического ключа доступа.
        * `secret_key` — значение секретного ключа доступа.
        * `target_bucket` — указание на бакет для хранения логов.
        * `target_prefix` — [префикс ключа](../../storage/concepts/server-logs.md#key-prefix) для объектов с логами.

        Подробнее о параметрах ресурса `yandex_storage_bucket` в Terraform смотрите в [документации провайдера](../../terraform/resources/storage_bucket.md#enable-logging).

        1. В терминале перейдите в директорию с конфигурационным файлом.
        1. Проверьте корректность конфигурации с помощью команды:
        
           ```bash
           terraform validate
           ```
        
           Если конфигурация является корректной, появится сообщение:
        
           ```bash
           Success! The configuration is valid.
           ```
        
        1. Выполните команду:
        
           ```bash
           terraform plan
           ```
        
           В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
        1. Примените изменения конфигурации:
        
           ```bash
           terraform apply
           ```
        
        1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).


- API {#api}

  Используйте метод REST API [putBucketLogging](../../storage/s3/api-ref/bucket/putBucketLogging.md).

{% endlist %}

## Подготовьте источник данных {#prepare-origin}

### Создайте кластер ClickHouse® {#create-ch-cluster}


Для создания кластера Managed Service for ClickHouse® нужна роль [vpc.user](../../vpc/security/index.md#vpc-user) и роль [managed-clickhouse.editor или выше](../security.md#roles-list). О том, как назначить роль, смотрите в [документации Identity and Access Management](../../iam/operations/roles/grant.md).


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать кластер.
  1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
  1. В открывшемся окне нажмите **Создать кластер**.
  1. Укажите настройки кластера ClickHouse®:

     1. В блоке **Базовые параметры** в поле **Имя кластера** укажите `s3-logs`.

     1. В блоке **Ресурсы** в поле **Тип** выберите `burstable`.

     
     1. В блоке **Хосты** нажмите ![image](../../_assets/console-icons/pencil.svg) и включите опцию **Публичный доступ**. Нажмите кнопку **Сохранить**.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}


     1. В блоке **Настройки СУБД**:

        * В поле **Управление пользователями через SQL** выберите `Выключено`.
        * В поле **Имя пользователя** укажите `user`.
        * В поле **Пароль** укажите пароль.
        * В поле **Имя БД** укажите `s3_data`.

        Запомните имя БД.

     1. В блоке **Сервисные настройки** включите опции:

        * **Доступ из DataLens**.
        * **Доступ из консоли управления**.

  1. Нажмите кнопку **Создать кластер**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  
  Чтобы создать кластер:

  1. Проверьте, есть ли в каталоге подсети для хостов кластера:

     ```bash
     yc vpc subnet list
     ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе VPC.

  1. Укажите параметры кластера в команде создания:

     ```bash
     yc managed-clickhouse cluster create \
        --name s3-logs \
        --environment production \
        --network-name <имя_сети> \
        --host type=clickhouse,zone-id=<зона_доступности>,subnet-id=<идентификатор_подсети> \
        --clickhouse-resource-preset b2.medium \
        --clickhouse-disk-type network-ssd \
        --clickhouse-disk-size 10 \
        --user name=user,password=<пароль_пользователя> \
        --database name=s3_data \
        --datalens-access=true \
        --websql-access=true
     ```



- Terraform {#tf}

  1. Добавьте в конфигурационный файл описание кластера, базы данных и пользователя:

     ```hcl
     resource "yandex_mdb_clickhouse_cluster_v2" "s3-logs" {
       name                = "s3-logs"
       environment         = "PRODUCTION"
       network_id          = yandex_vpc_network.<имя_сети_в_Terraform>.id

       clickhouse = {
         resources = {
           resource_preset_id = "b2.medium"
           disk_type_id       = "network-ssd"
           disk_size          = 10
         }
       }

       hosts = {
         "ch-host1" = {
           type       = "CLICKHOUSE"
           zone       = "<зона_доступности>"
           subnet_id  = yandex_vpc_subnet.<имя_подсети_в_Terraform>.id
           shard_name = "shard1"
         }
       }

       shards = {
         "shard1" = {}
       }

       access = {
         data_lens  = true
         web_sql    = true
       }

       maintenance_window {
         type = "ANYTIME"
       }
     }

     resource "yandex_mdb_clickhouse_database" "s3-data" {
       cluster_id = yandex_mdb_clickhouse_cluster_v2.s3-logs.id
       name       = "s3_data"
     }

     resource "yandex_mdb_clickhouse_user" "user1" {
       cluster_id = yandex_mdb_clickhouse_cluster_v2.s3-logs.id
       name       = "user"
       password   = "<пароль>"
       permission {
         database_name = yandex_mdb_clickhouse_database.s3-data.name
       }
     }
     ```

     Подробнее о ресурсах, которые вы можете создать с помощью Terraform, смотрите в [документации провайдера](../../terraform/resources/mdb_clickhouse_cluster.md).

  1. Проверьте корректность настроек.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Создайте кластер:

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.


- API {#api}
  
  Используйте метод REST API [create](../api-ref/Cluster/create.md).

{% endlist %}

После создания кластера вы автоматически будете перенаправлены на страницу **Кластеры**.

Дождитесь пока статус кластера изменится на `Alive`.

### Измените настройки пользователя {#user-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите кластер `s3-logs`.
  1. Перейдите на вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Настроить**.
  1. Нажмите кнопку **Дополнительные настройки** → **Settings**.
  1. В поле **Date time input format** выберите `best_effort`.
  1. Нажмите кнопку **Сохранить**.

{% endlist %}


### Создайте статический ключ {#create-static-key}

Для создания таблицы с доступом к Object Storage вам понадобится статический ключ. [Создайте его](../../iam/operations/authentication/manage-access-keys.md#create-access-key) и сохраните идентификатор и секретную часть ключа.


### Создайте таблицу в БД {#create-table}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите кластер `s3-logs`.
  1. Перейдите на вкладку **SQL**.
  1. В поле **Пароль** введите пароль.
  1. Нажмите кнопку **Подключиться**.
  1. В окне справа напишите SQL-запрос:

     ```sql
     CREATE TABLE s3_data.s3logs
     (
        bucket String,              -- Имя бакета.
        bytes_received Int64,       -- Размер запроса в байтах.
        bytes_send Int64,           -- Размер ответа в байтах.
        handler String,             -- Метод запроса в формате REST.<HTTP-метод>.<субъект>.
        http_referer String,        -- URL-адрес источника запроса.
        ip String,                  -- IP-адрес пользователя.
        method String,              -- Метод HTTP-запроса.
        object_key String,          -- Ключ объекта, закодированный методом URL-кодировки.
        protocol String,            -- Версия протокола передачи данных.
        range String,               -- HTTP-заголовок, который определяет диапазон байт для загрузки из объекта.
        requester String,           -- Идентификатор пользователя.
        request_args String,        -- Аргументы URL-запроса.
        request_id String,          -- Идентификатор запроса.
        request_path String,        -- Полный путь запроса.
        request_time Int64,         -- Время обработки запроса, в миллисекундах.
        scheme String,              -- Тип протокола передачи данных.
                                    -- Возможные значения:
                                    -- * http — протокол прикладного уровня передачи данных.
                                    -- * https — протокол прикладного уровня передачи данных с поддержкой шифрования.
        ssl_protocol String,        -- Протокол обеспечения безопасности.
        status Int64,               -- HTTP-код ответа.
        storage_class String,       -- Класс хранилища объекта.
        timestamp DateTime,         -- Дата и время операции с бакетом, в формате ГГГГ-ММ-ДДTЧЧ:ММ:ССZ.
        user_agent String,          -- Клиентское приложение (User Agent), которое выполнило запрос.
        version_id String,          -- Версия объекта.
        vhost String                -- Виртуальный хост запроса.
                                    -- Возможные значения:
                                    -- * storage.yandexcloud.net.
                                    -- * <имя_бакета>.storage.yandexcloud.net.
                                    -- * website.yandexcloud.net.
                                    -- * <имя_бакета>.website.yandexcloud.net.
     )
     ENGINE = S3(
           'https://storage.yandexcloud.net/<имя_бакета>/s3-logs/*',
           '<идентификатор_ключа>',
           '<секретный_ключ>',
           'JSONEachRow'
        )
     SETTINGS date_time_input_format='best_effort';
     ```

  1. Нажмите кнопку **Выполнить**.

{% endlist %}

## Создайте подключение в DataLens {#create-connection}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите кластер `s3-logs`.
  1. Перейдите на вкладку **DataLens**.
  1. В открывшемся окне нажмите **Создать подключение**.
  1. Заполните настройки подключения:

     1. Добавьте название подключения: `s3-logs-con`.
     1. В поле **Кластер** выберите `s3-logs`.
     1. В поле **Имя хоста** выберите хост ClickHouse® из выпадающего списка. 
     1. Введите имя пользователя БД и пароль.

  1. Нажмите кнопку **Подтвердить подключение**.
  1. После проверки подключения нажмите **Создать подключение**.
  1. В открывшемся окне введите имя подключения и нажмите кнопку **Создать**.

{% endlist %}

## Создайте датасет в DataLens {#create-dataset}

1. Нажмите кнопку **Создать датасет**.
1. В созданном датасете перенесите таблицу `s3_data.s3logs` на рабочую область.
1. Перейдите на вкладку **Поля**.
1. Нажмите значок ![image](../../_assets/console-icons/plus.svg)**Добавить поле**.
1. Создайте расчетное поле с типом файла:
   
   * Название поля — `object_type`.
   * Формула — `SPLIT([object_key], '.', -1)`.

1. Нажмите кнопку **Создать**.
1. В правом верхнем углу нажмите **Сохранить**.
1. Введите имя датасета `s3-dataset` и нажмите **Создать**.
1. После сохранения датасета в правом верхнем углу нажмите **Создать чарт**.

## Создайте чарты в DataLens {#create-charts}

### Создайте первый чарт {#create-pie-chart}

Чтобы визуализировать количество запросов к бакету разными методами, создайте чарт — круговую диаграмму:

1. Выберите тип визуализации `Круговая диаграмма`.
1. Перетащите поле `method` из раздела **Измерения** в секцию **Цвет**.
1. Перетащите поле `request_id` из раздела **Измерения** в секцию **Показатели**.
1. В правом верхнем углу нажмите **Сохранить**.
1. В открывшемся окне введите название чарта `S3 - Method pie` и нажмите **Сохранить**.

### Создайте второй чарт {#create-column-chart}

Чтобы визуализировать соотношение количества запросов по типу объекта, создайте чарт — столбчатую диаграмму:

1. Скопируйте чарт, получившийся на предыдущем шаге:

   1. В правом верхнем углу нажмите галочку рядом с кнопкой **Сохранить**.
   1. Нажмите кнопку **Сохранить как**.
   1. В открывшемся окне введите название нового чарта `S3 - Object type bars` и нажмите кнопку **Сохранить**.

1. Выберите тип визуализации **Столбчатая диаграмма**. Поля `method` и `request_id` автоматически попадут в секции **X** и **Y** соответственно.
1. Удалите поле `method` из секции **X** и перетащите туда поле `object_type`.
1. В правом верхнем углу нажмите **Сохранить**.

### Создайте третий чарт {#create-column-chart-2}

Чтобы визуализировать распределение исходящего трафика по дням, создайте чарт — столбчатую диаграмму:

1. Скопируйте чарт, получившийся на предыдущем шаге:

   1. В правом верхнем углу нажмите галочку рядом с кнопкой **Сохранить**.
   1. Нажмите кнопку **Сохранить как**.
   1. В открывшемся окне введите название нового чарта `S3 - Traffic generated by days` и нажмите кнопку **Сохранить**.

1. Перетащите поле `object_type` из секции **X** в секцию **Фильтры**.
1. В открывшемся окне выберите типы объектов, которые нужно отобразить на диаграмме, и нажмите **Применить фильтры**.
1. Перетащите поле `timestamp` из раздела **Измерения** в секцию **X**.
1. Удалите поле `request_id` из секции **Y** и перетащите туда поле `bytes_send`.
1. В правом верхнем углу нажмите **Сохранить**.

## Создайте дашборд в DataLens и добавьте на него чарты {#create-dashboard}

1. На панели слева нажмите ![image](../../_assets/console-icons/layout-cells-large.svg) **Дашборды**.
1. Нажмите кнопку **Создать дашборд**.
1. Введите название дашборда `S3 Logs Analysis` и нажмите **Создать**.
1. В правом верхнем углу нажмите **Добавить** и выберите `Чарт`.
1. В поле **Чарт** нажмите **Выбрать** и выберите из списка чарт `S3 - Method pie`.
1. Нажмите кнопку **Добавить**. Чарт появится на дашборде.
1. Повторите предыдущие шаги для чартов `S3 - Object type bars` и `S3 - Traffic generated by days`.

## Как удалить созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

* [Удалите бакет](../../storage/operations/buckets/delete.md).
* [Удалите кластер](../operations/cluster-delete.md) `s3-logs`.

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._