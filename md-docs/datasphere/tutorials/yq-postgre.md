# Работа с данными в Yandex Managed Service for PostgreSQL

Yandex Query — это интерактивный сервис для бессерверного анализа данных. С его помощью можно обрабатывать информацию из различных хранилищ без необходимости создания выделенного кластера. Поддерживается работа с хранилищами данных [Yandex Object Storage](../../storage/index.md), [Yandex Managed Service for PostgreSQL](../../managed-postgresql/index.md), [Yandex Managed Service for ClickHouse®](../../managed-clickhouse/index.md).

В этом руководстве вы подключитесь к базе данных Managed Service for PostgreSQL и выполните запросы к ней из ноутбука JupyterLab с помощью Query.

1. [Подготовьте инфраструктуру](#infra).
1. [Начните работу в Query](#yq-begin).
1. [Создайте кластер Managed Service for PostgreSQL](#create-cluster).
1. [Подключитесь к данным Managed Service for PostgreSQL](#mch-connect).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Ноутбук с примерами также доступен на [GitHub](https://github.com/yandex-cloud-examples/yc-yq-datasphere-examples).

<a href="https://datasphere.yandex.cloud/import-ipynb?path=https://raw.githubusercontent.com/yandex-cloud-examples/yc-yq-datasphere-examples/main/Working%20with%20Yandex%20Query%20in%20DataSphere.ipynb"><img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v2_ru.svg" 
  alt="Открыть в DataSphere"/></a>


## Перед началом работы {#before-you-begin}

Перед началом работы нужно зарегистрироваться в Yandex Cloud, настроить [сообщество](../concepts/community.md) и привязать к нему [платежный аккаунт](../../billing/concepts/billing-account.md):
1. [На главной странице DataSphere](https://datasphere.yandex.cloud) нажмите **Попробовать бесплатно** и выберите аккаунт для входа — Яндекс ID или рабочий аккаунт в федерации (SSO).
1. Выберите [организацию Yandex Identity Hub](../../organization/index.md), в которой вы будете работать в Yandex Cloud.
1. [Создайте сообщество](../operations/community/create.md).
1. [Привяжите платежный аккаунт](../operations/community/link-ba.md) к сообществу DataSphere, в котором вы будете работать. Убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, создайте его в интерфейсе DataSphere.


### Необходимые платные ресурсы {#paid-resources}

* Проект DataSphere: использование вычислительных ресурсов и хранилища ([тарифы DataSphere](../pricing.md)).
* Кластер Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for PostgreSQL](../../managed-postgresql/pricing.md)).
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

  1. Перейдите в каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `yq-sa`.
  1. Нажмите **Добавить роль** и назначьте сервисному аккаунту роли:
     * `yq.editor` — для отправки запросов Query.
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

Чтобы получить авторизованный ключ из ноутбука, создайте [секрет](../concepts/secrets.md) с содержимым файла авторизованного ключа.

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

## Создайте кластер Managed Service for PostgreSQL {#create-cluster}

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

### Создайте таблицу {#create-table}

На этом шаге вы создадите тестовую таблицу со случайными числами от 0 до 100.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud), откройте страницу кластера `postgresql` и перейдите на вкладку **SQL**.
  1. Введите **Имя пользователя** и **Пароль**, указанные при создании кластера.
  1. В окно ввода справа вставьте SQL-запрос:

     ```sql
     CREATE TABLE test (
         id SERIAL PRIMARY KEY,
         number INT
     );
 
     INSERT INTO test (number)
     SELECT random() * 100
     FROM generate_series(1, 100);
     ```

  1. Нажмите **Выполнить**.

{% endlist %}

## Подключитесь к данным в Managed Service for PostgreSQL {#mch-connect}

Чтобы создать подключение [подключение](../../query/concepts/glossary.md#connection) Query:

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

Чтобы проверить подключение, получите данные таблицы из ячейки ноутбука:

```sql
%yq SELECT * FROM postgresql.test
```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [удалите кластер](../../managed-postgresql/operations/cluster-delete.md) базы данных;
* [удалите проект](../operations/projects/delete.md).