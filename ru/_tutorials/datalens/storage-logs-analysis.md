# Анализ логов {{ objstorage-short-name }} при помощи {{ datalens-short-name }}

Для бакета {{ objstorage-full-name }} можно включить [логирование действий](../../storage/concepts/server-logs.md). В логах хранится информация по операциям с [бакетом](../../storage/concepts/bucket.md) и [объектами](../../storage/concepts/object.md), которые в нем находятся. Анализ логов бакета может быть полезен, например, если вам нужно выявить причины резкого повышения нагрузки или понять общую картину распределения трафика.

Построить визуализации, необходимые для анализа, можно с помощью сервиса бизнес-аналитики [{{ datalens-full-name }}](../../datalens/). Предварительно сохраненные логи необходимо перенести в БД {{ CH }}, которая будет использоваться в качестве источника для {{ datalens-short-name }}.

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


### Необходимые платные ресурсы {#paid-resources}

В стоимость входят:

* плата за хранение данных в {{ objstorage-short-name }}, операции с ними и исходящий трафик (см. [тарифы {{ objstorage-short-name }}](../../storage/pricing.md));
* плата за постоянно запущенный кластер {{ mch-name }} (см. [тарифы {{ mch-name }}](../../managed-clickhouse/pricing.md)).


## Создайте бакет для хранения логов {#create-bucket}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета.
  1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** выберите **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
  
- AWS CLI
  
  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).
  1. Создайте бакет:
  
     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3 mb s3://<имя_бакета>
     ```
     
     Результат:
     
     ```
     make_bucket: <имя_бакета>
     ```
  
- {{ TF }}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Добавьте в конфигурационный файл параметры бакета:
  
     ```
     resource "yandex_storage_bucket" "bucket-logs" {
       bucket = "<имя_бакета>"
     }
     ```
     
     Подробнее о ресурсе `yandex_storage_bucket` см. в [документации]({{ tf-provider-resources-link }}/storage_bucket) провайдера {{ TF }}.
     
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте бакет.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
     
- API

  Используйте метод REST API [create](../../storage/s3/api-ref/bucket/create.md).
       
{% endlist %}

## Включите экспорт логов {#logs-export}

{% list tabs %}

- AWS CLI

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
     
     ```
     aws s3api put-bucket-logging \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket <имя бакета, для которого надо включить логирование действий> \
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
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Укажите настройки кластера {{ CH }}:

     1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** в поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}** укажите `s3-logs`.

     1. В блоке **{{ ui-key.yacloud.mdb.forms.new_section_resource }}** в поле **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** выберите **burstable**.

     1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** нажмите ![image](../../_assets/edit.svg) и включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**. Нажмите кнопку **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

     1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}**:

        * В поле **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** выберите **Выключено**.
        * В поле **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** укажите `user`.
        * В поле **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** укажите пароль.
        * В поле **{{ ui-key.yacloud.mdb.forms.database_field_name }}** укажите `s3_data`.

        Запомните имя БД.

     1. В блоке **{{ ui-key.yacloud.mdb.forms.section_service-settings }}** включите опции:

        * **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}**.
        * **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер:

  1. Проверьте, есть ли в каталоге подсети для хостов кластера:

     ```bash
     yc vpc subnet list
     ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.

  1. Укажите параметры кластера в команде создания:

     ```bash
     {{ yc-mdb-ch }} cluster create \
        --name s3-logs \
        --environment production \
        --network-name <имя сети> \
        --host type=clickhouse,zone-id=<зона доступности>,subnet-id=<идентификатор подсети> \
        --clickhouse-resource-preset b2.medium \
        --clickhouse-disk-type {{ disk-type-example }} \
        --clickhouse-disk-size 10 \
        --user name=user,password=<пароль пользователя> \
        --database name=s3_data \
        --datalens-access=true \
        --websql-access=true
     ```

- {{ TF }}

  1. Добавьте в конфигурационный файл описание кластера и его хостов:

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "s3-logs" {
       name                = "s3-logs"
       environment         = "PRODUCTION"
       network_id          = yandex_vpc_network.<имя сети в {{ TF }}>.id

       clickhouse {
         resources {
           resource_preset_id = "b2.medium"
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

После создания кластера вы автоматически будете перенаправлены на страницу **{{ ui-key.yacloud.clickhouse.switch_list }}**.

Дождитесь пока статус кластера изменится на `Alive`.

### Измените настройки пользователя {#user-settings}

{% list tabs %}

- Консоль управления

  1. Выберите кластер `s3-logs`.
  1. Перейдите на вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.button_advanced-settings }}** → **Settings**.
  1. В поле **Date time input format** выберите `best_effort`.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-button_save }}**.

{% endlist %}

### Создайте статический ключ {#create-static-key}

Для создания таблицы с доступом к {{ objstorage-name }} вам понадобится статический ключ. [Создайте его](../../iam/operations/sa/create-access-key.md) и сохраните идентификатор и секретную часть ключа.

### Создайте таблицу в БД {#create-table}

{% list tabs %}

- Консоль управления

  1. Выберите кластер `s3-logs`.
  1. Перейдите на вкладку **{{ ui-key.yacloud.mysql.cluster.switch_explore }}**.
  1. В поле **{{ ui-key.yacloud.clickhouse.cluster.explore.label_password }}** введите пароль.
  1. Нажмите кнопку **{{ ui-key.yacloud.clickhouse.cluster.explore.button_submit-creds }}**.
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
                                    -- * {{ s3-storage-host }}.
                                    -- * <имя бакета>.{{ s3-storage-host }}.
                                    -- * {{ s3-web-host }}.
                                    -- * <имя бакета>.{{ s3-web-host }}.
     )
     ENGINE = S3(
           'https://{{ s3-storage-host }}/<имя_бакета>/s3-logs/*',
           '<идентификатор ключа>',
           '<секретный ключ>',
           'JSONEachRow'
        )
     SETTINGS date_time_input_format='best_effort';
     ```

  1. Нажмите кнопку **{{ ui-key.yacloud.clickhouse.cluster.explore.button_execute }}**.

