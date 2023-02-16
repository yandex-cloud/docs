# Асинхронная репликация данных из {{ mmy-full-name }} в {{ ydb-full-name }} с помощью {{ data-transfer-full-name }}

С помощью сервиса {{ data-transfer-name }} вы можете перенести данные из кластера-источника {{ mmy-name }} в {{ ydb-name }}.

Чтобы перенести данные:

1. [Подготовьте кластер-источник](#prepare-source).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs %}

* Вручную

    1. [Создайте кластер-источник {{ mmy-name }}](../../managed-mysql/operations/cluster-create.md) любой подходящей конфигурации.

    1. {% if audience != "internal" and product == "yandex-cloud" %}[Создайте базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md#create-db){% else %}Создайте базу данных {{ ydb-name }}{% endif %} любой подходящей конфигурации.

    1. [Настройте группы безопасности](../../managed-kafka/operations/connect.md#configuring-security-groups) кластера {{ mmy-name }}, чтобы к нему можно было подключаться из интернета.

* С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, {% if audience != "internal" %}[установите и настройте его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите и настройте его{% endif %}.
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и {% if audience != "internal" %}[укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}укажите значения параметров{% endif %}.
    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mmy-ydb.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-mmy-ydb.tf).

        В этом файле описаны:

        * {% if audience != "internal" %}[сеть](../../vpc/concepts/network.md#network){% else %}сеть{% endif %};
        * {% if audience != "internal" %}[подсеть](../../vpc/concepts/network.md#subnet){% else %}подсеть{% endif %};
        * {% if audience != "internal" %}[группа безопасности](../../vpc/concepts/security-groups.md){% else %}группа безопасности{% endif %} и правило, необходимое для подключения к кластеру {{ mmy-name }};
        * кластер-источник {{ mmy-name }};
        * база данных {{ ydb-name }};
        * эндпоинт для источника;
        * трансфер.

    1. Укажите в файле `data-transfer-mmy-ydb.tf`:

        * параметры кластера-источника {{ mmy-name }}, которые будут использоваться как [параметры эндпоинта-источника](../../data-transfer/operations/endpoint/target/mysql.md#managed-service):

            * `source_mysql_version` — версия {{ MY }};
            * `source_db_name` — имя базы данных;
            * `source_user` и `source_password` — имя и пароль пользователя-владельца базы данных.

        * `target_db_name` — имя базы данных {{ ydb-name }}.

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

1. Если создавали инфраструктуру вручную, [подготовьте кластер-источник](../../data-transfer/operations/prepare.md#source-my).

1. [Подключитесь к кластеру-источнику {{ mmy-name }}](../../managed-mysql/operations/connect.md).

1. Наполните базу тестовыми данными. В качестве примера используется простая таблица, содержащая информацию, поступающую от некоторых датчиков автомобиля.

    Создайте таблицу:

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
    ```

    Наполните таблицу данными:

    ```sql
    INSERT INTO measurements VALUES
        ('iv9a94th6rztooxh5ur2', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qmz3sdbrbu', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

    * **Тип базы данных** — `YDB`.
    * **Параметры эндпоинта**:

        * **Настройки подключения** → **База данных** — выберите базу данных {{ ydb-name }} из списка.
        * **ID сервисного аккаунта** — выберите или создайте сервисный аккаунт с ролью `ydb.editor`.

1. Создайте эндпоинт для источника и трансфер:

    {% list tabs %}

    * Вручную

        1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

            * **Тип базы данных** — `{{ MY }}`.
            * **Параметры эндпоинта** → **Настройки подключения** — `Кластер {{ mmy-name }}`.

                Выберите кластер-источник из списка и укажите настройки подключения к нему.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-copy-repl }}_, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    * С помощью {{ TF }}

        1. Раскомментируйте в файле `data-transfer-mmy-ydb.tf`:

            * переменную `target_endpoint_id` и задайте ей значение идентификатора эндпоинта для приемника, созданного на предыдущем шаге;
            * ресурсы `yandex_datatransfer_endpoint` и `yandex_datatransfer_transfer`.

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

1. Убедитесь, что в базу данных {{ ydb-name }} перенеслись данные из кластера-источника {{ mmy-name }}:

    {% list tabs %}

    * Консоль управления

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужная база данных.
        1. В списке сервисов выберите **{{ ydb-name }}**.
        1. Выберите базу из списка.
        1. Перейдите на вкладку **Навигация**.
        1. Проверьте, что база данных {{ ydb-name }} содержит таблицу `<имя базы данных кластера-источника>_measurements` с тестовыми данными.

    * CLI

        1. {% if audience != "internal" and product == "yandex-cloud" %}[Подключитесь к базе данных {{ ydb-name }}](../../ydb/operations/connection.md){% else %}Подключитесь к базе данных {{ ydb-name }}{% endif %}.
        1. Проверьте, что база данных содержит таблицу `<имя базы данных кластера-источника>_measurements` с тестовыми данными:

            ```sql
            SELECT *
            FROM <имя базы данных кластера-источника>_measurements;
            ```

    {% endlist %}

1. [Подключитесь к кластеру-источнику {{ mmy-name }}](../../managed-mysql/operations/connect.md) и добавьте данные в таблицу `measurements`:

    ```sql
    INSERT INTO measurements VALUES
        ('iv7b74th678tooxh5ur2', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
    ```

1. Убедитесь, что в базе данных {{ ydb-name }} отобразились сведения о добавленной строке:

    {% list tabs %}

    * Консоль управления

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужная база данных.
        1. В списке сервисов выберите **{{ ydb-name }}**.
        1. Выберите базу из списка.
        1. Перейдите на вкладку **Навигация**.
        1. Проверьте, что в таблицу `<имя базы данных кластера-источника>_measurements` добавились новые данные.

    * CLI

        1. {% if audience != "internal" and product == "yandex-cloud" %}[Подключитесь к базе данных {{ ydb-name }}](../../ydb/operations/connection.md){% else %}Подключитесь к базе данных {{ ydb-name }}{% endif %}.
        1. Проверьте, что в таблицу `<имя базы данных кластера-источника>_measurements` добавились новые данные:

            ```sql
            SELECT *
            FROM <имя базы данных кластера-источника>_measurements;
            ```

    {% endlist %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для приемника.
1. Если при создании эндпоинта для приемника вы создавали сервисный аккаунт, {% if audience != "internal" %}[удалите его](../../iam/operations/sa/delete.md){% else %}удалите его{% endif %}.

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs %}

* Вручную

    * [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для источника.
    * {% if audience != "internal" and product == "yandex-cloud" %}[Удалите базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md#delete-db){% else %}Удалите базу данных {{ ydb-name }}{% endif %}.
    * [Удалите кластер {{ mmy-name }}](../../managed-mysql/operations/cluster-delete.md).

* С помощью {{ TF }}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `data-transfer-mmy-ydb.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `data-transfer-mmy-ydb.tf`, будут удалены.

{% endlist %}
