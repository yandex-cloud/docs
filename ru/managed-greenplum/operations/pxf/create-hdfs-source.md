# Создание внешнего источника данных HDFS

В {{ mgp-name }} в качестве [внешнего источника данных](../../concepts/external-tables.md#pxf-data-sources) с типом подключения HDFS можно использовать систему HDFS в составе сервиса [{{ dataproc-full-name }}](../../../data-proc/index.yaml) или другие сторонние сервисы HDFS.

## Создайте внешний источник {#create-external-source}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Откройте страницу нужного кластера {{ mgp-name }}.
    1. На панели слева выберите ![image](../../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.greenplum.label_pxf }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.greenplum.cluster.pxf.action_create-datasource }}**.
    1. Выберите тип подключения `{{ ui-key.yacloud.greenplum.cluster.pxf.value_hdfs }}`.
    1. Укажите имя источника.
    1. Задайте хотя бы одну [опциональную настройку](../../concepts/settings-list.md#hdfs-settings).
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- API {#api}

    Чтобы добавить источник данных HDFS в кластер {{ mgp-name }}, воспользуйтесь методом REST API [create](../../api-ref/PXFDatasource/create.md) для ресурса [PXFDatasource](../../api-ref/PXFDatasource/index.md) или вызовом gRPC API [PXFDatasourceService/Create](../../api-ref/grpc/pxf_service.md#Create) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](../cluster-list.md#list-clusters).
    * Имя источника в параметре `name`.
    * Настройки внешнего источника в параметре `hdfs`.

{% endlist %}

## Пример запроса REST API {#example}

В примере ниже рассматривается, как создать внешний источник данных HDFS с помощью REST API {{ mgp-name }}. Чтобы создать источник:

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
                \"name\": \"hdfs:csv\",
                \"hdfs\": {
                    \"core\": {
                        \"defaultFs\": \"<тип_хранения:_DISK_или_ARCHIVE>\"
                    }
                }
            }
        }"
    ```

    В теле запроса передаются параметры:

    * `name` — имя источника, например `hdfs:csv`.
    * `defaultFs` — тип хранения данных, используемый по умолчанию (опциональный параметр). Возможные значения:

        * `DISK` — хранение данных на физическом диске.
        * `ARCHIVE` — архивное хранение данных. В этом случае можно разместить в HDFS больше данных, но скорость их обработки будет ниже.

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