{% endlist %}

## Создайте подключение в {{ datalens-short-name }} {#create-connection}

{% list tabs %}

- Консоль управления

  1. Выберите кластер `s3-logs`.
  1. Перейдите на вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_datalens }}**.
  1. В открывшемся окне нажмите **{{ ui-key.datalens.connections.form.button_add-connection }}**.
  1. Заполните настройки подключения:

     1. Добавьте название подключения: `s3-logs-con`.
     1. В поле **{{ ui-key.datalens.connections.form.field_cluster }}** выберите `s3-logs`.
     1. В поле **{{ ui-key.datalens.connections.form.field_host-name }}** выберите хост {{ CH }} из выпадающего списка. 
     1. Введите имя пользователя БД и пароль.

  1. Нажмите кнопку **{{ ui-key.datalens.connections.form.button_verify }}**.
  1. После проверки подключения нажмите **{{ ui-key.datalens.connections.form.button_create-connection }}**.
  1. В открывшемся окне введите имя подключения и нажмите кнопку **{{ ui-key.datalens.connections.form.button_create }}**.

{% endlist %}

## Создайте датасет в {{ datalens-short-name }} {#create-dataset}

1. Нажмите кнопку **{{ ui-key.datalens.connections.form.button_create-dataset }}**.
1. В созданном датасете перенесите таблицу `s3_data.s3logs` на рабочую область.
1. Перейдите на вкладку **{{ ui-key.datalens.dataset.dataset-editor.modify.value_dataset }}**.
1. Нажмите значок ![image](../../_assets/plus-sign.svg)**{{ ui-key.datalens.dataset.dataset-editor.modify.button_add-field }}**.
1. Создайте расчетное поле с типом файла:
   
   * Название поля — `object_type`.
   * Формула — `SPLIT([object_key], '.', -1)`.

1. Нажмите кнопку **{{ ui-key.datalens.component.dl-field-editor.view.button_create }}**.
1. В правом верхнем углу нажмите **{{ ui-key.datalens.dataset.dataset-editor.modify.button_save }}**.
1. Введите имя датасета `s3-dataset` и нажмите **{{ ui-key.datalens.dataset.dataset-editor.modify.button_create }}**.
1. После сохранения датасета в правом верхнем углу нажмите **{{ ui-key.datalens.dataset.dataset-editor.modify.button_create-widget }}**.

## Создайте чарты в {{ datalens-short-name }} {#create-charts}

### Создайте первый чарт {#create-pie-chart}

Чтобы визуализировать количество запросов к бакету разными методами, создайте чарт — круговую диаграмму:

