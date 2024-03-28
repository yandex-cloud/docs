# Создание внешнего источника данных Hive

В {{ mgp-name }} в качестве [внешнего источника данных](../../concepts/external-tables.md#pxf-data-sources) с типом подключения Hive можно использовать СУБД Hive в составе сервиса [{{ dataproc-full-name }}](../../../data-proc/index.yaml) или другие сторонние сервисы Hive.

Чтобы создать внешний источник данных Hive:

{% list tabs group=instructions %}


* API {#api}

    Чтобы добавить источник данных Hive в кластер {{ mgp-name }}, воспользуйтесь методом REST API [create](../../api-ref/PXFDatasource/create.md) для ресурса [PXFDatasource](../../api-ref/PXFDatasource/index.md) или вызовом gRPC API [PXFDatasourceService/Create](../../api-ref/grpc/pxf_service.md#Create) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](../cluster-list.md#list-clusters).
    * Имя источника в параметре `name`.
    * Настройки внешнего источника в параметре `hive`.

{% endlist %}

## Пример запроса REST API {#example}

В примере ниже рассматривается, как создать внешний источник данных Hive с помощью REST API {{ mgp-name }}. Чтобы создать источник:

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
                \"name\": \"hive:text\",
                \"hive\": {
                    \"kerberos\": {
                        \"enable\": true
                    }
                }
            }
        }"
    ```

    В теле запроса передаются параметры:

    * `name` — имя источника, например `hive:text`.
    * `enable` — активация [протокола Kerberos](https://ru.wikipedia.org/wiki/Kerberos) для аутентификации клиента и сервера (опциональный параметр).

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
