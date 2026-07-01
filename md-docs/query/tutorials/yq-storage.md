# Работа с данными в Yandex Object Storage

Yandex Query — это интерактивный сервис для бессерверного анализа данных. С его помощью можно обрабатывать информацию из различных хранилищ без необходимости создания выделенного кластера. Поддерживается работа с хранилищами данных [Yandex Object Storage](../../storage/index.md), [Yandex Managed Service for PostgreSQL](../../managed-postgresql/index.md), [Yandex Managed Service for ClickHouse®](../../managed-clickhouse/index.md).

В этом руководстве вы подключитесь к источнику данных в Object Storage и выполните запросы к ним из ноутбука JupyterLab с помощью Query.

1. [Подготовьте инфраструктуру](#infra).
1. [Начните работу в Query](#yq-begin).
1. [Подключитесь к данным Object Storage](#storage-connect).
1. [Настройте партицирование данных в Object Storage](#partitioning).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Ноутбук с примерами также доступен на [GitHub](https://github.com/yandex-cloud-examples/yc-yq-datasphere-examples).

<a href="https://datasphere.yandex.cloud/import-ipynb?path=https://raw.githubusercontent.com/yandex-cloud-examples/yc-yq-datasphere-examples/main/Working%20with%20Yandex%20Query%20in%20DataSphere.ipynb"><img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v2_ru.svg" 
  alt="Открыть в DataSphere"/></a>


## Перед началом работы {#before-you-begin}

Перед началом работы нужно зарегистрироваться в Yandex Cloud, настроить [сообщество](../../datasphere/concepts/community.md) и привязать к нему [платежный аккаунт](../../billing/concepts/billing-account.md):
1. [На главной странице DataSphere](https://datasphere.yandex.cloud) нажмите **Попробовать бесплатно** и выберите аккаунт для входа — Яндекс ID или рабочий аккаунт в федерации (SSO).
1. Выберите [организацию Yandex Identity Hub](../../organization/index.md), в которой вы будете работать в Yandex Cloud.
1. [Создайте сообщество](../../datasphere/operations/community/create.md).
1. [Привяжите платежный аккаунт](../../datasphere/operations/community/link-ba.md) к сообществу DataSphere, в котором вы будете работать. Убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, создайте его в интерфейсе DataSphere.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для работы с данными Object Storage входит:

* плата за использование [вычислительных ресурсов DataSphere](../../datasphere/pricing.md);
* плата за [хранение данных](../../storage/pricing.md#prices-storage) в бакете;
* плата за объем считанных данных при исполнении [запросов Query](../../query/pricing.md).

## Подготовьте инфраструктуру {#infra}

Войдите в [консоль управления](https://console.yandex.cloud) Yandex Cloud и выберите организацию, в которой вы работаете с DataSphere. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен платежный аккаунт.

Если у вас есть активный платежный аккаунт, на [странице облака](https://console.yandex.cloud/cloud) вы можете создать или выбрать каталог, в котором будет работать ваша инфраструктура.

{% note info %}

Если вы работаете с Yandex Cloud через [федерацию удостоверений](../../organization/concepts/add-federation.md), вам может быть недоступна платежная информация. В этом случае обратитесь к администратору вашей организации в Yandex Cloud.

{% endnote %}

### Создайте каталог {#create-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg)**Создать каталог**.
   1. Введите имя каталога, например `data-folder`.
   1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте сервисный аккаунт для проекта DataSphere {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `yq-sa`.
  1. Нажмите **Добавить роль** и назначьте сервисному аккаунту роли:
     * `yq.editor` — для отправки запросов Query.
     * `storage.viewer` — для просмотра содержимого бакета и объектов Object Storage.
  1. Нажмите кнопку **Создать**.

{% endlist %}

### Добавьте сервисный аккаунт в проект {#sa-to-project}

Чтобы сервисный аккаунт мог запускать проект DataSphere, добавьте его в список участников проекта. 

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. На вкладке **Участники** нажмите **Добавить участника**.
1. Выберите аккаунт `yq-sa` и нажмите **Добавить**.
1. Измените роль сервисного аккаунта на **Editor**.

### Создайте авторизованный ключ для сервисного аккаунта {#create-key}

Чтобы сервисный аккаунт мог отправлять запросы Query, создайте [авторизованный ключ](../../iam/concepts/authorization/key.md).

{% note info %}

Срок жизни авторизованных ключей не ограничен, но вы всегда можете получить новые авторизованные ключи и повторить процедуру аутентификации, если что-то пошло не так.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. В открывшемся списке выберите сервисный аккаунт `yq-sa`.
  1. Нажмите кнопку **Создать новый ключ** на верхней панели и выберите пункт **Создать авторизованный ключ**.
  1. Выберите алгоритм шифрования и нажмите **Создать**.
  1. Нажмите **Скачать файл с ключами**.

{% endlist %}

### Создайте секрет {#create-secret}

Чтобы получить авторизованный ключ из ноутбука, создайте [секрет](../../datasphere/concepts/secrets.md) с содержимым файла авторизованного ключа.

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. В блоке **Ресурсы проекта** нажмите ![secret](../../_assets/console-icons/shield-check.svg)**Секрет**.
1. Нажмите **Создать**.
1. В поле **Имя** задайте имя секрета — `yq_access_key`.
1. В поле **Значение** вставьте полное содержимое скачанного файла с авторизированным ключом.
1. Нажмите **Создать**.

### Создайте ноутбук {#create-notebook}

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. Нажмите кнопку **Открыть проект в JupyterLab** и дождитесь окончания загрузки.
1. На верхней панели нажмите **File** и выберите **New** ⟶ **Notebook**.
1. Выберите ядро и нажмите **Select**.

## Начните работу в Query {#yq-begin}

Пакет `yandex_query_magic` предоставляет _magic commands_ для работы в Jupyter. Установите его для отправки запросов в Query. Скопируйте код в ячейки ноутбука `yq-storage.ipynb`:

1. Откройте проект DataSphere:
   
   1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
   1. Нажмите кнопку **Открыть проект в JupyterLab** и дождитесь окончания загрузки.
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

1. Выполните тестовый запрос к Query:

    ```sql
    %yq select "Hello, world!"
    ```

## Подключитесь к данным в Object Storage {#storage-connect}

Для примера возьмем данные о поездках Нью-Йоркского желтого такси. Данные заранее размещены в Object Storage в общедоступном бакете `yq-sample-data` в каталоге `nyc_taxi_csv`.

{% note info %}

Yandex Cloud предоставляет набор данных — **поездки Нью-Йоркского такси** — на условиях “как есть” (as is). Yandex Cloud не дает никаких заверений, явных или подразумеваемых, гарантий или условий в отношении использования вами указанного датасета (набора данных). В пределах, разрешенных вашим местным законодательством, Yandex Cloud не несет никакой ответственности за любые убытки или ущерб, включая прямые, побочные, специальные, косвенные, случайные или штрафные, возникшие в результате использования вами датасета.

NYC Taxi and Limousine Commission (TLC):

Данные были собраны и предоставлены NYC Taxi and Limousine Commission (TLC) поставщиками технологий, уполномоченными в рамках Taxicab & Livery Passenger Enhancement Programs (TPEP/LPEP). Данные о поездке не были созданы TLC, и TLC не делает никаких заявлений относительно точности этих данных.

Ознакомьтесь с [Источником датасета](https://www1.nyc.gov/site/tlc/about/tlc-trip-record-data.page) и [Правилами его использования](https://www1.nyc.gov/home/terms-of-use.page).

{% endnote %}

Создайте [подключение](../concepts/glossary.md#connection) Query:

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Yandex Query**.
  1. На панели слева выберите **Соединения**.
  1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg)**Создать**.
  1. Введите имя соединения, например `storage-connection`.
  1. Выберите тип соединения **Object Storage** и укажите **Параметры типа соединения**:
  
     * В поле **Аутентификация бакета** выберите `Публичный` и укажите имя бакета.
     * Укажите имя бакета — `yq-sample-data`.
  
  1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте привязку к данным {#create-binding}

[Привязка](../concepts/glossary.md#binding) к данным содержит информацию о форматах и расположении файлов в бакете, а также о списке полей данных и их типах. Query может обрабатывать данные в форматах CSV, TSV, Json и Parquet. При этом данные в форматах CSV, TSV, Json могут быть дополнительно запакованы внешним архиватором: gzip, zstd и другими. Для данных в формате Parquet поддерживается сжатие Snappy, LZ4, ZSTD и другие.

Чтобы создать привязку к данным:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Yandex Query**.
  1. На панели слева выберите **Привязки**.
  1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **Создать**.
  1. В блоке **Параметры соединения**:

     * **Тип** — выберите **Object Storage**.
     * **Соединение** — выберите `storage-connection`.

  1. В блоке **Параметры привязки к данным**:
  
     1. Введите имя привязки, например `yq_binding`.
     1. В поле **Путь** укажите [путь к данным](../sources-and-sinks/object-storage.md#path_format) — `nyc_taxi_sample/data/`.
     1. Выберите тип сжатия — `gzip`.
  
  1. В блоке **Настройки формата** в поле **Формат** выберите `csv_with_names`.

  1. В блоке **Колонки** добавьте две колонки со следующими именами и типами данных:

     * `tpep_pickup_datetime` — `DATETIME`.
     * `trip_distance` — `DOUBLE`.
  
  1. Чтобы проверить корректность указанных данных, нажмите кнопку **Предпросмотр**. Внизу должна появиться таблица.
  1. Нажмите кнопку **Создать**.

{% endlist %}

Чтобы проверить подключение, получите данные таблицы из ячейки ноутбука:

```sql
%yq SELECT * FROM yq_binding LIMIT 100;
```

## Настройте партицирование в Object Storage {#partitioning}

В Query можно существенно снизить время запроса, если настроить правила [партицирования](../concepts/partitioning.md) (размещения) данных в Object Storage, которые позволят считывать только нужные данные. Например, когда файлы в бакете рассортированы в каталогах по годам, то при запросе Query будет искать данные только в заданных каталогах.

Query поддерживает два варианта указания правил размещения данных: [Hive-партицирование](../concepts/partitioning.md#formats) и [Расширенное партицирование](../concepts/partition-projection.md).

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
   
     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `data-folder`.
     1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Yandex Query**.
     1. На панели слева нажмите **Привязки**.
     1. В строке с привязкой `yq_binding` нажмите кнопку ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **Клонировать**.
     1. Укажите имя привязки — `yq_tutorial_hive_partitioned`.
     1. В блоке **Колонки партиционирования**:

        1. Выберите режим **Базовый**.
        1. Добавьте колонку с именем `year` и типом данных `UINT32`.
        1. Добавьте колонку с именем `month` и типом данных `UINT32`.

     1. Нажмите кнопку **Изменить**.
   
   {% endlist %}

1. Чтобы проверить результат, выполните следующий запрос:

   ```sql
   %yq SELECT * FROM yq_tutorial_hive_partitioned WHERE year=2021
   ```

### Расширенное партицирование {#explicit}

Иногда данные в Object Storage расположены по уникальным правилам. Для таких случаев существует режим [расширенного партицирования](../concepts/partition-projection.md), который позволяет указать собственный шаблон пути размещения данных.

При работе в режиме расширенного партицирования необходимо описать каждый компонент пути `year` и `month` по отдельности, указав диапазоны их значений. Затем нужно указать шаблон пути в бакете Object Storage, где хранятся данные.

Настройте расширенное партицирование:

1. Склонируйте привязку данных `yq_binding`:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `data-folder`.
     1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Yandex Query**.
     1. На панели слева нажмите **Привязки**.
     1. В строке с привязкой `yq_binding` нажмите кнопку ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **Клонировать**.
     1. Укажите имя привязки — `yq_tutorial_partition_projection`.
     1. В блоке **Колонки партиционирования**:
        
        1. Выберите режим **Расширенный**.
        1. Добавьте колонку с именем `year` и типом данных `UINT32`:
           * **Тип формата** — `integer`.
           * **Интервал**:
             * **Мин.** — `2019`
             * **Макс.** – `2024`
             * **Шаг** — 1.
           * **Кол-во символов** — 2.
        1. Добавьте колонку с именем `month` и типом данных `UINT32`:
           * **Тип формата** — `integer`.
           * **Интервал**:
             * **Мин.** — `1`
             * **Макс.** – `12`
             * **Шаг** — 1.
           * **Кол-во символов** — 2.

     1. Нажмите кнопку **Изменить**.
   
   {% endlist %}

1. Чтобы проверить результат, выполните следующий запрос:

   ```sql
   %yq SELECT * FROM yq_tutorial_partition_projection WHERE year=2021
   ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [удалите бакет](../../storage/operations/buckets/delete.md);
* [удалите проект](../../datasphere/operations/projects/delete.md).