1. Выберите тип визуализации **{{ ui-key.datalens.wizard.label_visualization-pie }}**.
1. Перетащите поле `method` из раздела **{{ ui-key.datalens.wizard.section_dimensions }}** в секцию **{{ ui-key.datalens.wizard.section_color }}**.
1. Перетащите поле `request_id` из раздела **{{ ui-key.datalens.wizard.section_dimensions }}** в секцию **{{ ui-key.datalens.wizard.section_measures }}**.
1. В правом верхнем углу нажмите **{{ ui-key.datalens.wizard.button_save }}**.
1. В открывшемся окне введите название чарта `S3 - Method pie` и нажмите **{{ ui-key.datalens.component.chartkit-alerts.view.button_save }}**.

### Создайте второй чарт {#create-column-chart}

Чтобы визуализировать соотношение количества запросов по типу объекта, создайте чарт — столбчатую диаграмму:

1. Скопируйте чарт, получившийся на предыдущем шаге:

   1. В правом верхнем углу нажмите галочку рядом с кнопкой **{{ ui-key.datalens.wizard.button_save }}**.
   1. Нажмите кнопку **{{ ui-key.datalens.wizard.button_save-as }}**.
   1. В открывшемся окне введите название нового чарта `S3 - Object type bars` и нажмите кнопку **{{ ui-key.datalens.component.chartkit-alerts.view.button_save }}**.

1. Выберите тип визуализации **{{ ui-key.datalens.wizard.label_visualization-column }}**. Поля `method` и `request_id` автоматически попадут в секции **{{ ui-key.datalens.wizard.section_x }}** и **{{ ui-key.datalens.wizard.section_y }}** соответственно.
1. Удалите поле `method` из секции **{{ ui-key.datalens.wizard.section_x }}** и перетащите туда поле `object_type`.
1. В правом верхнем углу нажмите **{{ ui-key.datalens.wizard.button_save }}**.

### Создайте третий чарт {#create-column-chart-2}

Чтобы визуализировать распределение исходящего трафика по дням, создайте чарт — столбчатую диаграмму:

1. Скопируйте чарт, получившийся на предыдущем шаге:

   1. В правом верхнем углу нажмите галочку рядом с кнопкой **{{ ui-key.datalens.wizard.button_save }}**.
   1. Нажмите кнопку **{{ ui-key.datalens.wizard.button_save-as }}**.
   1. В открывшемся окне введите название нового чарта `S3 - Traffic generated by days` и нажмите кнопку **{{ ui-key.datalens.component.chartkit-alerts.view.button_save }}**.

1. Перетащите поле `object_type` из секции **{{ ui-key.datalens.wizard.section_x }}** в секцию **{{ ui-key.datalens.wizard.section_filters }}**.
1. В открывшемся окне выберите типы объектов, которые нужно отобразить на диаграмме, и нажмите **{{ ui-key.datalens.wizard.button_apply-filter }}**.
1. Перетащите поле `timestamp` из раздела **{{ ui-key.datalens.wizard.section_dimensions }}** в секцию **{{ ui-key.datalens.wizard.section_x }}**.
1. Удалите поле `request_id` из секции **{{ ui-key.datalens.wizard.section_y }}** и перетащите туда поле `bytes_send`.
1. В правом верхнем углу нажмите **{{ ui-key.datalens.wizard.button_save }}**.

## Создайте дашборд в {{ datalens-short-name }} и добавьте на него чарты {#create-dashboard}

1. Перейдите на [главную страницу]({{ link-datalens-main }}) {{ datalens-short-name }}.
1. Нажмите кнопку **{{ ui-key.datalens.main.landing.view.button_create-dashboards }}**.
1. Введите название дашборда `S3 Logs Analysis` и нажмите **{{ ui-key.datalens.component.navigation.view.button_create }}**.
1. В правом верхнем углу нажмите **{{ ui-key.datalens.dash.action-panel.view.button_add }}** и выберите **{{ ui-key.datalens.dash.action-panel.view.value_widget }}**.
1. В поле **{{ ui-key.datalens.dash.widget-dialog.edit.field_widget }}** нажмите **{{ ui-key.datalens.dash.navigation-input.edit.button_choose }}** и выберите из списка чарт `S3 - Method pie`.
1. Нажмите кнопку **{{ ui-key.datalens.dash.widget-dialog.edit.button_add }}**. Чарт появится на дашборде.
1. Повторите предыдущие шаги для чартов `S3 - Object type bars` и `S3 - Traffic generated by days`.

## Как удалить созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

* [Удалите бакет](../../storage/operations/buckets/delete.md).
* [Удалите кластер](../../managed-clickhouse/operations/cluster-delete.md) `s3-logs`.
