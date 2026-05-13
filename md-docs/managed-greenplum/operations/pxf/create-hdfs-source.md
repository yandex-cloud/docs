# Создание внешнего источника данных HDFS

В Yandex MPP Analytics for PostgreSQL в качестве [внешнего источника данных](../../concepts/external-tables.md#pxf-data-sources) с типом подключения HDFS можно использовать систему HDFS в составе сервиса [Yandex Data Processing](../../../data-proc/index.md) или другие сторонние сервисы HDFS.

## Создайте внешний источник {#create-external-source}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
    1. Откройте страницу нужного кластера Greenplum®.
    1. На панели слева выберите ![image](../../../_assets/console-icons/arrow-right-arrow-left.svg) **PXF**.
    1. Нажмите кнопку **Создать источник данных**.
    1. Выберите тип подключения `HDFS`.
    1. Укажите имя источника.
    1. Задайте хотя бы одну [опциональную настройку](../../concepts/settings-list.md#hdfs-settings).
    1. Нажмите кнопку **Создать**.

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
                        "hdfs": {
                          "core": {
                            "defaultFs": "<тип_хранения>"
                          },
                          ...
                        }
                      }
                    }'
        ```

        Где:

        * `name` — имя внешнего источника данных.
        * `hdfs` — настройки внешнего источника данных. Задайте хотя бы одну [опциональную настройку](../../concepts/settings-list.md#hdfs-settings).

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
                    "hdfs": {
                      "core": {
                        "default_fs": "<тип_хранения>"
                      },
                      ...
                    }
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.greenplum.v1.PXFDatasourceService.Create
        ```

        Где:

        * `name` — имя внешнего источника данных.
        * `hdfs` — настройки внешнего источника данных. Задайте хотя бы одну [опциональную настройку](../../concepts/settings-list.md#hdfs-settings).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/PXFDatasource/create.md#yandex.cloud.operation.Operation).

{% endlist %}

После создания внешнего источника данных [создайте внешнюю таблицу](create-table.md).

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._