# Работа с данными в Yandex Managed Service for ClickHouse®

Yandex Query — это интерактивный сервис для бессерверного анализа данных. С его помощью можно обрабатывать информацию из различных хранилищ без необходимости создания выделенного кластера. Поддерживается работа с хранилищами данных [Yandex Object Storage](../../storage/index.md), [Yandex Managed Service for PostgreSQL](../../managed-postgresql/index.md), [Yandex Managed Service for ClickHouse®](../../managed-clickhouse/index.md).

В этом руководстве вы подключитесь к базе данных Managed Service for ClickHouse® и выполните запросы к ней из ноутбука JupyterLab с помощью Query.

1. [Подготовьте инфраструктуру](#infra).
1. [Начните работу в Query](#yq-begin).
1. [Создайте кластер Managed Service for ClickHouse®](#create-cluster).
1. [Подключитесь к данным Managed Service for ClickHouse®](#mch-connect).

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

В стоимость поддержки инфраструктуры для работы с данными Managed Service for ClickHouse® входит:

* плата за использование [вычислительных ресурсов DataSphere](../pricing.md);
* плата за запущенный [кластер Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md);
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
     * `managed-clickhouse.viewer` — для просмотра содержимого кластера Managed Service for ClickHouse®.
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

Чтобы получить авторизованный ключ из ноутбука, создайте [секрет](../concepts/secrets.md) с содержимым файла авторизованного ключа.

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. В блоке **Ресурсы проекта** нажмите ![secret](../../_assets/console-icons/shield-check.svg)**Секрет**.
1. Нажмите **Создать**.
1. В поле **Имя** задайте имя секрета — `yq_access_key`.
1. В поле **Значение** вставьте полное содержимое скачанного файла с авторизированным ключом.
1. Нажмите **Создать**.

### Создайте ноутбук {#create-notebook}

Запросы к базе данных Managed Service for ClickHouse® через Query будут отправляться из ноутбука.

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. Нажмите кнопку **Открыть проект в JupyterLab** и дождитесь окончания загрузки.
1. На верхней панели нажмите **File** и выберите **New** ⟶ **Notebook**.
1. Выберите ядро и нажмите **Select**.

## Начало работы в Query {#yq-begin}

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

## Создайте кластер Managed Service for ClickHouse® {#create-cluster}

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

### Создайте таблицу {#create-table}

На этом шаге вы создадите тестовую таблицу с числами от 0 до 100.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud), откройте страницу кластера `clickhouse` и перейдите на вкладку **SQL**.
  1. Введите **Имя пользователя** и **Пароль**, указанные при создании кластера.
  1. В окно ввода справа вставьте SQL-запрос:

     ```sql
     CREATE TABLE test(col1 int) 
         ENGINE = MergeTree 
             ORDER BY col1;
   
     INSERT INTO test
     SELECT 
         * 
     FROM numbers(100)
     ```

  1. Нажмите **Выполнить**.

{% endlist %}

## Подключитесь к данным в Managed Service for ClickHouse® {#mch-connect}

Чтобы создать [подключение](../../query/concepts/glossary.md#connection) Query:

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

Чтобы проверить подключение, получите данные таблицы из ячейки ноутбука:

```sql
%yq SELECT * FROM clickhouse.test
```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [удалите кластер](../../managed-clickhouse/operations/cluster-delete.md) базы данных;
* [удалите проект](../operations/projects/delete.md).

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._