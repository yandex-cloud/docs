# Переключение мастера

В отказоустойчивом кластере {{ mrd-name }} из нескольких хостов вы можете переключить роль мастера с текущего хоста-мастера на хост-реплику. После этой операции текущий хост-мастер станет хостом-репликой для нового мастера.

Переключение в среднем занимает несколько минут, кластер в это время доступен.

[Шардированный кластер](../concepts/sharding.md) содержит один или несколько хостов-мастеров — по одному на каждый [шард](../concepts/sharding.md#valkey-cluster-structure). Переключение мастера для шардированного кластера осуществляется поочередно для каждого шарда.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы переключить мастер в нешардированном кластере:

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нешардированным кластером.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. В строке хоста с ролью `MASTER` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_label-title }}**.
    1. В открывшемся окне выберите опцию **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_label_confirmation }}** и нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_button }}**.

    Чтобы переключить мастер в шардированном кластере:

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с шардированным кластером.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. В строке хоста с ролью `MASTER` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_label-title }}**.
    1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_button }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы переключить мастер в нешардированном кластере, выполните команду:

    ```bash
    {{ yc-mdb-rd }} cluster start-failover \
      --name <имя_кластера>
    ```

    Чтобы переключить мастер в шардированном кластере, выполните команду:

    ```bash
    {{ yc-mdb-rd }} cluster start-failover \
      --name <имя_кластера> \
      --hostnames <имя_текущего_мастера>
    ```

    Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md), имя мастера для нужного вам шарда — со [списком хостов в кластере](hosts.md#list).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.StartFailover](../api-ref/Cluster/startFailover.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        Чтобы переключить мастер в нешардированном кластере:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>:startFailover'
        ```

        Чтобы переключить мастер в шардированном кластере:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>:startFailover' \
            --data '{
                      "hostNames": [
                        "<имя_текущего_мастера>"
                      ]
                    }'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), имя текущего мастера — со [списком хостов в кластере](hosts.md#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/startFailover.md#yandex.cloud.operation.Operation).

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

    1. Воспользуйтесь вызовом [ClusterService.StartFailover](../api-ref/grpc/Cluster/startFailover.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        Чтобы переключить мастер в нешардированном кластере:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.StartFailover
        ```

        Чтобы переключить мастер в шардированном кластере:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "host_names": [
                    "<имя_текущего_мастера>"
                  ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.StartFailover
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), имя текущего мастера — со [списком хостов в кластере](hosts.md#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/startFailover.md#yandex.cloud.operation.Operation).

{% endlist %}