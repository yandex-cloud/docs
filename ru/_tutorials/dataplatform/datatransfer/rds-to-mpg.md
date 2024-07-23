

Чтобы настроить перенос данных из базы [Amazon RDS for {{ PG }}](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html) в базу {{ mpg-name }} с помощью сервиса {{ data-transfer-name }}:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Перенос данных работает для версий {{ PG }}, начиная с 9.4. Версия {{ PG }} в {{ mpg-name }} должна быть не старше, чем версия {{ PG }} в Amazon RDS.

{% note info %}

Использование сервисов Amazon не входит в [условия использования {{ yandex-cloud }}]({{ link-cloud-terms-of-use }}) и является предметом отдельного регулирования между клиентом и Amazon. Яндекс не несет ответственности за взаимоотношения клиента и Amazon, вытекающие из использования клиентом продуктов или услуг Amazon.

{% endnote %}

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. Если у вас нет аккаунта AWS, [создайте](https://aws.amazon.com) его.
    1. В Amazon RDS [создайте группу параметров](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithDBInstanceParamGroups.html) и установите в ней параметр `rds.logical_replication` в значение `1`. Остальные параметры можно оставить по умолчанию.
    1. [Создайте инстанс Amazon RDS for {{ PG }}](https://aws.amazon.com/ru/getting-started/hands-on/create-connect-postgresql-db/) (кластер-источник).

        При создании инстанса выполните необходимые настройки:

        * Включите для инстанса публичный доступ.
        * В группу безопасности инстанса добавьте правило, разрешающее входящий TCP-трафик с любых IP-адресов на порт инстанса {{ PG }} (по умолчанию — `5432`).
        * Назначьте инстансу созданную ранее группу параметров.

        {% note info %}

        Если вы изменили группу параметров существующего инстанса, перезагрузите инстанс, чтобы изменения вступили в силу. На время перезагрузки инстанс станет недоступен.

        {% endnote %}

    1. [Создайте кластер-приемник {{ mpg-name }}](../../../managed-postgresql/operations/cluster-create.md#create-cluster) любой подходящей конфигурации с хостами в публичном доступе и следующими настройками:

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `mpg_db`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `mpg_user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — `<пароль_приемника>`.

    1. Убедитесь, что группа безопасности кластера {{ mpg-name }} [настроена правильно](../../../managed-postgresql/operations/connect.md#configuring-security-groups) и допускает подключение к кластеру через интернет.
    1. Настройте [NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) в интернет для подсети, в которой расположен кластер-приемник.
    1. [Скачайте сертификат AWS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html#UsingWithRDS.SSL.RegionCertificates) для региона, в котором расположен инстанс Amazon RDS for {{ PG }}.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}

    1. Настройте [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html). Провайдер AWS для {{ TF }} использует конфигурацию AWS CLI для доступа к сервису.
    1. [Настройте провайдер {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf) и поместите в отдельную рабочую директорию.
    1. Отредактируйте файл `provider.tf`:

        * [Укажите значения параметров](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider) для провайдера `yandex`. Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.
        * Добавьте провайдер `aws` в блок `required_providers`:

            ```hcl
            required_providers {
              ...
              aws = {
                source  = "hashicorp/aws"
                version = ">= 3.70"
              }
            }
            ```

        * Добавьте описание провайдера `aws`, указав в параметрах регион, в котором будет расположен инстанс Amazon RDS for {{ PG }} (в примере `eu-north-1`):

            ```hcl
            provider "aws" {
              region = "eu-north-1"
            }
            ```

    1. Скачайте в ту же рабочую директорию файл конфигурации [rds-pg-mpg.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-postgresql-from-aws-rds/blob/main/rds-pg-mpg.tf).

        В этом файле описаны:

        * Инфраструктура, необходимая для работы инстанса Amazon RDS for {{ PG }}:

            * группа подсетей;
            * правило для группы безопасности;
            * группа параметров.

            Инстанс будет использовать сеть, подсети и группу безопасности, существующие по умолчанию.

        * Инстанс Amazon RDS for {{ PG }} (кластер-источник).
        * Инфраструктура, необходимая для работы кластера-приемника {{ mpg-name }}:

            * [сеть](../../../vpc/concepts/network.md#network) и [подсеть](../../../vpc/concepts/network.md#subnet);
            * [NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) для доступа кластера в интернет;
            * [группа безопасности](../../../vpc/concepts/security-groups.md).

        * Кластер-приемник {{ mpg-name }}.
        * Эндпоинты для источника и приемника.
        * Трансфер.

    1. [Скачайте сертификат AWS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html#UsingWithRDS.SSL.RegionCertificates) для региона, в котором будет расположен инстанс Amazon RDS for {{ PG }}.
    1. Укажите в файле `rds-pg-mpg.tf`:

        * Версии {{ PG }} для Amazon RDS for {{ PG }} и {{ mpg-name }}.
        * Семейство параметров для [группы параметров](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithDBInstanceParamGroups.html) Amazon RDS.
        * Путь к скачанному ранее сертификату AWS.
        * Пароли пользователей Amazon RDS for {{ PG }} и {{ mpg-name }}.

    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте тестовые данные {#prepare-data}

1. Установите утилиту `psql`:

    ```bash
    sudo apt update && sudo apt install --yes postgresql-client
    ```

1. Подключитесь к базе данных в кластере-источнике Amazon RDS for {{ PG }}:

    ```bash
    psql "host=<URL_хоста> \
    port=<порт_{{ PG }}> \
    sslmode=verify-full \
    sslrootcert=<путь_к_файлу_сертификата> \
    dbname=<имя_БД> \
    user=<имя_пользователя>"
    ```

    По умолчанию порт {{ PG }} — `5432`.

    {% note info %}

    Подключение к инстансу через интернет может стать доступно не сразу, а в течение часа с момента создания.

    {% endnote %}

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

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте эндпоинт-источник](../../../data-transfer/operations/endpoint/source/mysql.md) типа `{{ PG }}` и укажите в нем параметры подключения к кластеру:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.on_premise.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.host.title }}** — URL хоста.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.port.title }}** — `5432`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.ca_certificate.title }}** — выберите файл сертификата AWS.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.database.title }}** — `postgres`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.user.title }}** — `postgres`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.password.title }}** — `<пароль_пользователя>`.

    1. [Создайте эндпоинт-приемник](../../../data-transfer/operations/endpoint/target/postgresql.md) типа `{{ PG }}` и укажите в нем параметры подключения к кластеру:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}** — `<имя_кластера_приемника>` из выпадающего списка.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.database.title }}** — `mpg_db`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.user.title }}** — `mpg_user`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.password.title }}** — `<пароль_пользователя>`.

    1. [Создайте трансфер](../../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**, использующий созданные эндпоинты.
    1. [Активируйте трансфер](../../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

- {{ TF }} {#tf}

    1. Укажите в файле `rds-pg-mpg.tf` значение `1` для параметра `transfer_enabled`.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    1. Трансфер активируется автоматически. Дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

{% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

Чтобы убедиться в работоспособности трансфера, проверьте работу копирования и репликации.

### Проверьте работу копирования {#verify-copy}

1. [Подключитесь к базе данных в кластере-приемнике {{ mpg-name }}](../../../managed-postgresql/operations/connect.md).
1. Выполните запрос:

    ```sql
    SELECT * FROM measurements;
    ```

### Проверьте работу репликации {#verify-replication}

1. Подключитесь к базе данных в кластере-источнике Amazon RDS for {{ PG }}:

    ```bash
    psql "host=<URL_хоста> \
    port=<порт_{{ PG }}> \
    sslmode=verify-full \
    sslrootcert=<путь_к_файлу_сертификата> \
    dbname=<имя_БД> \
    user=<имя_пользователя>"
    ```

    По умолчанию порт {{ PG }} — `5432`.

1. Добавьте данные в таблицу `measurements`:

    ```sql
    INSERT INTO measurements VALUES
    ('iv7b74th678tooxdagrf', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
    ```

1. Убедитесь, что добавленная строка появилась в базе данных приемника:

    1. [Подключитесь к базе данных в кластере-приемнике {{ mpg-name }}](../../../managed-postgresql/operations/connect.md).
    1. Выполните запрос:

        ```sql
        SELECT * FROM measurements;
        ```

    {% note info %}

    Репликация данных может занять несколько минут.

    {% endnote %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    * [Трансфер](../../../data-transfer/operations/transfer.md#delete).
    * [Эндпоинты](../../../data-transfer/operations/endpoint/index.md#delete).
    * [Инстанс Amazon RDS for {{ PG }}](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html).
    * [Кластер {{ mpg-name }}](../../../managed-postgresql/operations/cluster-delete.md).
    * [Таблицу маршрутизации](../../../vpc/operations/delete-route-table.md).
    * [NAT-шлюз](../../../vpc/operations/delete-nat-gateway.md).

- {{ TF }} {#tf}

    Если вы создавали ресурсы с помощью {{ TF }}:

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `rds-pg-mpg.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `rds-pg-mpg.tf`, будут удалены.

{% endlist %}
