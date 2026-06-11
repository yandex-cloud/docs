# Создание внешнего источника данных S3

В Yandex MPP Analytics for PostgreSQL в качестве [внешнего источника данных](../../concepts/external-tables.md#pxf-data-sources) с типом подключения S3 можно использовать сервис [Yandex Object Storage](../../../storage/index.md) в том числе, с подключением к Yandex Object Storage через [Private Endpoint](../../../storage/operations/buckets/access-via-vpc.md). Вы также можете использовать другие сторонние сервисы S3.

Перед началом работы [создайте статический ключ доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key). Его данные нужно будет указать в параметрах источника.

## Создайте внешний источник данных

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы создать внешний источник данных S3:

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
    1. Откройте страницу нужного кластера Yandex MPP Analytics for PostgreSQL.
    1. На панели слева выберите ![image](../../../_assets/console-icons/arrow-right-arrow-left.svg) **PXF**.
    1. Нажмите кнопку **Создать источник данных**.
    1. Выберите тип подключения `S3`.
    1. Укажите имя источника.
    1. Задайте хотя бы одну [опциональную настройку](../../concepts/settings-list.md#s3-settings):

        * В поле **Access Key** введите идентификатор статического ключа доступа, а в поле **Secret Key** — его содержимое.
        
                    
          [Подробнее о статическом ключе доступа](../../../iam/concepts/authorization/access-key.md).
          
        
        * Выберите опцию **Fast Upload**, чтобы включить быструю загрузку больших файлов в S3-хранилище.
    
            По умолчанию опция выбрана.
               
            При использовании быстрой загрузки PXF формирует файлы в оперативной памяти (если ее не хватает, записывает файлы на диск). Если быстрая загрузка не используется, PXF формирует файлы на диске.
        
        * В поле **Endpoint** введите адрес S3-хранилища.
            
            По умолчанию используется Object Storage — `storage.yandexcloud.net`.

    1. Нажмите кнопку **Создать**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать внешний источник данных S3:

    1. Посмотрите описание команды CLI для создания источника данных:

        ```bash
        yc managed-greenplum pxf-datasource create s3 --help
        ```

    1. Задайте настройки источника данных:

        ```bash
        yc managed-greenplum pxf-datasource create s3 <имя_внешнего_источника_данных> \
           --cluster-id=<идентификатор_кластера> \
           --access-key=<идентификатор_статического_ключа> \
           --secret-key=<секретная_часть_статического_ключа> \
           --endpoint=<адрес_S3-хранилища> \
           --fast-upload=<быстрая_загрузка>
        ```

        Где:

        * `cluster-id` — идентификатор кластера. Его можно получить со [списком кластеров в каталоге](../cluster-list.md#list-cluster).
        * `access-key`, `secret-key` — [идентификатор и содержимое статического ключа доступа](../../../iam/concepts/authorization/access-key.md).
        * `endpoint` — адрес S3-хранилища. Значение для Object Storage — `storage.yandexcloud.net`. Это значение используется по умолчанию.
        * `fast-upload` — быстрая загрузка больших файлов в S3-хранилище. Возможные значения:
            * `true` (по умолчанию) — PXF формирует файлы в оперативной памяти (если ее не хватает, записывает файлы на диск).
            * `false` — PXF формирует файлы на диске.

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
                * `true` (по умолчанию) — PXF формирует файлы в оперативной памяти (если ее не хватает, записывает файлы на диск).
                * `false` — PXF формирует файлы на диске.

            * `endpoint` — адрес S3-хранилища. Значение для Object Storage — `storage.yandexcloud.net`. Это значение используется по умолчанию.

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
                    "s3": {
                      "access_key": "<идентификатор_статического_ключа>",
                      "secret_key": "<секретная_часть_статического_ключа>",
                      "fast_upload": <быстрая_загрузка>,
                      "endpoint": "<адрес_S3-хранилища>"
                    }
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.greenplum.v1.PXFDatasourceService.Create
        ```

        Где:

        * `name` — имя внешнего источника данных.
        * `s3` — настройки внешнего источника данных:

            * `access_key`, `secret_key` — [идентификатор и содержимое статического ключа доступа](../../../iam/concepts/authorization/access-key.md).
            * `fast_upload` — быстрая загрузка больших файлов в S3-хранилище. Возможные значения:
                * `true` (по умолчанию) — PXF формирует файлы в оперативной памяти (если ее не хватает, записывает файлы на диск).
                * `false` — PXF формирует файлы на диске.

            * `endpoint` — адрес S3-хранилища. Значение для Object Storage — `storage.yandexcloud.net`. Это значение используется по умолчанию.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/PXFDatasource/create.md#yandex.cloud.operation.Operation).

{% endlist %}

После создания внешнего источника данных [создайте внешнюю таблицу](create-table.md).