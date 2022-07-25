# Анализ логов {{ objstorage-short-name }} при помощи {{ datalens-short-name }}

Для бакета {{ objstorage-full-name }} можно включить [логирование действий](../../storage/concepts/server-logs.md). В логах хранится информация по операциям с [бакетом](../../storage/concepts/bucket.md) и [объектами](../../storage/concepts/object.md), которые в нем находятся. Анализ логов бакета может быть полезен, например, если вам нужно выявить причины резкого повышения нагрузки или понять общую картину распределения трафика.

Построить визуализации, необходимые для анализа, можно с помощью сервиса бизнес-аналитики [{{ datalens-full-name }}](../../datalens/index.yaml). Предварительно сохраненные логи необходимо перенести в БД {{ CH }}, которая будет использоваться в качестве источника для {{ datalens-short-name }}.

Чтобы проанализировать логи и представить результаты в виде интерактивных графиков:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бакет для хранения логов](#create-bucket).
1. [Включите экспорт логов](#logs-export).
1. [Подготовьте источник данных](#prepare-origin).
1. [Создайте подключение в {{ datalens-short-name }}](#create-connection).
1. [Создайте датасет в {{ datalens-short-name }}](#create-dataset).
1. [Создайте чарты в {{ datalens-short-name }}](#create-charts).
1. [Создайте дашборд в {{ datalens-short-name }}](#create-dashboard).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" and audience != "internal" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость входят:

* плата за хранение данных в {{ objstorage-short-name }}, операции с ними и исходящий трафик (см. [тарифы {{ objstorage-short-name }}](../../storage/pricing.md));
* плата за постоянно запущенный кластер {{ mch-name }} (см. [тарифы {{ mch-name }}](../../managed-clickhouse/pricing.md)).

{% endif %}

## Создайте бакет для хранения логов {#create-bucket}

Чтобы создать бакет:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
  1. В списке сервисов выберите **{{ objstorage-name }}**.
  1. Нажмите кнопку **Создать бакет**.
  1. Укажите **Имя** бакета: `bucket-logs`.
  1. В полях **Доступ на чтение объектов** и **Доступ к списку объектов** выберите **Публичный**.
  1. Нажмите кнопку **Создать бакет**.
  
- AWS CLI
  
  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).
  1. Создайте бакет `bucket-logs`:
  
     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3 mb s3://bucket-logs
     ```
     
     Результат:
     
     ```
     make_bucket: bucket-logs
     ```
     
  1. Включите публичный доступ к чтению объектов и их списка:
  
     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3api put-bucket-acl \
       --bucket bucket-logs \
       --acl public-read
     ```
  
- {{ TF }}

  1. Добавьте в конфигурационный файл параметры бакета `bucket-logs`:
  
     ```
     resource "yandex_storage_bucket" "bucket-logs" {
       bucket = "bucket-logs"
       acl    = "public-read"
     }
     ```
     
     Подробнее о ресурсе `yandex_storage_bucket` см. в [документации]({{ tf-provider-link }}/storage_bucket) провайдера {{ TF }}.
     
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте бакет.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
     
- API

  Используйте метод REST API [create](../../storage/s3/api-ref/bucket/create.md).
       
{% endlist %}

## Включите экспорт логов {#logs-export}

Чтобы включить экспорт логов в бакет `bucket-logs`:

{% list tabs %}

- AWS CLI

  1. Создайте файл `log-config.json` со следующим содержимым:

     ```json
     {
      "LoggingEnabled": {
         "TargetBucket": "bucket-logs",
         "TargetPrefix": "s3-logs/"
      }
     }
     ```

  1. Выполните команду:
     
     ```
     aws s3api put-bucket-logging \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket <имя целевого бакета> \
       --bucket-logging-status file://log-config.json
     ```

- API

  Используйте метод REST API [putBucketLogging](../../storage/s3/api-ref/bucket/putBucketLogging.md).

{% endlist %}

## Подготовьте источник данных {#prepare-origin}

### Создайте кластер {{ CH }} {#create-ch-cluster}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать кластер.
  1. В списке сервисов выберите **{{ mch-name }}**.
  1. В открывшемся окне нажмите **Создать кластер**.
  1. Укажите настройки кластера {{ CH }}:

     1. В блоке **Базовые параметры**:
        
        * Укажите имя кластера `s3-logs`.
        * Выберите версию 21.3 LTS.

     1. В блоке **Класс хоста** выберите тип виртуальной машины **burstable** и тип хоста **b2.nano**.
     1. В блоке **Размер хранилища** оставьте значение 10 ГБ.
     1. В блоке **База данных** укажите имя БД `s3_data`, имя пользователя `user` и пароль. Запомните имя БД.  
     1. В блоке **Хосты** нажмите значок ![pencil](../../_assets/pencil.svg). Включите опцию **Публичный доступ** и нажмите кнопку **Сохранить**.
     1. В блоке **Дополнительные настройки** включите опции:

        * Доступ из {{ datalens-short-name }}.
        * Доступ из консоли управления.

  1. После всех настроек нажмите кнопку **Создать кластер**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер:

  1. Проверьте, есть ли в каталоге подсети для хостов кластера:

     ```bash
     yc vpc subnet list
     ```

     Если ни одной подсети в каталоге нет, {% if audience != "internal" %}[создайте нужные подсети](../../vpc/operations/subnet-create.md) {% else %}создайте нужные подсети{% endif %} в сервисе {{ vpc-short-name }}.

  1. Укажите параметры кластера в команде создания:

     ```bash
     {{ yc-mdb-ch }} cluster create \
        --name s3-logs \
        --environment production \
        --network-name <имя сети> \
        --host type=clickhouse,zone-id=<зона доступности>,subnet-id=<идентификатор подсети> \
        --clickhouse-resource-preset b2.nano \
        --clickhouse-disk-type {{ disk-type-example }} \
        --clickhouse-disk-size 10 \
        --user name=user,password=<пароль пользователя> \
        --database name=s3_data \
        --datalens-access=true \
        --websql-access=true \
        --version 21.3
     ```

- {{ TF }}

  1. Добавьте в конфигурационный файл описание кластера и его хостов:

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "s3-logs" {
       name                = "s3-logs"
       environment         = "PRODUCTION"
       version             = "21.3"
       network_id          = yandex_vpc_network.<имя сети в {{ TF }}>.id

       clickhouse {
         resources {
           resource_preset_id = "b2.nano"
           disk_type_id       = "{{ disk-type-example }}"
           disk_size          = 10
         }
       }

       database {
         name = "s3_data"
       }

       user {
         name     = "user"
         password = "<пароль>"
         permission {
           database_name = "s3_data"
         }
       }

       host {
         type      = "CLICKHOUSE"
         zone      = "<зона доступности>"
         subnet_id = yandex_vpc_subnet.<имя подсети в {{ TF }}>.id
       }

       access {
         datalens  = true
         web_sql   = true
       }
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mch }}).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте кластер:

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API
  
  Используйте метод REST API [create](../../managed-clickhouse/api-ref/Cluster/create.md).

{% endlist %}

### Измените настройки пользователя {#user-settings}

{% list tabs %}

- Консоль управления

  1. На странице созданного кластера {{ CH }} в меню слева перейдите на вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Настроить**.
  1. Перейдите в раздел **Дополнительные настройки** → **Settings**.
  1. В поле **Date time input format** выберите значение `best_effort`.
  1. Нажмите кнопку **Сохранить**.

{% endlist %}

### Создайте таблицу в БД {#create-table}

{% list tabs %}

- Консоль управления

  1. На странице созданного кластера {{ CH }} в меню слева перейдите на вкладку **SQL**.
  1. Введите имя пользователя БД и пароль.
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
                                    -- * <имя бакета>.storage.yandexcloud.net.
                                    -- * website.yandexcloud.net.
                                    -- * <имя бакета>.website.yandexcloud.net.
     )
     ENGINE = S3(
           'https://{{ s3-storage-host }}/bucket-logs/s3-logs/*',
           'JSONEachRow'
        );
     ```

  1. Нажмите кнопку **Выполнить**.

{% endlist %}

## Создайте подключение в {{ datalens-short-name }} {#create-connection}

{% list tabs %}

- Консоль управления

  1. На странице созданного кластера {{ CH }} в меню слева перейдите на вкладку **{{ datalens-short-name }}**.
  1. В открывшемся окне нажмите кнопку **Создать подключение**.
  1. Заполните настройки подключения:

     1. Добавьте название подключения: `s3-logs-con`.
     1. В поле **Кластер** выберите `s3-logs`.
     1. В поле **Имя хоста** выберите хост {{ CH }} из выпадающего списка. 
     1. Введите имя пользователя БД и пароль.

  1. Нажмите **Проверить подключение**.
  1. После проверки подключения в правом верхнем углу нажмите кнопку **Создать**.

{% endlist %}

## Создайте датасет в {{ datalens-short-name }} {#create-dataset}

1. Во всплывающем окне в правом нижнем углу нажмите кнопку **Создать датасет**.
1. В созданном датасете перенесите таблицу `s3_data.s3logs` на рабочую область.
1. Перейдите на вкладку **Поля**.
1. Нажмите кнопку ![image](../../_assets/plus-sign.svg)**Добавить поле**.
1. Создайте расчетное поле с типом файла:
   
   * Название поля — `object_type`.
   * Формула — `SPLIT([object_key], '.', -1)`.

1. Нажмите кнопку **Создать**.
1. В правом верхнем углу нажмите кнопку **Сохранить**.
1. Введите имя датасета `s3-dataset` и нажмите **Создать**.
1. После сохранения датасета в правом верхнем углу нажмите **Создать чарт**.

## Создайте чарты в {{ datalens-short-name }} {#create-charts}

### Создайте первый чарт {#create-pie-chart}

Чтобы визуализировать количество запросов к бакету разными методами, создайте чарт — круговую диаграмму:

1. Выберите тип визуализации **Круговая диаграмма**.
1. Перетащите поле `method` из раздела **Измерения** в секцию **Цвет**.
1. Перетащите поле `request_id` из раздела **Измерения** в секцию **Показатели**.
1. В правом верхнем углу нажмите **Сохранить**.
1. В открывшемся окне введите название чарта `S3 - Method pie` и нажмите **Сохранить**.

### Создайте второй чарт {#create-column-chart}

Чтобы визуализировать соотношение количества запросов по типу объекта, создайте чарт — столбчатую диаграмму:

1. Скопируйте чарт, получившийся на предыдущем шаге:

   1. В правом верхнем углу нажмите значок галочки рядом с кнопкой **Сохранить**.
   1. Нажмите **Сохранить как**.
   1. В открывшемся окне введите название нового чарта `S3 - Object type bars` и нажмите кнопку **Сохранить**.

1. Выберите тип визуализации **Столбчатая диаграмма**. Поля `method` и `request_id` автоматически попадут в секции **X** и **Y** соответственно.
1. Удалите поле `method` из секции **X** и перетащите туда поле `object_type`.
1. В правом верхнем углу нажмите **Сохранить**.

### Создайте третий чарт {#create-column-chart-2}

Чтобы визуализировать распределение исходящего трафика по дням, создайте чарт — столбчатую диаграмму:

1. Скопируйте чарт, получившийся на предыдущем шаге:

   1. В правом верхнем углу нажмите значок галочки рядом с кнопкой **Сохранить**.
   1. Нажмите **Сохранить как**.
   1. В открывшемся окне введите название нового чарта `S3 - Traffic generated by days` и нажмите кнопку **Сохранить**.

1. Перетащите поле `object_type` из секции **X** в секцию **Фильтры**.
1. В открывшемся окне выберите типы объектов, которые нужно отобразить на диаграмме, и нажмите кнопку **Применить фильтр**.
1. Перетащите поле `timestamp` из раздела **Измерения** в секцию **X**.
1. Удалите поле `request_id` из секции **Y** и перетащите туда поле `bytes_send`.
1. В правом верхнем углу нажмите **Сохранить**.

## Создайте дашборд в {{ datalens-short-name }} и добавьте на него чарты {#create-dashboard}

Создайте дашборд, на котором будут размещены чарты:

1. Перейдите на [главную страницу]{% if lang == "ru" %}(https://datalens.yandex.ru){% endif %}{% if lang == "en" %}(https://datalens.yandex.com){% endif %} {{ datalens-short-name }}.
1. Нажмите кнопку **Создать дашборд**.
1. Введите название дашборда `S3 Logs Analysis` и нажмите кнопку **Создать**.
1. В правом верхнем углу нажмите кнопку **Добавить** и выберите **Чарт**.
1. В поле **Чарт** нажмите **Выбрать** и выберите из списка чарт `S3 - Method pie`.
1. Нажмите кнопку **Добавить**. Чарт появится на дашборде.
1. Повторите предыдущие шаги для чартов `S3 - Object type bars` и `S3 - Traffic generated by days`.

## Как удалить созданные ресурсы {#clear-out}

Если вам больше не нужны созданные ресурсы, удалите [бакет](../../storage/operations/buckets/delete.md) `bucket-logs` и [кластер](../../managed-clickhouse/operations/cluster-delete.md) `s3-logs`.
