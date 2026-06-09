# Обновление кластера Managed Service for Apache Kafka® с ZooKeeper на кластер с поддержкой KRaft

# Обновление кластера Managed Service for Apache Kafka® с ZooKeeper на кластер с поддержкой KRaft


Многохостовые кластеры Managed Service for Apache Kafka® версии 3.5 и ниже используют ZooKeeper для управления метаданными. С версией Apache Kafka® 4.0 поддержка ZooKeeper [прекратится](../../managed-kafka/concepts/update-policy.md#version-schedule). Для кластеров с хостами ZooKeeper поддерживается переход на протокол KRaft. Начиная с версии 3.6 Apache Kafka® использует [KRaft](../../managed-kafka/concepts/kraft.md) как основной протокол синхронизации метаданных.

Чтобы перейти на протокол KRaft в кластере с ZooKeeper:

1. [Обновите версию кластера](#update-version).
1. [Выполните миграцию кластера на протокол KRaft](#migrate-to-kraft).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Apache Kafka®: использование вычислительных ресурсов, выделенных хостам (в том числе хостам KRaft), и дискового пространства (см. [тарифы Managed Service for Apache Kafka®](../../managed-kafka/pricing.md)).
* Плата за использование публичных IP-адресов для хостов кластеров (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Обновите версию кластера {#update-version}

Обновите версию Apache Kafka® вашего кластера с ZooKeeper до версии `3.9` поэтапно, без пропуска версий. Обновление выполняется в такой последовательности: 3.5 → 3.6 → 3.7 → 3.8 → 3.9. Если версия кластера ниже `3.5`, вначале [обновите кластер](../../managed-kafka/operations/cluster-version-update.md) до этой версии.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
    1. В строке с вашим кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **Редактировать**.
    1. В поле **Версия** выберите версию 3.6.
    1. Нажмите кнопку **Сохранить**.
    1. Повторите действия для остальных версий Apache Kafka® в указанной последовательности.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Запустите обновление Apache Kafka® вашего кластера командой:

        ```bash
        yc managed-kafka cluster update <имя_или_идентификатор_кластера> \
           --version=3.6
        ```

    1. Повторите команду для остальных версий в указанной последовательности.

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.
    1. В блоке `config` кластера Managed Service for Apache Kafka® задайте новую версию Apache Kafka® в поле `version` — `3.6`:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          config {
            version = "3.6"
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

    1. Повторите действия для остальных версий Apache Kafka® в указанной последовательности.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../managed-kafka/api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.update](../../managed-kafka/api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.version",
                      "configSpec": {
                        "version": "3.6"
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае указан только один параметр: `configSpec.version`.

        * `configSpec.version` — версия Apache Kafka®.

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../managed-kafka/api-ref/Cluster/update.md#yandex.cloud.operation.Operation).
    1. Повторите действия для остальных версий Apache Kafka® в указанной последовательности.

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../managed-kafka/api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь вызовом [ClusterService/Update](../../managed-kafka/api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.version"
                    ]
                  },
                  "config_spec": {
                    "version": "3.6"
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае указан только один параметр: `config_spec.version`.

        * `config_spec.version` — версия Apache Kafka®.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../managed-kafka/api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).
    1. Повторите действия для остальных версий Apache Kafka® в указанной последовательности.

{% endlist %}

## Выполните миграцию кластера на протокол KRaft {#migrate-to-kraft}

Для миграции кластера Managed Service for Apache Kafka® с хостами ZooKeeper на протокол KRaft задайте конфигурацию ресурсов для контроллеров KRaft.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
    1. Нажмите на имя нужного кластера.
    1. В верхней части экрана нажмите кнопку **Мигрировать**.
    1. Выберите [платформу](../../compute/concepts/vm-platforms.md), тип хостов и класс хостов для контроллеров KRaft.
    1. Нажмите кнопку **Сохранить**.
    1. Дождитесь завершения миграции.

- CLI {#cli}

    Запустите миграцию вашего кластера командой:

     ```bash
     yc managed-kafka cluster update <имя_или_идентификатор_кластера> \
        --controller-resource-preset "<класс_хостов_KRaft>" \
        --controller-disk-size <размер_хранилища> \
        --controller-disk-type <тип_диска>
     ```

     Где:

     * `--controller-resource-preset` — [класс хостов KRaft](../../managed-kafka/concepts/instance-types.md).
     * `--controller-disk-type` — тип диска хостов KRaft.

     {% note info %}
     
     Для контроллеров KRaft:
     
     * Доступны только типы дисков `network-ssd` и `network-ssd-nonreplicated`.
     * Недоступно использование платформы Intel Broadwell.
     
     {% endnote %}

     Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](../../managed-kafka/operations/cluster-list.md#list-clusters).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.
    1. Удалите блок `config.zookeeper` кластера Managed Service for Apache Kafka®.
    1. Добавьте блок `config.kraft` с описанием ресурсов контроллеров KRaft:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          config {
            ...
            kraft {
              resources {
                disk_size          = <размер_хранилища_ГБ>
                disk_type_id       = "<тип_диска>"
                resource_preset_id = "<класс_хостов_KRaft>"
              }
            }
          }
        }
        ```

        Где:

        * `kraft.resources.resource_preset_id` — [класс хостов KRaft](../../managed-kafka/concepts/instance-types.md).
        * `kraft.resources.disk_type_id` — тип диска хостов KRaft.

        {% note info %}
        
        Для контроллеров KRaft:
        
        * Доступны только типы дисков `network-ssd` и `network-ssd-nonreplicated`.
        * Недоступно использование платформы Intel Broadwell.
        
        {% endnote %}

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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../managed-kafka/api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.update](../../managed-kafka/api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.kraft.resources.resourcePresetId,configSpec.kraft.resources.diskSize,configSpec.kraft.resources.diskTypeId",
                      "configSpec": {
                        "kraft": {
                          "resources": {
                            "resourcePresetId": "<класс_хостов_KRaft>",
                            "diskSize": "<размер_хранилища_в_байтах>",
                            "diskTypeId": "<тип_диска>"
                          }
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае должны быть указаны все параметры добавляемых ресурсов: `configSpec.kraft.resources.resourcePresetId`, `configSpec.kraft.resources.diskSize`, `configSpec.kraft.resources.diskTypeId`.

        * `configSpec.kraft` — конфигурация контроллеров KRaft:

            * `resources.resourcePresetId` — идентификатор класса хостов. Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.list](../../managed-kafka/api-ref/ResourcePreset/list.md).
            * `resources.diskSize` — размер диска в байтах.
            * `resources.diskTypeId` — тип диска.

            {% note info %}
            
            Для контроллеров KRaft:
            
            * Доступны только типы дисков `network-ssd` и `network-ssd-nonreplicated`.
            * Недоступно использование платформы Intel Broadwell.
            
            {% endnote %}

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../managed-kafka/api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../managed-kafka/api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь вызовом [ClusterService/Update](../../managed-kafka/api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.kraft.resources.resource_preset_id",
                      "config_spec.kraft.resources.disk_size",
                      "config_spec.kraft.resources.disk_type_id"
                    ]
                  },
                  "config_spec": {
                    "kraft": {
                      "resources": {
                        "resource_preset_id": "<класс_хостов_KRaft>",
                        "disk_size": "<размер_хранилища_в_байтах>",
                        "disk_type_id": "<тип_диска>"
                      }
                    }
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае должны быть указаны все параметры добавляемых ресурсов: `config_spec.kraft.resources.resource_preset_id`, `config_spec.kraft.resources.disk_size`, `config_spec.kraft.resources.disk_type_id`.

        * `config_spec.kraft` — конфигурация контроллеров KRaft:

            * `resources.resource_preset_id` — идентификатор класса хостов. Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.list](../../managed-kafka/api-ref/grpc/ResourcePreset/list.md).
            * `resources.disk_size` — размер диска в байтах.
            * `resources.disk_type_id` — тип диска.

            {% note info %}
            
            Для контроллеров KRaft:
            
            * Доступны только типы дисков `network-ssd` и `network-ssd-nonreplicated`.
            * Недоступно использование платформы Intel Broadwell.
            
            {% endnote %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../managed-kafka/api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    [Удалите кластер Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-delete.md).

- Terraform {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    
        {% note warning %}
    
        Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
    
        {% endnote %}
    
    1. Удалите ресурсы:
    
        1. Выполните команду:
    
            ```bash
            terraform destroy
            ```
    
        1. Подтвердите удаление ресурсов и дождитесь завершения операции.
    
        Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

{% endlist %}