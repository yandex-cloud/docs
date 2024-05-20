# Создание внешнего источника данных S3

В {{ mgp-name }} в качестве [внешнего источника данных](../../concepts/external-tables.md#pxf-data-sources) с типом подключения S3 можно использовать сервис [{{ objstorage-full-name }}](../../../storage/index.yaml) или другие сторонние сервисы S3.

Перед началом работы [создайте статический ключ доступа](../../../iam/operations/sa/create-access-key.md). Его данные нужно будет указать в параметрах источника.

{% list tabs group=instructions %}

* Консоль управления {#console}

    Чтобы создать внешний источник данных S3:

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Откройте страницу нужного кластера {{ mgp-name }}.
    1. На панели слева выберите ![image](../../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.greenplum.label_pxf }}**.
    1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.greenplum.cluster.pxf.action_create-datasource }}**.
    1. Выберите тип подключения `{{ ui-key.yacloud.greenplum.cluster.pxf.value_s3 }}`.
    1. Укажите имя источника.
    1. Задайте хотя бы одну [опциональную настройку](../../concepts/settings-list.md#s3-settings).
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

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
    curl --location "https://mdb.{{ api-host }}/managed-greenplum/v1/clusters/<идентификатор_кластера>/pxf_datasources" \
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
