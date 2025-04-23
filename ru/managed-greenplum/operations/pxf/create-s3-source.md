# Создание внешнего источника данных S3

В {{ mgp-name }} в качестве [внешнего источника данных](../../concepts/external-tables.md#pxf-data-sources) с типом подключения S3 можно использовать сервис [{{ objstorage-full-name }}](../../../storage/index.yaml) или другие сторонние сервисы S3.

Перед началом работы [создайте статический ключ доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key). Его данные нужно будет указать в параметрах источника.

## Создайте внешний источник данных

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы создать внешний источник данных S3:

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Откройте страницу нужного кластера {{ mgp-name }}.
    1. На панели слева выберите ![image](../../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.greenplum.label_pxf }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.greenplum.cluster.pxf.action_create-datasource }}**.
    1. Выберите тип подключения `{{ ui-key.yacloud.greenplum.cluster.pxf.value_s3 }}`.
    1. Укажите имя источника.
    1. Задайте хотя бы одну [опциональную настройку](../../concepts/settings-list.md#s3-settings).
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать внешний источник данных S3:

    1. Посмотрите описание команды CLI для создания источника данных:

        ```bash
        {{ yc-mdb-gp }} pxf-datasource create s3 --help
        ```

    1. Задайте настройки источника данных:

        ```bash
        {{ yc-mdb-gp }} pxf-datasource create s3 <имя_внешнего_источника_данных> \
           --cluster-id=<идентификатор_кластера> \
           --access-key=<идентификатор_статического_ключа> \
           --secret-key=<секретная_часть_статического_ключа> \
           --endpoint=<адрес_S3-хранилища> \
           --fast-upload=<быстрая_загрузка>
        ```

        Где:

        * `cluster-id` — идентификатор кластера. Его можно получить со [списком кластеров в каталоге](../cluster-list.md#list-cluster).
        * `access-key`, `secret-key` — [идентификатор и содержимое статического ключа доступа](../../../iam/concepts/authorization/access-key.md).
        * `endpoint` — адрес S3-хранилища. Значение для {{ objstorage-name }} — `{{ s3-storage-host }}`. Это значение используется по умолчанию.
        * `fast-upload` — быстрая загрузка больших файлов в S3-хранилище. Возможные значения:
            * `true` (значение по умолчанию) — PXF формирует файлы на диске перед отправкой в S3-хранилище.
            * `false` — PXF формирует файлы в оперативной памяти (если ее не хватает, то записывает на диск).

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
                        "s3": {
                          "accessKey": "<идентификатор_статического_ключа>",
                          "secretKey": "<секретная_часть_статического_ключа>",
                          "fastUpload": "<быстрая_загрузка>",
                          "endpoint": "<адрес_S3-хранилища>"
                        }
                      }
                    }'
        ```

        Где:

        * `name` — имя внешнего источника данных.
        * `s3` — настройки внешнего источника данных:

            * `accessKey`, `secretKey` — [идентификатор и содержимое статического ключа доступа](../../../iam/concepts/authorization/access-key.md).
            * `fastUpload` — быстрая загрузка больших файлов в S3-хранилище. Возможные значения:
                * `true` (значение по умолчанию) — PXF формирует файлы на диске перед отправкой в S3-хранилище.
                * `false` — PXF формирует файлы в оперативной памяти (если ее не хватает, то записывает на диск).

            * `endpoint` — адрес S3-хранилища. Значение для {{ objstorage-name }} — `{{ s3-storage-host }}`. Это значение используется по умолчанию.

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
                    "s3": {
                      "access_key": "<идентификатор_статического_ключа>",
                      "secret_key": "<секретная_часть_статического_ключа>",
                      "fast_upload": <быстрая_загрузка>,
                      "endpoint": "<адрес_S3-хранилища>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.PXFDatasourceService.Create
        ```

        Где:

        * `name` — имя внешнего источника данных.
        * `s3` — настройки внешнего источника данных:

            * `access_key`, `secret_key` — [идентификатор и содержимое статического ключа доступа](../../../iam/concepts/authorization/access-key.md).
            * `fast_upload` — быстрая загрузка больших файлов в S3-хранилище. Возможные значения:
                * `true` (значение по умолчанию) — PXF формирует файлы на диске перед отправкой в S3-хранилище.
                * `false` — PXF формирует файлы в оперативной памяти (если ее не хватает, то записывает на диск).

            * `endpoint` — адрес S3-хранилища. Значение для {{ objstorage-name }} — `{{ s3-storage-host }}`. Это значение используется по умолчанию.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/PXFDatasource/create.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
