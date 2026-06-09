# Создание внешнего источника данных JDBC

В {{ mgp-name }} в качестве [внешнего источника данных](../../concepts/external-tables.md#pxf-data-sources) с типом подключения JDBC можно использовать:

* {{ CH }};
* {{ MY }};
* Oracle;
* {{ PG }};
* {{ MS }};
* {{ TR }}.

В этот список входят управляемые БД {{ yandex-cloud }} и сторонние БД.

## Создайте внешний источник {#create-external-source}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}).
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Откройте страницу нужного кластера {{ mgp-name }}.
    1. На панели слева выберите ![image](../../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.greenplum.label_pxf }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.greenplum.cluster.pxf.action_create-datasource }}**.
    1. Выберите тип подключения `{{ ui-key.yacloud.greenplum.cluster.pxf.value_jdbc }}`.
    1. Укажите имя источника.
    1. Задайте хотя бы одну [опциональную настройку](../../concepts/settings-list.md#jdbc-settings).
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

    После создания внешнего источника данных [создайте внешнюю таблицу](create-table.md).

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать внешний источник данных JDBC:

    1. Посмотрите описание команды CLI для создания источника данных:

        ```bash
        {{ yc-mdb-gp }} pxf-datasource create jdbc --help
        ```

    1. Задайте настройки источника данных:

        ```bash
        {{ yc-mdb-gp }} pxf-datasource create jdbc <имя_внешнего_источника_данных> \
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

            * `jdbc:mysql://mysqlhost:{{ port-mmy }}/testdb` — для локальной БД {{ MY }}.
            * `jdbc:postgresql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mpg }}/db1` — для кластера {{ mpg-full-name }}. Адрес содержит [особый FQDN](../../../managed-postgresql/operations/connect/fqdn.md#special-fqdns) мастера в кластере.
            * `jdbc:oracle:thin:@host.example:1521:orcl` — для БД Oracle.

        * `user` — имя пользователя, владельца БД.
        * `password` — пароль пользователя БД.

        Вы также можете указать [дополнительные настройки](../../concepts/settings-list.md#jdbc-settings).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [PXFDatasource.Create](../../api-ref/PXFDatasource/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>/pxf_datasources' \
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

    1. Воспользуйтесь вызовом [PXFDatasourceService.Create](../../api-ref/grpc/PXFDatasource/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.PXFDatasourceService.Create
        ```

        Где:

        * `name` — имя внешнего источника данных.
        * `jdbc` — настройки внешнего источника данных. Задайте хотя бы одну [опциональную настройку](../../concepts/settings-list.md#jdbc-settings).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/PXFDatasource/create.md#yandex.cloud.operation.Operation).

- SQL {#sql}

  Этот способ подходит для {{ mgp-name }}, использующего [Apache Cloudberry™](https://cloudberry.apache.org).
  
  Чтобы создать внешний источник данных, выполните следующие действия:

  1. Создайте внешний источник данных: 

      ```sql
      CREATE SERVER "<локальное_имя_источника>"
        FOREIGN DATA WRAPPER jdbc_pxf_fdw
        OPTIONS (
          jdbc_driver '<имя_класса_JDBC_драйвера>',
          db_url 'jdbc:<тип_СУБД>://<FQDN_кластера>:<порт>/<имя_БД>',
          user '<имя_пользователя>',
          pass '<пароль>'
        );
      ```
  
  1. Создайте сопоставление локального пользователя с пользователем на внешнем источнике:
  
      ```sql
      CREATE USER MAPPING FOR CURRENT_USER
        SERVER "<локальное_имя_источника>";
      ```

{% endlist %}

{% note tip %}

После создания внешнего источника данных [создайте внешнюю таблицу](create-table.md).

{% endnote %}

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._