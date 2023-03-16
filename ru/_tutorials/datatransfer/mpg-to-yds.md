Вы можете настроить асинхронную репликацию данных из {{ mpg-full-name }} в {{ yds-full-name }} с помощью сервиса {{ data-transfer-full-name }}. Для этого:

1. [Подготовьте трансфер](#prepare-transfer).
1. [Активируйте трансфер](#activate-transfer).
1. [Проверьте работу репликации](#check-replication).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs %}

* Вручную

    1. [Создайте кластер-источник {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md) любой подходящей [конфигурации](../../managed-postgresql/concepts/instance-types.md) с хостами в публичном доступе и следующими настройками:
        * Имя базы — `db1`.
        * Имя пользователя — `pg-user`.
        * Пароль — `<пароль пользователя>`.

    {% if audience != "internal" %}

    1. Настройте [группы безопасности](../../managed-postgresql/operations/connect.md#configuring-security-groups) и убедитесь, что они допускают подключение к кластеру.

        {% include [preview-pp.md](../../_includes/preview-pp.md) %}

    {% endif %}

    1. [Выдайте роль](../../managed-postgresql/operations/grant.md#grant-privilege) `mdb_replication` пользователю `pg-user`.

    1. {% if audience != "internal" %}[Создайте базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md#create-db){% else %}Создайте базу данных {{ ydb-name }}{% endif %} с именем `ydb-example` любой подходящей конфигурации.

    1. {% if audience != "internal" %}[Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa){% else %}Создайте сервисный аккаунт{% endif %} с именем `yds-sa` и ролью `yds.editor`. Трансфер будет использовать его для доступа к {{ yds-name }}.

* С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, {% if audience != "internal" %}[установите и настройте его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите и настройте его{% endif %}.
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и {% if audience != "internal" %}[укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}укажите значения параметров{% endif %}.
    1. Скачайте в ту же рабочую директорию файл конфигурации [postgresql-yds.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/postgresql-yds.tf).

        В этом файле описаны:

        * {% if audience != "internal" %}[сеть](../../vpc/concepts/network.md#network){% else %}сеть{% endif %};
        * {% if audience != "internal" %}[подсеть](../../vpc/concepts/network.md#subnet){% else %}подсеть{% endif %};
        * {% if audience != "internal" %}[группа безопасности](../../vpc/concepts/security-groups.md){% else %}группа безопасности{% endif %}, необходимая для подключения к кластеру;
        * кластер-источник {{ mpg-name }};
        * база данных {{ ydb-name }};
        * сервисный аккаунт, который будет использоваться для доступа к {{ yds-name }};
        * эндпоинт для источника;
        * трансфер.

    1. Укажите в файле `postgresql-yds.tf` пароль пользователя {{ PG }}.

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

## Подготовьте трансфер {#prepare-transfer}

1. {% if audience != "internal" and product == "yandex-cloud" %}[Создайте поток данных {{ yds-name }}](../../data-streams/operations/aws-cli/create.md){% else %}Создайте поток данных {{ yds-name }}{% endif %} с именем `mpg-stream`.

1. [Подключитесь к кластеру {{ mpg-name }}](../../managed-postgresql/operations/connect.md), создайте в базе данных `db1` таблицу `measurements` и заполните ее данными:

    ```sql
    CREATE TABLE measurements (
        device_id varchar(200) NOT NULL,
        datetime timestamp NOT NULL,
        latitude real NOT NULL,
        longitude real NOT NULL,
        altitude real NOT NULL,
        speed real NOT NULL,
        battery_voltage real,
        cabin_temperature real NOT NULL,
        fuel_level real,
        PRIMARY KEY (device_id)
    );
    INSERT INTO measurements VALUES
        ('iv9a94th6rztooxh5ur2', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qmz3sdbrbu', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
    ```

1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/data-streams.md) типа `{{ yds-name }}` со следующими настройками:

    * База данных — `ydb-example`.
    * Поток — `mpg-stream`.
    * Сервисный аккаунт — `yds-sa`.

1. Создайте эндпоинт-источник и трансфер:

    {% list tabs %}

    * Вручную

        1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/postgresql.md) типа `{{ PG }}` и укажите в нем параметры подключения к кластеру:

            * **Тип подключения** — `Кластер Managed Service for PostgreSQL`.
            * **Кластер** — `<имя кластера-источника {{ PG }}>` из выпадающего списка.
            * **База данных** — `db1`.
            * **Пользователь** — `pg-user`.
            * **Пароль** — `<пароль пользователя>`.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-copy-repl }}_, использующий созданные эндпоинты.

    * С помощью {{ TF }}

        1. Укажите в файле `postgresql-yds.tf` переменные:

            * `yds_endpoint_id` — значение идентификатора эндпоинта для приемника;
            * `transfer_enabled` – значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

## Активируйте трансфер {#activate-transfer}

1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус _{{ dt-status-repl }}_.

{% include [get-yds-data](../../_includes/data-transfer/get-yds-data.md) %}

## Проверьте работу репликации {#check-replication}

1. Подключитесь к кластеру-источнику.
1. Добавьте в таблицу `measurements` новую строку:

    ```sql
    INSERT INTO measurements VALUES
        ('ad02l5ck6sdtrh7ks4hj', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 19, 45);
    ```

1. Убедитесь, что новая строка отобразилась в потоке данных {{ yds-name }}.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

* [Деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate) и дождитесь его перехода в статус _{{ dt-status-stopped }}_.
* [Удалите эндпоинт-приемник](../../data-transfer/operations/endpoint/index.md#delete).
* [Удалите поток данных {{ yds-name }}](../../data-streams/operations/manage-streams.md#delete-data-stream).
* Удалите трансфер, эндпоинт-источник, кластер {{ mpg-name }} и базу {{ ydb-name }}:

    {% list tabs %}

    * Вручную

        * [Трансфер](../../data-transfer/operations/transfer.md#delete).
        * [Эндпоинт-источник](../../data-transfer/operations/endpoint/index.md#delete).
        * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).
        * [Базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md#delete-db).

    * С помощью {{ TF }}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        1. Удалите конфигурационный файл `postgresql-yds.tf`.
        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Подтвердите изменение ресурсов.

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Все ресурсы, которые были описаны в конфигурационном файле `postgresql-yds.tf`, будут удалены.

    {% endlist %}
