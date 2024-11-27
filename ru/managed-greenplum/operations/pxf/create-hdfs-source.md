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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

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

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

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
                    "hdfs": {
                      "core": {
                        "default_fs": "<тип_хранения>"
                      },
                      ...
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.PXFDatasourceService.Create
        ```

        Где:

        * `name` — имя внешнего источника данных.
        * `hdfs` — настройки внешнего источника данных. Задайте хотя бы одну [опциональную настройку](../../concepts/settings-list.md#hdfs-settings).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/PXFDatasource/create.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
