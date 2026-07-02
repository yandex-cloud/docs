[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Kafka®](../index.md) > [Пошаговые инструкции](index.md) > Веб-интерфейс Kafka UI для Apache Kafka®

# Веб-интерфейс Kafka UI для работы с Apache Kafka®

Для работы с кластерами Managed Service for Apache Kafka® можно использовать веб-интерфейс Kafka UI. Он помогает отслеживать потоки данных, находить и устранять неисправности, управлять [брокерами](../concepts/brokers.md), кластером, [производителями и потребителями](../concepts/producers-consumers.md). Подробнее о возможностях в разделе [Веб-интерфейс Kafka UI для Apache Kafka®](../concepts/kafka-ui.md).

Чтобы предоставить доступ к веб-интерфейсу Kafka UI, [назначьте](../../iam/operations/roles/grant.md) аккаунту в Yandex Cloud роли на каталог, в котором создан кластер Apache Kafka®:

* [managed-kafka.interfaceUser](../security/index.md#managed-kafka-interface-user) — чтобы работать с веб-интерфейсом Kafka UI;
* [managed-kafka.viewer](../security/index.md#managed-kafka-viewer) — чтобы просматривать информацию о кластере Apache Kafka®;
* [resource-manager.viewer](../../resource-manager/security/index.md#resource-manager-viewer) — чтобы просматривать информацию об облаке и каталоге, в которых создан кластер Apache Kafka®.

## Включить веб-интерфейс {#enable-kafka-ui}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **Редактировать**.
  1. Включите опцию **Kafka UI**.
  1. Нажмите кнопку **Сохранить**.
  1. Перейдите на страницу **Kafka UI**. 

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     yc managed-kafka cluster update --help
     ```
  1. Включите веб-интерфейс Apache Kafka® на кластере с помощью `--kafka-ui-enabled`:

     ```bash
     yc managed-kafka cluster update <имя_или_идентификатор_кластера> \
       --kafka-ui-enabled=true
      ```
  Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.
  
     Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).
  
  1. Чтобы включить веб-интерфейс Apache Kafka®, добавьте к описанию кластера блок `config.kafka_ui`. В блоке передайте параметр `enabled` со значением `true`:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя кластера>" {
          ...
          config {
            ...
            kafka_ui {
              enabled = true
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
            --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.kafkaUiConfig.enabled",
                      "configSpec": {
                        "kafkaUiConfig": {
                          "enabled": true
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую. Укажите `configSpec.kafkaUiConfig.enabled`, чтобы изменить настройку включения веб-интерфейса Kafka UI.
        * `configSpec.kafkaUiConfig.enabled` — для включения веб-интерфейса Kafka UI укажите `true`.

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
                      "config_spec.kafka_ui_config.enabled"
                    ]
                  },
                  "config_spec": {
                    "kafka_ui_config": {
                      "enabled": true
                    }
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`. Укажите `config_spec.kafka_ui_config.enabled`, чтобы изменить настройку включения веб-интерфейса Kafka UI.
        * `config_spec.kafka_ui_config.enabled` — для включения веб-интерфейса Kafka UI укажите `true`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Получить ссылку на веб-интерфейс {#get-link}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) откройте страницу кластера.
  1. Перейдите на страницу **Kafka UI**. 

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  ```
  yc managed-kafka cluster get <имя_или_идентификатор_кластера>
  ```

  Ссылку на веб-интерфейс Kafka UI можно найти в параметре `kafka_ui.url`.
  
  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:
  
     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```
  
  1. Воспользуйтесь методом [Cluster.get](../api-ref/Cluster/get.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):
  
     ```bash
     curl \
         --request GET \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>'
     ```
  
     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/get.md#yandex.cloud.mdb.kafka.v1.Cluster).

     Ссылку на веб-интерфейс Apache Kafka® можно найти в параметре `config.kafkaUiConfig.url`.

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

  1. Воспользуйтесь вызовом [ClusterService/Get](../api-ref/grpc/Cluster/get.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                  "cluster_id": "<идентификатор_кластера>"
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.kafka.v1.ClusterService.Get
      ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.kafka.v1.Cluster).

     Ссылку на веб-интерфейс Kafka UI можно найти в параметре `config.kafka_ui_config.url`.

{% endlist %}