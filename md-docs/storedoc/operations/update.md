# Изменение настроек кластера Yandex StoreDoc 

После создания кластера вы можете:

* [Изменить класс хостов](#change-resource-preset).
* [Изменить тип диска и увеличить размер хранилища](#change-disk-size).
* [Настроить серверы](#change-mongod-config) Yandex StoreDoc согласно документации MongoDB.
* [Изменить дополнительные настройки кластера](#change-additional-settings).
* [Переместить кластер](#move-cluster) в другой каталог.
* [Изменить группы безопасности](#change-sg-set).

Если вы хотите переместить кластер в другую зону доступности, обратитесь к [инструкции](host-migration.md). В результате вы перенесете хосты кластера.

## Изменить класс хостов {#change-resource-preset}

{% note info %}

Некоторые настройки Yandex StoreDoc [зависят от выбранного класса хостов](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

При смене класса хостов:

* Кластер из одного хоста будет недоступен несколько минут, соединения с БД будут прерваны.
* В кластере из нескольких хостов сменится [первичная реплика](../concepts/replication.md). Каждый хост по очереди будет остановлен и обновлен, остановленный хост будет недоступен несколько минут.

Рекомендуется изменять класс хостов только во время отсутствия рабочей нагрузки на кластер.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex StoreDoc**.

  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.

  1. В зависимости от выбранного [типа шардирования](../concepts/sharding.md#shard-management), перейдите к блоку ресурсов кластера, которые нужно изменить: **Ресурсы**, **Ресурсы Mongod**, **Ресурсы Mongoinfra**, **Ресурсы Mongocfg** или **Ресурсы Mongos**.

  
  1. Выберите:

     * Одну из доступных [платформ](../../compute/concepts/vm-platforms.md).
     * Тип конфигурации: **memory-optimized**, **cpu-optimized**, **standard** или **burstable**.
     * [Класс хостов](../concepts/instance-types.md) — он определяет технические характеристики виртуальных машин, на которых будут развернуты хосты БД. При изменении класса хостов для кластера меняются характеристики всех созданных хостов.


  1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      yc managed-mongodb cluster update --help
      ```

  1. Запросите список доступных классов хостов (в колонке `ZONE IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     
     ```bash
     yc managed-mongodb resource-preset list

     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | ru-central1-a, ru-central1-b,  |     2 | 8.0 GB   |
     |           | ru-central1-d                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```



  1. Укажите нужный класс в команде изменения кластера. При смене класса учитывайте роль хоста, она зависит от [типа шардирования](../concepts/sharding.md#shard-management). В одной команде можно использовать параметры для хостов с разными ролями.

      * Для хостов `MONGOD`:

          ```bash
          yc managed-mongodb cluster update <имя_или_идентификатор_кластера> \
             --mongod-resource-preset <ID_класса>
          ```

      * Для хостов `MONGOINFRA`:

          ```bash
          yc managed-mongodb cluster update <имя_или_идентификатор_кластера> \
             --mongoinfra-resource-preset <ID_класса>
          ```

      * Для хостов `MONGOS`:

          ```bash
          yc managed-mongodb cluster update <имя_или_идентификатор_кластера> \
             --mongos-resource-preset <ID_класса>
          ```

      * Для хостов `MONGOCFG`:

          ```bash
          yc managed-mongodb cluster update <имя_или_идентификатор_кластера> \
             --mongocfg-resource-preset <ID_класса>
          ```

      Yandex StoreDoc запустит операцию изменения класса хостов для кластера.


- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.
  
      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  
  1. Измените в описании кластера Yandex StoreDoc значение параметра `resource_preset_id` для ресурсов `resources_mongod`, `resources_mongoinfra`, `resources_mongos` или `resources_mongocfg`. Тип ресурса зависит от [типа шардирования](../concepts/sharding.md#shard-management).

      Пример:
  
      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
        ...
        resources_mongod {
            resource_preset_id = "<класс_хостов>"
            ...
        }
      }
      ```

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
 
  Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_mongodb_cluster.md).

  {% note warning "Ограничения по времени" %}
  
  Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex StoreDoc:
  
  * создание, в т. ч. путем восстановления из резервной копии, — 30 минут;
  * изменение — 60 минут.
  
  Операции, длящиеся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию кластера блок `timeouts`, например:
  
  ```hcl
  resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
    ...
    timeouts {
      create = "1h30m" # Полтора часа
      update = "2h"    # 2 часа
    }
  }
  ```
  
  {% endcut %}
  
  {% endnote %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
      
      {% endnote %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "configSpec.mongodb.<тип_хоста_Yandex_StoreDoc>.resources.resourcePresetId",
                    "configSpec": {
                      "mongodb": {
                        "<тип_хоста_Yandex_StoreDoc>": {
                          "resources": {
                            "resourcePresetId": "<класс_хостов>"
                          }    
                        }
                      }
                    }
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае передается только один параметр.

      * `configSpec.mongodb.<тип_хоста_Yandex_StoreDoc>.resources.resourcePresetId` — новый [класс хостов](../concepts/instance-types.md).

        Тип хоста Yandex StoreDoc зависит от [типа шардирования](../concepts/sharding.md). Доступные значения: `mongod`, `mongocfg`, `mongos`, `mongoinfra`. Если кластер нешардированный, укажите `mongod`.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
      
      {% cut "Формат перечисления настроек" %}
      
      ```yaml
      "update_mask": {
          "paths": [
              "<настройка_1>",
              "<настройка_2>",
              ...
              "<настройка_N>"
          ]
      }
      ```
      
      {% endcut %}
      
      {% endnote %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                  "paths": [
                    "config_spec.mongodb.<тип_хоста_Yandex_StoreDoc>.resources.resource_preset_id"
                  ]
                },
                "config_spec": {
                  "mongodb": {
                    "<тип_хоста_Yandex_StoreDoc>": {
                      "resources": {
                        "resource_preset_id": "<класс_хостов>"
                      }    
                    }
                  }
                }
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается только один параметр.

      * `config_spec.mongodb.<тип_хоста_Yandex_StoreDoc>.resources.resource_preset_id` — новый класс хостов.
      
        Тип хоста Yandex StoreDoc зависит от [типа шардирования](../concepts/sharding.md). Доступные значения: `mongod`, `mongocfg`, `mongos`, `mongoinfra`. Если кластер нешардированный, укажите `mongod`.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить тип диска и увеличить размер хранилища {#change-disk-size}

Проверьте, что в облаке достаточно квот для увеличения хранилища. Откройте страницу [Квоты](https://console.yandex.cloud/cloud?section=quotas) для облака и убедитесь, что в секции **Managed Databases** в строке **Объём HDD-хранилищ** или **Объём SSD-хранилищ** есть квота на объем хранилищ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить тип диска и увеличить размер хранилища для кластера:

  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex StoreDoc**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. В зависимости от выбранного [типа шардирования](../concepts/sharding.md#shard-management), перейдите к блоку ресурсов кластера, которые нужно изменить: **Ресурсы**, **Ресурсы Mongod**, **Ресурсы Mongoinfra**, **Ресурсы Mongocfg** или **Ресурсы Mongos**.
  1. В блоке **Хранилище**:

      * Выберите [тип диска](../concepts/storage.md).
      * Укажите нужный размер диска.

  1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить тип диска и увеличить размер хранилища для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      yc managed-mongodb cluster update --help
      ```

  1. Укажите [тип диска](../concepts/instance-types.md) и нужный размер хранилища в команде изменения кластера (размер хранилища должен быть не меньше, чем значение `disk_size` в свойствах кластера).

      При увеличении размера хранилища учитывайте роль хоста, она зависит от [типа шардирования](../concepts/sharding.md#shard-management). В одной команде можно использовать параметры для хостов с разными ролями.

      * Для хостов `MONGOD`:

          ```bash
          yc managed-mongodb cluster update <имя_или_идентификатор_кластера> \
             --mongod-disk-type <тип_диска> \
             --mongod-disk-size <размер_хранилища_ГБ>
          ```

      * Для хостов `MONGOINFRA`:

          ```bash
          yc managed-mongodb cluster update <имя_или_идентификатор_кластера> \
             --mongoinfra-disk-type <тип_диска> \
             --mongoinfra-disk-size <размер_хранилища_ГБ>
          ```

      * Для хостов `MONGOS`:

          ```bash
          yc managed-mongodb cluster update <имя_или_идентификатор_кластера> \
             --mongos-disk-type <тип_диска> \
             --mongos-disk-size <размер_хранилища_ГБ>
          ```

      * Для хостов `MONGOCFG`:

          ```bash
          yc managed-mongodb cluster update <имя_или_идентификатор_кластера> \
             --mongocfg-disk-type <тип_диска> \
             --mongocfg-disk-size <размер_хранилища_ГБ>
          ```

      Если все условия выполнены, Yandex StoreDoc запустит операцию по изменению параметров хранилища.


- Terraform {#tf}

  Чтобы изменить тип диска и увеличить размер хранилища для кластера:

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Измените в описании кластера Yandex StoreDoc значения параметров `disk_type_id` и `disk_size` для ресурсов `resources_mongod`, `resources_mongoinfra`, `resources_mongos` или `resources_mongocfg`. Тип ресурса зависит от [типа шардирования](../concepts/sharding.md#shard-management).

      Пример:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
        ...
        resources_mongod {
          disk_type_id = "<тип_диска>"
          disk_size    = <размер_хранилища_ГБ>
          ...
        }
      }
      ```

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

    Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_mongodb_cluster.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex StoreDoc:
    
    * создание, в т. ч. путем восстановления из резервной копии, — 30 минут;
    * изменение — 60 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
      ...
      timeouts {
        create = "1h30m" # Полтора часа
        update = "2h"    # 2 часа
      }
    }
    ```
    
    {% endcut %}
    
    {% endnote %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
      
      {% endnote %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "configSpec.mongodb.<тип_хоста_Yandex_StoreDoc>.resources.diskTypeId,configSpec.mongodb.<тип_хоста_Yandex_StoreDoc>.resources.diskSize",
                    "configSpec": {
                      "mongodb": { 
                        "<тип_хоста_Yandex_StoreDoc>": {
                          "resources": {
                            "diskTypeId": "<тип_диска>",
                            "diskSize": "<размер_хранилища_в_байтах>"
                          }  
                        }
                      }
                    }
                  }'
      ```             

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
      
      * `configSpec.mongodb.<тип_хоста_Yandex_StoreDoc>.resources` — параметры хранилища:

          * `diskTypeId` — [тип диска](../concepts/storage.md).
          * `diskSize` — новый размер хранилища в байтах.

        Тип хоста Yandex StoreDoc зависит от [типа шардирования](../concepts/sharding.md). Доступные значения: `mongod`, `mongocfg`, `mongos`, `mongoinfra`. Если кластер нешардированный, укажите `mongod`.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
      
      {% cut "Формат перечисления настроек" %}
      
      ```yaml
      "update_mask": {
          "paths": [
              "<настройка_1>",
              "<настройка_2>",
              ...
              "<настройка_N>"
          ]
      }
      ```
      
      {% endcut %}
      
      {% endnote %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                  "paths": [
                    "config_spec.mongodb.<тип_хоста_Yandex_StoreDoc>.resources.disk_type_id",
                    "config_spec.mongodb.<тип_хоста_Yandex_StoreDoc>.resources.disk_size"
                  ]
                },
                "config_spec": {
                  "mongodb": {
                    "<тип_хоста_Yandex_StoreDoc>": {
                      "resources": {
                        "disk_type_id": "<тип_диска>",
                        "disk_size": "<размер_хранилища_в_байтах>"
                      }    
                    }
                  }
                }
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

      * `config_spec.mongodb.<тип_хоста_Yandex_StoreDoc>.resources.disk_size` — параметры хранилища:

          * `disk_type_id` — [тип диска](../concepts/storage.md).
          * `disk_size` — новый размер хранилища в байтах.

        Тип хоста Yandex StoreDoc зависит от [типа шардирования](../concepts/sharding.md). Доступные значения: `mongod`, `mongocfg`, `mongos`, `mongoinfra`. Если кластер нешардированный, укажите `mongod`.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки Yandex StoreDoc {#change-mongod-config}

Вы можете изменить настройки СУБД для хостов вашего кластера.

{% note info %}

Некоторые настройки Yandex StoreDoc [зависят от выбранного класса хостов](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex StoreDoc**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. Чтобы изменить [настройки Yandex StoreDoc](../concepts/settings-list.md#dbms-cluster-settings), нажмите кнопку **Настроить** в блоке **Настройки СУБД**.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить [настройки Yandex StoreDoc](../concepts/settings-list.md#dbms-cluster-settings) для кластера, используйте команду:

  ```bash
  yc managed-mongodb cluster update-config
  ```

  Например, для установки значения параметра net.maxIncomingConnections в `4096`, выполните следующую команду:

  ```bash
  yc managed-mongodb cluster update-config <имя_кластера> \
     --set net.max_incoming_connections=4096
  ```

  Yandex StoreDoc запустит операцию изменения настроек СУБД для кластера. Если изменяемая настройка применяется только с перезапуском СУБД, то Yandex StoreDoc последовательно перезапустит СУБД на всех хостах кластера.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
      
      {% endnote %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "configSpec.mongodb.<тип_хоста_Yandex_StoreDoc>.config.<настройка_1>,configSpec.mongodb.<тип_хоста_Yandex_StoreDoc>.config.<настройка_2>,...,configSpec.mongodb.<тип_хоста_Yandex_StoreDoc>.config.<настройка_N>",
                    "configSpec": {
                      "mongodb": {    
                        "<тип_хоста_Yandex_StoreDoc>": {
                          "config": {
                            "<настройка_1>": "<значение_1>",
                            "<настройка_2>": "<значение_2>",
                            ...
                            "<настройка_N>": "<значение_N>"
                          }
                        }
                      }    
                    }
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

      * `configSpec.mongodb.<тип_хоста_Yandex_StoreDoc>.config` — набор настроек Yandex StoreDoc. Укажите каждую настройку на отдельной строке через запятую. Все поддерживаемые настройки описаны [в справочнике API](../api-ref/Cluster/update.md) и в разделе [Настройки Yandex StoreDoc](../concepts/settings-list.md).

        Тип хоста Yandex StoreDoc зависит от [типа шардирования](../concepts/sharding.md). Доступные значения: `mongod`, `mongocfg`, `mongos`, `mongoinfra`. Если кластер нешардированный, укажите `mongod`.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
      
      {% cut "Формат перечисления настроек" %}
      
      ```yaml
      "update_mask": {
          "paths": [
              "<настройка_1>",
              "<настройка_2>",
              ...
              "<настройка_N>"
          ]
      }
      ```
      
      {% endcut %}
      
      {% endnote %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                  "paths": [
                    "config_spec.mongodb.<тип_хоста_Yandex_StoreDoc>.config.<настройка_1>",
                    "config_spec.mongodb.<тип_хоста_Yandex_StoreDoc>.config.<настройка_2>",
                    ...
                    "config_spec.mongodb.<тип_хоста_Yandex_StoreDoc>.config.<настройка_N>"
                  ]
                },
                "config_spec": {
                  "mongodb": {    
                    "<тип_хоста_Yandex_StoreDoc>": {
                      "config": {
                        "<настройка_1>": "<значение_1>",
                        "<настройка_2>": "<значение_2>",
                        ...
                        "<настройка_N>": "<значение_N>"
                      }
                    }
                  }
                }
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

      * `config_spec.mongodb.<тип_хоста_Yandex_StoreDoc>.config` — набор настроек Yandex StoreDoc. Укажите каждую настройку на отдельной строке через запятую. Все поддерживаемые настройки описаны [в справочнике API](../api-ref/grpc/Cluster/update.md) и в разделе [Настройки Yandex StoreDoc](../concepts/settings-list.md).

        Тип хоста Yandex StoreDoc зависит от [типа шардирования](../concepts/sharding.md). Доступные значения: `mongod`, `mongocfg`, `mongos`, `mongoinfra`. Если кластер нешардированный, укажите `mongod`.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex StoreDoc**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. Измените дополнительные настройки кластера:

     - **Начало резервного копирования (UTC)** — промежуток времени, в течение которого начинается резервное копирование кластера. Время указывается по UTC в 24-часовом формате. По умолчанию — `22:00 - 23:00` UTC.
     
     - **Срок хранения автоматических резервных копий, дней**{#setting-backup-saving}
       
       Время, в течение которого нужно хранить созданные автоматически резервные копии. Если для такой копии истекает срок хранения, то она удаляется. Значение по умолчанию — 7 дней. Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Подробнее см. в разделе [Резервные копии](../concepts/backup.md).
     
     
       Изменение срока хранения затрагивает как новые автоматические резервные копии, так и уже существующие. Например, если изначальный срок хранения был 7 дней и оставшееся время жизни отдельной автоматической резервной копии при таком сроке — 1 день, то при увеличении срока хранения до 9 дней, оставшееся время жизни этой резервной копии будет уже 3 дня.
     
       Для существующего кластера автоматически созданные копии хранятся заданное количество дней, а созданные вручную — бессрочно. После удаления кластера все копии хранятся 7 дней.
     
     - **Окно обслуживания** — настройки времени [технического обслуживания](../concepts/maintenance.md):
     
         * Чтобы разрешить проведение технического обслуживания в любое время, выберите пункт **произвольное** (по умолчанию).
         * Чтобы указать предпочтительное время начала обслуживания, выберите пункт **по расписанию** и укажите нужные день недели и час дня по UTC. Например, можно выбрать время, когда кластер наименее загружен.
         
         Операции по техническому обслуживанию проводятся для включенных и выключенных кластеров. Они могут включать в себя: обновление СУБД, применение патчей и так далее.
     
     
     
     - **Доступ из WebSQL** — опция разрешает [выполнять SQL-запросы](websql.md) к базам данных кластера из консоли управления Yandex Cloud с помощью сервиса Yandex WebSQL.
     
     
     - **Сбор статистики** — включите эту опцию, чтобы пользоваться встроенным инструментом для [диагностики производительности](performance-diagnostics.md) в кластере. Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).
     
     - **Защита от удаления** — защита кластера от непреднамеренного удаления.
     
       Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.
     
  1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        yc managed-mongodb cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        yc managed-mongodb cluster update <идентификатор_или_имя_кластера> \
          --backup-retain-period-days=<срок_хранения> \
          --backup-window-start <время_начала_резервного_копирования> \
          --maintenance-window type=<тип_технического_обслуживания>,`
                               `day=<день_недели>,`
                               `hour=<час_дня> \
          --performance-diagnostics=<включить_диагностику> \
          --deletion-protection
        ```

    Вы можете изменить следующие настройки:

    * `--backup-retain-period` — срок хранения автоматических резервных копий (в днях).
      
      Значение параметра `<срок_хранения>` задается в диапазоне от 7 до 35 (по умолчанию — 7). Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Подробнее см. в разделе [Резервные копии](../concepts/backup.md).


      Изменение срока хранения затрагивает как новые автоматические резервные копии, так и уже существующие.

      Например, если изначальный срок хранения был семь дней и оставшееся время жизни отдельной автоматической резервной копии при таком сроке — один день, то при увеличении срока хранения до девяти дней оставшееся время жизни этой резервной копии будет уже три дня.

    * `--backup-window-start` — время начала резервного копирования кластера, задается по UTC в формате `HH:MM:SS`. Если время не задано, резервное копирование начнется в 22:00 UTC.

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        * `anytime` (по умолчанию) — в любое время.
        * `weekly` — по расписанию. Для этого значения дополнительно укажите:
            * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
            * `hour` — час дня по UTC: от `1` до `24`.

    * `--performance-diagnostics` — укажите параметр, чтобы воспользоваться инструментом [Диагностика производительности](performance-diagnostics.md) в кластере. Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

    * `--deletion-protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

      Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).


- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.
      
       О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Чтобы изменить время начала резервного копирования, добавьте к описанию кластера Yandex StoreDoc блок `backup_window_start` в секции `cluster_config`:
  
        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
          ...
          cluster_config {
            backup_window_start {
              hours   = <час>
              minutes = <минута>
            }
            ...
          }
          ...
        }
        ```

        Где `hours` и `minutes` — час и минута начала резервного копирования.

    1. Чтобы настроить время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), добавьте к описанию кластера блок `maintenance_window`:
       
       ```hcl
       resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
         ...
         maintenance_window {
           type = "<тип_технического_обслуживания>"
           day  = "<день_недели>"
           hour = <час_дня>
         }
         ...
       }
       ```
       
       Где:
       
       * `type` — тип технического обслуживания. Принимает значения:
           * `ANYTIME` — в любое время.
           * `WEEKLY` — по расписанию.
       * `day` — день недели для типа `WEEKLY`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
       * `hour` — час дня по UTC для типа `WEEKLY`: от `1` до `24`.

    1. Чтобы защитить кластер от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
          ...
          deletion_protection = <защитить_кластер_от_удаления>
        }
        ```

        Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

        Чтобы отключить защиту, установите значение `false`.

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

  Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_mongodb_cluster.md).

  {% note warning "Ограничения по времени" %}
  
  Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex StoreDoc:
  
  * создание, в т. ч. путем восстановления из резервной копии, — 30 минут;
  * изменение — 60 минут.
  
  Операции, длящиеся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию кластера блок `timeouts`, например:
  
  ```hcl
  resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
    ...
    timeouts {
      create = "1h30m" # Полтора часа
      update = "2h"    # 2 часа
    }
  }
  ```
  
  {% endcut %}
  
  {% endnote %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
      
      {% endnote %}

      
      ```json
      {
        "updateMask": "configSpec.backupWindowStart,configSpec.backupRetainPeriodDays,configSpec.performanceDiagnostics,maintenanceWindow,deletionProtection",
        "configSpec": {
          "backupWindowStart":  {
            "hours": "<часы>",
            "minutes": "<минуты>",
            "seconds": "<секунды>",
            "nanos": "<наносекунды>"
          },
          "backupRetainPeriodDays": "<время_хранения_резервных_копий_в_днях>",
          "performanceDiagnostics": {
            "profilingEnabled": <включить_профилировщик>
          }
        }
        "maintenanceWindow": {
          "weeklyMaintenanceWindow": {
            "day": "<день_недели>",
            "hour": "<час>"
          }
        },    
        "deletionProtection": <защитить_кластер_от_удаления>
      }
      ```
    

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
      * `configSpec` — настройки кластера:

        * `backupWindowStart` — настройки окна [резервного копирования](../concepts/backup.md).

          В параметре укажите время, когда начинать резервное копирование:

          * `hours` — от `0` до `23` часов.
          * `minutes` — от `0` до `59` минут.
          * `seconds` — от `0` до `59` секунд.
          * `nanos` — от `0` до `999999999` наносекунд.

        * `backupRetainPeriodDays` — время хранения резервных копий в днях.

        * `performanceDiagnostics` — настройки для [сбора статистики](performance-diagnostics.md#activate-stats-collector):
          * `profilingEnabled` — включение [профилировщика](tools.md#explore-profiler): `true` или `false`.

      * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). В `maintenanceWindow` передайте один из двух параметров:

        * `anytime` — техническое обслуживание происходит в любое время.
        * `weeklyMaintenanceWindow` — техническое обслуживание происходит раз в неделю, в указанное время:

          * `day` — день недели в формате `DDD`.
          * `hour` — час в формате `HH`. Возможные значения: от `1` до `24` часов.

      * `deletionProtection` — защита кластера от непреднамеренного удаления: `true` или `false`.

        Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.
        
    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>' \
            --data "@body.json"
        ```

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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
  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
      
      {% cut "Формат перечисления настроек" %}
      
      ```yaml
      "update_mask": {
          "paths": [
              "<настройка_1>",
              "<настройка_2>",
              ...
              "<настройка_N>"
          ]
      }
      ```
      
      {% endcut %}
      
      {% endnote %}

      
      ```json
      {
        "cluster_id": "<идентификатор_кластера>",
        "update_mask": {
          "paths": [
            "config_spec.backup_window_start",
            "config_spec.backup_retain_period_days",
            "config_spec.performance_diagnostics",
            "maintenance_window",
            "deletion_protection"
          ]
        },
        "config_spec": {
          "backup_window_start": {
            "hours": "<часы>",
            "minutes": "<минуты>",
            "seconds": "<секунды>",
            "nanos": "<наносекунды>"
          },
          "backup_retain_period_days": "<время_хранения_резервных_копий_в_днях>",
          "performance_diagnostics": {
            "profiling_enabled": <включить_профилировщик>
          }
        },
        "maintenance_window": {
          "weekly_maintenance_window": {
            "day": "<день_недели>",
            "hour": "<час>"
          }
        },
        "deletion_protection": <защитить_кластер_от_удаления>
      }
      ```


      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
      * `config_spec` — настройки кластера:

        * `backup_window_start` — настройки окна [резервного копирования](../concepts/backup.md).

          В параметре укажите время, когда начинать резервное копирование:

          * `hours` — от `0` до `23` часов.
          * `minutes` — от `0` до `59` минут.
          * `seconds` — от `0` до `59` секунд.
          * `nanos` — от `0` до `999999999` наносекунд.

        * `backup_retain_period_days` — время хранения резервных копий в днях.

        * `performance_diagnostics` — настройки для [сбора статистики](performance-diagnostics.md#activate-stats-collector):

          * `profiling_enabled` — включение [профилировщика](tools.md#explore-profiler): `true` или `false`.

      * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). В `maintenance_window` передайте один из двух параметров:

        * `anytime` — техническое обслуживание происходит в любое время.
        * `weekly_maintenance_window` — техническое обслуживание происходит раз в неделю, в указанное время:

          * `day` — день недели в формате `DDD`.
          * `hour` — час в формате `HH`. Возможные значения: от `1` до `24` часов.

      * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

        Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Update \
          < body.json
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Переместить кластер {#move-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex StoreDoc**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке кластера, который вы хотите переместить.
    1. Выберите пункт **Переместить**.
    1. Выберите каталог, в который вы хотите переместить кластер.
    1. Нажмите кнопку **Переместить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы переместить кластер:

    1. Посмотрите описание команды CLI для перемещения кластера:

        ```bash
        yc managed-mongodb cluster move --help
        ```

    1. Укажите каталог назначения в команде перемещения кластера:

        ```bash
        yc managed-mongodb cluster move <имя_или_идентификатор_кластера> \
           --destination-folder-name=<имя_каталога_назначения>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените или добавьте в описании кластера Yandex StoreDoc значение параметра `folder_id`:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
          ...
          folder_id = "<идентификатор_каталога_назначения>"
        }
        ```

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

    Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_mongodb_cluster.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex StoreDoc:
    
    * создание, в т. ч. путем восстановления из резервной копии, — 30 минут;
    * изменение — 60 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
      ...
      timeouts {
        create = "1h30m" # Полтора часа
        update = "2h"    # 2 часа
      }
    }
    ```
    
    {% endcut %}
    
    {% endnote %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Cluster.Move](../api-ref/Cluster/move.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>:move' \
          --data '{
                    "destinationFolderId": "<идентификатор_каталога>"
                  }'
      ```

      Где `destinationFolderId` — идентификатор каталога, куда перемещается кластер. Идентификатор можно получить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/move.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [ClusterService.Move](../api-ref/grpc/Cluster/move.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "destination_folder_id": "<идентификатор_каталога>"
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Move
      ```

      Где `destination_folder_id` — идентификатор каталога, куда перемещается кластер. Идентификатор можно получить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/move.md#yandex.cloud.operation.Operation).

{% endlist %}


## Изменить группы безопасности {#change-sg-set}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex StoreDoc**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. В блоке **Сетевые настройки** выберите группы безопасности для сетевого трафика кластера.
    1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        yc managed-mongodb cluster update --help
        ```

    1. Укажите нужные группы безопасности в команде изменения кластера:

        ```bash
        yc managed-mongodb cluster update <имя_или_идентификатор_кластера> \
          --security-group-ids <список_идентификаторов_групп_безопасности>
        ```

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.
      
       О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера Yandex StoreDoc значение параметра `security_group_ids`:
  
        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
          ...
          security_group_ids = [ <список_идентификаторов_групп_безопасности> ]
          ...
        }
        ```

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

  Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_mongodb_cluster.md).

  {% note warning "Ограничения по времени" %}
  
  Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex StoreDoc:
  
  * создание, в т. ч. путем восстановления из резервной копии, — 30 минут;
  * изменение — 60 минут.
  
  Операции, длящиеся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию кластера блок `timeouts`, например:
  
  ```hcl
  resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
    ...
    timeouts {
      create = "1h30m" # Полтора часа
      update = "2h"    # 2 часа
    }
  }
  ```
  
  {% endcut %}
  
  {% endnote %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
      
      {% endnote %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "securityGroupIds",
                    "securityGroupIds": [
                      "<идентификатор_группы_безопасности_1>",
                      "<идентификатор_группы_безопасности_2>",
                      ...
                      "<идентификатор_группы_безопасности_N>"
                    ]
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае передается только один параметр.

      * `securityGroupIds` — список идентификаторов [групп безопасности](../concepts/network.md#security-groups).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
      
      {% cut "Формат перечисления настроек" %}
      
      ```yaml
      "update_mask": {
          "paths": [
              "<настройка_1>",
              "<настройка_2>",
              ...
              "<настройка_N>"
          ]
      }
      ```
      
      {% endcut %}
      
      {% endnote %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                  "paths": [
                    "security_group_ids"
                  ]
                },
                "security_group_ids": [
                  "<идентификатор_группы_безопасности_1>",
                  "<идентификатор_группы_безопасности_2>",
                  ...
                  "<идентификатор_группы_безопасности_N>"
                ]
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается только один параметр.

      * `security_group_ids` — список идентификаторов [групп безопасности](../concepts/network.md#security-groups).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}