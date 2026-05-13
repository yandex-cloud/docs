# Создание внешнего источника данных JDBC

В Yandex MPP Analytics for PostgreSQL в качестве [внешнего источника данных](../../concepts/external-tables.md#pxf-data-sources) с типом подключения JDBC можно использовать:

* ClickHouse®;
* MySQL®;
* Oracle;
* PostgreSQL;
* SQL Server;
* Trino.

В этот список входят управляемые БД Yandex Cloud и сторонние БД.

## Создайте внешний источник {#create-external-source}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
    1. Откройте страницу нужного кластера Greenplum®.
    1. На панели слева выберите ![image](../../../_assets/console-icons/arrow-right-arrow-left.svg) **PXF**.
    1. Нажмите кнопку **Создать источник данных**.
    1. Выберите тип подключения `JDBC`.
    1. Укажите имя источника.
    1. Задайте хотя бы одну [опциональную настройку](../../concepts/settings-list.md#jdbc-settings).
    1. Нажмите кнопку **Создать**.

    После создания внешнего источника данных [создайте внешнюю таблицу](create-table.md).

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать внешний источник данных JDBC:

    1. Посмотрите описание команды CLI для создания источника данных:

        ```bash
        yc managed-greenplum pxf-datasource create jdbc --help
        ```

    1. Задайте настройки источника данных:

        ```bash
        yc managed-greenplum pxf-datasource create jdbc <имя_внешнего_источника_данных> \
           --cluster-id=<идентификатор_кластера> \
           --driver=<адрес_драйвера> \
           --url=<URL_базы_данных> \
           --user=<имя_пользователя> \
           --password=<пароль>
        ```

        Где:

        * `cluster-id` — идентификатор кластера. Его можно получить со [списком кластеров в каталоге](../cluster-list.md#list-cluster).
        * `driver` — класс JDBC-драйвера в Java. Возможные значения:

            * `com.clickhouse.jdbc.ClickHouseDriver`
            * `com.ibm.as400.access.AS400JDBCDriver`
            * `com.microsoft.sqlserver.jdbc.SQLServerDriver`
            * `com.mysql.cj.jdbc.Driver`
            * `org.postgresql.Driver`
            * `oracle.jdbc.driver.OracleDriver`
            * `net.snowflake.client.jdbc.SnowflakeDriver`
            * `io.trino.jdbc.TrinoDriver`

        * `url` — URL базы данных. Примеры:

            * `jdbc:mysql://mysqlhost:3306/testdb` — для локальной БД MySQL®.
            * `jdbc:postgresql://c-<идентификатор_кластера>.rw.mdb.yandexcloud.net:6432/db1` — для кластера Yandex Managed Service for PostgreSQL. Адрес содержит [особый FQDN](../../../managed-postgresql/operations/connect/fqdn.md#special-fqdns) мастера в кластере.
            * `jdbc:oracle:thin:@host.example:1521:orcl` — для БД Oracle.

        * `user` — имя пользователя, владельца БД.
        * `password` — пароль пользователя БД.

        Вы также можете указать [дополнительные настройки](../../concepts/settings-list.md#jdbc-settings).

    После создания внешнего источника данных [создайте внешнюю таблицу](create-table.md).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [PXFDatasource.Create](../../api-ref/PXFDatasource/create.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>/pxf_datasources' \
            --data '{
                      "datasource": {
                        "name": "<имя_внешнего_источника_данных>",
                        "jdbc": {
                          "driver": "<адрес_драйвера>",
                          "url": "<URL_базы_данных>",
                          "user": "<логин_пользователя>",
                          "password": "<пароль_пользователя>",
                          ...
                        }
                      }
                    }'
        ```

        Где:

        * `name` — имя внешнего источника данных.
        * `jdbc` — настройки внешнего источника данных. Задайте хотя бы одну [опциональную настройку](../../concepts/settings-list.md#jdbc-settings).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/PXFDatasource/create.md#yandex.cloud.operation.Operation).

    После создания внешнего источника данных [создайте внешнюю таблицу](create-table.md).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [PXFDatasourceService.Create](../../api-ref/grpc/PXFDatasource/create.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/pxf_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>"
                  "datasource": {
                    "name": "<имя_внешнего_источника_данных>",
                    "jdbc": {
                      "driver": "<адрес_драйвера>",
                      "url": "<URL_базы_данных>",
                      "user": "<логин_пользователя>",
                      "password": "<пароль_пользователя>",
                      ...
                    }
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.greenplum.v1.PXFDatasourceService.Create
        ```

        Где:

        * `name` — имя внешнего источника данных.
        * `jdbc` — настройки внешнего источника данных. Задайте хотя бы одну [опциональную настройку](../../concepts/settings-list.md#jdbc-settings).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/PXFDatasource/create.md#yandex.cloud.operation.Operation).

    После создания внешнего источника данных [создайте внешнюю таблицу](create-table.md).

- SQL {#sql}

  Этот способ подходит для Yandex MPP Analytics for PostgreSQL, использующего [Apache Cloudberry™](https://cloudberry.apache.org).
  
  Чтобы создать внешний источник данных и внешнюю таблицу с помощью SQL, выполните следующие действия:

  1. Создайте внешний источник данных: 

      ```sql
      CREATE SERVER pgserver
        FOREIGN DATA WRAPPER jdbc_pxf_fdw
        OPTIONS (
          CONFIG 'default',
          JDBC_DRIVER 'org.postgresql.Driver',
          DB_URL 'jdbc:postgresql://host:5432/db',
          USER '<имя_пользователя>',
          PASS '<пароль>'
        );
      ```
  
  1. Создайте сопоставление локального пользователя с пользователем на внешнем источнике:
  
      ```sql
      CREATE USER MAPPING FOR CURRENT_USER
        SERVER "pgserver";
      ```

  1. Создайте внешнюю таблицу:

      ```sql
      CREATE FOREIGN TABLE <имя_таблицы>
        (<имя_столбца> <тип_данных> [, ...])
        SERVER "pgserver";
      ```

{% endlist %}

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._