# Работа с данными в {{ objstorage-full-name }}

{{ yq-full-name }} — это интерактивный сервис для бессерверного анализа данных. С его помощью можно обрабатывать информацию из различных хранилищ без необходимости создания выделенного кластера. Поддерживается работа с хранилищами данных [{{ objstorage-full-name }}](../../storage/index.md), [{{ mpg-full-name }}](../../managed-postgresql/index.md), [{{ mch-full-name }}](../../managed-clickhouse/index.md).

В этом руководстве вы подключитесь к источнику данных в {{ objstorage-name }} и выполните запросы к ним из ноутбука {{ jlab }}Lab с помощью {{ yq-name }}.

1. [Подготовьте инфраструктуру](#infra).
1. [Начните работу в {{ yq-name }}](#yq-begin).
1. [Подключитесь к данным {{ objstorage-name }}](#storage-connect).
1. [Настройте партицирование данных в {{ objstorage-name }}](#partitioning).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Ноутбук с примерами также доступен на [GitHub](https://github.com/yandex-cloud-examples/yc-yq-datasphere-examples).

<a href="{{ link-datasphere-main }}/import-ipynb?path=https://raw.githubusercontent.com/yandex-cloud-examples/yc-yq-datasphere-examples/main/Working%20with%20Yandex%20Query%20in%20DataSphere.ipynb"><img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v2_ru.svg" 
  alt="Открыть в {{ ml-platform-name }}"/></a>


## Перед началом работы {#before-you-begin}

Перед началом работы нужно зарегистрироваться в {{ yandex-cloud }}, настроить [сообщество](../../datasphere/concepts/community.md) и привязать к нему [платежный аккаунт](../../billing/concepts/billing-account.md):
1. [На главной странице {{ ml-platform-name }}]({{ link-datasphere-main }}) нажмите **Попробовать бесплатно** и выберите аккаунт для входа — Яндекс ID или рабочий аккаунт в федерации (SSO).
1. Выберите [организацию {{ org-full-name }}](../../organization/index.md), в которой вы будете работать в {{ yandex-cloud }}.
1. [Создайте сообщество](../../datasphere/operations/community/create.md).
1. [Привяжите платежный аккаунт](../../datasphere/operations/community/link-ba.md) к сообществу {{ ml-platform-name }}, в котором вы будете работать. Убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, создайте его в интерфейсе {{ ml-platform-name }}.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для работы с данными {{ objstorage-name }} входит:

* плата за использование [вычислительных ресурсов {{ ml-platform-name }}](../../datasphere/pricing.md);
* плата за [хранение данных](../../storage/pricing.md#prices-storage) в бакете;
* плата за объем считанных данных при исполнении [запросов {{ yq-name }}](../pricing.md).

## Подготовьте инфраструктуру {#infra}

Войдите в [консоль управления]({{ link-console-main }}) {{ yandex-cloud }} и выберите организацию, в которой вы работаете с {{ ml-platform-name }}. На странице [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) убедитесь, что у вас подключен платежный аккаунт.

Если у вас есть активный платежный аккаунт, на [странице облака]({{ link-console-cloud }}) вы можете создать или выбрать каталог, в котором будет работать ваша инфраструктура.

{% note info %}

Если вы работаете с {{ yandex-cloud }} через [федерацию удостоверений](../../organization/concepts/add-federation.md), вам может быть недоступна платежная информация. В этом случае обратитесь к администратору вашей организации в {{ yandex-cloud }}.

{% endnote %}

### Создайте каталог {#create-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Введите имя каталога, например `data-folder`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Создайте сервисный аккаунт для проекта {{ ml-platform-name }} {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `yq-sa`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту роли:
     * `yq.editor` — для отправки запросов {{ yq-name }}.
     * `storage.viewer` — для просмотра содержимого бакета и объектов {{ objstorage-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Добавьте сервисный аккаунт в проект {#sa-to-project}

Чтобы сервисный аккаунт мог запускать проект {{ ml-platform-name }}, добавьте его в список участников проекта. 

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. На вкладке **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** нажмите **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
1. Выберите аккаунт `yq-sa` и нажмите **{{ ui-key.yc-ui-datasphere.common.add }}**.
1. Измените роль сервисного аккаунта на **Editor**.

### Создайте авторизованный ключ для сервисного аккаунта {#create-key}

Чтобы сервисный аккаунт мог отправлять запросы {{ yq-name }}, создайте [авторизованный ключ](../../iam/concepts/authorization/key.md).

{% note info %}

Срок жизни авторизованных ключей не ограничен, но вы всегда можете получить новые авторизованные ключи и повторить процедуру аутентификации, если что-то пошло не так.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. В открывшемся списке выберите сервисный аккаунт `yq-sa`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** на верхней панели и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
  1. Выберите алгоритм шифрования и нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}**.

{% endlist %}

### Создайте секрет {#create-secret}

Чтобы получить авторизованный ключ из ноутбука, создайте [секрет](../../datasphere/concepts/secrets.md) с содержимым файла авторизованного ключа.

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![secret](../../_assets/console-icons/shield-check.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.secret.name }}** задайте имя секрета — `yq_access_key`.
1. В поле **{{ ui-key.yc-ui-datasphere.secret.content }}** вставьте полное содержимое скачанного файла с авторизированным ключом.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**.

### Создайте ноутбук {#create-notebook}

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}** и дождитесь окончания загрузки.
1. На верхней панели нажмите **File** и выберите **New** ⟶ **Notebook**.
1. Выберите ядро и нажмите **Select**.

## Начните работу в {{ yq-name }} {#yq-begin}

Пакет `yandex_query_magic` предоставляет _magic commands_ для работы в {{ jlab }}. Установите его для отправки запросов в {{ yq-name }}. Скопируйте код в ячейки ноутбука `yq-storage.ipynb`:

1. Откройте проект {{ ml-platform-name }}:
   
   1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
   1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}** и дождитесь окончания загрузки.
   1. Откройте вкладку с ноутбуком.

1. Установите пакет `yandex_query_magic`:

    ```python
    %pip install yandex_query_magic
    ```

1. После завершения установки на верхней панели выберите **Kernel** ⟶ **Restart kernel...**.

1. Загрузите расширение:

    ```python
    %load_ext yandex_query_magic
    ```

1. Настройте подключение, указав идентификатор каталога `data-folder` и название секрета с авторизованным ключом:

    ```sql
    %yq_settings --folder-id <идентификатор_каталога> --env-auth yq_access_key
    ```

1. Выполните тестовый запрос к {{ yq-name }}:

    ```sql
    %yq select "Hello, world!"
    ```

## Подключитесь к данным в {{ objstorage-name }} {#storage-connect}

Для примера возьмем данные о поездках Нью-Йоркского желтого такси. Данные заранее размещены в {{ objstorage-name }} в общедоступном бакете `yq-sample-data` в каталоге `nyc_taxi_csv`.

{% note info %}

{{ yandex-cloud }} предоставляет набор данных — **поездки Нью-Йоркского такси** — на условиях “как есть” (as is). {{ yandex-cloud }} не дает никаких заверений, явных или подразумеваемых, гарантий или условий в отношении использования вами указанного датасета (набора данных). В пределах, разрешенных вашим местным законодательством, {{ yandex-cloud }} не несет никакой ответственности за любые убытки или ущерб, включая прямые, побочные, специальные, косвенные, случайные или штрафные, возникшие в результате использования вами датасета.

NYC Taxi and Limousine Commission (TLC):

Данные были собраны и предоставлены NYC Taxi and Limousine Commission (TLC) поставщиками технологий, уполномоченными в рамках Taxicab & Livery Passenger Enhancement Programs (TPEP/LPEP). Данные о поездке не были созданы TLC, и TLC не делает никаких заявлений относительно точности этих данных.

Ознакомьтесь с [Источником датасета](https://www1.nyc.gov/site/tlc/about/tlc-trip-record-data.page) и [Правилами его использования](https://www1.nyc.gov/home/terms-of-use.page).

{% endnote %}

Создайте [подключение](../concepts/glossary.md#connection) {{ yq-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
  1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
  1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg)**{{ ui-key.yql.yq-connection-form.action_create-new }}**.
  1. Введите имя соединения, например `storage-connection`.
  1. Выберите тип соединения **{{ ui-key.yql.yq-connection.action_object-storage }}** и укажите **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:
  
     * В поле **{{ ui-key.yql.yq-connection-form.bucket-auth.input-label }}** выберите `{{ ui-key.yql.yq-connection-form.public.button-text }}` и укажите имя бакета.
     * Укажите имя бакета — `yq-sample-data`.
  
  1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

{% endlist %}

### Создайте привязку к данным {#create-binding}

[Привязка](../concepts/glossary.md#binding) к данным содержит информацию о форматах и расположении файлов в бакете, а также о списке полей данных и их типах. {{ yq-name }} может обрабатывать данные в форматах CSV, TSV, Json и Parquet. При этом данные в форматах CSV, TSV, Json могут быть дополнительно запакованы внешним архиватором: gzip, zstd и другими. Для данных в формате Parquet поддерживается сжатие Snappy, LZ4, ZSTD и другие.

Чтобы создать привязку к данным:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
  1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
  1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-binding-add.create-binding.button-text }}**.
  1. В блоке **{{ ui-key.yql.yq-binding-form.connection-parameters.title }}**:

     * **{{ ui-key.yql.yq-binding-form.connection-type.title }}** — выберите **{{ ui-key.yql.yq-connection.action_object-storage }}**.
     * **{{ ui-key.yql.yq-binding-form.connection.title }}** — выберите `storage-connection`.

  1. В блоке **{{ ui-key.yql.yq-binding-form.binding-parameters.title }}**:
  
     1. Введите имя привязки, например `yq_binding`.
     1. В поле **{{ ui-key.yql.yq-binding-form.binding-path-pattern.title }}** укажите [путь к данным](../sources-and-sinks/object-storage.md#path_format) — `nyc_taxi_sample/data/`.
     1. Выберите тип сжатия — `gzip`.
  
  1. В блоке **{{ ui-key.yql.yq-binding-form.binding-format-settings.title }}** в поле **{{ ui-key.yql.yq-binding-form.binding-format.title }}** выберите `csv_with_names`.

  1. В блоке **{{ ui-key.yql.yq-binding-form.binding-fields.title }}** добавьте две колонки со следующими именами и типами данных:

     * `tpep_pickup_datetime` — `DATETIME`.
     * `trip_distance` — `DOUBLE`.
  
  1. Чтобы проверить корректность указанных данных, нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-preview.button-text }}**. Внизу должна появиться таблица.
  1. Нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.

{% endlist %}

Чтобы проверить подключение, получите данные таблицы из ячейки ноутбука:

```sql
%yq SELECT * FROM yq_binding LIMIT 100;
```

## Настройте партицирование в {{ objstorage-name }} {#partitioning}

В {{ yq-name }} можно существенно снизить время запроса, если настроить правила [партицирования](../concepts/partitioning.md) (размещения) данных в {{ objstorage-name }}, которые позволят считывать только нужные данные. Например, когда файлы в бакете рассортированы в каталогах по годам, то при запросе {{ yq-name }} будет искать данные только в заданных каталогах.

{{ yq-name }} поддерживает два варианта указания правил размещения данных: [Hive-партицирование](../concepts/partitioning.md#formats) и [Расширенное партицирование](../concepts/partition-projection.md).

### Hive-партицирование {#hive}

Размещение файлов в стиле Apache Hive™ — это размещение данных в структуре каталогов вида `ключ=значение/ключ2=значение2/...`. Этот формат используется в системах, изначально построенных вокруг экосистемы Apache Hadoop™, например, в Apache Spark™.

Например, данные из используемого датасета Yellow Taxi расположены в каталогах по правилам Hive-партицирования:

* `year=2021/month=1/...`
* `year=2021/month=2/...`
* ...
* `year=2022/month=1/...`
* `year=2022/month=2/...`

Настройте Hive-партицирование:

1. Склонируйте привязку к данным `yq_binding`:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог `data-folder`.
     1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
     1. На панели слева нажмите **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
     1. В строке с привязкой `yq_binding` нажмите кнопку ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yql.yq-binding-actions.clone-binding.menu-item-text }}**.
     1. Укажите имя привязки — `yq_tutorial_hive_partitioned`.
     1. В блоке **{{ ui-key.yql.yq-schema.schema-partitioning.section-header }}**:

        1. Выберите режим **{{ ui-key.yql.yq-binding-form.projection-radio.disabled.label }}**.
        1. Добавьте колонку с именем `year` и типом данных `UINT32`.
        1. Добавьте колонку с именем `month` и типом данных `UINT32`.

     1. Нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-modify.button-text }}**.
   
   {% endlist %}

