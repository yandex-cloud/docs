[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for ClickHouse®](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Управление хостами > Изменение сервиса координации c ZooKeeper на ClickHouse® Keeper

# Изменение сервиса координации с ZooKeeper на ClickHouse® Keeper на отдельных хостах

Вы можете перейти с [сервиса координации](../concepts/coordination-system.md) ZooKeeper на ClickHouse® Keeper на отдельных хостах. Обратный переход с ClickHouse® Keeper на ZooKeeper не поддерживается.

{% note warning %}

* На время выполнения операции кластер будет работать в режиме read-only.

* Хосты ClickHouse® Keeper учитываются в расчете использованной [квоты ресурсов](https://console.yandex.cloud/cloud?section=quotas) в облаке и в [расчете стоимости](../pricing.md) кластера.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить сервис координации с ZooKeeper на ClickHouse® Keeper:

  1. Посмотрите описание команды:

      ```bash
      yc managed-clickhouse cluster migrate-to-keeper --help
      ```

  1. Измените сервис координации:

      
      ```bash
      yc managed-clickhouse cluster migrate-to-keeper <имя_или_идентификатор_кластера> \
         --resource-preset <класс_хоста> \
         --disk-type <тип_диска> \
         --disk-size <размер_хранилища_ГБ> \
         --host zone-id=<зона_доступности>,`
               `subnet-id=<идентификатор_подсети> \
         --allow-degradation-to-read-only
      ```


      Где:

      * `<имя_или_идентификатор_кластера>` — имя или идентификатор кластера, которые можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
      * `--resource-preset` — [класс хоста](../concepts/instance-types.md).
      * `--disk-type` — [тип диска](../concepts/storage.md).
      * `--disk-size` — размер хранилища в гигабайтах.

      
      * `--host` — настройки хоста. Параметр задается для каждого хоста отдельно и имеет следующую структуру:

        * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnet-id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).


      * `--allow-degradation-to-read-only` — переход кластера в режим read-only на время изменения сервиса координации. Обязательный параметр.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Чтобы изменить сервис координации с ZooKeeper на ClickHouse® Keeper:

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     О том, как создать такой файл, в разделе [Создание кластера](cluster-create.md).

  1. В описание ресурса кластера внесите следующие изменения:

      * Добавьте параметр `allow_degradation_to_read_only = true`, чтобы разрешить переход кластера в режим read-only на время изменения сервиса координации. Иначе операция не будет выполнена.
      * Замените хосты ZooKeeper на хосты ClickHouse® Keeper.
      * Измените конфигурацию хостов в блоке `zookeeper.resources`.

      Пример конфигурационного файла:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster_v2" "<локальное_имя_кластера>" {
        ...

        allow_degradation_to_read_only = true

        zookeeper = {
          resources = {
            resource_preset_id = "<класс_хоста>"
            disk_type_id       = "<тип_диска>"
            disk_size          = <размер_хранилища_ГБ>
          }
        }

        hosts = {
          ...
          <имя_хоста_1> = {
            type      = "KEEPER"
            zone      = "ru-central1-a"
            subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_ru-central1-a>.id
          }

          <имя_хоста_2> = {
            type      = "KEEPER"
            zone      = "ru-central1-b"
            subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_ru-central1-b>.id
          }

          <имя_хоста_3> = {
            type      = "KEEPER"
            zone      = "ru-central1-d"
            subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_ru-central1-d>.id
          }
        }
      }
      ```

      Подробнее о ресурсе в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster_v2.md).

  1. Проверьте корректность настроек.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
     
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

  {% note warning "Ограничения по времени" %}
  
  Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for ClickHouse®:
  
  * создание, в т. ч. путем восстановления из резервной копии, — 60 минут;
  * изменение — 90 минут;
  * удаление — 30 минут.
  
  Операции, длящиеся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию кластера блок `timeouts`, например:
  
  ```hcl
  resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
    ...
    timeouts = {
      create = "1h30m" # Полтора часа
      update = "2h"    # 2 часа
      delete = "30m"   # 30 минут
    }
  }
  ```
  
  {% endcut %}
  
  {% endnote %}


- REST API {#api}

  Чтобы изменить сервис координации с ZooKeeper на ClickHouse® Keeper:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Cluster.MigrateToKeeper](../api-ref/Cluster/migrateToKeeper.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

      1. Создайте файл `body.json` и добавьте в него следующее содержимое:

          
          ```json
          {
            "resources": {
              "resourcePresetId": "<класс_хоста>",
              "diskSize": "<размер_хранилища_в_байтах>",
              "diskTypeId": "<тип_диска>"
            },
            "hostSpecs": [
              {
                "type": "KEEPER",
                "zoneId": "<зона_доступности>",
                "subnetId": "<идентификатор_подсети>"
              }
            ],
            "allowDegradationToReadOnly": true
          }
          ```


          Где:

          * `resources` — конфигурация хостов:

            * `resourcePresetId` — [класс хоста](../concepts/instance-types.md). Список доступных классов хостов можно получить с помощью метода [ResourcePreset.list](../api-ref/ResourcePreset/list.md).
            * `diskSize` — размер хранилища в байтах.
            * `diskTypeId` — [тип диска](../concepts/storage.md).

          * `hostSpecs` — настройки хостов в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

            * `type` — тип хоста: `KEEPER`.
            * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
            
            
            * `subnetId` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).


          * `allowDegradationToReadOnly` — переход кластера в режим read-only на время изменения сервиса координации: `true`. Обязательный параметр.

      1. Выполните запрос:

          ```bash
          curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>:migrateToKeeper' \
            --data '@body.json'
          ```

          Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/migrateToKeeper.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}
  
  Чтобы изменить сервис координации с ZooKeeper на ClickHouse® Keeper:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

  1. Воспользуйтесь вызовом [ClusterService.MigrateToKeeper](../api-ref/grpc/Cluster/migrateToKeeper.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      1. Создайте файл `body.json` и добавьте в него следующее содержимое:

          
          ```json
          {
            "cluster_id": "<идентификатор_кластера>",
            "resources": {
              "resource_preset_id": "<класс_хоста>",
              "disk_size": "<размер_хранилища_в_байтах>",
              "disk_type_id": "<тип_диска>"
            },
            "host_specs": [
              {
                "type": "KEEPER",
                "zone_id": "<зона_доступности>",
                "subnet_id": "<идентификатор_подсети>"
              }
            ],
            "allow_degradation_to_read_only": true
          }
          ```


          Где:

          * `cluster_id` — идентификатор кластера, который можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
          * `resources` — конфигурация хостов:

            * `resource_preset_id` — [класс хоста](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePresetService.List](../api-ref/grpc/ResourcePreset/list.md).
            * `disk_size` — размер хранилища в байтах.
            * `disk_type_id` — [тип диска](../concepts/storage.md).

          * `host_specs` — настройки хостов в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

            * `type` — тип хоста: `KEEPER`.
            * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).

            
            * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).


          * `allow_degradation_to_read_only` — переход кластера в режим read-only на время изменения сервиса координации: `true`. Обязательный параметр.

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
            yandex.cloud.mdb.clickhouse.v1.ClusterService.MigrateToKeeper \
            < body.json
          ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/migrateToKeeper.md#yandex.cloud.operation.Operation).

{% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._