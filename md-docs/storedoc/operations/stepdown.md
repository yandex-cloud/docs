# Переключение первичной реплики

Если в кластере есть [несколько реплик](../concepts/replication.md), то при необходимости можно переключить первичную реплику (мастер).

Переключение в среднем занимает менее одной минуты. Во время переключения кластер может быть недоступен для записи в течение нескольких секунд.


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. Перейдите в сервис **Yandex StoreDoc**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Хосты**.
    1. Нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) в строке `PRIMARY` хоста и выберите пункт **Сменить мастер**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы переключить первичную реплику в кластере, выполните команду:

    ```bash
    yc managed-mongodb hosts stepdown <имя_текущей_первичной_реплики> \
       --name=<имя_кластера>
    ```

    Имя первичной реплики для нужного шарда можно получить со [списком хостов в кластере](hosts.md#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.StepdownHosts](../api-ref/Cluster/stepdownHosts.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>:stepdownHosts' \
            --data '{
                     "hostNames": [
                        "<имя_текущей_первичной_реплики>"
                     ]
                    }'
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя первичной реплики для нужного шарда — со [списком хостов в кластере](hosts.md#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/stepdownHosts.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.StepdownHosts](../api-ref/grpc/Cluster/stepdownHosts.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                 "cluster_id": "<идентификатор_кластера>",
                 "host_names": [
                    "<имя_текущей_первичной_реплики>"
                 ]
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.mongodb.v1.ClusterService.StepdownHosts
        ```    

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя первичной реплики для нужного шарда — со [списком хостов в кластере](hosts.md#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/stepdownHosts.md#yandex.cloud.operation.Operation).

{% endlist %}