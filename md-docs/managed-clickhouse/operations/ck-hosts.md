# Управление хостами {{ CK }}

После создания кластера с отдельными хостами {{ CK }} вы можете:

* [получить список хостов](#list-hosts);
* [создать хост](#add-ck);
* [изменить настройки {{ CK }}](#update-keeper-settings);
* [перезагрузить хост](#restart-host);
* [преобразовать нереплицируемые таблицы в реплицируемые](#replicated-tables);
* [удалить хост {{ CK }}](#delete-host).

Подробнее о работе хостов {{ CK }} читайте в разделе [{#T}](../concepts/coordination-system.md#ck).

## Получить список хостов в кластере {#list-hosts}

# Получить список хостов в кластере

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список хостов в кластере, выполните команду:

  ```bash
  {{ yc-mdb-ch }} host list \
     --cluster-name=<имя_кластера>
  ```

  ```text
  +----------------------------+--------------+---------+--------+---------------+
  |            NAME            |  CLUSTER ID  |  ROLE   | HEALTH |    ZONE ID    |
  +----------------------------+--------------+---------+--------+---------------+
  | rc1b...{{ dns-zone }} | c9qp71dk1... | MASTER  | ALIVE  | {{ region-id }}-b |
  | rc1a...{{ dns-zone }} | c9qp71dk1... | REPLICA | ALIVE  | {{ region-id }}-a |
  +----------------------------+--------------+---------+--------+---------------+
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.ListHosts](../api-ref/Cluster/listHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse).

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

    1. Воспользуйтесь вызовом [ClusterService.ListHosts](../api-ref/grpc/Cluster/listHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.ListHosts
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse).

{% endlist %}


## Создать хост {{ CK }} {#add-ck}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-clickhouse-keeper }}**.
  1. Выберите [зону доступности](../../overview/concepts/geo-scope.md) и подсеть в указанной зоне доступности.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

{% endlist %}

## Изменить настройки {{ CK }} {#update-keeper-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Выберите кластер и на панели сверху нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-resource }}** выберите платформу, тип виртуальной машины и нужный класс хоста {{ CK }}.
  1. В блоке **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-disk }}** задайте тип диска, размер хранилища и настройте [автоматическое увеличение размера хранилища](../concepts/storage.md#autoscaling).
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}

## Перезагрузить хост {#restart-host}

# Перезагрузить хост

Перезагрузка хостов может понадобиться, если нужно экстренно устранить такие проблемы, как:

* перерасход ресурсов;
* утечка памяти;
* взаимоблокировка (deadlock) между запросами;
* зависание операций и внутренних процессов {{ CH }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы перезагрузить один хост:

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. В строке нужного хоста нажмите на значок ![icon](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.hosts.action_restart-host }}**.
    1. В открывшемся окне включите опцию **Я перезагружаю хост** и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.popup-confirm_button }}**.

  Чтобы перезагрузить несколько хостов сразу:

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Выберите хосты, которые хотите перезагрузить, и нажмите **{{ ui-key.yacloud.mdb.cluster.hosts.action_restart-host }}** в нижней части экрана.
    1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.popup-confirm_button }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы перезагрузить один или несколько хостов, выполните команду, передав их имена. Используйте пробел в качестве разделителя.

  Команда для перезагрузки одного хоста выглядит так:

  ```bash
  {{ yc-mdb-ch }} host restart <имя_хоста> \
     --cluster-name=<имя_кластера>
  ```

  Имя хоста можно запросить со списком хостов в кластере, имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.RestartHosts](../api-ref/Cluster/restartHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts:restartHosts' \
            --data '{
                      "hostNames": [
                        <перечень_имен_хостов>
                      ]
                    }'
        ```

        Где `hostNames` — массив строк. Каждая строка — имя хоста, который нужно перезагрузить. Имена хостов можно запросить со [списком хостов в кластере](hosts.md#list-hosts).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/restartHosts.md#yandex.cloud.operation.Operation).

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

    1. Воспользуйтесь вызовом [ClusterService.RestartHosts](../api-ref/grpc/Cluster/restartHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "host_names": [
                      <перечень_имен_хостов>
                    ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.RestartHosts
        ```

        Где `host_names` — массив строк. Каждая строка — имя хоста, который нужно перезагрузить. Имена хостов можно запросить со [списком хостов в кластере](hosts.md#list-hosts).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Преобразовать нереплицируемые таблицы в реплицируемые {#replicated-tables}

Чтобы автоматически преобразовать нереплицируемые таблицы на движке семейства [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree) в [реплицируемые](../concepts/replication.md#replicated-tables) на движке [ReplicatedMergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/replication), при [включении сервиса координации](update.md#enable-coordination) включите настройку **{{ ui-key.yacloud.clickhouse.field_convert_tables_to_replicated }}**.

## Удалить хост {{ CK }} {#delete-host}

{% note warning %}

Хосты {{ CK }} можно удалять только по одному за раз. При этом в кластере всегда должны оставаться минимум три хоста {{ CK }}.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. В строке нужного хоста нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. Подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить хост {{ CK }}:

  1. Посмотрите описание команды CLI для удаления хоста:
    
      ```bash
      {{ yc-mdb-ch }} hosts delete --help
      ```
      
  1. Удалите хост, выполнив команду:

      ```bash
      {{ yc-mdb-ch }} hosts delete <имя_хоста> \ 
        --cluster-id=<идентификатор_кластера>
      ```

      Имя хоста можно получить со [списком хостов](#list-hosts) в кластере.

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:
  
      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Воспользуйтесь методом [Cluster.DeleteHosts](../api-ref/Cluster/deleteHosts.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:
  
      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts:batchDelete' \
        --data '{
          "hostNames": [
            <имя_хоста>
          ]
        }'
      ```
  
      Имя хоста можно получить со [списком хостов](#list-hosts) в кластера.

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).
  
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
  
  1. Воспользуйтесь вызовом [ClusterService.DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:
  
      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
          "cluster_id": "<идентификатор_кластера>",
          "host_names": [
            <имя_хоста>
          ]
        }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteHosts
      ```
  
      Имя хоста можно получить со [списком хостов](#list-hosts) в кластере.

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).

{% endlist %}

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._