# Создание внешнего источника данных JDBC

В {{ mgp-name }} в качестве [внешнего источника данных](../../concepts/external-tables.md#pxf-data-sources) с типом подключения JDBC можно использовать:

* {{ CH }};
* HBase;
* {{ MY }};
* Oracle;
* {{ PG }};
* {{ MS }}.

В этот список входят управляемые БД {{ yandex-cloud }} и сторонние БД.

## Создайте внешний источник {#create-external-source}

{% list tabs group=instructions %}

* Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Откройте страницу нужного кластера {{ mgp-name }}.
    1. На панели слева выберите ![image](../../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.greenplum.label_pxf }}**.
    1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.greenplum.cluster.pxf.action_create-datasource }}**.
    1. Выберите тип подключения `{{ ui-key.yacloud.greenplum.cluster.pxf.value_jdbc }}`.
    1. Укажите имя источника.
    1. Задайте хотя бы одну [опциональную настройку](../../concepts/settings-list.md#jdbc-settings).
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

* API {#api}

    Чтобы добавить источник данных JDBC в кластер {{ mgp-name }}, воспользуйтесь методом REST API [create](../../api-ref/PXFDatasource/create.md) для ресурса [PXFDatasource](../../api-ref/PXFDatasource/index.md) или вызовом gRPC API [PXFDatasourceService/Create](../../api-ref/grpc/pxf_service.md#Create) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](../cluster-list.md#list-clusters).
    * Имя источника в параметре `name`.
    * Настройки внешнего источника в параметре `jdbc`.

{% endlist %}

## Пример запроса REST API {#example}

В примере ниже рассматривается, как создать внешний источник данных для кластера {{ mpg-name }} с помощью REST API {{ mgp-name }}. Чтобы создать источник:

1. [Получите IAM-токен](../../../iam/operations/index.md#iam-tokens). Он используется для аутентификации в API.
1. Добавьте IAM-токен в переменную окружения:

    ```bash
    export IAM_TOKEN=<токен>
    ```

1. Отправьте запрос с помощью утилиты [cURL](https://curl.haxx.se):

    ```bash
    curl --location "https://mdb.{{ api-host }}/managed-greenplum/v1/clusters/<идентификатор_кластера>/pxf_datasources" \
         --header "Content-Type: text/plain" \
         --header "Authorization: Bearer ${IAM_TOKEN}" \
         --data "{
             \"datasource\": {
                 \"name\": \"jdbc\",
                 \"jdbc\": {
                     \"driver\": \"org.postgresql.Driver\",
                     \"url\": \"jdbc:postgresql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mpg }}/<имя_БД>\",
                     \"user\": \"<логин_пользователя>\",
                     \"password\": \"<пароль_пользователя>\"
                 }
             }
         }"
    ```

    В теле запроса передаются параметры:

    * `name` — имя источника, например `jdbc`.
    * `driver` — адрес драйвера для БД.
    * `url` — URL базы данных. Содержит [особый FQDN текущего мастера](../../../managed-postgresql/operations/connect.md#fqdn-master).

        Идентификатор кластера можно [получить со списком кластеров](../../../managed-postgresql/operations/cluster-list.md#list-clusters) в каталоге.

    * `user` — имя пользователя, владельца БД.
    * `password` — пароль пользователя.

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