1. Чтобы проверить результат, выполните следующий запрос:

   ```sql
   %yq SELECT * FROM yq_tutorial_hive_partitioned WHERE year=2021
   ```

### Расширенное партицирование {#explicit}

Иногда данные в {{ objstorage-name }} расположены по уникальным правилам. Для таких случаев существует режим [расширенного партицирования](../concepts/partition-projection.md), который позволяет указать собственный шаблон пути размещения данных.

При работе в режиме расширенного партицирования необходимо описать каждый компонент пути `year` и `month` по отдельности, указав диапазоны их значений. Затем нужно указать шаблон пути в бакете {{ objstorage-name }}, где хранятся данные.

Настройте расширенное партицирование:

1. Склонируйте привязку данных `yq_binding`:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог `data-folder`.
     1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
     1. На панели слева нажмите **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
     1. В строке с привязкой `yq_binding` нажмите кнопку ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yql.yq-binding-actions.clone-binding.menu-item-text }}**.
     1. Укажите имя привязки — `yq_tutorial_partition_projection`.
     1. В блоке **{{ ui-key.yql.yq-schema.schema-partitioning.section-header }}**:
        
        1. Выберите режим **{{ ui-key.yql.yq-binding-form.projection-radio.enabled.label }}**.
        1. Добавьте колонку с именем `year` и типом данных `UINT32`:
           * **{{ ui-key.yql.yq-binding-form.projection-format-type.title }}** — `integer`.
           * **{{ ui-key.yql.yq-binding-form.projection-int-interval.title }}**:
             * **{{ ui-key.yql.yq-binding-form.projection-date-interval-min.placeholder }}** — `2019`
             * **{{ ui-key.yql.yq-binding-form.projection-date-interval-max.placeholder }}** – `2024`
             * **{{ ui-key.yql.yq-binding-form.projection-date-interval-step.title }}** — 1.
           * **{{ ui-key.yql.yq-binding-form.projection-int-fixed-width.title }}** — 2.
        1. Добавьте колонку с именем `month` и типом данных `UINT32`:
           * **{{ ui-key.yql.yq-binding-form.projection-format-type.title }}** — `integer`.
           * **{{ ui-key.yql.yq-binding-form.projection-int-interval.title }}**:
             * **{{ ui-key.yql.yq-binding-form.projection-date-interval-min.placeholder }}** — `1`
             * **{{ ui-key.yql.yq-binding-form.projection-date-interval-max.placeholder }}** – `12`
             * **{{ ui-key.yql.yq-binding-form.projection-date-interval-step.title }}** — 1.
           * **{{ ui-key.yql.yq-binding-form.projection-int-fixed-width.title }}** — 2.

     1. Нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-modify.button-text }}**.
   
   {% endlist %}

1. Чтобы проверить результат, выполните следующий запрос:

   ```sql
   %yq SELECT * FROM yq_tutorial_partition_projection WHERE year=2021
   ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [удалите бакет](../../storage/operations/buckets/delete.md);
* [удалите проект](../../datasphere/operations/projects/delete.md).