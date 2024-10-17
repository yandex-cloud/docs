# Создание внешнего источника данных S3

В {{ mgp-name }} в качестве [внешнего источника данных](../../concepts/external-tables.md#pxf-data-sources) с типом подключения S3 можно использовать сервис [{{ objstorage-full-name }}](../../../storage/index.yaml) или другие сторонние сервисы S3.

Перед началом работы [создайте статический ключ доступа](../../../iam/operations/sa/create-access-key.md). Его данные нужно будет указать в параметрах источника.

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

        * `cluster-id` — идентификатор кластера. Его можно получить со [списком кластеров в каталоге](../cluster-list.md##list-cluster).
        * `access-key`, `secret-key` — [идентификатор и содержимое статического ключа доступа](../../../iam/concepts/authorization/access-key.md).
        * `endpoint` — адрес S3-хранилища. Значение для {{ objstorage-name }} — `{{ s3-storage-host }}`. Это значение используется по умолчанию.
        * `fast-upload` — быстрая загрузка больших файлов в S3-хранилище. Возможные значения:
            * `true` (значение по умолчанию) — PXF формирует файлы на диске перед отправкой в S3-хранилище.
            * `false` — PXF формирует файлы в оперативной памяти (если ее не хватает, то записывает на диск).

- API {#api}

    Чтобы добавить источник данных S3 в кластер {{ mgp-name }}, воспользуйтесь методом REST API [create](../../api-ref/PXFDatasource/create.md) для ресурса [PXFDatasource](../../api-ref/PXFDatasource/index.md) или вызовом gRPC API [PXFDatasourceService/Create](../../api-ref/grpc/PXFDatasource/create.md) и передайте в запросе:

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
