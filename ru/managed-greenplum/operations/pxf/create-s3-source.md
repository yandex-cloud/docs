# Создание внешнего источника данных S3

В {{ mgp-name }} в качестве [внешнего источника данных](../../concepts/external-tables.md#pxf-data-sources) с типом подключения S3 можно использовать сервис [{{ objstorage-full-name }}](../../../storage/index.yaml) или другие сторонние сервисы S3.

Перед началом работы [создайте статический ключ доступа](../../../iam/operations/sa/create-access-key.md). Его данные нужно будет указать в параметрах источника.

Чтобы создать внешний источник данных S3:

{% list tabs group=instructions %}


* API {#api}

    Чтобы добавить источник данных S3 в кластер {{ mgp-name }}, воспользуйтесь методом REST API [create](../../api-ref/PXFDatasource/create.md) для ресурса [PXFDatasource](../../api-ref/PXFDatasource/index.md) или вызовом gRPC API [PXFDatasourceService/Create](../../api-ref/grpc/pxf_service.md#Create) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](../cluster-list.md#list-clusters).
    * Имя источника в параметре `name`.
    * Настройки внешнего источника в параметре `s3`.

{% endlist %}

## Пример запроса REST API {#example}

В примере ниже рассматривается, как создать внешний источник данных для бакета {{ objstorage-name }} с помощью REST API {{ mgp-name }}. Чтобы создать источник:

1. [Получите IAM-токен](../../../iam/operations/index.md#iam-tokens). Он используется для аутентификации в API.
1. Добавьте IAM-токен в переменную окружения:

    ```bash
    export IAM_TOKEN=<токен>
    ```

1. Создайте статический ключ доступа.
1. Отправьте запрос с помощью утилиты [cURL](https://curl.haxx.se):

    ```bash
    curl --location "https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>/pxf_datasources" \
         --header "Content-Type: text/plain" \
         --header "Authorization: Bearer ${IAM_TOKEN}" \
         --data "{
             \"datasource\": {
                 \"name\": \"s3:csv\",
                 \"s3\": {
                     \"accessKey\": \"<идентификатор_ключа>\",
                     \"secretKey\": \"<секретный_ключ>\",
                     \"endpoint\": \"{{ s3-storage-host }}\"
                 }
             }
        }"
    ```

    В теле запроса передаются параметры:

    * `name` — имя источника, например `s3:csv`.
    * `accessKey` — идентификатор статического ключа доступа.
    * `secretKey` — секретный ключ. Является частью статического ключа.
    * `endpoint` — адрес {{ objstorage-name }}.

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
