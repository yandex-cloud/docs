# Поставка данных из {{ mpg-full-name }} в {{ ydb-full-name }}

В кластер {{ ydb-name }} можно в реальном времени поставлять данные из базы данных {{ PG }}. Эти данные будут автоматически добавлены в таблицы {{ ydb-short-name }} с именами исходных схем и таблиц.

Чтобы запустить поставку данных:

1. [Подготовьте кластер-источник](#prepare-source).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру поставки данных:

{% list tabs %}

* Вручную

    1. [Создайте кластер-источник {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.
    1. {% if audience != "internal" %}[Создайте базу данных {{ ydb-name }}](../../ydb/operations/manage-database.md#create-db){% else %}Создайте базу данных {{ ydb-name }}{% endif %} любой подходящей конфигурации.
    1. [Создайте в кластере-источнике пользователя](../../managed-postgresql/operations/cluster-users.md#adduser) и [назначьте ему](../../managed-postgresql/operations/grant.md) роль `mdb_replication`.

* С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, {% if audience != "internal" %}[установите и настройте его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите и настройте его{% endif %}.
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и {% if audience != "internal" %}[укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}укажите значения параметров{% endif %}.
    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mpg-ydb.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-mpg-ydb.tf).

        В этом файле описаны:

        * {% if audience != "internal" %}[сеть](../../vpc/concepts/network.md#network){% else %}сеть{% endif %};
        * {% if audience != "internal" %}[подсеть](../../vpc/concepts/network.md#subnet){% else %}подсеть{% endif %};
        * {% if audience != "internal" %}[группа безопасности](../../vpc/concepts/security-groups.md){% else %}группа безопасности{% endif %} и правило, необходимое для подключения к кластеру {{ mpg-name }};
        * кластер-источник {{ mpg-name }};
        * база данных {{ PG }};
        * пользователь {{ mpg-name }};
        * база данных {{ ydb-name }};
        * эндпоинт-источник;
        * трансфер.

    1. Укажите в файле `data-transfer-mpg-ydb.tf` значения параметров:

        * `source_pg_version` – версия {{ PG }} в кластере-источнике;
        * `source_db_name` – имя БД в кластере-источнике;
        * `source_user_name` – имя пользователя для подключения к кластеру-источнику;
        * `source_user_password` – пароль пользователя;
        * `target_db_name` — имя базы данных {{ ydb-name }};
        * `transfer_enabled` – значение `0`, чтобы не создавать эндпоинт-источник и трансфер до [создания эндпоинта-приемника вручную](#prepare-transfer).

    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте кластер-источник {#prepare-source}

1. [Подключитесь к базе данных](../../managed-postgresql/operations/connect.md) кластера-источника от имени созданного пользователя.
1. Наполните базу тестовыми данными. В качестве примера используется простая таблица, содержащая информацию с некоторых датчиков автомобиля.

    Создайте таблицу:

    ```sql
    CREATE TABLE public.sensors (
        "device_id" text PRIMARY KEY NOT NULL,
        "datetime" timestamp NOT NULL,
        "latitude" real NOT NULL,
        "longitude" real NOT NULL,
        "altitude" real NOT NULL,
        "speed" real NOT NULL,
        "battery_voltage" real,
        "cabin_temperature" real NOT NULL,
        "fuel_level" real
    );
    ```

    Наполните таблицу данными:

    ```sql
    INSERT INTO public.sensors VALUES
        ('iv9a94th6rztooxh5ur2', '2020-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qmz3sdbrbu', '2020-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32),
        ('iv9a94th678tooxh5ur2', '2020-06-07 15:00:10', 55.70985913, 37.62141918,  417.0, 15.7, 10.3, 17, NULL);
    ```

1. [Подготовьте кластер-источник к трансферу](../../data-transfer/operations/prepare.md#source-pg).

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

    * **Тип базы данных** — `YDB`.
    * **Параметры эндпоинта**:

        * **Настройки подключения**:
           * **База данных** — выберите базу данных {{ ydb-name }} из списка.
           * **ID сервисного аккаунта** — выберите или создайте сервисный аккаунт с ролью `ydb.editor`.

1. Создайте эндпоинт для источника и трансфер:

    {% list tabs %}

    * Вручную

        1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для [созданного ранее](#before-you-begin) источника {{ PG }} с [настройками](../../data-transfer/operations/endpoint/source/postgresql.md):

            * **Тип базы данных** — `PostgreSQL`.
            * **Параметры эндпоинта**:
                * **Настройки подключения** — `Кластер MDB`.
                * **Кластер MDB** — созданный кластер {{ mpg-name }}.
                * **Имя базы данных** — имя созданной БД в кластере {{ mpg-name }}.
                * **Имя пользователя** — имя созданного пользователя в кластере {{ mpg-name }}.
                * **Пароль** — пароль пользователя.
                * **Список включенных таблиц** — `<имя БД>.sensors`.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа {{ dt-type-copy-repl }}, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) трансфер.

    * С помощью {{ TF }}

        1. Укажите в файле `data-transfer-mpg-ydb.tf` значения параметров:

            * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
            * `transfer_enabled` – значение `1` для создания эндпоинта-источника и трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Трансфер активируется автоматически после создания.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.
1. Убедитесь, что в базу данных {{ ydb-name }} перенеслись данные из кластера-источника {{ mpg-name }}:

    {% list tabs %}

    * Консоль управления

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужная база данных.
        1. В списке сервисов выберите **{{ ydb-name }}**.
        1. Выберите базу из списка.
        1. Перейдите на вкладку **Навигация**.
        1. Проверьте, что база данных {{ ydb-name }} содержит таблицу `public_sensors` с тестовыми данными.

    * {{ ydb-short-name }} CLI

        1. {% if audience != "internal" %}[Подключитесь к базе данных {{ ydb-name }}](../../ydb/operations/connection.md){% else %}Подключитесь к базе данных {{ ydb-name }}{% endif %}.
        1. Проверьте, что база данных содержит таблицу `public_sensors` с тестовыми данными:

            ```bash
            ydb table query execute \
              --query "SELECT * \
              FROM public_sensors"
            ```

    {% endlist %}

1. [Подключитесь к кластеру-источнику {{ mpg-name }}](../../managed-postgresql/operations/connect.md) и добавьте данные в таблицу `sensors`:

    ```sql
    INSERT INTO public.sensors VALUES
        ('iv7b74th678tooxh5ur2', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
    ```

1. Убедитесь, что в базе данных {{ ydb-name }} отобразились сведения о добавленной строке:

    {% list tabs %}

    * Консоль управления

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужная база данных.
        1. В списке сервисов выберите **{{ ydb-name }}**.
        1. Выберите базу из списка.
        1. Перейдите на вкладку **Навигация**.
        1. Проверьте, что в таблицу `public_sensors` добавились новые данные.

    * {{ ydb-short-name }} CLI

        1. {% if audience != "internal" %}[Подключитесь к базе данных {{ ydb-name }}](../../ydb/operations/connection.md){% else %}Подключитесь к базе данных {{ ydb-name }}{% endif %}.
        1. Проверьте, что в таблицу `public_sensors` добавились новые данные:

            ```bash
            ydb table query execute \
              --query "SELECT * \
              FROM public_sensors"
            ```

    {% endlist %}

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:

{% list tabs %}

* Вручную

    1. [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate) и [удалите трансфер](../../data-transfer/operations/transfer.md#delete).
    1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для приемника и источника.
    1. Если при создании эндпоинта для приемника вы создавали сервисный аккаунт, {% if audience != "internal" %}[удалите его](../../iam/operations/sa/delete.md){% else %}удалите его{% endif %}.
    1. {% if audience != "internal" %}[Удалите базу данных {{ ydb-name }}](../../ydb/operations/manage-database.md#delete-db){% else %}Удалите базу данных {{ ydb-name }}{% endif %}.
    1. [Удалите кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).

* С помощью {{ TF }}

    1. В терминале перейдите в рабочую директорию с конфигурационным файлом `data-transfer-mpg-ydb.tf`.
    1. Удалите ресурсы с помощью команды:

        ```bash
        terraform destroy
        ```

    1. Введите слово `yes` и нажмите **Enter**.

        Все ресурсы, которые были описаны в конфигурационном файле `data-transfer-mpg-ydb.tf`, будут удалены.

{% endlist %}
