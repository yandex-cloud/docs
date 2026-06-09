# Управление топиками Apache Kafka®

Кластер Managed Service for Apache Kafka® позволяет управлять топиками и разделами двумя способами (как отдельно, так и совместно):

* С помощью [стандартных интерфейсов Yandex Cloud](#yandex-cloud) (CLI, [API](../../glossary/rest-api.md), консоль управления). Способ подходит, если вы хотите управлять топиками, используя возможности сервиса Managed Service for Apache Kafka®.

    Вы можете выполнить следующие действия над топиками Managed Service for Apache Kafka®:

    * [cоздать топик](#create-topic);
    * [изменить настройки топика](#update-topic);
    * [получить список топиков в кластере](#list-topics);
    * [получить детальную информацию о топике](#get-topic);
    * [импортировать топик в Terraform](#import-topic);
    * [перенести информацию о созданных топиках в файл состояния Terraform](#move-info-topic);
    * [удалить топик](#delete-topic).

* С помощью [Admin API Apache Kafka®](#admin-api). Способ подходит, если вы хотите использовать уже существующее у вас решение для управления топиками и разделами.

## Управление топиками через интерфейсы Yandex Cloud {#yandex-cloud}

### Создать топик {#create-topic}

Перед созданием топика рассчитайте [минимальный размер хранилища](../concepts/storage.md#minimal-storage-size).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Топики**.
  1. Нажмите кнопку **Создать топик**.
  1. В блоке **Базовые параметры** задайте базовые параметры топика:
     * Имя топика (должно быть уникально в пределах кластера Apache Kafka®).

       {% note info %}
       
       Если нужно создать топик, начинающийся с символа `_`, используйте [Admin API Apache Kafka®](cluster-topics.md#admin-api). Создать такой топик с помощью интерфейсов Yandex Cloud нельзя.
       
       {% endnote %}

     * Количество разделов в топике.
     * Фактор репликации. Значение этого параметра не должно превышать количество брокеров в кластере. Минимальное значение: `1`. Максимальное значение: `3`. Значение по умолчанию:
       * для кластера из одного или двух брокеров: `1`;
       * для кластера с тремя и более брокерами: `3`.
  1. В блоке **Настройки топика** задайте [настройки топика](../concepts/settings-list.md#topic-settings).
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать топик:
  1. Посмотрите описание команды CLI для создания топиков:

     ```bash
     yc managed-kafka topic create --help
     ```

  1. Создайте топик:

     ```bash
     yc managed-kafka topic create <имя_топика> \
       --cluster-name <имя_кластера> \
       --partitions <количество_разделов> \
       --replication-factor <фактор_репликации>
     ```

     При необходимости здесь же задайте [настройки топика](../concepts/settings-list.md#topic-settings).

     {% note info %}
     
     Если нужно создать топик, начинающийся с символа `_`, используйте [Admin API Apache Kafka®](cluster-topics.md#admin-api). Создать такой топик с помощью интерфейсов Yandex Cloud нельзя.
     
     {% endnote %}

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).
  1. Добавьте ресурс `yandex_mdb_kafka_topic` и, при необходимости, задайте [настройки топика](../concepts/settings-list.md#topic-settings) в блоке `topic_config`:

     ```hcl
     resource "yandex_mdb_kafka_topic" "<имя_топика>" {
       cluster_id         = "<идентификатор_кластера>"
       name               = "<имя_топика>"
       partitions         = <количество_разделов>
       replication_factor = <фактор_репликации>
       topic_config {
         compression_type = "<тип_сжатия>"
         flush_messages   = <максимальное_число_сообщений_в_памяти>
         ...
       }
     }
     ```

     {% note info %}
     
     Если нужно создать топик, начинающийся с символа `_`, используйте [Admin API Apache Kafka®](cluster-topics.md#admin-api). Создать такой топик с помощью интерфейсов Yandex Cloud нельзя.
     
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

  Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_topic.md).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Topic.create](../api-ref/Topic/create.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>/topics' \
       --data '{
                 "topicSpec": {
                  "name": "<имя_топика>",
                  "partitions": "<количество_партиций>",
                  "replicationFactor": "<фактор_репликации>"
               }'
     ```

     Где:

     * `topicSpec` — настройки топика:

        * `name` — имя топика.
        
            {% note info %}
            
            Если нужно создать топик, начинающийся с символа `_`, используйте [Admin API Apache Kafka®](cluster-topics.md#admin-api). Создать такой топик с помощью интерфейсов Yandex Cloud нельзя.
            
            {% endnote %}
        
        * `partitions` – количество разделов.
        * `replicationFactor` – фактор репликации.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Topic/create.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [TopicService/Create](../api-ref/grpc/Topic/create.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/topic_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "topic_spec": {
                  "name": "<имя_топика>",
                  "partitions": {
                    "value": "<количество_партиций>"
                  },
                  "replication_factor": {
                    "value": "<фактор_репликации>"
                  }
             }
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.kafka.v1.TopicService.Create
     ```

     Где:

     * `topic_spec` — настройки топика:

        * `name` — имя топика.
        
            {% note info %}
            
            Если нужно создать топик, начинающийся с символа `_`, используйте [Admin API Apache Kafka®](cluster-topics.md#admin-api). Создать такой топик с помощью интерфейсов Yandex Cloud нельзя.
            
            {% endnote %}
        
        * `partitions` – количество разделов. Передается в виде объекта с полем `value`.
        * `replication_factor` – фактор репликации. Передается в виде объекта с полем `value`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Topic/create.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note info %}

В процессе своей работы Managed Service for Apache Kafka® может создавать [служебные топики](../concepts/topics.md#service-topics). Записывать пользовательские данные в такие топики нельзя.

{% endnote %}

### Изменить настройки топика {#update-topic}

Количество разделов в топиках Managed Service for Apache Kafka® нельзя уменьшить. Если в хранилище не хватает места, создать новые разделы нельзя.

Подробнее в разделе [Минимальный размер хранилища](../concepts/storage.md#minimal-storage-size).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Топики**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного топика и выберите пункт **Редактировать**.
  1. Измените базовые параметры топика:
     * Количество разделов в топике.
     * Фактор репликации. Значение этого параметра не должно превышать количество брокеров в кластере. Минимальное значение: `1`. Максимальное значение: `3`. Значение по умолчанию:
       * Для кластера из одного или двух брокеров: `1`.
       * Для кластера с тремя и более брокерами: `3`.
  1. Измените [дополнительные настройки топика](../concepts/settings-list.md#topic-settings).
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить настройки топика:
  1. Посмотрите описание команды CLI для изменения топиков:

     ```bash
     yc managed-kafka topic update --help
     ```

  1. Измените [настройки топика](../concepts/settings-list.md#topic-settings):

     ```bash
     yc managed-kafka topic update <имя_топика> \
       --cluster-name <имя_кластера> \
       --partitions <количество_разделов> \
       --replication-factor <фактор_репликации>
     ```

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).
  1. Измените значение параметров в описании ресурса `yandex_mdb_kafka_topic`:

     ```hcl
     resource "yandex_mdb_kafka_topic" "<имя_топика>" {
       cluster_id         = "<идентификатор_кластера>"
       name               = "<имя_топика>"
       partitions         = <количество_разделов>
       replication_factor = <фактор_репликации>
       topic_config {
         compression_type = "<тип_сжатия>"
         flush_messages   = <максимальное_число_сообщений_в_памяти>
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

  Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_topic.md).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Topic.update](../api-ref/Topic/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
     
     {% endnote %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>/topics/<имя_топика>' \
       --data '{
                 "clusterId": "<идентификатор_кластера>",
                 "updateMask": "topicSpec.partitions,topicSpec.replicationFactor,topicSpec.topicConfig_2_8.<настройка_1>,...,topicSpec.topicConfig_2_8.<настройка_N>,topicSpec.topicConfig_3.<настройка_1>,...,topicSpec.topicConfig_3.<настройка_N>",
                 "topicSpec": {
                   "partitions": "<количество_партиций>",
                   "replicationFactor": "<фактор_репликации>",
                   "topicConfig_3": {
                     "<настройка_1_топика_Apache Kafka®_версии_3.x>": "<значение_1>",
                     "<настройка_2_топика_Apache Kafka®_версии_3.x>": "<значение_2>",
                     ...
                     "<настройка_N_топика_Apache Kafka®_версии_3.x>": "<значение_N>"
                   }
                 } 
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае перечислите все изменяемые настройки топика.

     * `topicSpec` — новые настройки топика:

        * `partitions` – количество разделов.
        * `replicationFactor` – фактор репликации.
        * `topicConfig_3` — набор настроек топика, если используется Apache Kafka® версий `3.x`. Укажите каждую настройку на отдельной строке через запятую.
        
           Описание и возможные значения настроек приведены в разделе [Настройки отдельных топиков](../concepts/settings-list.md#topic-settings).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Topic/update.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [TopicService/Update](../api-ref/grpc/Topic/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/topic_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "topic_name": "<имя_топика>",
             "update_mask": {
               "paths": [
                 "topic_spec.partitions",
                 "topic_spec.replication_factor",
                 "topic_spec.topic_config_2_8.<настройка_1>",
                 ...,
                 "topic_spec.topic_config_2_8.<настройка_N>",
                 "topic_spec.topic_config_3.<настройка_1>",
                 ...,
                 "topic_spec.topic_config_3.<настройка_N>"
               ]
             },
             "topic_spec": {
                  "partitions": {
                    "value": "<количество_партиций>"
                  },
                  "replication_factor": {
                    "value": "<фактор_репликации>"
                  },
                   "topic_сonfig_3": {
                     "<настройка_1_топика_Apache Kafka®_версии_3.x>": "<значение_1>",
                     "<настройка_2_топика_Apache Kafka®_версии_3.x>": "<значение_2>",
                     ...
                     "<настройка_N_топика_Apache Kafka®_версии_3.x>": "<значение_N>"
                   }
             }
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.kafka.v1.TopicService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае перечислите все изменяемые настройки топика.

     * `topic_spec` — новые настройки топика:

        * `partitions` – количество разделов. Передается в виде объекта с полем `value`.
        * `replication_factor` – фактор репликации. Передается в виде объекта с полем `value`.
        * `topic_config_3` — набор настроек топика, если используется Apache Kafka® версий `3.x`. Укажите каждую настройку на отдельной строке через запятую.
        
           Описание и возможные значения настроек приведены в разделе [Настройки отдельных топиков](../concepts/settings-list.md#topic-settings).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Topic/update.md#yandex.cloud.operation.Operation).

{% endlist %}

### Получить список топиков в кластере {#list-topics}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Топики**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список топиков, выполните следующую команду:

  ```bash
  yc managed-kafka topic list --cluster-name <имя_кластера>
  ```

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Topic.list](../api-ref/Topic/list.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>/topics'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Topic/list.md#yandex.cloud.mdb.kafka.v1.ListTopicsResponse).

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
  1. Воспользуйтесь вызовом [TopicService/List](../api-ref/grpc/Topic/list.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/topic_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.kafka.v1.TopicService.List
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Topic/list.md#yandex.cloud.mdb.kafka.v1.ListTopicsResponse).

{% endlist %}

### Получить детальную информацию о топике {#get-topic}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Топики**.
  1. Нажмите на имя нужного топика.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить детальную информацию о топике, выполните следующую команду:

  ```bash
  yc managed-kafka topic get <имя_топика> --cluster-name <имя_кластера>
  ```

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Topic.list](../api-ref/Topic/get.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>/topics/<имя_топика>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя топика — со [списком топиков в кластере](#list-topics).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Topic/get.md#yandex.cloud.mdb.kafka.v1.Topic).

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
  1. Воспользуйтесь вызовом [TopicService/Get](../api-ref/grpc/Topic/get.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/topic_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "topic_name": "<имя_топика>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.kafka.v1.TopicService.Get
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя топика — со [списком топиков в кластере](#list-topics).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Topic/list.md#yandex.cloud.mdb.kafka.v1.Topic).

{% endlist %}

### Импортировать топик в Terraform {#import-topic}

С помощью импорта вы можете передать существующие в кластере топики под управление Terraform.

{% list tabs group=instructions %}

- Terraform {#tf}

    1. Укажите в конфигурационном файле Terraform топик, который необходимо импортировать:

        ```hcl
        resource "yandex_mdb_kafka_topic" "<имя_топика>" {}
        ```

    1. Выполните команду для импорта топика:

        ```hcl
        terraform import yandex_mdb_kafka_topic.<имя_топика> <идентификатор_кластера>:<имя_топика>
        ```

        Подробнее об импорте топиков в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_topic.md#import).

{% endlist %}

### Перенести информацию о созданных топиках в файл состояния Terraform {#move-info-topic}

При переходе на новую версию Terraform-провайдера между файлом состояния и конфигурационным файлом могут возникнуть расхождения по созданным топикам: устаревшие атрибуты `topic` и новые ресурсы `yandex_mdb_kafka_topic`. Чтобы убрать расхождения, необходимо удалить атрибуты `topic` и перенести информацию о созданных ресурсах `yandex_mdb_kafka_topic` в файл состояния `.tfstate` одним из двух способов.

#### Первый способ {#first}

{% list tabs %}

- Terraform {#tf}

  1. Удалите информацию о кластере из файла состояния `.tfstate`, используя команду:

     ```bash
     terraform state rm yandex_mdb_kafka_cluster.<имя_кластера>
     ```

  1. Отредактируйте конфигурационный файл Terraform:
     * удалите атрибуты `topic` из ресурса `yandex_mdb_kafka_cluster`;
     * [добавьте новые ресурсы](../../terraform/resources/mdb_kafka_topic.md) `yandex_mdb_kafka_topic`.

      {% cut "Пример обновленного конфигурационного файла" %}
        
      ```hcl
      resource "yandex_mdb_kafka_cluster" "this" {
        name = "terraform-test"
        environment = "PRODUCTION"
        network_id = data.yandex_vpc_network.this.id

        config {
          version = "3.4"
          brokers_count = 1
          zones = ["ru-central1-a"]
          kafka {
            resources {
              resource_preset_id = "s2.small"
              disk_size = 30
              disk_type_id = "network-ssd"
            }
            kafka_config {
              log_segment_bytes = 104857600
            }
          }
        }
      }

      resource "yandex_mdb_kafka_topic" "topic1" {
        cluster_id = yandex_mdb_kafka_cluster.this.id
        name = "topic1"
        partitions = 3
        replication_factor = 1
      }


      resource "yandex_mdb_kafka_topic" "topic2" {
        cluster_id = yandex_mdb_kafka_cluster.this.id
        name = "topic2"
        partitions = 3
        replication_factor = 1
      }
      ```
        
      {% endcut %}
        
  1. Выполните импорт кластера и топиков:

     ```bash
     terraform import yandex_mdb_kafka_cluster.<имя_кластера> <идентификатор_кластера>
     terraform import yandex_mdb_kafka_topic.<имя_топика> <идентификатор_кластера>:<имя_топика>
     terraform import yandex_mdb_kafka_topic.<имя_топика> <идентификатор_кластера>:<имя_топика>
     ```
    
  1. Проверьте результат переноса, используя команду:
     
     ```bash
     terraform plan
     ```
     
     Если файл состояния совпадает с конфигурацией, в терминале отобразится сообщение:
     
     ```bash
     No changes. Infrastructure is up-to-date.
     ```
     
     Если файл состояния и конфигурации не совпадает, Terraform об этом сообщит.

{% endlist %}

#### Второй способ {#second}

{% list tabs %}

- Terraform {#tf}

  1. Скачайте файл состояния `.tfstate`, используя команду:

     ```bash
     terraform state pull
     ```
    
  1. Откройте скачанный файл в любом текстовом редакторе и удалите атрибуты `topic` из ресурса `yandex_mdb_kafka_cluster`.
  1. Отправьте обновленный файл состояния, используя команду:

     ```bash
     terraform state push
     ```
    
  1. Отредактируйте конфигурационный файл Terraform:
     * удалите атрибуты `topic` из ресурса `yandex_mdb_kafka_cluster`;
     * [добавьте новые ресурсы](../../terraform/resources/mdb_kafka_topic.md) `yandex_mdb_kafka_topic`.

      {% cut "Пример обновленного конфигурационного файла" %}
        
      ```hcl
      resource "yandex_mdb_kafka_cluster" "this" {
        name = "terraform-test"
        environment = "PRODUCTION"
        network_id = data.yandex_vpc_network.this.id

        config {
          version = "3.4"
          brokers_count = 1
          zones = ["ru-central1-a"]
          kafka {
            resources {
              resource_preset_id = "s2.small"
              disk_size = 30
              disk_type_id = "network-ssd"
            }
            kafka_config {
              log_segment_bytes = 104857600
            }
          }
        }
      }

      resource "yandex_mdb_kafka_topic" "topic1" {
        cluster_id = yandex_mdb_kafka_cluster.this.id
        name = "topic1"
        partitions = 3
        replication_factor = 1
      }


      resource "yandex_mdb_kafka_topic" "topic2" {
        cluster_id = yandex_mdb_kafka_cluster.this.id
        name = "topic2"
        partitions = 3
        replication_factor = 1
      }
      ```
        
      {% endcut %}

  1. Выполните импорт топиков:

     ```bash
     terraform import yandex_mdb_kafka_topic.<имя_топика> <идентификатор_кластера>:<имя_топика>
     terraform import yandex_mdb_kafka_topic.<имя_топика> <идентификатор_кластера>:<имя_топика>
     ``` 
    
  1. Проверьте результат переноса, используя команду:
     
     ```bash
     terraform plan
     ```
     
     Если файл состояния совпадает с конфигурацией, в терминале отобразится сообщение:
     
     ```bash
     No changes. Infrastructure is up-to-date.
     ```
     
     Если файл состояния и конфигурации не совпадает, Terraform об этом сообщит.

{% endlist %}

### Удалить топик {#delete-topic}

{% note info %}

Выданные [пользователю](cluster-accounts.md) права на доступ к топику сохраняются после [его удаления](cluster-topics.md#delete-topic). Если после удаления вы не [отзывали права](cluster-accounts.md#revoke-permission), то при [создании топика](cluster-topics.md#create-topic) с тем же именем пользователь сможет работать с ним без переназначения прав.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Топики**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного топика и выберите пункт **Удалить топик**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить топик:
  1. Посмотрите описание команды CLI для удаления топиков:

     ```bash
     yc managed-kafka topic delete --help
     ```

  1. Удалите топик:

     ```bash
     yc managed-kafka topic delete <имя_топика> --cluster-name <имя_кластера>
     ```

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).
  1. Удалите ресурс `yandex_mdb_kafka_topic` с описанием нужного топика.
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

  Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_topic.md).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Topic.delete](../api-ref/Topic/delete.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>/topics/<имя_топика>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя топика — со [списком топиков в кластере](#list-topics).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Topic/delete.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [TopicService/Delete](../api-ref/grpc/Topic/delete.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/topic_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "topic_name": "<имя_топика>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.kafka.v1.TopicService.Delete
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя топика — со [списком топиков в кластере](#list-topics).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Topic/delete.md#yandex.cloud.operation.Operation).

{% endlist %}

## Управление топиками через Admin API Apache Kafka® {#admin-api}

Чтобы управлять топиками через Admin API Apache Kafka®:
1. [Создайте](cluster-accounts.md#create-account) в кластере пользователя-администратора с ролью `ACCESS_ROLE_ADMIN` или `ACCESS_ROLE_TOPIC_ADMIN`. [Подробнее](../concepts/account-roles.md) о правах, которые предоставляет каждая роль.
1. Управляйте топиками от имени этого пользователя с помощью запросов к Admin API Apache Kafka®. О работе с Admin API читайте в документации выбранного языка программирования.

Подробнее о работе с Admin API и о действующих ограничениях читайте в разделе [Управление топиками и разделами](../concepts/topics.md#management) и в [документации Apache Kafka®](https://kafka.apache.org/42/apis/#admin-api).