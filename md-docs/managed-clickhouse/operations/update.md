# Изменение настроек кластера ClickHouse®

После создания кластера вы можете:

* [Изменить настройки сервисного аккаунта](#change-service-account).
* [Изменить класс хостов](#change-resource-preset).
* [Изменить тип диска и увеличить размер хранилища](#change-disk-size).
* [Настроить сервис координации](#coordination).
* [Включить управление пользователями и базами данных через SQL](#SQL-management).
* [Изменить дополнительные настройки кластера](#change-additional-settings).
* [Переместить кластер](#move-cluster) в другой каталог.
* [Изменить группы безопасности кластера](#change-sg-set).
* [Изменить настройки гибридного хранилища](#change-hybrid-storage).

Подробнее о других изменениях кластера:

* [Настройка технического обслуживания](cluster-maintenance.md).
* [Перенос кластера в другую зону доступности](host-migration.md).
* [Настройка серверов ClickHouse®](change-server-level-settings.md) согласно [документации ClickHouse®](https://clickhouse.com/docs/ru/operations/server-configuration-parameters/settings).
* [Изменение настроек ClickHouse® на уровне запроса](change-query-level-settings.md).


## Изменить настройки сервисного аккаунта {#change-service-account}


Для привязки сервисного аккаунта к кластеру Managed Service for ClickHouse® [назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.


{% note warning %}

Если для доступа к объектам из Object Storage в кластере уже используется сервисный аккаунт, то его смена может привести к недоступности этих объектов и нарушению работы кластера. Перед изменением настроек сервисного аккаунта убедитесь, что кластер не использует соответствующие объекты.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы изменить настройки сервисного аккаунта:

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. В разделе **Сервисные настройки** выберите нужный сервисный аккаунт из списка или [создайте новый](../../iam/operations/sa/create.md). Подробнее о настройке сервисного аккаунта см. в разделе [Настройка доступа к Object Storage из кластера ClickHouse®](s3-access.md).

{% endlist %}


## Изменить класс хостов {#change-resource-preset}

{% note info %}

В кластерах с поддержкой ClickHouse® Keeper хосты ZooKeeper не используются. Подробнее см. в разделе [Сервисы координации](../concepts/coordination-system.md).

{% endnote %}

При смене класса хостов:

* Кластер из одного хоста будет недоступен несколько минут, соединения с БД будут прерваны.
* В кластере из нескольких хостов каждый хост по очереди будет остановлен и обновлен. Остановленный хост будет недоступен несколько минут.
* Кластер с хранилищем на локальных SSD-дисках может быть недоступен длительное время, т. к. может потребоваться миграция данных на другой физический сервер.
* Подключение по [особому FQDN](connect/fqdn.md#auto) не гарантирует стабильность соединения с БД: пользовательские сессии могут быть прерваны.

Рекомендуется изменять класс хостов только во время отсутствия рабочей нагрузки на кластер.

Вы также можете [изменить класс хостов у отдельного шарда](shards.md#shard-update).

Класс хостов влияет на количество оперативной памяти, доступной для использования ClickHouse®. Подробнее см. в разделе [Управление памятью](../concepts/memory-management.md).

Минимальное количество ядер для одного хоста ZooKeeper зависит от суммарного количества ядер хостов ClickHouse®. Подробнее см. в разделе [Сервисы координации](../concepts/coordination-system.md#zk).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. Чтобы изменить класс хостов ClickHouse®, в блоке **Ресурсы** выберите платформу, тип виртуальной машины и нужный класс хоста.
  1. Чтобы изменить класс хостов ZooKeeper, в блоке **Класс хоста ZooKeeper** выберите платформу, тип виртуальной машины и нужный класс хоста ZooKeeper.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     yc managed-clickhouse cluster update --help
     ```

  1. Запросите список доступных классов хостов (в колонке `ZONE IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     
     ```bash
     yc managed-clickhouse resource-preset list

     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | ru-central1-a, ru-central1-b,  |     2 | 8.0 GB   |
     |           | ru-central1-d                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```


  1. Укажите нужный класс в команде изменения кластера:

     ```bash
     yc managed-clickhouse cluster update <имя_или_идентификатор_кластера> \
        --clickhouse-resource-preset=<идентификатор_класса>
     ```

     Managed Service for ClickHouse® запустит операцию изменения класса хостов для кластера.

  1. Чтобы изменить класс хостов ZooKeeper, передайте нужное значение в параметре `--zookeeper-resource-preset`.


- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера Managed Service for ClickHouse® значение параметра `resource_preset_id` в блоках `clickhouse.resources` и `zookeeper.resources` для хостов ClickHouse® и ZooKeeper соответственно:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          clickhouse = {
            resources = {
              resource_preset_id = "<класс_хостов_ClickHouse®>"
              ...
            }
          }
          zookeeper = {
            resources = {
              resource_preset_id = "<класс_хостов_ZooKeeper>"
              ...
            }
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

    Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

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

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Запросите список доступных классов хостов:

        1. Воспользуйтесь методом [ResourcePreset.List](../api-ref/ResourcePreset/list.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/resourcePresets'
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ResourcePreset/list.md#responses).

    1. Измените класс хостов на нужный:

        1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
                --data '{
                          "updateMask": "configSpec.clickhouse.resources.resourcePresetId,configSpec.zookeeper.resources.resourcePresetId",
                          "configSpec": {
                            "clickhouse": {
                              "resources": {
                                "resourcePresetId": "<идентификатор_класса_хостов_ClickHouse®>"
                              }
                            },
                            "zookeeper": {
                              "resources": {
                                "resourcePresetId": "<идентификатор_класса_хостов_ZooKeeper>"
                              }
                            }
                          }
                        }'
            ```

            Где:

            * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

                Укажите нужные параметры:
                * `configSpec.clickhouse.resources.resourcePresetId` — если нужно изменить класс хостов ClickHouse®.
                * `configSpec.zookeeper.resources.resourcePresetId` — если нужно изменить класс хостов ZooKeeper.

                В примере запроса класс хостов изменяется и для хостов ClickHouse®, и для хостов ZooKeeper.

            * `configSpec.clickhouse.resources.resourcePresetId` — идентификатор класса хостов ClickHouse®.
            * `configSpec.zookeeper.resources.resourcePresetId` — идентификатор класса хостов ZooKeeper.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

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

    1. Запросите список доступных классов хостов:

        1. Воспользуйтесь вызовом [ResourcePresetService.List](../api-ref/grpc/ResourcePreset/list.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/resource_preset_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                mdb.api.cloud.yandex.net:443 \
                yandex.cloud.mdb.clickhouse.v1.ResourcePresetService.List
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.clickhouse.v1.ListResourcePresetsResponse).

    1. Измените класс хостов на нужный:

        1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
                -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<идентификатор_кластера>",
                      "update_mask": {
                        "paths": [
                          "config_spec.clickhouse.resources.resource_preset_id",
                          "config_spec.zookeeper.resources.resource_preset_id"
                        ]
                      },
                      "config_spec": {
                        "clickhouse": {
                          "resources": {
                            "resource_preset_id": "<идентификатор_класса_хостов_ClickHouse®>"
                          }
                        },
                        "zookeeper": {
                          "resources": {
                            "resource_preset_id": "<идентификатор_класса_хостов_ZooKeeper>"
                          }
                        }
                      }
                    }' \
                mdb.api.cloud.yandex.net:443 \
                yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
            ```

            Где:

            * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

                Укажите нужные параметры:
                * `config_spec.clickhouse.resources.resource_preset_id` — если нужно изменить класс хостов ClickHouse®.
                * `config_spec.zookeeper.resources.resource_preset_id` — если нужно изменить класс хостов ZooKeeper.

                В примере запроса класс хостов изменяется и для хостов ClickHouse®, и для хостов ZooKeeper.

            * `config_spec.clickhouse.resources.resource_preset_id` — идентификатор класса хостов ClickHouse®.
            * `config_spec.zookeeper.resources.resource_preset_id` — идентификатор класса хостов ZooKeeper.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить тип диска и увеличить размер хранилища {#change-disk-size}

{% note info %}

В кластерах с поддержкой ClickHouse® Keeper хосты ZooKeeper не используются. Подробнее см. в разделе [Сервисы координации](../concepts/coordination-system.md).

{% endnote %}

Проверьте, что в облаке достаточно квот для увеличения хранилища. Откройте страницу [Квоты](https://console.yandex.cloud/cloud?section=quotas) для облака и убедитесь, что в секции **Managed Databases** в строке **Объём HDD-хранилищ** или **Объём SSD-хранилищ** есть квота на объем хранилищ.

{% note warning %}

При изменении типа диска хосты кластера пересоздаются. Данные реплицированных таблиц сохраняются автоматически. Данные нереплицированных таблиц будут потеряны. Перед изменением типа диска [преобразуйте](zk-hosts.md#replicated-tables) нереплицированные таблицы в реплицированные или [создайте резервную копию данных](cluster-backups.md).

{% endnote %}

При изменении типа диска или размера хранилища кластер с хранилищем на локальных SSD-дисках может быть недоступен длительное время, т. к. может потребоваться миграция данных на другой физический сервер.

Вы также можете [изменить тип диска и размер хранилища у отдельного шарда](shards.md#shard-update).

{% note info %}

Чтобы изменить тип диска на `local-ssd`, обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить тип диска и увеличить размер хранилища для кластера:

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. Чтобы изменить тип диска и увеличить размер хранилища для хостов ClickHouse®, выберите нужное значение в блоке **Размер хранилища**.
  1. Чтобы изменить тип диска и увеличить размер хранилища для хостов ZooKeeper, выберите нужное значение в блоке **Размер хранилища ZooKeeper**.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить тип диска и увеличить размер хранилища для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     yc managed-clickhouse cluster update --help
     ```

  1. Укажите нужный [тип диска](../concepts/storage.md) и размер хранилища в команде изменения кластера:

     ```bash
     yc managed-clickhouse cluster update <имя_или_идентификатор_кластера> \
       --clickhouse-disk-size <размер_хранилища_ГБ> \
       --clickhouse-disk-type <тип_диска>
     ```

          
     Новый размер хранилища должен быть не меньше, чем значение `disk_size` в свойствах кластера.


     Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Чтобы изменить тип диска и увеличить размер хранилища хостов ZooKeeper, передайте нужные значения в параметре `--zookeeper-disk-size`.


- Terraform {#tf}

  Чтобы изменить [тип диска](../concepts/storage.md) и увеличить размер хранилища:

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера Managed Service for ClickHouse® значения параметров `disk_size` и `disk_type_id` в блоках `clickhouse.resources` и `zookeeper.resources` для хостов ClickHouse® и ZooKeeper соответственно:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          clickhouse = {
            resources = {
              disk_size = <размер_хранилища_ГБ>
              disk_type_id = "<тип_диска>"
              ...
            }
          }
          zookeeper = {
            resources = {
              disk_size = <размер_хранилища_ГБ>
              disk_type_id = "<тип_диска>"
              ...
            }
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

    Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

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

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.clickhouse.resources.diskSize,configSpec.clickhouse.resources.diskTypeId,configSpec.zookeeper.resources.diskSize,configSpec.zookeeper.resources.diskTypeId",
                      "configSpec": {
                        "clickhouse": {
                          "resources": {
                            "diskSize": "<размер_хранилища_в_байтах>",
                            "diskTypeId": "<тип_диска>"
                          }
                        },
                        "zookeeper": {
                          "resources": {
                            "diskSize": "<размер_хранилища_в_байтах>",
                            "diskTypeId": "<тип_диска>"
                          }
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:

            * `configSpec.clickhouse.resources.diskSize,configSpec.clickhouse.resources.diskTypeId` — если нужно изменить тип диска и увеличить размер хранилища хостов ClickHouse®.
            * `configSpec.zookeeper.resources.diskSize,configSpec.zookeeper.resources.diskTypeId` — если нужно изменить тип диска и увеличить размер хранилища хостов ZooKeeper.

            В примере запроса размер хранилища и тип диска изменяются и для хостов ClickHouse®, и для хостов ZooKeeper.

        * `configSpec.clickhouse.resources.diskSize` — размер хранилища хостов ClickHouse® в байтах.
        * `configSpec.clickhouse.resources.diskTypeId` — [тип диска](../concepts/storage.md) хостов ClickHouse®.
        * `configSpec.zookeeper.resources.diskSize` — размер хранилища хостов ZooKeeper в байтах.
        * `configSpec.zookeeper.resources.diskTypeId` — тип диска хостов ZooKeeper.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

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

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.clickhouse.resources.disk_size",
                      "config_spec.clickhouse.resources.disk_type_id",
                      "config_spec.zookeeper.resources.disk_size",
                      "config_spec.zookeeper.resources.disk_type_id"
                    ]
                  },
                  "config_spec": {
                    "clickhouse": {
                      "resources": {
                        "disk_size": "<размер_хранилища_в_байтах>",
                        "disk_type_id": "<тип_диска>"
                      }
                    },
                    "zookeeper": {
                      "resources": {
                        "disk_size": "<размер_хранилища_в_байтах>",
                        "disk_type_id": "<тип_диска>"
                      }
                    }
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:

            * `config_spec.clickhouse.resources.disk_size` — если нужно увеличить размер хранилища хостов ClickHouse®.
            * `config_spec.clickhouse.resources.disk_type_id` — если нужно изменить тип диска хостов ClickHouse®.
            * `config_spec.zookeeper.resources.disk_size` — если нужно увеличить размер хранилища хостов ZooKeeper.
            * `config_spec.zookeeper.resources.disk_type_id` — если нужно изменить тип диска хостов ZooKeeper.

            В примере запроса размер хранилища и тип диска изменяются и для хостов ClickHouse®, и для хостов ZooKeeper.

        * `config_spec.clickhouse.resources.disk_size` — размер хранилища хостов ClickHouse® в байтах.
        * `config_spec.clickhouse.resources.disk_type_id` — [тип диска](../concepts/storage.md) хостов ClickHouse®.
        * `config_spec.zookeeper.resources.disk_size` — размер хранилища хостов ZooKeeper в байтах.
        * `config_spec.zookeeper.resources.disk_type_id` — тип диска хостов ZooKeeper.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Настроить сервис координации {#coordination}

Вы можете [включить сервис координации](#enable-coordination) ClickHouse® Keeper или ZooKeeper, если он не был задан. Для включенного сервиса координации можно [изменить его настройки](#change-coordination).

### Включить сервис координации {#enable-coordination}

{% note warning %}

Хосты ClickHouse® Keeper и ZooKeeper учитываются в расчете использованной [квоты ресурсов](https://console.yandex.cloud/cloud?section=quotas) в облаке и в [расчете стоимости](../pricing.md) кластера.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;ClickHouse**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Хосты**.
  1. В правом верхнем углу страницы нажмите кнопку **Настроить сервис координации**.
  1. В блоке **Основные настройки** выберите [сервис координации](../concepts/coordination-system.md).
  1. В зависимости от выбранного сервиса задайте следующие настройки:
      
      * Для сервиса координации **ZooKeeper (на отдельных хостах)**:

        * В блоке **Класс хоста ZooKeeper** выберите платформу, тип виртуальной машины и [класс хоста](../concepts/instance-types.md).
        * В блоке **Размер хранилища ZooKeeper** выберите [тип диска](../concepts/storage.md), размер хранилища и при необходимости задайте настройки [автоматического увеличения размера хранилища](../concepts/storage.md#autoscaling) ZooKeeper.

        * В блоке **Хосты ZooKeeper**:
          
          * При необходимости измените настройки автоматически добавленных хостов ZooKeeper.
        
            Чтобы изменить настройки хоста, нажмите на значок ![pencil](../../_assets/console-icons/pencil.svg) в строке нужного хоста и укажите:
          
            * **Зона доступности** — выберите [зону доступности](../../overview/concepts/geo-scope.md).
            * **Подсеть** — выберите [подсеть](../../vpc/concepts/network.md#subnet) в выбранной зоне доступности.

          * Чтобы преобразовать нереплицируемые таблицы в [реплицируемые](../concepts/replication.md#replicated-tables), включите настройку **Преобразовать нереплицируемые таблицы**.
          
            Нереплицируемые таблицы на движке семейства [MergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree) будут автоматически преобразованы в реплицируемые на движке [ReplicatedMergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/replication).
            
            После включения этой настройки ее нельзя отключить.

      * Для сервиса координации **ClickHouse Keeper (на отдельных хостах)**:

        * В блоке **Ресурсы ClickHouse Keeper** выберите платформу, тип виртуальной машины и [класс хоста](../concepts/instance-types.md).
        * В блоке **Размер хранилища ClickHouse Keeper** выберите [тип диска](../concepts/storage.md), размер хранилища и при необходимости задайте настройки [автоматического увеличения размера хранилища](../concepts/storage.md#autoscaling) ClickHouse® Keeper.
        * В блоке **Хосты ClickHouse Keeper**:
        
          * При необходимости измените настройки автоматически добавленных хостов ClickHouse® Keeper.
        
            Чтобы изменить настройки хоста, нажмите на значок ![pencil](../../_assets/console-icons/pencil.svg) в строке нужного хоста и укажите:
          
            * **Зона доступности** — выберите [зону доступности](../../overview/concepts/geo-scope.md).
            * **Подсеть** — выберите [подсеть](../../vpc/concepts/network.md#subnet) в выбранной зоне доступности.

          * Чтобы преобразовать нереплицируемые таблицы в [реплицируемые](../concepts/replication.md#replicated-tables), включите настройку **Преобразовать нереплицируемые таблицы**.
          
            Нереплицируемые таблицы на движке семейства [MergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree) будут автоматически преобразованы в реплицируемые на движке [ReplicatedMergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/replication).
            
            После включения этой настройки ее нельзя отключить.

  1. Нажмите кнопку **Сохранить изменения**.

{% endlist %}

### Изменить настройки включенного сервиса координации {#change-coordination}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;ClickHouse**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. В зависимости от выбранного сервиса координации задайте следующие настройки:
      
      * Для сервиса координации **ClickHouse Keeper (на отдельных хостах)**:

        * В блоке **Ресурсы ClickHouse Keeper** выберите платформу, тип виртуальной машины и [класс хоста](../concepts/instance-types.md);
        * В блоке **Размер хранилища ClickHouse Keeper** выберите [тип диска](../concepts/storage.md), размер хранилища и при необходимости задайте [настройки автоматического увеличения размера хранилища](../concepts/storage.md#autoscaling) ClickHouse® Keeper.

      * Для сервиса координации **ZooKeeper (на отдельных хостах)**:

        * В блоке **Класс хоста ZooKeeper** выберите платформу, тип виртуальной машины и [класс хоста](../concepts/instance-types.md);
        * В блоке **Размер хранилища ZooKeeper** выберите [тип диска](../concepts/storage.md), размер хранилища и при необходимости задайте [настройки автоматического увеличения размера хранилища](../concepts/storage.md#autoscaling) ZooKeeper.

  1. Нажмите кнопку **Сохранить изменения**.

{% endlist %}

## Включить управление пользователями и базами данных через SQL {#SQL-management}

Сервис Managed Service for ClickHouse® позволяет включить управление [пользователями](cluster-users.md#sql-user-management) и [базами данных](databases.md#sql-database-management) кластера через SQL.

{% note alert %}

Управление пользователями и базами данных через стандартные интерфейсы Yandex Cloud (консоль управления, CLI, Terraform, API) станет недоступно.

Включенные настройки управления пользователями или базами данных через SQL невозможно выключить.

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. Для [управления пользователями через SQL](cluster-users.md#sql-user-management), в блоке **Настройки СУБД** включите настройку **Управление пользователями через SQL** и укажите пароль пользователя `admin`.
  1. Для [управления базами данных через SQL](databases.md#sql-database-management), в блоке **Настройки СУБД** включите настройки **Управление пользователями через SQL** и **Управление базами данных через SQL**, укажите пароль пользователя `admin`.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Чтобы включить [режим управления пользователями через SQL](cluster-users.md#sql-user-management):

        * задайте значение `true` для параметра `--enable-sql-user-management`;
        * задайте пароль для пользователя `admin` в параметре `--admin-password`.

        ```bash
        yc managed-clickhouse cluster update <имя_или_идентификатор_кластера> \
           ...
           --enable-sql-user-management true \
           --admin-password "<пароль_пользователя_admin>"
        ```

    1. Чтобы включить [режим управления базами данных через SQL](databases.md#sql-database-management):

        * задайте значение `true` для параметров `--enable-sql-user-management` и `--enable-sql-database-management`;
        * задайте пароль для пользователя `admin` в параметре `--admin-password`.

        ```bash
        yc managed-clickhouse cluster update <имя_или_идентификатор_кластера> \
           ...
           --enable-sql-user-management true \
           --enable-sql-database-management true \
           --admin-password "<пароль_пользователя_admin>"
        ```


- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Чтобы включить [режим управления пользователями через SQL](cluster-users.md#sql-user-management), добавьте к описанию кластера поле `sql_user_management` со значением `true` и поле `admin_password` с паролем пользователя `admin`:
       
       ```hcl
       resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
         name                = "<имя_кластера>"
         ...
         admin_password      = "<пароль_пользователя_admin>"
         sql_user_management = true
         ...
       }
       ```

    1. Чтобы включить [режим управления базами данных через SQL](databases.md#sql-database-management), добавьте к описанию кластера поля `sql_user_management` и `sql_database_management` со значением `true`, а также поле `admin_password` с паролем пользователя `admin`:
       
       ```hcl
       resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
         name                    = "<имя_кластера>"
         ...
         admin_password          = "<пароль_пользователя_admin>"
         sql_database_management = true
         sql_user_management     = true
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

    Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

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

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.adminPassword,configSpec.sqlUserManagement,configSpec.sqlDatabaseManagement",
                      "configSpec": {
                        "adminPassword": "<пароль_пользователя_admin>",
                        "sqlUserManagement": <управление_пользователями_через_SQL>,
                        "sqlDatabaseManagement": <управление_базами_данных_через_SQL>
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:

            * `configSpec.adminPassword` — пароль пользователя `admin`, с помощью которого осуществляется управление.
            * `configSpec.sqlUserManagement` — если нужно включить управление пользователями через SQL.
            * `configSpec.sqlDatabaseManagement` — если нужно включить управление базами данных через SQL.

            В примере запроса включается и управление пользователями, и управление базами данных черех SQL.

        * `configSpec.adminPassword` — пароль пользователя `admin`.
        * `configSpec.sqlUserManagement` — режим управления пользователями через SQL: `true` или `false`.
        * `configSpec.sqlDatabaseManagement` — режим управления базами данных через SQL: `true` или `false`. Необходимо, чтобы был включен режим управления пользователями через SQL.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

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

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.admin_password",
                      "config_spec.sql_user_management",
                      "config_spec.sql_database_management"
                    ]
                  },
                  "config_spec": {
                    "admin_password": "<пароль_пользователя_admin>",
                    "sql_user_management": <управление_пользователями_через_SQL>,
                    "sql_database_management": <управление_базами_данных_через_SQL>
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:

            * `config_spec.admin_password` — пароль пользователя `admin`, с помощью которого осуществляется управление.
            * `config_spec.sql_user_management` — если нужно включить управление пользователями через SQL.
            * `config_spec.sql_database_management` — если нужно включить управление базами данных через SQL.

            В примере запроса включается и управление пользователями, и управление базами данных черех SQL.

        * `config_spec.admin_password` — пароль пользователя `admin`.
        * `config_spec.sql_user_management` — режим управления пользователями через SQL: `true` или `false`.
        * `config_spec.sql_database_management` — режим управления базами данных через SQL: `true` или `false`. Необходимо, чтобы был включен режим управления пользователями через SQL.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. В блоке **Размер хранилища**:

     * (Опционально) Задайте настройки [автоматического увеличения размера хранилища](../concepts/storage.md#autoscaling) ClickHouse®:

       * В поле **Увеличивать размер** выберите один или оба порога:
         * **В окно обслуживания при заполненности более** — порог для планового увеличения. При его достижении размер хранилища увеличивается во время ближайшего [окна обслуживания](../concepts/maintenance.md#maintenance-window).
           
           Для планового увеличения необходимо настроить расписание [окна обслуживания](../concepts/maintenance.md#maintenance-window).
       
         * **Незамедлительно при заполненности более** — порог для незамедлительного увеличения. При его достижении размер хранилища увеличивается немедленно.
       * Задайте пороговое значение (в процентах от общего размера хранилища). Если выбраны оба порога, значение для незамедлительного увеличения должно быть не меньше, чем для планового.
       * Задайте **Максимальный размер хранилища**.

       Настройки автоматического увеличения размера хранилища, заданные для ClickHouse®, применяются ко всем существующим шардам. При добавлении нового шарда значения настроек берутся с самого старого шарда.

  1. В блоке **Сервисные настройки** измените дополнительные настройки кластера:

     * **Начало резервного копирования (UTC)** — промежуток времени, в течение которого начинается резервное копирование кластера. Время указывается по UTC в 24-часовом формате. По умолчанию — `22:00 - 23:00` UTC.
     
     * **Срок хранения автоматических резервных копий, дней** — время, в течение которого нужно хранить созданные автоматически резервные копии (в днях). Если для такой копии истекает срок хранения, то она удаляется. Значение по умолчанию — 7 дней. Подробнее см. в разделе [Резервные копии](../concepts/backup.md#storage).
     
         Изменение срока хранения затрагивает как новые автоматические резервные копии, так и уже существующие. Например, изначальный срок хранения был 7 дней, оставшееся время жизни отдельной автоматической резервной копии — 1 день. При увеличении срока хранения до 9 дней оставшееся время жизни этой резервной копии будет уже 3 дня.
     
     * **Окно обслуживания** — настройки времени [технического обслуживания](../concepts/maintenance.md):
     
        * Чтобы разрешить проведение технического обслуживания в любое время, выберите пункт **произвольное** (по умолчанию).
        * Чтобы указать предпочтительное время начала обслуживания, выберите пункт **по расписанию** и укажите нужные день недели и час дня по UTC. Например, можно выбрать время, когда кластер наименее загружен.
        
        Операции по техническому обслуживанию проводятся для включенных и выключенных кластеров. Они могут включать в себя: обновление СУБД, применение патчей и так далее.
     
     
     * **Сервисный аккаунт** — аккаунт, от имени которого пользовательские программы могут управлять кластером. Подробнее см. в документации [Управление доступом в Managed Service for ClickHouse®](../security.md).
     
     * **Шифрование дисков** — опция включает шифрование диска [пользовательским ключом KMS](../../kms/concepts/key.md). Задайте ключ одним из способов:
     
        * Чтобы [создать](../../kms/operations/key.md#create) новый ключ, нажмите кнопку **Создать**.
     
        * Чтобы использовать созданный ранее ключ, выберите его в поле **Ключ KMS**.
     
        Подробнее о шифровании дисков см. в разделе [Хранилище](../concepts/storage.md#disk-encryption).
     
     
     * **Доступ из DataLens** — опция разрешает анализировать данные из кластера в сервисе [Yandex DataLens](../../datalens/concepts/index.md).
     
     
     * **Доступ из WebSQL** — опция разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления Yandex Cloud с помощью сервиса Yandex WebSQL.
     
     
     
     
     * **Доступ из Метрики и AppMetrica** — опция разрешает [импортировать данные из AppMetrica](https://appmetrica.yandex.ru/docs/common/cloud/about.html) в кластер.
     
     * **Доступ из Serverless** — включите эту опцию, чтобы разрешить доступ к кластеру из сервиса [Yandex Cloud Functions](../../functions/concepts/index.md). Подробнее о настройке доступа см. в документации [Cloud Functions](../../functions/operations/database-connection.md).
     
     
     * **Доступ из Yandex Query** — включите эту опцию, чтобы разрешить доступ к кластеру из сервиса [Yandex Query](../../query/concepts/index.md). Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).
     
     * **Защита от удаления** — управляет защитой кластера от непреднамеренного удаления.
     
        Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

  1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        yc managed-clickhouse cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        
        ```bash
        yc managed-clickhouse cluster update <имя_или_идентификатор_кластера> \
           --backup-window-start <время_начала_резервного_копирования> \
           --backup-retain-period-days <срок_хранения_автоматических_резервных_копий> \
           --datalens-access=<true_или_false> \
           --metrika-access=<true_или_false> \
           --serverless-access=<true_или_false> \
           --websql-access=<true_или_false> \
           --yandexquery-access=<true_или_false> \
           --deletion-protection \
           --disk-size-autoscaling clickhouse-disk-size-limit=<максимальный_размер_хранилища_ГБ>,`
                                  `clickhouse-planned-usage-threshold=<порог_для_планового_увеличения_в_процентах>,`
                                  `clickhouse-emergency-usage-threshold=<порог_для_незамедлительного_увеличения_в_процентах>,`
                                  `zookeeper-disk-size-limit=<максимальный_размер_хранилища_ГБ>,`
                                  `zookeeper-planned-usage-threshold=<порог_для_планового_увеличения_в_процентах>,`
                                  `zookeeper-emergency-usage-threshold=<порог_для_незамедлительного_увеличения_в_процентах> \
           --maintenance-window type=<тип_технического_обслуживания>,`
                               `day=<день_недели>,`
                               `hour=<час_дня>
        ```


    Вы можете изменить следующие настройки:

    * `--backup-window-start` — время начала резервного копирования кластера, задается по UTC в формате `HH:MM:SS`. Если время не задано, резервное копирование начнется в 22:00 UTC.

    * `--backup-retain-period-days` – срок хранения автоматических резервных копий (в днях).

    * `--datalens-access` — разрешает доступ из DataLens. Значение по умолчанию — `false`. Подробнее о настройке подключения см. в разделе [Подключение из DataLens](datalens-connect.md).

    
    * `--metrika-access` — разрешает [импорт данных из AppMetrika в кластер](https://appmetrica.yandex.ru/docs/common/cloud/about.html). Значение по умолчанию — `false`.

    * `--serverless-access` — разрешает доступ к кластеру из сервиса [Yandex Cloud Functions](../../functions/concepts/index.md). Значение по умолчанию — `false`. Подробнее о настройке доступа см. в документации [Cloud Functions](../../functions/operations/database-connection.md).


    * `--websql-access` — разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления Yandex Cloud с помощью сервиса Yandex WebSQL. Значение по умолчанию — `false`.


    * `--yandexquery-access=true` — разрешает доступ к кластеру из сервиса [Yandex Query](../../query/concepts/index.md). Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Значение по умолчанию — `false`.

    * `--deletion-protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

        Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

    * `--disk-size-autoscaling` — настройки автоматического увеличения размера хранилища:
        
        * `clickhouse-disk-size-limit` — максимальный размер хранилища ClickHouse®, в гигабайтах.
        
        * `clickhouse-planned-usage-threshold` — порог заполнения хранилища ClickHouse® в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
                   
          Допустимые значения: от `0` до `100`.
                 
        * `clickhouse-emergency-usage-threshold` — порог заполнения хранилища ClickHouse® в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
                   
          Допустимые значения: от `0` до `100`.
        
        * `zookeeper-disk-size-limit` — максимальный размер хранилища ZooKeeper, в гигабайтах.
        
        * `zookeeper-planned-usage-threshold` — порог заполнения хранилища ZooKeeper в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
                   
          Допустимые значения: от `0` до `100`.
        
        * `zookeeper-emergency-usage-threshold` — порог заполнения хранилища ZooKeeper в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
        
          Допустимые значения: от `0` до `100`.
        
        {% note warning %}
                 
        * Если заданы оба порога для ClickHouse®, значение `clickhouse-emergency-usage-threshold` должно быть не меньше `clickhouse-planned-usage-threshold`.
        
        * Если заданы оба порога для ZooKeeper, значение `zookeeper-emergency-usage-threshold` должно быть не меньше `zookeeper-planned-usage-threshold`.
        
        * При использовании параметров `clickhouse-planned-usage-threshold` и `zookeeper-planned-usage-threshold` необходимо настроить [окно технического обслуживания](../concepts/maintenance.md).
        
        {% endnote %}
        
        Настройки автоматического увеличения размера хранилища, заданные для ClickHouse®, применяются ко всем существующим шардам. При добавлении нового шарда значения настройки берутся с самого старого шарда. Эти значения не сохраняются в конфигурации ClickHouse® и не отображаются при выводе команды `yc managed-clickhouse cluster get`. 
                 
        Чтобы посмотреть информацию о конкретном шарде, включая настройки автоматического увеличения размера хранилища, используйте команду: 
                 
        ```bash
        yc managed-clickhouse shards get <имя_шарда> --cluster-id <идентификатор_кластера>
        ```
        Идентификатор кластера можно получить [со списком кластеров](cluster-list.md#list-clusters) в каталоге.
        
        Имя шарда можно получить [со списком шардов](shards.md#list-shards) в кластере.
    
    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        * `anytime` (по умолчанию) — в любое время.
        * `weekly` — по расписанию. Для этого значения дополнительно укажите:
            * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
            * `hour` — час дня по UTC: от `1` до `24`.

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).


- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Чтобы изменить время начала резервного копирования, добавьте к описанию кластера Managed Service for ClickHouse® блок `backup_window_start`.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          backup_window_start = {
            hours   = <час_начала_резервного_копирования>
            minutes = <минута_начала_резервного_копирования>
          }
          ...
        }
        ```

    1. Чтобы разрешить доступ к кластеру из других сервисов и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью Yandex WebSQL, измените значения соответствующих полей в блоке `access`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          access = {
            data_lens    = <доступ_из_DataLens>
            metrika      = <доступ_из_Метрики_и_AppMetrika>
            serverless   = <доступ_из_Cloud_Functions>
            web_sql      = <выполнение_SQL-запросов_из_консоли_управления>
            yandex_query = <доступ_из_Yandex_Query>
          }
          ...
        }
        ```

        Где:

        * `data_lens` — доступ из DataLens: `true` или `false`.
        * `metrika` — доступ из Метрики и AppMetrika: `true` или `false`.
        * `serverless` — доступ из Cloud Functions: `true` или `false`.
        * `yandex_query` — доступ из Yandex Query: `true` или `false`.
        * `web_sql` — выполнение SQL-запросов из консоли управления: `true` или `false`.

    1. Чтобы настроить время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), добавьте к описанию кластера блок `maintenance_window`:
       
       ```hcl
       resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
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

    1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          deletion_protection = <защита_кластера_от_удаления>
        }
        ```

        Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

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

    Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

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

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            
            ```json
            {
              "updateMask": "<перечень_изменяемых_настроек>",
              "configSpec": {
                "backupWindowStart": {
                  "hours": "<часы>",
                  "minutes": "<минуты>",
                  "seconds": "<секунды>",
                  "nanos": "<наносекунды>"
                },
                "clickhouse": {
                  "diskSizeAutoscaling": {
                    "plannedUsageThreshold": "<порог_для_планового_увеличения_в_процентах>",
                    "emergencyUsageThreshold": "<порог_для_незамедлительного_увеличения_в_процентах>",
                    "diskSizeLimit": "<максимальный_размер_хранилища_в_байтах>"
                  }
                },
                "zookeeper": {
                  "diskSizeAutoscaling": {
                    "plannedUsageThreshold": "<порог_для_планового_увеличения_в_процентах>",
                    "emergencyUsageThreshold": "<порог_для_незамедлительного_увеличения_в_процентах>",
                    "diskSizeLimit": "<максимальный_размер_хранилища_в_байтах>"
                  }
                },
                "access": {
                  "dataLens": <доступ_из_DataLens>,
                  "webSql": <выполнение_SQL-запросов>,
                  "metrika": <импорт_данных_из_AppMetrica>,
                  "serverless": <доступ_из_Yandex Cloud Functions>,
                  "dataTransfer": <доступ_из_Yandex Data Transfer>,
                  "yandexQuery": <доступ_из_Yandex Query>
                }    
              },
              "maintenanceWindow": {
                "anytime": {},
                "weeklyMaintenanceWindow": {
                  "day": "<день_недели>",
                  "hour": "<час_дня_по_UTC>"
                }
              },
              "deletionProtection": <защита_кластера_от_удаления>
            }
            ```


            Где:

            * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            * `configSpec.backupWindowStart` — время начала резервного копирования (UTC):
              
              * `hours` — часы в 24-часовом формате.
              * `minutes` — минуты.
              * `seconds` — секунды.
              * `nanos` — наносекунды.

            * `configSpec.access` — настройки, которые разрешают доступ к кластеру из других сервисов и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью Yandex WebSQL:

                * `dataLens` — разрешить доступ из DataLens: `true` или `false`. Значение по умолчанию — `false`. Подробнее о настройке подключения см. в разделе [Подключение из DataLens](datalens-connect.md).
                
                * `webSql` — разрешить [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления Yandex Cloud с помощью сервиса Yandex WebSQL: `true` или `false`. Значение по умолчанию — `false`.
                
                
                * `metrika` — разрешить [импорт данных из AppMetrika в кластер](https://appmetrica.yandex.ru/docs/common/cloud/about.html): `true` или `false`. Значение по умолчанию — `false`.
                
                * `serverless` — разрешить доступ к кластеру из сервиса [Yandex Cloud Functions](../../functions/concepts/index.md): `true` или `false`. Значение по умолчанию — `false`. Подробнее о настройке доступа см. в документации [Cloud Functions](../../functions/operations/database-connection.md).
                
                * `dataTransfer` — разрешить доступ к кластеру из сервиса [Yandex Data Transfer](../../data-transfer/concepts/index.md) в Serverless-режиме: `true` или `false`. Значение по умолчанию — `false`.
                
                    Это позволит через специальную сеть подключаться к Yandex Data Transfer, запущенному в Kubernetes. В результате будут быстрее выполняться, например, запуск и деактивация трансфера.
                
                
                * `yandexQuery` — разрешить доступ к кластеру из сервиса [Yandex Query](../../query/concepts/index.md): `true` или `false`. Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Значение по умолчанию — `false`.

            * `configSpec.clickhouse.diskSizeAutoscaling` — настройки автоматического увеличения размера хранилища ClickHouse®:
            
                * `plannedUsageThreshold` — порог заполнения хранилища ClickHouse® в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
                                      
                  Допустимые значения: от `0` до `100`.
                                      
                * `emergencyUsageThreshold` — порог заполнения хранилища ClickHouse® в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
                                      
                  Допустимые значения: от `0` до `100`.
                                      
                * `diskSizeLimit` — максимальный размер хранилища ClickHouse®, в байтах.
                                      
                {% note warning %}
                                      
                * Если заданы оба порога, значение `emergencyUsageThreshold` должно быть не меньше `plannedUsageThreshold`.
                                      
                * При использовании параметра `plannedUsageThreshold` необходимо настроить [окно технического обслуживания](../concepts/maintenance.md).
                                      
                {% endnote %}
                                      
                Настройки автоматического увеличения размера хранилища, заданные для ClickHouse®, применяются ко всем существующим шардам. При добавлении нового шарда значения настройки берутся с самого старого шарда. Эти значения не сохраняются в конфигурации ClickHouse®.
                                      
                Чтобы посмотреть информацию о конкретном шарде, включая настройки автоматического увеличения размера хранилища, воспользуйтесь методом [Cluster.GetShard](../api-ref/Cluster/getShard.md) и передайте в запросе идентификатор кластера и имя шарда.
                                      
                Идентификатор кластера можно получить [со списком кластеров](cluster-list.md#list-clusters) в каталоге.
                
                Имя шарда можно получить [со списком шардов](shards.md#list-shards) в кластере.
            
            * `configSpec.zookeeper.diskSizeAutoscaling` — настройки автоматического увеличения размера хранилища ZooKeeper:
                      
                * `plannedUsageThreshold` — порог заполнения хранилища ZooKeeper в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
                                      
                  Допустимые значения: от `0` до `100`.
                                      
                * `emergencyUsageThreshold` — порог заполнения хранилища ZooKeeper в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
                                      
                  Допустимые значения: от `0` до `100`.
                                      
                * `diskSizeLimit` — максимальный размер хранилища ZooKeeper, в байтах.
                                      
                {% note warning %}
                                      
                * Если заданы оба порога, значение `emergencyUsageThreshold` должно быть не меньше `plannedUsageThreshold`.
                                      
                * При использовании параметра `plannedUsageThreshold` необходимо настроить [окно технического обслуживания](../concepts/maintenance.md).
                                      
                {% endnote %}
            
            * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Выберите один из вариантов:

                * `anytime` — (по умолчанию) — в любое время.
                * `weeklyMaintenanceWindow` — по расписанию:
                    * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                    * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

            * `deletionProtection` — защита кластера от непреднамеренного удаления: `true` или `false`. Значение по умолчанию — `false`.

                Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

        1. Выполните запрос:

            ```bash
            curl \
              --request PATCH \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
              --data '@body.json'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

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

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            
            ```json
            {
              "cluster_id": "<идентификатор_кластера>",
              "update_mask": {
                "paths": [
                  <перечень_изменяемых_настроек>
                ]
              },
              "config_spec": {
                "backup_window_start": {
                  "hours": "<часы>",
                  "minutes": "<минуты>",
                  "seconds": "<секунды>",
                  "nanos": "<наносекунды>"
                },
                "clickhouse": {
                  "disk_size_autoscaling": {
                    "planned_usage_threshold": "<порог_для_планового_увеличения_в_процентах>",
                    "emergency_usage_threshold": "<порог_для_незамедлительного_увеличения_в_процентах>",
                    "disk_size_limit": "<максимальный_размер_хранилища_в_байтах>"
                  }
                },
                "zookeeper": {
                  "disk_size_autoscaling": {
                    "planned_usage_threshold": "<порог_для_планового_увеличения_в_процентах>",
                    "emergency_usage_threshold": "<порог_для_незамедлительного_увеличения_в_процентах>",
                    "disk_size_limit": "<максимальный_размер_хранилища_в_байтах>"
                  }
                },
                "access": {
                  "data_lens": <доступ_из_DataLens>,
                  "web_sql": <выполнение_SQL-запросов>,
                  "metrika": <импорт_данных_из_AppMetrica>,
                  "serverless": <доступ_из_Yandex Cloud Functions>,
                  "data_transfer": <доступ_из_Yandex Data Transfer>,
                  "yandex_query": <доступ_из_Yandex Query>
                }
              },
              "maintenance_window": {
                "anytime": {},
                "weekly_maintenance_window": {
                  "day": "<день_недели>",
                  "hour": "<час_дня_по_UTC>"
                }
              },
              "deletion_protection": <защита_кластера_от_удаления>
            }
            ```


            Где:

            * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            * `config_spec.backup_window_start` — время начала резервного копирования (UTC):
              
              * `hours` — часы в 24-часовом формате.
              * `minutes` — минуты.
              * `seconds` — секунды.
              * `nanos` — наносекунды.

            * `config_spec.access` — настройки, которые разрешают доступ к кластеру из других сервисов и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью Yandex WebSQL:

                * `data_lens` — разрешить доступ из DataLens: `true` или `false`. Значение по умолчанию — `false`. Подробнее о настройке подключения см. в разделе [Подключение из DataLens](datalens-connect.md).
                
                * `web_sql` — разрешить [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления Yandex Cloud с помощью сервиса Yandex WebSQL: `true` или `false`. Значение по умолчанию — `false`.
                
                
                * `metrika` — разрешить [импорт данных из AppMetrika в кластер](https://appmetrica.yandex.ru/docs/common/cloud/about.html): `true` или `false`. Значение по умолчанию — `false`.
                
                * `serverless` — разрешить доступ к кластеру из сервиса [Yandex Cloud Functions](../../functions/concepts/index.md): `true` или `false`. Значение по умолчанию — `false`. Подробнее о настройке доступа см. в документации [Cloud Functions](../../functions/operations/database-connection.md).
                
                * `data_transfer` — разрешить доступ к кластеру из сервиса [Yandex Data Transfer](../../data-transfer/concepts/index.md) в Serverless-режиме: `true` или `false`. Значение по умолчанию — `false`.
                
                    Это позволит через специальную сеть подключаться к Yandex Data Transfer, запущенному в Kubernetes. В результате будут быстрее выполняться, например, запуск и деактивация трансфера.
                
                
                * `yandex_query` — разрешить доступ к кластеру из сервиса [Yandex Query](../../query/concepts/index.md): `true` или `false`. Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Значение по умолчанию — `false`.

            * `config_spec.clickhouse.disk_size_autoscaling` — настройки автоматического увеличения размера хранилища ClickHouse®:
            
                * `planned_usage_threshold` — порог заполнения хранилища ClickHouse® в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
                                      
                  Допустимые значения: от `0` до `100`.
                                      
                * `emergency_usage_threshold` — порог заполнения хранилища ClickHouse® в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
                                      
                  Допустимые значения: от `0` до `100`.
                                      
                * `disk_size_limit` — максимальный размер хранилища ClickHouse®, в байтах.
                                      
                {% note warning %}
                                      
                * Если заданы оба порога, значение `emergency_usage_threshold` должно быть не меньше `planned_usage_threshold`.
                                      
                * При использовании параметра `planned_usage_threshold` необходимо настроить [окно технического обслуживания](../concepts/maintenance.md).
                                      
                {% endnote %}
                                      
                Настройки автоматического увеличения размера хранилища, заданные для ClickHouse®, применяются ко всем существующим шардам. При добавлении нового шарда значения настройки берутся с самого старого шарда. Эти значения не сохраняются в конфигурации ClickHouse®.
                                      
                Чтобы посмотреть информацию о конкретном шарде, включая настройки автоматического увеличения размера хранилища, воспользуйтесь методом [ClusterService.GetShard](../api-ref/grpc/Cluster/getShard.md) и передайте в запросе идентификатор кластера и имя шарда.
                                      
                Идентификатор кластера можно получить [со списком кластеров](cluster-list.md#list-clusters) в каталоге.
                
                Имя шарда можно получить [со списком шардов](shards.md#list-shards) в кластере.

            * `config_spec.zookeeper.disk_size_autoscaling` — настройки автоматического увеличения размера хранилища ZooKeeper:
                      
                * `planned_usage_threshold` — порог заполнения хранилища ZooKeeper в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
                                      
                  Допустимые значения: от `0` до `100`.
                                      
                * `emergency_usage_threshold` — порог заполнения хранилища ZooKeeper в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
                                      
                  Допустимые значения: от `0` до `100`.
                                      
                * `disk_size_limit` — максимальный размер хранилища ZooKeeper, в байтах.
                                      
                {% note warning %}
                                      
                * Если заданы оба порога, значение `emergency_usage_threshold` должно быть не меньше `planned_usage_threshold`.
                                      
                * При использовании параметра `planned_usage_threshold` необходимо настроить [окно технического обслуживания](../concepts/maintenance.md).
                                      
                {% endnote %}

            * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Выберите один из вариантов:

                * `anytime` — (по умолчанию) — в любое время.
                * `weekly_maintenance_window` — по расписанию:
                    * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                    * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

            * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`. Значение по умолчанию — `false`.

                Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

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
              yandex.cloud.mdb.clickhouse.v1.ClusterService.Update \
              < body.json
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}


### Connection Manager {#conn-man}

Если в кластере не включена интеграция с сервисом Connection Manager, включите опцию **Использовать Connection Manager**. Она доступна только в [консоли управления](https://console.yandex.cloud).

Для каждого пользователя БД будут созданы:

* [Подключение](../../metadata-hub/concepts/connection-manager.md) Connection Manager с информацией о соединении с БД.

* [Секрет Yandex Lockbox](../../metadata-hub/concepts/secret.md), в котором хранится пароль пользователя. Хранение паролей в сервисе Yandex Lockbox обеспечивает их безопасность.

  Подключение и секрет создаются для каждого нового пользователя БД. Чтобы увидеть все подключения, на странице кластера выберите вкладку **Подключения**.

  Для просмотра информации о подключении требуется роль `connection-manager.viewer`. Вы можете [настраивать доступ к подключениям в Connection Manager](../../metadata-hub/operations/connection-access.md).

  {% note info %}

  Использование сервиса Connection Manager и секретов, созданных с его помощью, не тарифицируется.

  {% endnote %}


## Переместить кластер {#move-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
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
        yc managed-clickhouse cluster move --help
        ```

    1. Укажите каталог назначения в команде перемещения кластера:

        ```bash
        yc managed-clickhouse cluster move <имя_или_идентификатор_кластера> \
           --destination-folder-name=<имя_каталога_назначения>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените или добавьте в описании кластера Managed Service for ClickHouse® значение параметра `folder_id`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
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

    Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

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

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Move](../api-ref/Cluster/move.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>:move' \
            --data '{
                      "destinationFolderId": "<идентификатор_каталога_назначения>"
                    }'
        ```

        Где `destinationFolderId` — идентификатор каталога назначения, в который нужно переместить кластер. Этот идентификатор можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).

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

    1. Воспользуйтесь вызовом [ClusterService.Move](../api-ref/grpc/Cluster/move.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "destination_folder_id": "<идентификатор_каталога_назначения>"
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Move
        ```

        Где `destination_folder_id` — идентификатор каталога назначения, в который нужно переместить кластер. Этот идентификатор можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/move.md#yandex.cloud.operation.Operation).

{% endlist %}


## Изменить группы безопасности {#change-sg-set}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. В блоке **Сетевые настройки** выберите группы безопасности для сетевого трафика кластера.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      yc managed-clickhouse cluster update --help
      ```

  1. Укажите нужные группы безопасности в команде изменения кластера:

      ```bash
      yc managed-clickhouse cluster update <имя_кластера> \
         --security-group-ids <список_идентификаторов_групп_безопасности>
      ```

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените значение параметра `security_group_ids` в описании кластера:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          security_group_ids = [ <список_идентификаторов_групп_безопасности_кластера> ]
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

    Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

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

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "securityGroupIds",
                      "securityGroupIds": [
                        <список_идентификаторов_групп_безопасности>
                      ]
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае указан только один параметр: `securityGroupIds`.

        * `securityGroupIds` — массив строк. Каждая строка — идентификатор группы безопасности.

            {% note warning %}

            Список назначенных кластеру групп безопасности будет полностью перезаписан списком, переданным в параметре `securityGroupIds`.

            Перед выполнением запроса убедитесь, что вы включили в этот список все нужные идентификаторы групп безопасности, в том числе существующие.

            {% endnote %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

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

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "security_group_ids"
                    ]
                  },
                  "security_group_ids": [
                    <список_идентификаторов_групп_безопасности>
                  ]
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае указан только один параметр: `security_group_ids`.

        * `security_group_ids` — массив строк. Каждая строка — идентификатор группы безопасности.

            {% note warning %}

            Список назначенных кластеру групп безопасности будет полностью перезаписан списком, переданным в параметре `security_group_ids`.

            Перед выполнением запроса убедитесь, что вы включили в этот список все нужные идентификаторы групп безопасности, в том числе существующие.

            {% endnote %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}


## Изменить настройки гибридного хранилища {#change-hybrid-storage}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить [настройки гибридного хранилища](../concepts/storage.md#hybrid-storage-settings):

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      yc managed-clickhouse cluster update --help
      ```

  1. Если гибридное хранилище в кластере выключено, включите его:

      ```bash
      yc managed-clickhouse cluster update <имя_или_идентификатор_кластера> \
          --cloud-storage=true
      ```

      {% note info %}
      
      Включенное однажды гибридное хранилище нельзя отключить.
      
      {% endnote %}

  1. Передайте список настроек, которые хотите изменить:

      ```bash
      yc managed-clickhouse cluster update <имя_или_идентификатор_кластера> \
          --cloud-storage-data-cache=<хранение_файлов> \
          --cloud-storage-data-cache-max-size=<объем_памяти_в_байтах> \
          --cloud-storage-move-factor=<доля_свободного_места> \
          --cloud-storage-prefer-not-to-merge=<слияние_кусков_данных>
      ```

      Вы можете изменить следующие настройки:

      * `--cloud-storage-data-cache` — разрешает временное хранение файлов в кластерном хранилище. По умолчанию — `true` (разрешено).
      * `--cloud-storage-data-cache-max-size` — определяет максимальный объем памяти (в байтах), выделяемый в кластерном хранилище для временного хранения файлов. Если значение параметра не задано, максимальный объем памяти по умолчанию равен половине объема кластерного хранилища.
      * `--cloud-storage-move-factor` — устанавливает минимальную долю свободного места в кластерном хранилище. Если доля свободного места меньше этого значения, данные переносятся в Yandex Object Storage. Минимальное значение — `0`, максимальное — `1`, по умолчанию — `0.01`.
      * `--cloud-storage-prefer-not-to-merge` — отключает [слияние кусков данных](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/custom-partitioning-key/) в кластерном и объектном хранилищах. Чтобы отключить слияние, укажите значение `true` или передайте параметр без значения. Чтобы оставить слияние включенным, укажите значение `false` или не передавайте параметр в команде CLI при создании кластера.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "<перечень_изменяемых_настроек>",
                      "configSpec": {
                        "cloudStorage": {
                          "enabled": <использование_гибридного_хранилища>,
                          "moveFactor": "<доля_свободного_места>",
                          "dataCacheEnabled": <временное_хранение_файлов>,
                          "dataCacheMaxSize": "<максимальный_объем_памяти_для_хранения_файлов>",
                          "preferNotToMerge": <отключение_слияния_кусков_данных>
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `configSpec.cloudStorage` — настройки гибридного хранилища:

            * `enabled` — включить гибридное хранилище в кластере, если оно выключено: `true` или `false`. Значение по умолчанию — `false` (выключено).
            
                {% note info %}
                
                Включенное однажды гибридное хранилище нельзя отключить.
                
                {% endnote %}
            
            * `moveFactor` — минимальная доля свободного места в кластерном хранилище. Если доля свободного места меньше этого значения, данные переносятся в Yandex Object Storage.
            
                Минимальное значение — `0`, максимальное — `1`, по умолчанию — `0.01`.
            
            * `dataCacheEnabled` — разрешить временное хранение файлов в кластерном хранилище: `true` или `false`.
            
                По умолчанию — `true` (разрешено).
            
            * `dataCacheMaxSize` — максимальный объем памяти (в байтах), выделяемый в кластерном хранилище для временного хранения файлов.
                
                Если значение параметра не задано, максимальный объем памяти по умолчанию равен половине объема кластерного хранилища.
            
            * `preferNotToMerge` — отключить [слияние кусков данных](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/custom-partitioning-key/) в кластерном и объектном хранилищах: `true` или `false`.
            
                Чтобы отключить слияние, укажите значение `true`. Чтобы оставить слияние включенным, укажите значение `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

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

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      <перечень_изменяемых_настроек>
                    ]
                  },
                  "config_spec": {
                    "cloud_storage": {
                      "enabled": <использование_гибридного_хранилища>,
                      "move_factor": "<доля_свободного_места>",
                      "data_cache_enabled": <временное_хранение_файлов>,
                      "data_cache_max_size": "<максимальный_объем_памяти_для_хранения_файлов>",
                      "prefer_not_to_merge": <отключение_слияния_кусков_данных>
                    }
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `config_spec.cloud_storage` — настройки гибридного хранилища:

            * `enabled` — включить гибридное хранилище в кластере, если оно выключено: `true` или `false`. Значение по умолчанию — `false` (выключено).
            
                {% note info %}
                
                Включенное однажды гибридное хранилище нельзя отключить.
                
                {% endnote %}
            
            * `move_factor` — минимальная доля свободного места в кластерном хранилище. Если доля свободного места меньше этого значения, данные переносятся в Yandex Object Storage.
            
                Минимальное значение — `0`, максимальное — `1`, по умолчанию — `0.01`.
            
            * `data_cache_enabled` — разрешить временное хранение файлов в кластерном хранилище: `true` или `false`.
            
                По умолчанию — `true` (разрешено).
            
            * `data_cache_max_size` — максимальный объем памяти (в байтах), выделяемый в кластерном хранилище для временного хранения файлов.
            
                Если значение параметра не задано, максимальный объем памяти по умолчанию равен половине объема кластерного хранилища.
            
            * `prefer_not_to_merge` — отключить [слияние кусков данных](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/custom-partitioning-key/) в кластерном и объектном хранилищах: `true` или `false`.
            
                Чтобы отключить слияние, укажите значение `true`. Чтобы оставить слияние включенным, укажите значение `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._