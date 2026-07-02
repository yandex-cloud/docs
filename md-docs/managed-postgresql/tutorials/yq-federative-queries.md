[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for PostgreSQL](../index.md) > [Практические руководства](index.md) > Федеративные запросы к данным с помощью Query

# Федеративные запросы к данным с помощью Yandex Query

Yandex Query — это интерактивный сервис для бессерверного анализа данных. С его помощью можно обрабатывать информацию из различных хранилищ без необходимости создания выделенного кластера. Поддерживается работа с хранилищами данных [Yandex Object Storage](../../storage/index.md), [Yandex Managed Service for PostgreSQL](../index.md), [Yandex Managed Service for ClickHouse®](../../managed-clickhouse/index.md).

Данные из этих систем можно обрабатывать как по отдельности, так и в рамках одного общего запроса — такие запросы называются _федеративными_.

В этом руководстве вы создадите три отдельных хранилища данных: покупатели, купленные товары и даты покупок. С помощью федеративного запроса из ячейки ноутбука вы сможете получить данные из всех хранилищ одновременно.

1. [Подготовьте инфраструктуру](#infra).
1. [Начните работу в Query](#yq-begin).
1. [Подключитесь к данным Object Storage](#storage-connect).
1. [Подключитесь к данным Managed Service for ClickHouse®](#ch-connect).
1. [Подключитесь к данным Managed Service for PostgreSQL](#pg-connect).
1. [Выполните федеративный запрос](#federated_query).

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

* Проект DataSphere: использование вычислительных ресурсов и хранилища ([тарифы DataSphere](../../datasphere/pricing.md)).
* Кластер Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for PostgreSQL](../pricing.md)).
* Кластер Managed Service for ClickHouse®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Бакет Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).
* Сервис Query: объем считанных данных при исполнении запросов ([тарифы Query](../../query/pricing.md)).


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

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `yq-sa`.
  1. Нажмите **Добавить роль** и назначьте сервисному аккаунту роли:
     * `yq.editor` — для отправки запросов Query.
     * `storage.viewer` — для просмотра содержимого бакета и объектов Object Storage.
     * `managed-clickhouse.viewer` — для просмотра содержимого кластера Managed Service for ClickHouse®.
     * `managed-postgresql.viewer` — для просмотра содержимого кластера Managed Service for PostgreSQL.
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

Запросы к базе данных Managed Service for PostgreSQL через Query будут отправляться из ноутбука.

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

## Подключитесь к данным Object Storage {#storage-connect}

Для работы с данными Object Storage вам понадобится бакет с таблицей, [подключение](../../query/concepts/glossary.md#connection) Query и [привязка](../../query/concepts/glossary.md#binding) к данным.

### Создайте бакет с данными {#storage-data}

[Бакет](../../storage/concepts/bucket.md) Object Storage будет содержать даты покупок.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
  1. Справа сверху нажмите кнопку **Создать бакет**.
  1. В поле **Имя** укажите имя бакета.
  1. В полях **Чтение объектов**, **Чтение списка объектов** и **Чтение настроек** выберите **С авторизацией**.
  1. Нажмите кнопку **Создать бакет**.
  1. Создайте файл `visits.csv` и поместите в него таблицу с датами покупок:

     ```text
     date|persons_id|item_id
     2024-05-14 12:12:00|1|2
     2024-05-15 13:13:00|2|1
     ```

  1. Перейдите в созданный бакет и нажмите **Загрузить**.
  1. В появившемся окне выберите файл `visits.csv` и нажмите кнопку **Открыть**.
  1. Нажмите кнопку **Загрузить**.

{% endlist %}

### Создайте подключение к Object Storage {#yq-storage}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Yandex Query**.
  1. На панели слева выберите **Соединения**.
  1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg)**Создать**.
  1. Введите имя соединения, например `storage-connection`.
  1. Выберите тип соединения **Object Storage** и укажите **Параметры типа соединения**.
  1. В поле **Аутентификация бакета** выберите `Приватный` и задайте параметры:

     * **Облако и каталог** — `data-folder`.
     * **Бакет** — выберите созданный бакет.
     * **Сервисный аккаунт** — `yq-sa`.
  
  1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте привязку к данным {#create-binding}

Привязка к данным содержит информацию о форматах и расположении файлов в бакете, а также о списке полей данных и их типах.

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
  
     1. Введите имя привязки, например `visits`.
     1. В поле **Путь** укажите [путь к таблице](../../query/sources-and-sinks/object-storage.md#path_format) в бакете — `/visits.csv`.
  
  1. В блоке **Настройки формата**:
     
     * **Формат** — выберите `csv_with_names`.
     * **Разделитель {%secondary%}(необязательно){%secondary%}** — `|`.

  1. В блоке **Колонки** добавьте три колонки со следующими именами и типами данных:

     * `date` — `DATETIME`.
     * `person_id` — `INT32`.
     * `items_id` — `INT32`.
  
  1. Чтобы проверить корректность указанных данных, нажмите кнопку **Предпросмотр**. Внизу должна появиться ваша таблица.
  1. Нажмите кнопку **Создать**.

{% endlist %}

Чтобы проверить подключение, получите данные таблицы из ячейки ноутбука:

```sql
%yq SELECT * FROM visits LIMIT 100;
```

## Подключитесь к данным Managed Service for ClickHouse® {#ch-connect}

Для работы с данными Managed Service for ClickHouse® вам понадобится кластер с таблицей и подключение Query.

### Создайте кластер Managed Service for ClickHouse® {#cluster-ch}

Для отправки запросов подойдет любой рабочий кластер Managed Service for ClickHouse® со включенной опцией **Доступ из Yandex Query**.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Нажмите кнопку **Создать кластер**.
  1. Введите имя кластера в поле **Имя кластера**, например `clickhouse`.

  1. В блоке **Настройки СУБД**:

      * В поле **Управление пользователями через SQL** выберите из выпадающего списка **Включено**.
      * Укажите **Имя пользователя** и **Пароль**.

  1. В блоке **Сервисные настройки**:

      * Выберите сервисный аккаунт `yq-sa`.
      * Включите опции **Доступ из Yandex Query** и **Доступ из консоли управления**.

  1. Остальные настройки можно оставить по умолчанию.
  1. Нажмите кнопку **Создать кластер**.

{% endlist %}

### Создайте таблицу {#ch-data}

Таблица Managed Service for ClickHouse® будет содержать названия товаров.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud), откройте страницу кластера `clickhouse` и перейдите на вкладку **SQL**.
  1. Введите **Имя пользователя** и **Пароль**, указанные при создании кластера.
  1. В окно ввода справа последовательно выполните SQL-запросы:

     ```sql
     CREATE TABLE items(id INT, description VARCHAR) ENGINE=MergeTree ORDER BY id;
     ```
 
     ```sql
     INSERT INTO items(id, description) VALUES(1, 'Refrigerator')
     ```
 
     ```sql
     INSERT INTO items(id, description) VALUES(2, 'TV')
     ```

  1. Нажмите **Выполнить**.

{% endlist %}

### Создайте подключение к Managed Service for ClickHouse® {#yq-ch}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Yandex Query**.
  1. На панели слева выберите **Соединения**.
  1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg)**Создать**.
  1. Введите имя соединения, например `clickhouse`.
  1. Выберите тип соединения **Managed Service for ClickHouse**.
  1. В блоке **Параметры типа соединения**:

     * **Кластер** — выберите ранее созданный кластер `clickhouse`.
     * **Сервисный аккаунт** — выберите сервисный аккаунт `yq-sa`.
     * Введите **Логин** и **Пароль**, указанные при создании кластера.

  1. Нажмите кнопку **Создать**.

{% endlist %}

Чтобы проверить подключение, выполните запрос в ячейке ноутбука. Например:

```sql
%yq SELECT * FROM clickhouse.items
```

## Подключитесь к данным Managed Service for PostgreSQL {#pg-connect}

Для работы с данными Managed Service for PostgreSQL вам понадобится кластер с таблицей и подключение Query.

### Создайте кластер Managed Service for PostgreSQL {#cluster-pg}

Для отправки запросов подойдет любой рабочий кластер Managed Service for PostgreSQL со включенной опцией **Доступ из Yandex Query**.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите кнопку **Создать кластер**.
  1. Введите имя кластера в поле **Имя кластера**, например `postgresql`.
  1. В блоке **База данных**:
     * Укажите **Имя БД**, например `db1`.
     * Укажите **Имя пользователя** и **Пароль**.
  1. В блоке **Сервисные настройки** включите опции **Доступ из Yandex Query** и **Доступ из консоли управления**.
  1. Остальные настройки можно оставить по умолчанию.
  1. Нажмите кнопку **Создать кластер**.

{% endlist %}

### Создайте таблицу {#table-pg}

Таблица Managed Service for PostgreSQL будет содержать имена покупателей.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud), откройте страницу кластера `postgresql` и перейдите на вкладку **SQL**.
  1. Введите **Имя пользователя** и **Пароль**, указанные при создании кластера.
  1. В окно ввода справа последовательно выполните SQL-запросы:

     ```sql
     CREATE TABLE persons(person_id INT, name VARCHAR);
     ```
 
     ```sql
     INSERT INTO persons(person_id, name) values(1, 'Ivan')
     ```
 
     ```sql
     INSERT INTO persons(person_id, name) values(2, 'Peter')
     ```

{% endlist %}

### Создайте подключение к Managed Service for PostgreSQL {#yq-pg}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Yandex Query**.
  1. На панели слева выберите **Соединения**.
  1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg)**Создать**.
  1. Введите имя соединения, например `postgresql`.
  1. Выберите тип соединения **Managed Service for PostgreSQL**.
  1. В блоке **Параметры типа соединения**:

     * **Кластер** — выберите ранее созданный кластер `postgresql`.
     * **Сервисный аккаунт** — `yq-sa`.
     * **База данных** — `db1`.
     * Введите **Логин** и **Пароль**, указанные при создании кластера.

  1. Нажмите кнопку **Создать**.

{% endlist %}

Чтобы проверить подключение, выполните запрос в ячейке ноутбука. Например:

```sql
%yq SELECT * FROM postgresql.persons
```

## Выполните федеративный запрос {#federate-query}

Работа с федеративными источниками данных (межсервисная аналитика) ничем не отличается от работы с обычными источниками данных. К внешним источникам данных, таким как таблицы в БД и данные в Object Storage, можно одновременно обращаться из запроса и выполнять над ними любые допустимые языком YQL операции.

Чтобы совместить и получить данные из всех трех таблиц, выполните федеративный запрос в ячейке ноутбука:

```sql
%%yq SELECT 
    v.person_id, 
    date, 
    p.name,
    c.description 
FROM visits AS v 
    INNER JOIN postgresql.persons AS p ON 
        v.person_id = p.person_id 
    INNER JOIN clickhouse.items AS c ON
        v.item_id = c.id
```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [удалите бакет](../../storage/operations/buckets/delete.md);
* [удалите кластер](../../managed-clickhouse/operations/cluster-delete.md) Managed Service for ClickHouse®;
* [удалите кластер](../operations/cluster-delete.md) Managed Service for PostgreSQL;
* [удалите проект](../../datasphere/operations/projects/delete.md).

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._