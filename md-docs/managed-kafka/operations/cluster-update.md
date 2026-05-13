# Изменение настроек кластера Apache Kafka®


После создания кластера Managed Service for Apache Kafka® вы можете:

* [изменить имя и описание кластера](#change-name-and-description);
* [изменить класс и количество хостов-брокеров](#change-brokers);
* [изменить класс хостов ZooKeeper](#change-zookeeper);
* [изменить класс хостов KRaft](#change-kraft);
* [изменить настройки групп безопасности и публичного доступа](#change-sg-set);
* [изменить дополнительные настройки кластера](#change-additional-settings);
* [изменить настройки Apache Kafka®](#change-kafka-settings);
* [переместить кластер в другой каталог](#move-cluster).

Подробнее о других изменениях кластера:

* [Обновление версии Apache Kafka®](cluster-version-update.md).
* [Управление дисковым пространством в кластере Managed Service for Apache Kafka®](storage-space.md).
* [Миграция хостов кластера Apache Kafka® в другую зону доступности](host-migration.md).
* [Веб-интерфейс Kafka UI для работы с Apache Kafka®](kafka-ui-enable.md).

## Изменить имя и описание кластера {#change-name-and-description}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kafka**.
    1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **Редактировать**.
    1. В блоке **Базовые параметры** задайте новые имя и описание кластера.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить имя и описание кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        yc managed-kafka cluster update --help
        ```

    1. Укажите новые имя и описание в команде изменения кластера:

        ```bash
        yc managed-kafka cluster update <имя_или_идентификатор_кластера> \
          --new-name <новое_имя_кластера> \
          --description <новое_описание_кластера>
        ```

        Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

    {% note alert %}

    Не изменяйте имя кластера с помощью Terraform. Это приведет к удалению существующего кластера и созданию нового.

    {% endnote %}

    Чтобы изменить описание кластера:

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).

    1. Измените в описании кластера Managed Service for Apache Kafka® значение параметра `description`:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          name        = "<имя_кластера>"
          description = "<новое_описание_кластера>"
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

    Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_cluster.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение всех операций с кластером Managed Service for Apache Kafka® 60 минутами.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
      ...
      timeouts {
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

    1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "name,description",
                      "name": "<имя_кластера>",
                      "description": "<новое_описание_кластера>"
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:
            * `name` — если нужно изменить имя кластера.
            * `description` — если нужно изменить описание кластера.
        * `name` — новое имя кластера.
        * `description` — новое описание кластера.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#responses).

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

    1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "name",
                      "description"
                    ]
                  },
                  "name": "<имя_кластера>",
                  "description": "<новое_описание_кластера>"
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:
            * `name` — если нужно изменить имя кластера.
            * `description` — если нужно изменить описание кластера.
        * `name` — новое имя кластера.
        * `description` — новое описание кластера.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить класс и количество хостов-брокеров {#change-brokers}

Увеличить количество [хостов-брокеров](../concepts/brokers.md) можно, если выполняются условия:

* В кластере используется Apache Kafka® с ZooKeeper. В кластерах с Apache Kafka® и [протоколом KRaft](../concepts/kraft.md) нельзя изменить количество хостов-брокеров.
* Кластер содержит не менее двух хостов-брокеров в разных зонах доступности.

Уменьшить количество хостов-брокеров нельзя. Для выполнения [условий высокой доступности](../concepts/ha-cluster.md) кластера необходимо минимум три хоста-брокера.

При смене класса хостов-брокеров:

* Кластер из одного хоста-брокера будет недоступен несколько минут, соединения с топиками будут прерваны.
* В кластере из нескольких хостов-брокеров каждый хост по очереди будет остановлен и обновлен, остановленный хост будет недоступен несколько минут.

Рекомендуется изменять класс хостов-брокеров только во время отсутствия рабочей нагрузки на кластер.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить класс и количество хостов:

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kafka**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **Редактировать**.
  1. Измените требуемые настройки:
     * Чтобы изменить класс хостов-брокеров, выберите новый [**Класс хоста**](../concepts/instance-types.md).
     * Измените **Количество брокеров в зоне**.

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить класс и количество хостов:

  1. Получите информацию о кластере:

     ```bash
     yc managed-kafka cluster list
     yc managed-kafka cluster get <имя_или_идентификатор_кластера>
     ```

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     yc managed-kafka cluster update --help
     ```

  1. Чтобы увеличить количество хостов-брокеров, выполните команду:

     ```bash
     yc managed-kafka cluster update <имя_или_идентификатор_кластера> --brokers-count <число>
     ```

  1. Чтобы изменить [класс хоста-брокера](../concepts/instance-types.md), выполните команду:

     ```bash
     yc managed-kafka cluster update <имя_или_идентификатор_кластера> --resource-preset <класс_хоста>
     ```

  Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).

    1. Измените в описании кластера Managed Service for Apache Kafka® значение параметра `brokers_count`, чтобы увеличить количество хостов-брокеров:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          config {
            brokers_count = <количество_хостов-брокеров>
            ...
          }
          ...
        }
        ```

    1. Измените в описании кластера Managed Service for Apache Kafka® значение параметра `resource_preset_id` в блоке `kafka.resources`, чтобы задать новый [класс хостов-брокеров](../concepts/instance-types.md):

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          kafka {
            resources {
              resource_preset_id = "<класс_хостов-брокеров>"
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

    Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_cluster.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение всех операций с кластером Managed Service for Apache Kafka® 60 минутами.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
      ...
      timeouts {
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

        1. Воспользуйтесь методом [ResourcePreset.list](../api-ref/ResourcePreset/list.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/resourcePresets'
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ResourcePreset/list.md#responses).

    1. Измените класс и количество хостов-брокеров на нужные:

        1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>' \
                --data '{
                          "updateMask": "configSpec.kafka.resources.resourcePresetId,configSpec.brokersCount",
                          "configSpec": {
                            "kafka": {
                              "resources": {
                                "resourcePresetId": "<идентификатор_класса_хостов-брокеров>"
                              }
                            },
                            "brokersCount": "<количество_хостов-брокеров>"
                          }
                        }'
            ```

            Где:

            * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

                Укажите нужные параметры:
                * `configSpec.kafka.resources.resourcePresetId` — если нужно изменить класс хостов-брокеров.
                * `configSpec.brokersCount` — если нужно изменить количество хостов-брокеров.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#responses).

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

        1. Воспользуйтесь вызовом [ResourcePresetService/List](../api-ref/grpc/ResourcePreset/list.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/resource_preset_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                mdb.api.cloud.yandex.net:443 \
                yandex.cloud.mdb.kafka.v1.ResourcePresetService.List
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.kafka.v1.ListResourcePresetsResponse).

    1. Измените класс хостов на нужный:

        1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
                -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<идентификатор_кластера>",
                      "update_mask": {
                        "paths": [
                          "config_spec.kafka.resources.resource_preset_id",
                          "config_spec.brokers_count"
                        ]
                      },
                      "config_spec": {
                        "kafka": {
                          "resources": {
                            "resource_preset_id": "<идентификатор_класса_хостов-брокеров>"
                          }
                        },
                        "brokers_count": {
                          "value": "<количество_хостов-брокеров>"
                        }
                      }
                    }' \
                mdb.api.cloud.yandex.net:443 \
                yandex.cloud.mdb.kafka.v1.ClusterService.Update
            ```

            Где:

            * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

                Укажите нужные параметры:
                * `config_spec.kafka.resources.resource_preset_id` — если нужно изменить класс хостов-брокеров.
                * `config_spec.brokers_count` — если нужно изменить количество хостов-брокеров.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}


## Изменить класс хостов ZooKeeper {#change-zookeeper}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kafka**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **Редактировать**.
  1. Выберите новый [**Класс хоста ZooKeeper**](../concepts/instance-types.md).
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить класс хостов ZooKeeper:

  1. Получите информацию о кластере:

     ```bash
     yc managed-kafka cluster list
     yc managed-kafka cluster get <имя_или_идентификатор_кластера>
     ```

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     yc managed-kafka cluster update --help
     ```

  1. Чтобы изменить [класс хостов](../concepts/instance-types.md) ZooKeeper, выполните команду:

     ```bash
     yc managed-kafka cluster update <имя_или_идентификатор_кластера> \
       --zookeeper-resource-preset <класс_хоста>
     ```

  Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).

    1. Измените в описании кластера Managed Service for Apache Kafka® значение параметра `resource_preset_id` в блоке `zookeeper.resources`, чтобы задать новый [класс хостов](../concepts/instance-types.md) ZooKeeper:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          zookeeper {
            resources {
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

    Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_cluster.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение всех операций с кластером Managed Service for Apache Kafka® 60 минутами.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
      ...
      timeouts {
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

        1. Воспользуйтесь методом [ResourcePreset.list](../api-ref/ResourcePreset/list.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/resourcePresets'
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ResourcePreset/list.md#yandex.cloud.mdb.kafka.v1.ListResourcePresetsResponse).

    1. Измените класс хостов на нужный:

        1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>' \
                --data '{
                          "updateMask": "configSpec.zookeeper.resources.resourcePresetId",
                          "configSpec": {
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
                * `configSpec.zookeeper.resources.resourcePresetId` — если нужно изменить класс хостов ZooKeeper.

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

        1. Воспользуйтесь вызовом [ResourcePresetService/List](../api-ref/grpc/ResourcePreset/list.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/resource_preset_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                mdb.api.cloud.yandex.net:443 \
                yandex.cloud.mdb.kafka.v1.ResourcePresetService.List
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.kafka.v1.ListResourcePresetsResponse).

    1. Измените класс хостов на нужный:

        1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
                -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<идентификатор_кластера>",
                      "update_mask": {
                        "paths": [
                          "config_spec.zookeeper.resources.resource_preset_id"
                        ]
                      },
                      "config_spec": {
                        "zookeeper": {
                          "resources": {
                            "resource_preset_id": "<идентификатор_класса_хостов_ZooKeeper>"
                          }
                        }
                      }
                    }' \
                mdb.api.cloud.yandex.net:443 \
                yandex.cloud.mdb.kafka.v1.ClusterService.Update
            ```

            Где:

            * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

                Укажите нужные параметры:
                * `config_spec.zookeeper.resources.resource_preset_id` — если нужно изменить класс хостов ZooKeeper.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}



## Изменить класс хостов KRaft {#change-kraft}

{% note info %}

Класс хостов KRaft используется только в кластерах с версией Apache Kafka® 3.6 и выше.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kafka**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **Редактировать**.
  1. Выберите новый [**Класс хоста KRaft**](../concepts/instance-types.md).
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить класс хостов KRaft:

  1. Получите информацию о кластере:

     ```bash
     yc managed-kafka cluster list
     yc managed-kafka cluster get <имя_или_идентификатор_кластера>
     ```

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     yc managed-kafka cluster update --help
     ```

  1. Чтобы изменить [класс хостов](../concepts/instance-types.md) KRaft, выполните команду:

     ```bash
     yc managed-kafka cluster update <имя_или_идентификатор_кластера> \
       --controller-resource-preset <класс_хоста>
     ```

  Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).

    1. Измените в описании кластера Managed Service for Apache Kafka® значение параметра `resource_preset_id` в блоке `kraft.resources`, чтобы задать новый [класс хостов](../concepts/instance-types.md) KRaft:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          kraft {
            resources {
              resource_preset_id = "<класс_хостов_KRaft>"
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

    Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_cluster.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение всех операций с кластером Managed Service for Apache Kafka® 60 минутами.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
      ...
      timeouts {
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

        1. Воспользуйтесь методом [ResourcePreset.list](../api-ref/ResourcePreset/list.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/resourcePresets'
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ResourcePreset/list.md#yandex.cloud.mdb.kafka.v1.ListResourcePresetsResponse).

    1. Измените класс хостов на нужный:

        1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>' \
                --data '{
                          "updateMask": "configSpec.kraft.resources.resourcePresetId",
                          "configSpec": {
                            "kraft": {
                              "resources": {
                                "resourcePresetId": "<идентификатор_класса_хостов_KRaft>"
                              }
                            }
                          }
                        }'
            ```

            Где:

            * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

                Укажите нужные параметры:
                * `configSpec.kraft.resources.resourcePresetId` — если нужно изменить класс хостов KRaft.

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

        1. Воспользуйтесь вызовом [ResourcePresetService/List](../api-ref/grpc/ResourcePreset/list.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/resource_preset_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                mdb.api.cloud.yandex.net:443 \
                yandex.cloud.mdb.kafka.v1.ResourcePresetService.List
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.kafka.v1.ListResourcePresetsResponse).

    1. Измените класс хостов на нужный:

        1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
                -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<идентификатор_кластера>",
                      "update_mask": {
                        "paths": [
                          "config_spec.kraft.resources.resource_preset_id"
                        ]
                      },
                      "config_spec": {
                        "kraft": {
                          "resources": {
                            "resource_preset_id": "<идентификатор_класса_хостов_KRaft>"
                          }
                        }
                      }
                    }' \
                mdb.api.cloud.yandex.net:443 \
                yandex.cloud.mdb.kafka.v1.ClusterService.Update
            ```

            Где:

            * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

                Укажите нужные параметры:
                * `config_spec.kraft.resources.resource_preset_id` — если нужно изменить класс хостов KRaft.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}



## Изменить настройки групп безопасности и публичного доступа {#change-sg-set}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kafka**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **Редактировать**.
  1. В блоке **Сетевые настройки** выберите группы безопасности для сетевого трафика кластера.
  1. Установите или отключите публичный доступ к кластеру при помощи опции **Публичный доступ**.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      yc managed-kafka cluster update --help
      ```

  1. Укажите нужные группы безопасности и настройку публичного доступа в команде изменения кластера:

      ```bash
      yc managed-kafka cluster update <имя_или_идентификатор_кластера> \
         --security-group-ids <список_групп_безопасности> \
         --assign-public-ip=<разрешить_публичный_доступ_к_кластеру>
      ```

      Где:

      * `--security-group-ids` — список идентификаторов групп безопасности кластера.
      * `--assign-public-ip` — публичный доступ к кластеру: `true` или `false`.

      Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).

    1. Измените значения параметров `security_group_ids` и `assign_public_ip` в описании кластера:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          security_group_ids = [ <список_групп_безопасности> ]
          ...
          config {
            assign_public_ip = "<разрешить_публичный_доступ_к_кластеру>"
            ...
            }
        }
        ```

        Где:
        * `security_group_ids` — список идентификаторов групп безопасности кластера.
        * `assign_public_ip` — публичный доступ к кластеру: `true` или `false`.

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

    Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_cluster.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение всех операций с кластером Managed Service for Apache Kafka® 60 минутами.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
      ...
      timeouts {
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

    1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "securityGroupIds,configSpec.assignPublicIp",
                      "securityGroupIds": [
                        <список_идентификаторов_групп_безопасности>
                      ],
                      "configSpec": {
                        "assignPublicIp": "<разрешить_публичный_доступ_к_кластеру>"
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:
            * `securityGroupIds` — если нужно изменить список групп безопасности.
            * `configSpec.assignPublicIp` — если нужно изменить настройку публичного доступа.
        * `securityGroupIds` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md) в виде массива строк. Каждая строка — идентификатор группы безопасности.

            {% note warning %}

            Список назначенных кластеру групп безопасности будет полностью перезаписан списком, переданным в параметре `securityGroupIds`.

            Перед выполнением запроса убедитесь, что вы включили в этот список все нужные идентификаторы групп безопасности, в том числе существующие.

            {% endnote %}

        * `assignPublicIp` — доступность хостов-брокеров из интернета: `true` или `false`.

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

    1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "security_group_ids",
                      "config_spec.assign_public_ip"
                    ]
                  },
                  "security_group_ids": [
                    <список_идентификаторов_групп_безопасности>
                  ],
                  "config_spec": {
                    "assign_public_ip": "<разрешить_публичный_доступ_к_кластеру>"
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:
            * `security_group_ids` — если нужно изменить список групп безопасности.
            * `config_spec.assign_public_ip` — если нужно изменить настройку публичного доступа.
        * `security_group_ids` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md) в виде массива строк. Каждая строка — идентификатор группы безопасности.

            {% note warning %}

            Список назначенных кластеру групп безопасности будет полностью перезаписан списком, переданным в параметре `security_group_ids`.

            Перед выполнением запроса убедитесь, что вы включили в этот список все нужные идентификаторы групп безопасности, в том числе существующие.

            {% endnote %}

        * `assign_public_ip` — доступность хостов-брокеров из интернета: `true` или `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

[Перезагрузите кластер](cluster-stop.md), чтобы изменение настройки публичного доступа вступило в силу.

Для подключения к кластеру может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups).


## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kafka**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **Редактировать**.
  1. Измените дополнительные настройки кластера:

     * **Окно обслуживания** — настройки времени [технического обслуживания](../concepts/maintenance.md):
     
         * Чтобы разрешить проведение технического обслуживания в любое время, выберите пункт **произвольное** (по умолчанию).
         * Чтобы указать предпочтительное время начала обслуживания, выберите пункт **по расписанию** и укажите нужные день недели и час дня по UTC. Например, можно выбрать время, когда кластер наименее загружен.
         
         Операции по техническому обслуживанию проводятся для включенных и выключенных кластеров. Они могут включать в себя: обновление СУБД, применение патчей и так далее.
     
     
     * **Защита от удаления** — управляет защитой кластера от непреднамеренного удаления.
     
         Включенная защита кластера от удаления не помешает удалить пользователя или топик, а также подключиться вручную и удалить данные.
     
     
     * **Шифрование дисков** — включите настройку, чтобы зашифровать диски [пользовательским ключом KMS](../../kms/concepts/key.md).
     
        * Чтобы [создать](../../kms/operations/key.md#create) новый ключ, нажмите кнопку **Создать**.
     
        * Чтобы использовать созданный ранее ключ, выберите его в поле **Ключ KMS**.
     
        Подробнее о шифровании дисков см. в разделе [Хранилище](../concepts/storage.md#disk-encryption).
     
        {% note warning %}
        
        Включить шифрование дисков можно только при создании кластера.
        
        {% endnote %}
     
     
     * **Реестр схем данных** — включите настройку, чтобы управлять схемами данных с помощью [Managed Schema Registry](../concepts/managed-schema-registry.md).
     
         {% note warning %}
         
         Невозможно отключить управление схемами данных с помощью Managed Schema Registry после его подключения.
         
         {% endnote %}
     
     * **Kafka Rest API** — включите настройку, чтобы разрешить отправку запросов к API Apache Kafka®.
     
         В качестве реализации используется приложение с открытым исходным кодом [Karapace](https://github.com/Aiven-Open/karapace). API Karapace совместимо с [API Confluent REST Proxy](https://docs.confluent.io/platform/current/kafka-rest/api.html) за исключением небольших расхождений.
     
         {% note warning %}
     
         Настройку **Kafka Rest API** невозможно отключить после ее включения.
     
         {% endnote %}
     
     
     * **Kafka UI** — включите настройку, чтобы использовать [веб-интерфейс Apache Kafka®](../concepts/kafka-ui.md).

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        yc managed-kafka cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        
        ```bash
        yc managed-kafka cluster update <имя_или_идентификатор_кластера> \
           --maintenance-window type=<тип_технического_обслуживания>,`
                               `day=<день_недели>,`
                               `hour=<час_дня> \
           --datatransfer-access=<разрешить_доступ_из_Data_Transfer> \
           --deletion-protection \
           --schema-registry=<управление_схемами_данных>
        ```


    Вы можете изменить следующие настройки:

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        * `anytime` (по умолчанию) — в любое время.
        * `weekly` — по расписанию. Для этого значения дополнительно укажите:
            * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
            * `hour` — час дня по UTC: от `1` до `24`.


    * `--deletion-protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

        Включенная защита кластера от удаления не помешает удалить пользователя или топик, а также подключиться вручную и удалить данные.

    * `--schema-registry` — управление схемами данных с помощью [Managed Schema Registry](../concepts/managed-schema-registry.md): `true` или `false`.

        {% note warning %}
        
        Невозможно отключить управление схемами данных с помощью Managed Schema Registry после его подключения.
        
        {% endnote %}

    Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).

    1. Чтобы настроить время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), добавьте к описанию кластера блок `maintenance_window`:
       
       ```hcl
       resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
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
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          deletion_protection = <защитить_кластер_от_удаления>
        }
        ```

        Включенная защита кластера от удаления не помешает удалить пользователя или топик, а также подключиться вручную и удалить данные.

    1. Чтобы включить управление схемами данных с помощью [Managed Schema Registry](../concepts/managed-schema-registry.md), добавьте к описанию кластера поле `config.schema_registry` со значением `true`:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя кластера>" {
          ...
          config {
            ...
            schema_registry  = <управление_схемами_данных>
          }
        }
        ```

        {% note warning %}
        
        Невозможно отключить управление схемами данных с помощью Managed Schema Registry после его подключения.
        
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

    Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_cluster.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение всех операций с кластером Managed Service for Apache Kafka® 60 минутами.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
      ...
      timeouts {
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

    1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        
        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.restApiConfig.enabled,configSpec.schemaRegistry,maintenanceWindow,deletionProtection",
                      "configSpec": {
                        "schemaRegistry": true,
                        "restApiConfig": {
                          "enabled": true
                        }
                      },
                      "maintenanceWindow": {
                        "anytime": {},
                        "weeklyMaintenanceWindow": {
                          "day": "<день_недели>",
                          "hour": "<час_дня_по_UTC>"
                        }
                      },
                      "deletionProtection": <защитить_кластер_от_удаления>
                    }'
        ```


        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:
            * `configSpec.schemaRegistry` – если нужно включить настройки управления схемами данных с помощью [Managed Schema Registry](../concepts/managed-schema-registry.md).
            * `configSpec.restApiConfig.enabled` — если нужно включить доступ к отправке запросов к REST API Apache Kafka®.


            * `maintenanceWindow` — если нужно изменить настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров).
            * `deletionProtection` — если нужно включить или выключить защиту кластера от непреднамеренного удаления.

              Включенная защита кластера от удаления не помешает удалить пользователя или топик, а также подключиться вручную и удалить данные.

        * `configSpec.schemaRegistry` — укажите `true`, чтобы управлять схемами данных с помощью [Managed Schema Registry](../concepts/managed-schema-registry.md). Эту настройку невозможно изменить после включения.
        * `configSpec.restApiConfig.enabled` — для доступа к отправке запросов к REST API Apache Kafka® укажите `true`. Эту настройку невозможно изменить после включения.


        * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Выберите один из вариантов:

            * `anytime` — (по умолчанию) — в любое время.
            * `weeklyMaintenanceWindow` — по расписанию:
                * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

        * `deletionProtection` — включить (`true`) или выключить (`false`) защиту кластера от непреднамеренного удаления.

            Включенная защита кластера от удаления не помешает удалить пользователя или топик, а также подключиться вручную и удалить данные.

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

    1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "maintenance_window",
                      "deletion_protection",
                      "config_spec.schema_registry",
                      "config_spec.rest_api_config.enabled"
                    ]
                  },
                  "config_spec": {
                    "schema_registry": true,
                    "rest_api_config": {
                      "enabled": true
                    }
                  },
                  "maintenance_window": {
                    "anytime": {},
                    "weekly_maintenance_window": {
                      "day": "<день_недели>",
                      "hour": "<час_дня_по_UTC>"
                    }
                  },
                  "deletion_protection": <защитить_кластер_от_удаления>
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```


        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:
            * `config_spec.schema_registry` – если нужно управлять схемами данных с помощью [Managed Schema Registry](../concepts/managed-schema-registry.md).
            * `config_spec.rest_api_config.enabled` – если нужно включить доступ к отправке запросов к REST API Apache Kafka®.


            * `maintenance_window` — если нужно изменить настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров).
            * `deletion_protection` — если нужно включить или выключить защиту кластера, его баз данных и пользователей от непреднамеренного удаления.
        * `schema_registry` — укажите `true`, чтобы управлять схемами данных с помощью [Managed Schema Registry](../concepts/managed-schema-registry.md). Эту настройку невозможно изменить после включения.
        * `rest_api_config.enabled` — для доступа к отправке запросов к REST API Apache Kafka® укажите `true`. Эту настройку невозможно изменить после включения.


        * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md). Выберите один из вариантов:

            * `anytime` — в любое время.
            * `weekly_maintenance_window` — по расписанию:
                * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

        * `deletion_protection` — включить (`true`) или выключить (`false`) защиту кластера от непреднамеренного удаления.

            Включенная защита кластера от удаления не помешает удалить пользователя или топик, а также подключиться вручную и удалить данные.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки Apache Kafka® {#change-kafka-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kafka**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **Редактировать**.
  1. В блоке **Настройки Kafka** нажмите кнопку **Настроить**.

     Подробнее в разделе [Настройки Apache Kafka®](../concepts/settings-list.md).

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить настройки Apache Kafka®:

    1. Посмотрите описание команды CLI для изменения настроек кластера:

        ```bash
        yc managed-kafka cluster update --help
        ```

    1. Измените [настройки Apache Kafka®](../concepts/settings-list.md#cluster-settings) в команде изменения кластера (в примере приведены не все настройки):

        ```bash
        yc managed-kafka cluster update <имя_или_идентификатор_кластера> \
           --compression-type <тип_сжатия> \
           --log-flush-interval-messages <количество_сообщений_в_логе> \
           --log-flush-interval-ms <максимальное_время_хранения_сообщений>
        ```

        Где:

        * `--log-flush-interval-messages` — количество сообщений в логе, необходимое для их сброса на диск.
        * `--log-flush-interval-ms` — максимальное время хранения сообщений в памяти перед сбросом на диск.

        Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).

    1. Измените в описании кластера Managed Service for Apache Kafka® значения параметров в блоке `kafka.kafka_config` (в примере приведены не все [настройки](../concepts/settings-list.md#cluster-settings)):

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          config {
            kafka {
              ...
              kafka_config {
                compression_type            = "<тип_сжатия>"
                log_flush_interval_messages = <максимальное_количество_сообщений_в_памяти>
                ...
              }
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

    Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_cluster.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение всех операций с кластером Managed Service for Apache Kafka® 60 минутами.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
      ...
      timeouts {
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

    1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.kafka.kafkaConfig_2_8.<настройка_1_конфигурации_Apache Kafka®_версии_2.8>,...,configSpec.kafka.kafkaConfig_2_8.<настройка_N_конфигурации_Apache Kafka®_версии_2.8>,configSpec.kafka.kafkaConfig_3.<настройка_1_конфигурации_Apache Kafka®_версии_3.x>,...,configSpec.kafka.kafkaConfig_3.<настройка_N_конфигурации_Apache Kafka®_версии_3.x>",
                      "configSpec": {
                        "kafka": {
                          "kafkaConfig_2_8": {
                            "<настройка_1_конфигурации_Apache Kafka®_версии_2.8>": "<значение_настройки>",
                            "<настройка_2_конфигурации_Apache Kafka®_версии_2.8>": "<значение_настройки>",
                            ...,
                            "<настройка_N_конфигурации_Apache Kafka®_версии_2.8>": "<значение_настройки>"
                          },
                          "kafkaConfig_3": {
                            "<настройка_1_конфигурации_Apache Kafka®_версии_3.x>": "<значение_настройки>",
                            "<настройка_2_конфигурации_Apache Kafka®_версии_3.x>": "<значение_настройки>",
                            ...,
                            "<настройка_N_конфигурации_Apache Kafka®_версии_3.x>": "<значение_настройки>"
                          }
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:
            * `configSpec.kafka.kafkaConfig_2_8.<настройка_конфигурации_Apache Kafka®_версии_2.8>` – если используете Apache Kafka® версии `2.8`.
            * `configSpec.kafka.kafkaConfig_3.<настройка_конфигурации_Apache Kafka®_версии_3.x>` – если используете Apache Kafka® версий `3.x`.
        * `configSpec.kafka.kafkaConfig_2_8.<настройка_конфигурации_Apache Kafka®_версии_2.8` – укажите новое значение настройки, если используете Apache Kafka® версии `2.8`.
        * `configSpec.kafka.kafkaConfig_3.<настройка_конфигурации_Apache Kafka®_версии_3.x` – укажите новое значение настройки, если используете Apache Kafka® версий `3.x`.

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

    1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.kafka.kafka_config_2_8.<настройка_1_конфигурации_Apache Kafka®_версии_2.8>",
                      ...,
                      "config_spec.kafka.kafka_config_2_8.<настройка_N_конфигурации_Apache Kafka®_версии_2.8>",
                      "config_spec.kafka.kafka_config_3.<настройка_1_конфигурации_Apache Kafka®_версии_3.x>",
                      ...,
                      "config_spec.kafka.kafka_config_3.<настройка_N_конфигурации_Apache Kafka®_версии_3.x>"
                    ]
                  }
                  "config_spec": {
                    "kafka": {
                      "kafka_config_2_8": {
                        "<настройка_1_конфигурации_Apache Kafka®_версии_2.8>": "<значение_настройки>",
                        "<настройка_2_конфигурации_Apache Kafka®_версии_2.8>": "<значение_настройки>",
                        ...,
                        "<настройка_N_конфигурации_Apache Kafka®_версии_2.8>": "<значение_настройки>"
                      },
                      "kafka_config_3": {
                        "<настройка_1_конфигурации_Apache Kafka®_версии_3.x>": "<значение_настройки>",
                        "<настройка_2_конфигурации_Apache Kafka®_версии_3.x>": "<значение_настройки>",
                        ...,
                        "<настройка_N_конфигурации_Apache Kafka®_версии_3.x>": "<значение_настройки>"
                      }
                    }
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:
            * `config_spec.kafka.kafka_config_2_8.<настройка_конфигурации_Apache Kafka®_версии_2.8>` – если используете Apache Kafka® версии `2.8`.
            * `config_spec.kafka.kafka_config_3.<настройка_конфигурации_Apache Kafka®_версии_3.x>` – если используете Apache Kafka® версий `3.x`.
        * `config_spec.kafka.kafka_config_2_8.<настройка_конфигурации_Apache Kafka®_версии_2.8` – укажите новое значение настройки, если используете Apache Kafka® версии `2.8`.
        * `config_spec.kafka.kafka_config_3.<настройка_конфигурации_Apache Kafka®_версии_3.x` – укажите новое значение настройки, если используете Apache Kafka® версий `3.x`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Переместить кластер в другой каталог {#move-cluster}

{% list tabs group=instructions %}


- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы переместить кластер:

    1. Посмотрите описание команды CLI для перемещения кластера:

        ```bash
        yc managed-kafka cluster move --help
        ```

    1. Укажите каталог назначения в команде перемещения кластера:

        ```bash
        yc managed-kafka cluster move <имя_или_идентификатор_кластера> \
           --destination-folder-name=<имя_каталога_назначения>
        ```

        Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).

    1. Измените или добавьте в описании кластера Managed Service for Apache Kafka® значение параметра `folder_id`:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
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

    Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_cluster.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение всех операций с кластером Managed Service for Apache Kafka® 60 минутами.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
      ...
      timeouts {
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

    1. Воспользуйтесь методом [Cluster.move](../api-ref/Cluster/move.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>:move' \
            --data '{
                      "destinationFolderId": "<идентификатор_каталога>"
                    }'
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

    1. Воспользуйтесь вызовом [ClusterService/Move](../api-ref/grpc/Cluster/move.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "destination_folder_id": "<идентификатор_каталога>"
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.kafka.v1.ClusterService.Move
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}