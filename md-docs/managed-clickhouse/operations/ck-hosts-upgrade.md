[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for ClickHouse®](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Управление хостами > Изменение сервиса координации

# Изменение сервиса координации со встроенного ClickHouse® Keeper на ClickHouse® Keeper на отдельных хостах

Если в качестве сервиса координации используется встроенный ClickHouse® Keeper, вы можете изменить его на ClickHouse® Keeper на отдельных хостах. После включения ClickHouse® Keeper на отдельных хостах его нельзя выключить или переключить обратно на встроенный ClickHouse® Keeper.

{% note warning %}

Хосты ClickHouse® Keeper учитываются в расчете использованной [квоты ресурсов](https://console.yandex.cloud/cloud?section=quotas) в облаке и в [расчете стоимости](../pricing.md) кластера.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить сервис координации:

  1. Посмотрите описание команды:

      ```bash
      yc managed-clickhouse cluster add-zookeeper --help
      ```

  1. Укажите параметры хоста в команде:

      
      ```bash
      yc managed-clickhouse cluster add-zookeeper \
        --name <имя_кластера> \
        --resource-preset <класс_хоста> \
        --disk-type <тип_диска> \
        --disk-size <размер_хранилища> \
        --host type=keeper,`
              `zone-id=<зона_доступности>,`
              `subnet-id=<идентификатор_подсети> \
        --convert-tables-to-replicated <конвертировать_таблицы>
      ```


      Где:

      * `--resource-preset` — [класс хоста](../concepts/instance-types.md).
      * `--disk-type` — [тип диска](../concepts/storage.md).
      * `--disk-size` — размер хранилища в байтах.

      * `--host` — параметры хоста:
        * `type` — тип хоста: `keeper`.
        * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).

        
        * `subnet-id` — идентификатор подсети. Его необходимо указывать, если в выбранной зоне доступности создано две и более подсетей.


        Вы можете добавить сразу несколько хостов. Для каждого хоста необходимо указать отдельный флаг `--host`.

      * `--convert-tables-to-replicated` — преобразовать нереплицируемые таблицы в [реплицируемые](../concepts/replication.md#replicated-tables).

      Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    Чтобы изменить сервис координации:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.AddZookeeper](../api-ref/Cluster/addZookeeper.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            
            ```json
            {
              "resources": {
                "resourcePresetId": "<класс_хоста>",
                "diskSize": "<размер_хранилища>",
                "diskTypeId": "<тип_диска>"
              },
              "hostSpecs": [
                {
                  "zoneId": "<зона_доступности>",
                  "type": "KEEPER",
                  "subnetId": "<идентификатор_подсети>"
                }
              ],
              "convertTablesToReplicated": <конвертировать_таблицы>
            }
            ```


            Где:

            * `resources` — конфигурация хоста:

               * `resourcePresetId` — идентификатор [класса хостов](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.list](../api-ref/ResourcePreset/list.md).
               * `diskSize` — размер хранилища в байтах.
               * `diskTypeId` — [тип диска](../concepts/storage.md).

            * `hostSpecs` — настройки хостов в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

                * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
                * `type` — тип хоста: `KEEPER`.

                
                * `subnetId` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).


            * `convertTablesToReplicated` — преобразовать нереплицируемые таблицы в [реплицируемые](../concepts/replication.md#replicated-tables).

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Выполните запрос:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>:addZookeeper' \
              --data '@body.json'
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/addZookeeper.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    Чтобы изменить сервис координации:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.AddZookeeper](../api-ref/grpc/Cluster/addZookeeper.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            
            ```json
            {
              "cluster_id": "<идентификатор_кластера>",
              "resources": {
                "resource_preset_id": "<класс_хоста>",
                "disk_size": "<размер_хранилища>",
                "disk_type_id": "<тип_диска>"
              },
              "host_specs": [
                {
                  "zone_id": "<зона_доступности>",
                  "type": "KEEPER",
                  "subnet_id": "<идентификатор_подсети>",
                }
              ],
              "convert_tables_to_replicated": <конвертировать_таблицы>
            }
            ```


            Где:

            * `resources` — конфигурация хоста:

               * `resource_preset_id` — идентификатор [класса хостов](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePresetService.List](../api-ref/grpc/ResourcePreset/list.md).
               * `disk_size` — размер хранилища в байтах.
               * `disk_type_id` — [тип диска](../concepts/storage.md).

            * `host_specs` — настройки хостов в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

                * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
                * `type` — тип хоста: `KEEPER`.

                
                * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).


            * `convertTablesToReplicated` — преобразовать нереплицируемые таблицы в [реплицируемые](../concepts/replication.md#replicated-tables).

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Выполните запрос:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              mdb.api.cloud.yandex.net:443 \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.addZookeeper \
              < body.json
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addZookeeper.md#yandex.cloud.operation.Operation).

{% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._