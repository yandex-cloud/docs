[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Kafka®](../index.md) > [Пошаговые инструкции](index.md) > Управление коннекторами

# Управление коннекторами

[Коннектор](../concepts/connectors.md) управляет процессом переноса топиков Apache Kafka® в другой кластер или другую систему хранения данных.

Вы можете:

* [получить список коннекторов](#list);
* [получить детальную информацию о коннекторе](#get);
* [создать коннектор](#create) нужного типа:
    * [MirrorMaker](#settings-mm2);
    * [S3 Sink](#settings-s3);
    * [Iceberg Sink](#settings-iceberg).
* [изменить коннектор](#update);
* [приостановить коннектор](#pause);
* [возобновить работу коннектора](#resume);
* [импортировать коннектор в Terraform](#import);
* [удалить коннектор](#delete).

## Получить список коннекторов {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
    1. Выберите нужный кластер и перейдите на вкладку **Коннекторы**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы запросить список коннекторов кластера, выполните команду:

    ```bash
    yc managed-kafka connector list --cluster-name=<имя_кластера>
    ```

    Результат:

    ```text
    +--------------+-----------+
    |     NAME     | TASKS MAX |
    +--------------+-----------+
    | connector559 |         1 |
    | ...          |           |
    +--------------+-----------+
    ```

    Имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Connector.list](../api-ref/Connector/list.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>/connectors'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Connector/list.md#yandex.cloud.mdb.kafka.v1.ListConnectorsResponse).

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
  1. Воспользуйтесь вызовом [ConnectorService/List](../api-ref/grpc/Connector/list.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/connector_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.kafka.v1.ConnectorService.List
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Connector/list.md#yandex.cloud.mdb.kafka.v1.ListConnectorsResponse).

{% endlist %}

## Получить детальную информацию о коннекторе {#get}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
    1. Выберите нужный кластер и перейдите на вкладку **Коннекторы**.
    1. Нажмите на имя нужного коннектора.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы получить детальную информацию о коннекторе, выполните команду:

    ```bash
    yc managed-kafka connector get <имя_коннектора>\
       --cluster-name=<имя_кластера>
    ```

    Результат:

    ```text
    name: connector785
    tasks_max: "1"
    cluster_id: c9qbkmoiimsl********
    ...
    ```

    Имя коннектора можно запросить со [списком коннекторов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Connector.get](../api-ref/Connector/get.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>/connectors/<имя_коннектора>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя коннектора — со [списком коннекторов в кластере](#list).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Connector/get.md#yandex.cloud.mdb.kafka.v1.Connector).

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
  1. Воспользуйтесь вызовом [ConnectorService/Get](../api-ref/grpc/Connector/get.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/connector_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.kafka.v1.ConnectorService.Get
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Connector/get.md#yandex.cloud.mdb.kafka.v1.Connector).

{% endlist %}

## Создать коннектор {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
    1. Выберите нужный кластер и перейдите на вкладку **Коннекторы**.
    1. Нажмите кнопку **Создать коннектор**.
    1. В блоке **Базовые параметры** укажите:

        * Имя коннектора.
        * Лимит задач — количество одновременно работающих процессов. Рекомендуется указывать не менее `2` для равномерного распределения нагрузки репликации.

    1. В блоке **Дополнительные свойства** укажите свойства коннектора в формате:

        ```text
        <ключ>:<значение>
        ```

        При этом ключ может быть как простой строкой, так и содержать префикс, указывающий на принадлежность к источнику или приемнику (псевдоним кластера в конфигурации коннектора):

        ```text
        <псевдоним_кластера>.<тело_ключа>:<значение>
        ```

    1. Выберите тип коннектора — [MirrorMaker](#settings-mm2), [S3 Sink](#settings-s3) или [Iceberg Sink](#settings-iceberg) — и задайте его конфигурацию.

        Подробнее о поддерживаемых типах коннекторов в разделе [Коннекторы](../concepts/connectors.md).

    1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать коннектор [MirrorMaker](#settings-mm2):

  1. Посмотрите описание команды CLI для создания коннектора:

      ```bash
      yc managed-kafka connector-mirrormaker create --help
      ```

  1. Создайте коннектор:

      ```bash
      yc managed-kafka connector-mirrormaker create <имя_коннектора> \
         --cluster-name=<имя_кластера> \
         --direction=<направление_коннектора> \
         --tasks-max=<лимит_задач> \
         --properties=<дополнительные_свойства> \
         --replication-factor=<фактор_репликации> \
         --topics=<шаблон_для_топиков> \
         --this-cluster-alias=<префикс_для_обозначения_этого_кластера> \
         --external-cluster alias=<префикс_для_обозначения_внешнего_кластера>,`
                           `bootstrap-servers=<список_FQDN_хостов-брокеров>,`
                           `security-protocol=<протокол_безопасности>,`
                           `sasl-mechanism=<механизм_шифрования>,`
                           `sasl-username=<имя_пользователя>,`
                           `sasl-password=<пароль_пользователя>,`
                           `ssl-truststore-certificates=<сертификаты_в_формате_PEM>
      ```

      Как получить FQDN хоста-брокера, читайте в [инструкции](connect/index.md#get-fqdn).

      Имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

      Параметр `--direction` принимает значение:

       * `egress` — если текущий кластер является кластером-источником.
       * `ingress` — если текущий кластер является кластером-приемником.

  Чтобы создать коннектор [S3 Sink](#settings-s3):

  1. Посмотрите описание команды CLI для создания коннектора:

      ```bash
      yc managed-kafka connector-s3-sink create --help
      ```

  1. Создайте коннектор:

      ```bash
      yc managed-kafka connector-s3-sink create <имя_коннектора> \
         --cluster-name=<имя_кластера> \
         --tasks-max=<лимит_задач> \
         --properties=<дополнительные_свойства> \
         --topics=<шаблон_для_топиков> \
         --file-compression-type=<кодек_сжатия> \
         --file-max-records=<максимальное_количество_сообщений_в_файле> \
         --bucket-name=<имя_бакета> \
         --access-key-id=<идентификатор_AWS-совместимого_статического_ключа> \
         --secret-access-key=<содержимое_AWS-совместимого_статического_ключа> \
         --storage-endpoint=<эндпоинт_S3-совместимого_хранилища> \
         --region=<регион_S3-совместимого_хранилища>
      ```

     Имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  Чтобы создать коннектор [Iceberg Sink](#settings-iceberg):

  1. Посмотрите описание команды CLI для создания коннектора:

      ```bash
      yc managed-kafka connector-iceberg-sink create --help
      ```

  1. Создайте коннектор:

      ```bash
      yc managed-kafka connector-iceberg-sink create <имя_коннектора> \
         --cluster-name=<имя_кластера> \
         --tasks-max=<лимит_задач> \
         --properties=<дополнительные_свойства> \
         --topics=<шаблон_для_топиков> \
         --file-compression-type=<кодек_сжатия> \
         --file-max-records=<максимальное_количество_сообщений_в_файле> \
         --bucket-name=<имя_бакета> \
         --access-key-id=<идентификатор_AWS-совместимого_статического_ключа> \
         --secret-access-key=<содержимое_AWS-совместимого_статического_ключа> \
         --storage-endpoint=<эндпоинт_S3-совместимого_хранилища> \
         --region=<регион_S3-совместимого_хранилища>
      ```

     Имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

    1. Ознакомьтесь со списком настроек коннекторов [MirrorMaker](#settings-mm2) и [S3 Sink](#settings-s3).

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).

    1. Чтобы создать коннектор MirrorMaker, добавьте ресурс `yandex_mdb_kafka_connector` с блоком настроек `connector_config_mirrormaker`:

        ```hcl
        resource "yandex_mdb_kafka_connector" "<имя_коннектора>" {
          cluster_id = "<идентификатор_кластера>"
          name       = "<имя_коннектора>"
          tasks_max  = <лимит_задач>
          properties = {
            <дополнительные_свойства>
          }
          connector_config_mirrormaker {
            topics             = "<шаблон_для_топиков>"
            replication_factor = <фактор_репликации>
            source_cluster {
              alias = "<префикс_для_обозначения_кластера>"
              external_cluster {
                bootstrap_servers           = "<список_FQDN_хостов-брокеров>"
                sasl_username               = "<имя_пользователя>"
                sasl_password               = "<пароль_пользователя>"
                sasl_mechanism              = "<механизм_шифрования>"
                security_protocol           = "<протокол_безопасности>"
                ssl-truststore-certificates = "<содержимое_PEM-сертификата>"
              }
            }
            target_cluster {
              alias = "<префикс_для_обозначения_кластера>"
              this_cluster {}
            }
          }
        }
        ```

        Как получить FQDN хоста-брокера, читайте в [инструкции](connect/index.md#get-fqdn).

    1. Чтобы создать коннектор S3 Sink, добавьте ресурс `yandex_mdb_kafka_connector` с блоком настроек `connector_config_s3_sink`:

        ```hcl
        resource "yandex_mdb_kafka_connector" "<имя_коннектора>" {
          cluster_id = "<идентификатор_кластера>"
          name       = "<имя_коннектора>"
          tasks_max  = <лимит_задач>
          properties = {
            <дополнительные_свойства>
          }
          connector_config_s3_sink {
            topics                = "<шаблон_для_топиков>"
            file_compression_type = "<кодек_сжатия>"
            file_max_records      = <максимальное_количество_сообщений_в_файле>
            s3_connection {
              bucket_name = "<имя_бакета>"
              external_s3 {
                endpoint          = "<эндпоинт_S3-совместимого_хранилища>"
                access_key_id     = "<идентификатор_AWS-совместимого_статического_ключа>"
                secret_access_key = "<содержимое_AWS-совместимого_статического_ключа>"
              }
            }
          }
        }
        ```
    
    1. Чтобы создать коннектор Iceberg Sink, добавьте ресурс `yandex_mdb_kafka_connector` с блоком настроек `connector_config_iceberg_sink`:
       
       ```hcl
       resource "yandex_mdb_kafka_connector" "<имя_коннектора>" {
          cluster_id = "<идентификатор_кластера>"
          name       = "<имя_коннектора>"
          tasks_max  = <лимит_задач>
          properties = {
            <дополнительные_свойства>
          }
          connector_config_iceberg_sink {
            topics        = "<список_топиков_через_запятую>"
            control_topic = "<имя_топика_управления>"

            metastore_connection {
              catalog_uri = "<URI_для_подключения_к_кластеру_Metastore>"
              warehouse   = "<корневая_директория_для_хранения_данных_управляемых_таблиц_в_S3>"
            }

            s3_connection {
              external_s3 {
                endpoint          = "<эндпоинт_S3-совместимого_хранилища>"
                access_key_id     = "<идентификатор_AWS-совместимого_статического_ключа>"
                secret_access_key = "<содержимое_AWS-совместимого_статического_ключа>"
                region            = "<название_региона>"
             }
            }

            static_tables {
              tables = "имена_таблиц_через_запятую"
            }

            tables_config {
              default_commit_branch    = "<имя_ветки_по_умолчанию>"
              default_id_columns       = "<список_столбцов_по_умолчанию_через_запятую>"
              default_partition_by     = "<список_стобцов_или выражений_трансформации>"
              evolve_schema_enabled    = <автоматически_изменять_схему_Iceberg-таблицы>
              schema_force_optional    = <сделать_поля_схемы_Iceberg-таблицы_необязательными>
              schema_case_insensitive  = <игнорировать_регистр_при_сопоставлении_полей>
            }

            control_config {
              group_id_prefix      = "<префикс_для_Consumer_Group_ID>"
              commit_interval_ms   = <интервал_коммита_данных_в_Iceberg-таблицу>
              commit_timeout_ms    = <сколько_времени_координатор_ждет_подтверждения>
              commit_threads       = <количество_потоков_для_коммита_данных_в_Iceberg-таблицу>
              transactional_prefix = "<префикс_для_Transactional_ID>"
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

    Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_connector.md).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

       ```bash
       export IAM_TOKEN="<IAM-токен>"
       ```

    1. Чтобы создать коннектор [MirrorMaker](#settings-mm2), воспользуйтесь методом [Connector.create](../api-ref/Connector/create.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

       ```bash
       curl \
         --request POST \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>/connectors' \
         --data '{
                   "connectorSpec": {
                     "name": "<имя_коннектора>",
                     "tasksMax": "<лимит_задач>"
                     "properties": "<дополнительные_свойства_коннектора>"
                     "connectorConfigMirrormaker": {
                       <настройки_коннектора_Mirrormaker>
                     }
                   }
                 }'
       ```

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Чтобы создать коннектор [S3 Sink](#settings-s3), воспользуйтесь методом [Connector.create](../api-ref/Connector/create.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

       ```bash
       curl \
         --request POST \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>/connectors' \
         --data '{
                   "connectorSpec": {
                     "name": "<имя_коннектора>",
                     "tasksMax": "<лимит_задач>"
                     "properties": "<дополнительные_свойства_коннектора>"
                     "connectorConfigS3Sink": {
                       <настройки_коннектора_S3-Sink>
                     }
                   }
                 }'
       ```

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Connector/list.md#yandex.cloud.operation.Operation).

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

    1. Чтобы создать коннектор [MirrorMaker](#settings-mm2), воспользуйтесь вызовом [ConnectorService/Create](../api-ref/grpc/Connector/create.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/connector_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "connector_spec": {
                  "name": "<имя_коннектора>",
                  "tasks_max": {
                    "value": "<лимит_задач>"
                  },
                  "properties": "<дополнительные_свойства_коннектора>"
                  "connector_config_mirrormaker": {
                    <настройки_коннектора_Mirrormaker>
                  }
                }
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.kafka.v1.ConnectorService.Create
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Чтобы создать коннектор [S3 Sink](#settings-s3), воспользуйтесь вызовом [ConnectorService/Create](../api-ref/grpc/Connector/create.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/connector_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "connector_spec": {
                  "name": "<имя_коннектора>",
                  "tasks_max": {
                    "value": "<лимит_задач>"
                  },
                  "properties": "<дополнительные_свойства_коннектора>"
                  "connector_config_s3_sink": {
                    <настройки_коннектора_S3-Sink>
                  }
                }
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.kafka.v1.ConnectorService.Create
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Connector/create.md#yandex.cloud.operation.Operation).

{% endlist %}

### MirrorMaker {#settings-mm2}

Укажите параметры коннектора MirrorMaker:

{% list tabs group=instructions %}

- Консоль управления {#console}

  * **Топики** — шаблон для отбора реплицируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
  * **Фактор репликации** — количество копий топика, хранящихся в кластере.
  * В блоке **Кластер-источник** укажите параметры для подключения к кластеру-источнику:
    * **Псевдоним** — префикс для обозначения кластера-источника в настройках коннектора.

      {% note info %}

      Топики в кластере-приемнике будут созданы с указанным префиксом.

      {% endnote %}

    * **Использовать этот кластер** — выберите опцию для использования текущего кластера в качестве источника.
    * **Бутстрап-серверы** — список FQDN хостов-брокеров кластера-источника с номерами портов для подключения, разделенный запятыми. Например: `broker1.example.com:9091,broker2.example.com`.

       Как получить FQDN хоста-брокера, читайте в [инструкции](connect/index.md#get-fqdn).

    * **SASL имя пользователя** — имя пользователя для подключения коннектора к кластеру-источнику.
    * **SASL пароль** — пароль пользователя для подключения коннектора к кластеру-источнику.
    * **SASL механизм** — выберите механизм шифрования имени и пароля.
    * **Протокол безопасности** — выберите протокол подключения коннектора:
      * `PLAINTEXT`, `SASL_PLAINTEXT` – для подключений без SSL;
      * `SSL`, `SASL_SSL` – для подключений с SSL.
    * **Сертификат в формате PEM** — загрузите PEM-сертификат для доступа к внешнему кластеру.

  * В блоке **Кластер-приёмник** укажите параметры для подключения к кластеру-приемнику:
    * **Псевдоним** — префикс для обозначения кластера-приемника в настройках коннектора.
    * **Использовать этот кластер** — выберите опцию для использования текущего кластера в качестве приемника.
    * **Бутстрап-серверы** — список FQDN хостов-брокеров кластера-приемника с номерами портов для подключения, разделенный запятыми.

       Как получить FQDN хоста-брокера, читайте в [инструкции](connect/index.md#get-fqdn).

    * **SASL имя пользователя** — имя пользователя для подключения коннектора к кластеру-приемнику.
    * **SASL пароль** — пароль пользователя для подключения коннектора к кластеру-приемнику.
    * **SASL механизм** — выберите механизм шифрования имени и пароля.
    * **Протокол безопасности** — выберите протокол подключения коннектора:
      * `PLAINTEXT`, `SASL_PLAINTEXT` – для подключений без SSL;
      * `SSL`, `SASL_SSL` – для подключений с SSL.
    * **Сертификат в формате PEM** — загрузите PEM-сертификат для доступа к внешнему кластеру.

  * Чтобы задать значения дополнительных настроек, не указанных в этом списке, создайте необходимые ключи и задайте их значения в блоке **Дополнительные свойства** при [создании](#create) или [изменении](#update) коннектора. Примеры ключей:

    * `key.converter`
    * `value.converter`

    Список общих настроек коннекторов в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/kafka-connect-configs/).

- CLI {#cli}

    * `--cluster-name` — имя кластера.
    * `--direction` — направление коннектора:

        * `ingress` — если кластер является приемником.
        * `egress` — если кластер является источником.

    * `--tasks-max` — максимальное количество одновременно запущенных задач коннектора.
    * `--properties` — список дополнительных настроек коннектора в формате `<ключ>:<значение>`, разделенный запятыми. Примеры ключей:

        * `key.converter`
        * `value.converter`

        Список общих настроек коннекторов в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/kafka-connect-configs/).

    * `--replication-factor` — количество копий топика, хранящихся в кластере.
    * `--topics` — шаблон для отбора реплицируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
    * `--this-cluster-alias` — префикс для обозначения этого кластера в настройках коннектора.
    * `--external-cluster` — параметры внешнего кластера:

        * `alias` — префикс для обозначения внешнего кластера в настройках коннектора.
        * `bootstrap-servers` — список FQDN хостов-брокеров внешнего кластера с номерами портов для подключения, разделенный запятыми.

           Как получить FQDN хоста-брокера, читайте в [инструкции](connect/index.md#get-fqdn).

        * `security-protocol` — протокол подключения коннектора:

            * `plaintext`, `sasl_plaintext` – для подключений без SSL;
            * `ssl`, `sasl_ssl` – для подключений с SSL.

        * `sasl-mechanism` — механизм шифрования имени и пароля.
        * `sasl-username` — имя пользователя для подключения коннектора к внешнему кластеру.
        * `sasl-password` — пароль пользователя для подключения коннектора к внешнему кластеру.
        * `ssl-truststore-certificates` — список сертификатов в формате PEM.

- Terraform {#tf}

  * **properties** — список дополнительных настроек коннектора в формате `<ключ>:<значение>`, разделенный запятыми. Примеры ключей:

     * `key.converter`
     * `value.converter`

     Список общих настроек коннекторов в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/kafka-connect-configs/).
  
   * **connector_config_mirrormaker** — настройки коннектора MirrorMaker:
      
      * **replication_factor** — количество копий топика, хранящихся в кластере.
      * **topics** — шаблон для отбора реплицируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
      * **source_cluster** и **target_cluster** — параметры для подключения к кластеру-источнику и кластеру-приемнику:
         * **alias** — префикс для обозначения кластера в настройках коннектора.

            {% note info %}

            Топики в кластере-приемнике будут созданы с указанным префиксом.

            {% endnote %}

         * **external_cluster** — параметры для подключения к внешнему кластеру:
            * **bootstrap_servers** — список FQDN хостов-брокеров кластера с номерами портов для подключения, разделенный запятыми.

               Как получить FQDN хоста-брокера, читайте в [инструкции](connect/index.md#get-fqdn).

            * **sasl_username** — имя пользователя для подключения коннектора к кластеру.
            * **sasl_password** — пароль пользователя для подключения коннектора к кластеру.
            * **sasl_mechanism** — механизм шифрования имени и пароля.
            * **security_protocol** — протокол подключения коннектора:
               * `PLAINTEXT`, `SASL_PLAINTEXT` — для подключений без SSL;
               * `SSL`, `SASL_SSL` — для подключений с SSL.
            * **ssl_truststore_certificates** — содержимое PEM-сертификата.
         * **this_cluster** — опция для использования текущего кластера в качестве источника или приемника.

- REST API {#api}

    Настройки коннектора MirrorMaker задаются в параметре `connectorSpec.connectorConfigMirrormaker`:

    * `sourceCluster` и `targetCluster` — параметры для подключения к кластеру-источнику и кластеру-приемнику:

        * `alias` — префикс для обозначения кластера в настройках коннектора.

            {% note info %}

            Топики в кластере-приемнике будут созданы с указанным префиксом.

            {% endnote %}

        * `thisCluster` — опция для использования текущего кластера в качестве источника или приемника.

        * `externalCluster` — параметры для подключения к внешнему кластеру:

            * `bootstrapServers` — список FQDN хостов-брокеров кластера с номерами портов для подключения, разделенный запятыми.

                Как получить FQDN хоста-брокера, читайте в [инструкции](connect/index.md#get-fqdn).

            * `saslUsername` — имя пользователя для подключения коннектора к кластеру.
            * `saslPassword` — пароль пользователя для подключения коннектора к кластеру.
            * `saslMechanism` — механизм шифрования имени и пароля.
            * `securityProtocol` — протокол подключения коннектора:
                * `PLAINTEXT`, `SASL_PLAINTEXT` – для подключений без SSL;
                * `SSL`, `SASL_SSL` – для подключений с SSL.
            * `sslTruststoreCertificates` — содержимое PEM-сертификата.

    * `topics` — шаблон для отбора реплицируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
    * `replicationFactor` — количество копий топика, хранящихся в кластере.

- gRPC API {#grpc-api}

    Настройки коннектора MirrorMaker задаются в параметре `connector_spec.connector_config_mirrormaker`:

    * `source_cluster` и `target_cluster` — параметры для подключения к кластеру-источнику и кластеру-приемнику:

        * `alias` — префикс для обозначения кластера в настройках коннектора.

            {% note info %}

            Топики в кластере-приемнике будут созданы с указанным префиксом.

            {% endnote %}

        * `this_cluster` — опция для использования текущего кластера в качестве источника или приемника.

        * `external_cluster` — параметры для подключения к внешнему кластеру:

            * `bootstrap_servers` — список FQDN хостов-брокеров кластера с номерами портов для подключения, разделенный запятыми.

                Как получить FQDN хоста-брокера, читайте в [инструкции](connect/index.md#get-fqdn).

            * `sasl_username` — имя пользователя для подключения коннектора к кластеру.
            * `sasl_password` — пароль пользователя для подключения коннектора к кластеру.
            * `sasl_mechanism` — механизм шифрования имени и пароля.
            * `security_protocol` — протокол подключения коннектора:
                * `PLAINTEXT`, `SASL_PLAINTEXT` – для подключений без SSL;
                * `SSL`, `SASL_SSL` – для подключений с SSL.
            * `ssl_truststore_certificates` — содержимое PEM-сертификата.

    * `topics` — шаблон для отбора реплицируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
    * `replication_factor` — количество копий топика, хранящихся в кластере. Передается в виде объекта с полем `value`.

{% endlist %}

### S3 Sink {#settings-s3}

Укажите параметры коннектора S3 Sink:

{% list tabs group=instructions %}

- Консоль управления {#console}

  * **Топики** — шаблон для отбора экспортируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
  * **Механизм сжатия** — выберите кодек для сжатия сообщений:

      * `none` (по умолчанию) — сжатие отсутствует;
      * `gzip` — кодек [gzip](https://www.gzip.org/);
      * `snappy` — кодек [snappy](https://github.com/google/snappy);
      * `zstd` — кодек [zstd](https://facebook.github.io/zstd/).

      После создания кластера данный параметр нельзя изменить.

  * (Опционально) **Максимальное количество записей на файл** — максимальное количество записей, которое может быть записано в один файл, размещенный в [S3-совместимом хранилище](../../glossary/s3.md).
  * В блоке **Подключение к S3** укажите параметры подключения к хранилищу:
      * **Имя бакета** — имя бакета хранилища.
      * **Эндпоинт** — эндпоинт для доступа к хранилищу (его необходимо узнать у провайдера хранилища).
      * (Опционально) **Регион** — название региона. Значение по умолчанию — `ru-central1`. [Список доступных регионов](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

          {% note info %}
          
          Некоторые приложения, предназначенные для работы с Amazon S3, не позволяют указывать регион, поэтому [Yandex Object Storage](../../storage/index.md) принимает также значение основного региона AWS — [первая строка в таблице регионов](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html#available-regions).
          
          {% endnote %}

      
      * (Опционально) **Идентификатор ключа доступа**, **Секретный ключ** — [идентификатор и содержимое AWS-совместимого ключа](../../iam/concepts/authorization/access-key.md).


  * Чтобы задать значения дополнительных настроек, не указанных в этом списке, создайте необходимые ключи и задайте их значения в блоке **Дополнительные свойства** при [создании](#create) или [изменении](#update) коннектора. Примеры ключей:

      * `key.converter`
      * `value.converter`
      * `value.converter.schemas.enable`
      * `format.output.type`

      Список всех настроек коннектора в [документации коннектора](https://github.com/aiven/s3-connector-for-apache-kafka). Список общих настроек коннекторов в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/kafka-connect-configs/).

- CLI {#cli}

    * `--cluster-name` — имя кластера.
    * `--tasks-max` — максимальное количество одновременно запущенных задач коннектора.
    * `--properties` — список дополнительных настроек коннектора в формате `<ключ>:<значение>`, разделенный запятыми. Примеры ключей:

      * `key.converter`
      * `value.converter`
      * `value.converter.schemas.enable`
      * `format.output.type`

      Список всех настроек коннектора в [документации коннектора](https://github.com/aiven/s3-connector-for-apache-kafka). Список общих настроек коннекторов в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/kafka-connect-configs/).

    * `--topics` — шаблон для отбора реплицируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
    * `--file-compression-type` — кодек для сжатия сообщений. После создания кластера данный параметр нельзя изменить. Допустимые значения:

        * `none` (по умолчанию) — сжатие отсутствует;
        * `gzip` — кодек [gzip](https://www.gzip.org/);
        * `snappy` — кодек [snappy](https://github.com/google/snappy);
        * `zstd` — кодек [zstd](https://facebook.github.io/zstd/).

    * `--file-max-records` — максимальное количество записей, которое может быть записано в один файл, размещенный в S3-совместимом хранилище.
    * `--bucket-name` — имя бакета в S3-совместимом хранилище, в который будет производиться запись.
    * `--storage-endpoint` — эндпоинт для доступа к хранилищу (его необходимо узнать у провайдера хранилища). Пример: `storage.yandexcloud.net`.
    * `--region` — регион, в котором находится бакет S3-совместимого хранилища. Значение по умолчанию — `ru-central1`. [Список доступных регионов](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

        {% note info %}
        
        Некоторые приложения, предназначенные для работы с Amazon S3, не позволяют указывать регион, поэтому [Yandex Object Storage](../../storage/index.md) принимает также значение основного региона AWS — [первая строка в таблице регионов](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html#available-regions).
        
        {% endnote %}

    
    * `--access-key-id`, `--secret-access-key` — [идентификатор и содержимое AWS-совместимого ключа](../../iam/concepts/authorization/access-key.md).


- Terraform {#tf}

  * **properties** — список дополнительных настроек коннектора в формате `<ключ>:<значение>`, разделенный запятыми. Примеры ключей:

     * `key.converter`
     * `value.converter`
     * `value.converter.schemas.enable`
     * `format.output.type`

   Список всех настроек коннектора в [документации коннектора](https://github.com/aiven/s3-connector-for-apache-kafka). Список общих настроек коннекторов в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/kafka-connect-configs/).

  * **connector_config_s3_sink** — настройки коннектора S3 Sink:
     * **file_compression_type** — кодек для сжатия сообщений. После создания кластера данный параметр нельзя изменить. Допустимые значения:

        * `none` (по умолчанию) — сжатие отсутствует;
        * `gzip` — кодек [gzip](https://www.gzip.org/);
        * `snappy` — кодек [snappy](https://github.com/google/snappy);
        * `zstd` — кодек [zstd](https://facebook.github.io/zstd/).

     * **topics** — шаблон для отбора реплицируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
     * **file_max_records** — максимальное количество записей, которое может быть записано в один файл, размещенный в S3-совместимом хранилище.

     * **s3_connection** — параметры для подключения к S3-совместимому хранилищу:

        * **bucket_name** — имя бакета, в который будет производиться запись.
        * **external_s3** — параметры для подключения к внешнему S3-совместимому хранилищу:

           * **endpoint** — эндпоинт для доступа к хранилищу (его необходимо узнать у провайдера хранилища). Пример: `storage.yandexcloud.net`.
            * **region** — регион, в котором находится бакет S3-совместимого хранилища. Значение по умолчанию — `ru-central1`. [Список доступных регионов](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

                {% note info %}
                
                Некоторые приложения, предназначенные для работы с Amazon S3, не позволяют указывать регион, поэтому [Yandex Object Storage](../../storage/index.md) принимает также значение основного региона AWS — [первая строка в таблице регионов](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html#available-regions).
                
                {% endnote %}

            
            * **access_key_id**, **secret_access_key** — [идентификатор и содержимое AWS-совместимого ключа](../../iam/concepts/authorization/access-key.md).


- REST API {#api}

    Настройки коннектора S3 Sink задаются в параметре `connectorSpec.connectorConfigS3Sink`:

    * `topics` — шаблон для отбора реплицируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
    * `fileCompressionType` — кодек для сжатия сообщений. После создания кластера данный параметр нельзя изменить. Допустимые значения:

        * `none` (по умолчанию) — сжатие отсутствует;
        * `gzip` — кодек [gzip](https://www.gzip.org/);
        * `snappy` — кодек [snappy](https://github.com/google/snappy);
        * `zstd` — кодек [zstd](https://facebook.github.io/zstd/).

    * `fileMaxRecords` — максимальное количество записей, которое может быть записано в один файл, размещенный в S3-совместимом хранилище.
    * `s3Connection` — параметры для подключения к S3-совместимому хранилищу:
        * `bucketName` — имя бакета, в который будет производиться запись.
        * `externalS3` — параметры внешнего хранилища:
            * `endpoint` — эндпоинт для доступа к хранилищу (его необходимо узнать у провайдера хранилища). Пример: `storage.yandexcloud.net`.
            * `region` — регион, в котором находится бакет S3-совместимого хранилища. Значение по умолчанию — `ru-central1`. [Список доступных регионов](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

                {% note info %}
                
                Некоторые приложения, предназначенные для работы с Amazon S3, не позволяют указывать регион, поэтому [Yandex Object Storage](../../storage/index.md) принимает также значение основного региона AWS — [первая строка в таблице регионов](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html#available-regions).
                
                {% endnote %}

            
            * `accessKeyId`, `secretAccessKey` — [идентификатор и содержимое AWS-совместимого ключа](../../iam/concepts/authorization/access-key.md).


- gRPC API {#grpc-api}

    Настройки коннектора S3 Sink задаются в параметре `connector_spec.connector_config_s3_sink`:

    * `topics` — шаблон для отбора реплицируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
    * `file_compression_type` — кодек для сжатия сообщений. После создания кластера данный параметр нельзя изменить. Допустимые значения:

        * `none` (по умолчанию) — сжатие отсутствует;
        * `gzip` — кодек [gzip](https://www.gzip.org/);
        * `snappy` — кодек [snappy](https://github.com/google/snappy);
        * `zstd` — кодек [zstd](https://facebook.github.io/zstd/).

    * `file_max_records` — максимальное количество записей, которое может быть записано в один файл, размещенный в S3-совместимом хранилище. Передается в виде объекта с полем `value`.
    * `s3_connection` — параметры для подключения к S3-совместимому хранилищу:
        * `bucket_name` — имя бакета, в который будет производиться запись.
        * `external_s3` — параметры внешнего хранилища:
            * `endpoint` — эндпоинт для доступа к хранилищу (его необходимо узнать у провайдера хранилища). Пример: `storage.yandexcloud.net`.
            * `region` — регион, в котором находится бакет S3-совместимого хранилища. Значение по умолчанию — `ru-central1`. [Список доступных регионов](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

                {% note info %}
                
                Некоторые приложения, предназначенные для работы с Amazon S3, не позволяют указывать регион, поэтому [Yandex Object Storage](../../storage/index.md) принимает также значение основного региона AWS — [первая строка в таблице регионов](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html#available-regions).
                
                {% endnote %}

            
            * `access_key_id`, `secret_access_key` — [идентификатор и содержимое AWS-совместимого ключа](../../iam/concepts/authorization/access-key.md).


{% endlist %}

### Iceberg Sink {#settings-iceberg}

Укажите параметры коннектора Iceberg Sink:

{% list tabs group=instructions %}

- Консоль управления {#console}

  * **Топик управления** — выберите или создайте топик управления. Топик будет использоваться для координации и управления процессом записи данных в Iceberg-таблицы.
  * **Источник топиков** — выберите источник топиков, данные из которого будут перенесены в Iceberg-таблицы:
     * **Список топиков** — имена топиков через запятую.
     * **Regex топиков** — регулярное выражение для выбора топиков. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
  * **Маршрутизация таблиц** — выберите правило, по которому каждое сообщение из топика Apache Kafka® будет попадать в Iceberg-таблицы:
     * **Статическая** — таблицы назначения определяются заранее. Каждый топик со всеми сообщениями будет попадать в отдельную Iceberg-таблицу. 
        
        В поле **Таблицы** перечислите имена Iceberg-таблиц через запятую.
    
     * **Динамическая** — таблица назначения определяется по содержимому самого сообщения.
       
       В поле **Поле маршрутизации** укажите поле в сообщении, по значению которого определяется целевая таблица.
  * В блоке **Подключение к Metastore** укажите параметры подключения к Apache Hive™ Metastore:
     * **URI каталога** — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<хост>:<порт>`.
     * **Warehouse** — корневая директория для хранения данных управляемых таблиц в S3 в формате `s3a://bucket-name/path/to/warehouse`.
  * В блоке **Подключение к S3** укажите параметры подключения к хранилищу:
     * **Эндпоинт** — эндпоинт для доступа к хранилищу (его необходимо узнать у провайдера хранилища).
     * (Опционально) **Регион** — название региона. Значение по умолчанию — `ru-central1`. [Список доступных регионов](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

        {% note info %}
        
        Некоторые приложения, предназначенные для работы с Amazon S3, не позволяют указывать регион, поэтому [Yandex Object Storage](../../storage/index.md) принимает также значение основного региона AWS — [первая строка в таблице регионов](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html#available-regions).
        
        {% endnote %}

     * **Идентификатор ключа доступа**, **Секретный ключ** — [идентификатор и содержимое AWS-совместимого ключа](../../iam/concepts/authorization/access-key.md). 

  * (Опционально) В блоке **Дополнительные настройки**:
     * Секция **Настройки таблиц**:
        * **Ветка коммитов по умолчанию** — имя ветки по умолчанию. В эту ветку Iceberg-таблицы коннектор будет коммитить данные. Значение по умолчанию — `main`.
        * **Список столбцов по умолчанию** — список столбцов по умолчанию, разделенных запятыми, которые определяют строку идентификатора в Iceberg-таблицах (primary key). Является обязательным параметром при включенном UPSERT-режиме.
        * **Партиционирование по умолчанию** — список столбцов или выражений трансформации для партиционирования данных Iceberg-таблицы через запятую. Определяет физическое размещение данных для оптимизации запросов. Примеры: `date`, `year`, `month`, `year (timestamp)`, `month (timestamp)`, `days (timestamp)`, `bucket (16, user_id)`.
        * **Включить автоматическую эволюцию схемы** — настройка, которая указывает, должен ли коннектор автоматически изменять схему Iceberg-таблицы, если схема входящих сообщений из Apache Kafka® изменилась.
        * **Сделать все колонки nullable** — настройка, указывающая, делать ли все поля схемы Iceberg-таблицы необязательными (`nullable`), независимо от того, как они определены в схеме входящего сообщения.
        * **Регистронезависимое сопоставление имён полей** — настройка, которая указывает, должен ли коннектор игнорировать регистр при сопоставлении полей входящего сообщения с колонками Iceberg-таблицы.

     * Секция **Настройки управления**:
        * **Префикс consumer group** — префикс для `Consumer Group ID`, который коннектор использует при чтении из топиков Apache Kafka®. Значение по умолчанию — `cg-control`.
        * **Интервал коммита, мс** — указывает, как часто коннектор делает коммит данных в Iceberg-таблицу. Задается в миллисекундах. Значение по умолчанию — `300000`.
        * **Таймаут коммита, мс** — указывает, сколько времени координатор ждет подтверждения от всех воркеров перед тем, как признать коммит неудачным. Задается в миллисекундах. Значение по умолчанию — `30000`.
        * **Потоки коммита** — количество потоков, которые используются для коммита данных в Iceberg-таблицу.
        * **Транзакционный префикс** — префикс для `Transactional ID`, который коннектор использует при записи в Apache Kafka® в рамках транзакций.

- CLI {#cli}

  * `--cluster-id` — идентификатор кластера.
  * `--cluster-name` — имя кластера.
  * `--tasks-max` — максимальное количество одновременно запущенных задач коннектора.
   * `--properties` — список дополнительных настроек коннектора в формате `<ключ>:<значение>`, разделенный запятыми. Примеры ключей:

     * `key.converter`
     * `value.converter`
     * `value.converter.schemas.enable`

     Список общих настроек коннекторов в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/kafka-connect-configs/).

  * `--topics` — список топиков, разделенных запятыми, данные из которых будут перенесены в Iceberg-таблицы.
  * `--topics-regex` — регулярное выражение для выбора топиков, данные из которых будут перенесены в Iceberg-таблицы. Можно использовать выражение `.*`, например, `analysis.*`. Для переноса всех топиков укажите `.*`.
  * `--control-topic` — имя топика управления, используется для координации и управления процессом записи данных в Iceberg-таблицы.
  * `--catalog-uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<хост>:<порт>`.
  * `--warehouse` — корневая директория для хранения данных управляемых таблиц в S3 в формате `s3a://bucket-name/path/to/warehouse`.
  * `--access-key-id`, `--secret-access-key` — [идентификатор и содержимое AWS-совместимого ключа](../../iam/concepts/authorization/access-key.md).
  * `--storage-endpoint` — эндпоинт для доступа к хранилищу (его необходимо узнать у провайдера хранилища). Пример: `storage.yandexcloud.net`.
  * `--region` — регион, в котором находится бакет S3-совместимого хранилища. Значение по умолчанию — `ru-central1`. [Список доступных регионов](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

     {% note info %}
     
     Некоторые приложения, предназначенные для работы с Amazon S3, не позволяют указывать регион, поэтому [Yandex Object Storage](../../storage/index.md) принимает также значение основного региона AWS — [первая строка в таблице регионов](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html#available-regions).
     
     {% endnote %}
  
  * `--tables` — имена Iceberg-таблиц, разделенные запятыми, для статической маршрутизации таблиц.
  * `--route-field` — поле в сообщении для определения целевой таблицы при динамической маршрутизации.
  * `--default-commit-branch` — имя ветки по умолчанию. В эту ветку Iceberg-таблицы коннектор будет коммитить данные. Значение по умолчанию — `main`.
  * `--default-id-columns` — список столбцов по умолчанию, разделенных запятыми, которые определяют строку идентификатора в Iceberg-таблицах (primary key). Является обязательным параметром при включенном UPSERT-режиме.
  * `--default-partition-by` — список столбцов или выражений трансформации для партиционирования данных Iceberg-таблицы через запятую. Определяет физическое размещение данных для оптимизации запросов. Примеры: `date`, `year`, `month`, `year (timestamp)`, `month (timestamp)`, `days (timestamp)`, `bucket (16, user_id)`.
  * `--evolve-schema-enabled` — настройка, которая указывает, должен ли коннектор автоматически изменять схему Iceberg-таблицы, если схема входящих сообщений из Apache Kafka® изменилась. Значение по умолчанию — `false`.
  * `--schema-force-optional` — настройка, которая указывает, делать ли все поля схемы Iceberg-таблицы необязательными (`nullable`), независимо от того, как они определены в схеме входящего сообщения. Значение по умолчанию — `false`.
  * `--schema-case-insensitive` — настройка, которая указывает, должен ли коннектор игнорировать регистр при сопоставлении полей входящего сообщения с колонками Iceberg-таблицы. Значение по умолчанию — `false`.
  * `--group-id-prefix` — префикс для `Consumer Group ID`, который коннектор использует при чтении из топиков Apache Kafka®. Значение по умолчанию — `cg-control`.
  * `--commit-interval-ms` — указывает, как часто коннектор делает коммит данных в Iceberg-таблицу. Задается в миллисекундах. Значение по умолчанию — `300000`.
  * `--commit-timeout-ms` — указывает, сколько времени координатор ждет подтверждения от всех воркеров перед тем, как признать коммит неудачным. Задается в миллисекундах. Значение по умолчанию — `30000`.
  * `--commit-threads` — количество потоков, которые используются для коммита данных в Iceberg-таблицу. Значение по умолчанию — `vCPU × 2`.
  * `--transactional-prefix` — префикс для `Transactional ID`, который коннектор использует при записи в Apache Kafka® в рамках транзакций.

- Terraform {#tf}

  * **properties** — список дополнительных настроек коннектора в формате `<ключ>:<значение>`, разделенный запятыми. Примеры ключей:

     * `key.converter`
     * `value.converter`
     * `value.converter.schemas.enable`

     Список общих настроек коннекторов в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/kafka-connect-configs/).

  * **tasks_max** — максимальное количество одновременно запущенных задач коннектора.
  * **connector_config_iceberg_sink** — блок с настройками коннектора Iceberg Sink:
     * **control_topic** — имя топика управления, используется для координации и управления процессом записи данных в Iceberg-таблицы.
     * **topics** — список топиков, разделенных запятыми, данные из которых будут перенесены в Iceberg-таблицы.
     * **topics_regex** — регулярное выражение для выбора топиков, данные из которых будут перенесены в Iceberg-таблицы. Можно использовать выражение `.*`, например, `analysis.*`. Для переноса всех топиков укажите `.*`.
     * **control_config** — блок с дополнительными настройками:
        * **commit_interval_ms** — указывает, как часто коннектор делает коммит данных в Iceberg-таблицу. Задается в миллисекундах. Значение по умолчанию — `300000`.
        * **commit_threads** — количество потоков, которые используются для коммита данных в Iceberg-таблицу. Значение по умолчанию — `vCPU × 2`.
        * **commit_timeout_ms** — указывает, сколько времени координатор ждет подтверждения от всех воркеров перед тем, как признать коммит неудачным. Задается в миллисекундах. Значение по умолчанию — `30000`.
        * **group_id_prefix** — префикс для `Consumer Group ID`, который коннектор использует при чтении из топиков Apache Kafka®. Значение по умолчанию — `cg-control`.
        * **transactional_prefix** — префикс для `Transactional ID`, который коннектор использует при записи в Apache Kafka® в рамках транзакций.
     * **dynamic_tables** — блок с настройками динамической маршрутизации таблиц:
        * **route_field** — поле в сообщении для определения целевой таблицы при динамической маршрутизации.
     * **metastore_connection** — блок с настройками подключения к Apache Hive™ Metastore:
        * **catalog_uri** — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<хост>:<порт>`.
        * **warehouse** — корневая директория для хранения данных управляемых таблиц в S3 в формате `s3a://bucket-name/path/to/warehouse`.
     * **s3_connection** — блок с настройками для подключения к S3-совместимому хранилищу:
        * **external_s3** — блок с параметрами для подключения к S3-совместимому хранилищу:
           * **endpoint** — эндпоинт для доступа к хранилищу (его необходимо узнать у провайдера хранилища). Пример: `storage.yandexcloud.net`.
           * **region** — регион, в котором находится бакет S3-совместимого хранилища. Значение по умолчанию — `ru-central1`. [Список доступных регионов](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

              {% note info %}
              
              Некоторые приложения, предназначенные для работы с Amazon S3, не позволяют указывать регион, поэтому [Yandex Object Storage](../../storage/index.md) принимает также значение основного региона AWS — [первая строка в таблице регионов](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html#available-regions).
              
              {% endnote %}

           * **access_key_id**, **secret_access_key** — [идентификатор и содержимое AWS-совместимого ключа](../../iam/concepts/authorization/access-key.md).

     * **static_tables** — блок с настройками статической маршрутизации таблиц:
        * **tables** — имена Iceberg-таблиц, разделенные запятыми, для статической маршрутизации таблиц.
     * **tables_config** — блок с настройками таблиц:
        * **default_commit_branch** — имя ветки по умолчанию. В эту ветку Iceberg-таблиц коннектор будет коммитить данные. Значение по умолчанию — `main`.
        * **default_id_columns** — список столбцов по умолчанию, разделенных запятыми, которые определяют строку идентификатора в Iceberg-таблицах (primary key). Является обязательным параметром при включенном UPSERT-режиме.
        * **default_partition_by** — список столбцов или выражений трансформации для партиционирования данных Iceberg-таблицы через запятую. Определяет физическое размещение данных для оптимизации запросов. Примеры: `date`, `year`, `month`, `year (timestamp)`, `month (timestamp)`, `days (timestamp)`, `bucket (16, user_id)`.
        * **evolve_schema_enabled** — настройка указывает, должен ли коннектор автоматически изменять схему Iceberg-таблицы, если схема входящих сообщений из Apache Kafka® изменилась. Значение по умолчанию — `false`.
        * **schema_case_insensitive** — настройка, которая указывает, должен ли коннектор игнорировать регистр при сопоставлении полей входящего сообщения с колонками Iceberg-таблицы. Значение по умолчанию — `false`.
        * **schema_force_optional** — настройка, указывающая, делать ли все поля схемы Iceberg-таблицы необязательными (`nullable`), независимо от того, как они определены в схеме входящего сообщения. Значение по умолчанию — `false`.

- REST API {#api}

  Настройки коннектора Iceberg Sink задаются в параметре `connectorSpec.connectorConfigIcebergSink`:

  * `topics` — список топиков, разделенных запятыми, данные из которых будут перенесены в Iceberg-таблицы.
  * `topicsRegex` — регулярное выражение для выбора топиков, данные из которых будут перенесены в Iceberg-таблицы. Можно использовать выражение `.*`, например, `analysis.*`. Для переноса всех топиков укажите `.*`.

  Для отбора топиков используйте либо параметр `topics`, либо параметр `topicsRegex`.
    
  * `controlTopic` — имя топика управления, используется для координации и управления процессом записи данных в Iceberg-таблицы.
  * `metastoreConnection` — параметры для подключения к Apache Hive™ Metastore:
      * `catalogUri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<хост>:<порт>`.
      * `warehouse` — корневая директория для хранения данных управляемых таблиц в S3 в формате `s3a://bucket-name/path/to/warehouse`.
  * `s3Connection` — параметры для подключения к S3-совместимому хранилищу:
      * `externalS3` — параметры внешнего хранилища:
          * `endpoint` — эндпоинт для доступа к хранилищу (его необходимо узнать у провайдера хранилища). Пример: `storage.yandexcloud.net`.
          * `region` — регион, в котором находится бакет S3-совместимого хранилища. Значение по умолчанию — `ru-central1`. [Список доступных регионов](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

             {% note info %}
             
             Некоторые приложения, предназначенные для работы с Amazon S3, не позволяют указывать регион, поэтому [Yandex Object Storage](../../storage/index.md) принимает также значение основного региона AWS — [первая строка в таблице регионов](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html#available-regions).
             
             {% endnote %}

          * `accessKeyId`, `secretAccessKey` — [идентификатор и содержимое AWS-совместимого ключа](../../iam/concepts/authorization/access-key.md).
  
  * `staticTables` — блок с настройками статической маршрутизации таблиц:
      * `tables` — имена Iceberg-таблиц через запятую для статической маршрутизации таблиц.
  * `dynamicTables` — блок с настройками динамической маршрутизации таблиц:
      * `routeField` — поле в сообщении для определения целевой таблицы при динамической маршрутизации.

  Для настройки маршрутизации таблиц используйте либо параметр `staticTables`, либо параметр `dynamicTables`.

  * `tablesConfig` — блок с настройками таблиц:
      * `defaultCommitBranch` — имя ветки по умолчанию. В эту ветку Iceberg-таблицы коннектор будет коммитить данные. Значение по умолчанию — `main`.
      * `defaultIdColumns` — список столбцов по умолчанию, разделенных запятыми, которые определяют строку идентификатора в Iceberg-таблицах (primary key). Является обязательным параметром при включенном UPSERT-режиме.
      * `defaultPartitionBy` — список столбцов или выражений трансформации для партиционирования данных Iceberg-таблицы через запятую. Определяет физическое размещение данных для оптимизации запросов. Примеры: `date`, `year`, `month`, `year (timestamp)`, `month (timestamp)`, `days (timestamp)`, `bucket (16, user_id)`.
      * `evolveSchemaEnabled` — настройка, указывающая, должен ли коннектор автоматически изменять схему Iceberg-таблицы, если схема входящих сообщений из Apache Kafka® изменилась. Значение по умолчанию — `false`.
      * `schemaForceOptional` — настройка, указывающая, делать ли все поля схемы Iceberg-таблицы необязательными (`nullable`), независимо от того, как они определены в схеме входящего сообщения. Значение по умолчанию — `false`.
      * `schemaCaseInsensitive` — настройка, указывающая, должен ли коннектор игнорировать регистр при сопоставлении полей входящего сообщения с колонками Iceberg-таблицы. Значение по умолчанию — `false`.
  * `controlConfig` — блок с дополнительными настройками:
      * `groupIdPrefix` — префикс для `Consumer Group ID`, который коннектор использует при чтении из топиков Apache Kafka®. Значение по умолчанию — `cg-control`.
      * `commitIntervalMs` — указывает, как часто коннектор делает коммит данных в Iceberg-таблицу. Задается в миллисекундах. Значение по умолчанию — `300000`.
      * `commitTimeoutMs` — указывает, сколько времени координатор ждет подтверждения от всех воркеров перед тем, как признать коммит неудачным. Задается в миллисекундах. Значение по умолчанию — `30000`.
      * `commitThreads` — количество потоков, которые используются для коммита данных в Iceberg-таблицу. Значение по умолчанию — `vCPU × 2`.
      * `transactionalPrefix` — префикс для `Transactional ID`, который коннектор использует при записи в Apache Kafka® в рамках транзакций.

- gRPC API {#grpc-api}

  Настройки коннектора Iceberg Sink задаются в параметре `connector_spec.connector_config_iceberg_sink`:

  * `topics` — список топиков, разделенных запятыми, данные из которых будут перенесены в Iceberg-таблицы.
  * `topics_regex` — регулярное выражение для выбора топиков, данные из которых будут перенесены в Iceberg-таблицы. Можно использовать выражение `.*`, например, `analysis.*`. Для переноса всех топиков укажите `.*`.

  Для отбора топиков используйте либо параметр `topics`, либо параметр `topics_regex`.
    
  * `control_topic` — имя топика управления, используется для координации и управления процессом записи данных в Iceberg-таблицы.
  * `metastore_connection` — параметры для подключения к Apache Hive™ Metastore:
      * `catalog_uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<хост>:<порт>`.
      * `warehouse` — корневая директория для хранения данных управляемых таблиц в S3 в формате `s3a://bucket-name/path/to/warehouse`.
    * `s3_connection` — параметры для подключения к S3-совместимому хранилищу:
        * `externalS3` — параметры внешнего хранилища:
            * `endpoint` — эндпоинт для доступа к хранилищу (его необходимо узнать у провайдера хранилища). Пример: `storage.yandexcloud.net`.
            * `region` — регион, в котором находится бакет S3-совместимого хранилища. Значение по умолчанию — `ru-central1`. [Список доступных регионов](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

                {% note info %}
                
                Некоторые приложения, предназначенные для работы с Amazon S3, не позволяют указывать регион, поэтому [Yandex Object Storage](../../storage/index.md) принимает также значение основного региона AWS — [первая строка в таблице регионов](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html#available-regions).
                
                {% endnote %}

            * `access_key_id`, `secret_access_key` — [идентификатор и содержимое AWS-совместимого ключа](../../iam/concepts/authorization/access-key.md).
  
    * `static_tables` — блок с настройками статической маршрутизации таблиц:
       * `tables` — имена Iceberg-таблиц через запятую для статической маршрутизации таблиц.
    * `dynamic_tables` — блок с настройками динамической маршрутизации таблиц:
       * `route_field` — поле в сообщении для определения целевой таблицы при динамической маршрутизации.

    Для настройки маршрутизации таблиц используйте либо параметр `static_tables`, либо параметр `dynamic_tables`.

    * `tables_config` — блок с настройками таблиц:
       * `default_commit_branch` — имя ветки по умолчанию. В эту ветку Iceberg-таблиц коннектор будет коммитить данные. Значение по умолчанию — `main`.
       * `default_id_columns` — список столбцов по умолчанию, разделенных запятыми, которые определяют строку идентификатора в Iceberg-таблицах (primary key). Является обязательным параметром при включенном UPSERT-режиме.
       * `default_partition_by` — список столбцов или выражений трансформации для партиционирования данных Iceberg-таблицы через запятую. Определяет физическое размещение данных для оптимизации запросов. Примеры: `date`, `year`, `month`, `year (timestamp)`, `month (timestamp)`, `days (timestamp)`, `bucket (16, user_id)`.
       * `evolve_schema_enabled` — настройка, которая указывает, должен ли коннектор автоматически изменять схему Iceberg-таблицы, если схема входящих сообщений из Apache Kafka® изменилась. Значение по умолчанию — `false`.
       * `schema_force_optional` — настройка, указывающая, делать ли все поля схемы Iceberg-таблицы необязательными (`nullable`), независимо от того, как они определены в схеме входящего сообщения. Значение по умолчанию — `false`.
       * `schema_case_insensitive` — настройка, которая указывает, должен ли коннектор игнорировать регистр при сопоставлении полей входящего сообщения с колонками Iceberg-таблицы. Значение по умолчанию — `false`.
    * `control_config` — блок с дополнительными настройками:
       * `group_id_prefix` — префикс для `Consumer Group ID`, который коннектор использует при чтении из топиков Apache Kafka®. Значение по умолчанию — `cg-control`.
       * `commit_interval_ms` — указывает, как часто коннектор делает коммит данных в Iceberg-таблицу. Задается в миллисекундах. Значение по умолчанию — `300000`.
       * `commit_timeout_ms` — указывает, сколько времени координатор ждет подтверждения от всех воркеров перед тем, как признать коммит неудачным. Задается в миллисекундах. Значение по умолчанию — `30000`.
       * `commit_threads` — количество потоков, которые используются для коммита данных в Iceberg-таблицу. Значение по умолчанию — `vCPU × 2`.
       * `transactional_prefix` — префикс для `Transactional ID`, который коннектор использует при записи в Apache Kafka® в рамках транзакций.

{% endlist %}

## Изменить коннектор {#update}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
    1. Выберите нужный кластер и перейдите на вкладку **Коннекторы**.
    1. В строке с нужным коннектором нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **Изменить коннектор**.
    1. Внесите необходимые изменения в свойства коннектора.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить коннектор [MirrorMaker](#settings-mm2):

    1. Посмотрите описание команды CLI для изменения коннектора:

        ```bash
        yc managed-kafka connector-mirrormaker update --help
        ```

    1. Запустите операцию, например, изменения лимита задач:

        ```bash
        yc managed-kafka connector-mirrormaker update <имя_коннектора> \
           --cluster-name=<имя_кластера> \
           --direction=<направление_коннектора> \
           --tasks-max=<новый_лимит_задач>
        ```

        Где `--direction` — направление коннектора: `ingress` или `egres`.

        Имя коннектора можно запросить со [списком коннекторов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    Чтобы изменить коннектор [S3 Sink](#settings-s3):

    1. Посмотрите описание команды CLI для изменения коннектора:

        ```bash
        yc managed-kafka connector-s3-sink update --help
        ```

    1. Запустите операцию, например, изменения лимита задач:

        ```bash
        yc managed-kafka connector-s3-sink update <имя_коннектора> \
           --cluster-name=<имя_кластера> \
           --tasks-max=<новый_лимит_задач>
        ```

        Имя коннектора можно запросить со [списком коннекторов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    Чтобы изменить коннектор [Iceberg Sink](#settings-iceberg):

    1. Посмотрите описание команды CLI для изменения коннектора:

        ```bash
        yc managed-kafka connector-iceberg-sink update --help
        ```

    1. Запустите операцию, например, изменение лимита задач:

        ```bash
        yc managed-kafka connector-iceberg-sink update <имя_коннектора> \
           --cluster-name=<имя_кластера> \
           --tasks-max=<новый_лимит_задач>
        ```

        Имя коннектора можно запросить со [списком коннекторов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

    1. Ознакомьтесь со списком настроек коннекторов [MirrorMaker](#settings-mm2), [S3 Sink](#settings-s3) и [Iceberg Sink](#settings-iceberg).

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).

    1. Измените значение параметров в описании ресурса `yandex_mdb_kafka_connector`:

        * Для коннектора MirrorMaker:

            ```hcl
            resource "yandex_mdb_kafka_connector" "<имя_коннектора>" {
              cluster_id = "<идентификатор_кластера>"
              name       = "<имя_коннектора>"
              tasks_max  = <лимит_задач>
              properties = {
                <дополнительные_свойства>
              }
              connector_config_mirrormaker {
                topics             = "<шаблон_для_топиков>"
                replication_factor = <фактор_репликации>
                source_cluster {
                  alias = "<префикс_для_обозначения_кластера>"
                  external_cluster {
                    bootstrap_servers           = "<список_FQDN_хостов-брокеров>"
                    sasl_username               = "<имя_пользователя>"
                    sasl_password               = "<пароль_пользователя>"
                    sasl_mechanism              = "<механизм_шифрования>"
                    security_protocol           = "<протокол_безопасности>"
                    ssl-truststore-certificates = "<содержимое_PEM-сертификата>"
                  }
                }
                target_cluster {
                  alias = "<префикс_для_обозначения_кластера>"
                  this_cluster {}
                }
              }
            }
            ```

        * Для коннектора S3 Sink:

            ```hcl
            resource "yandex_mdb_kafka_connector" "<имя_S3_Sink_коннектора>" {
              cluster_id = "<идентификатор_кластера>"
              name       = "<имя_S3_Sink_коннектора>"
              tasks_max  = <лимит_задач>
              properties = {
                <дополнительные_свойства>
             }
              connector_config_s3_sink {
                topics                = "<шаблон_для_топиков>"
                file_max_records      = <максимальное_количество_сообщений_в_файле>
                s3_connection {
                  bucket_name = "<имя_бакета>"
                  external_s3 {
                    endpoint          = "<эндпоинт_S3-совместимого_хранилища>"
                    access_key_id     = "<идентификатор_AWS-совместимого_статического_ключа>"
                    secret_access_key = "<содержимое_AWS-совместимого_статического_ключа>"
                  }
                }
              }
            }
            ```
          
        * Для коннектора Iceberg Sink:

           ```hcl
           resource "yandex_mdb_kafka_connector" "<имя_коннектора>" {
             cluster_id = "<идентификатор_кластера>"
             name       = "<имя_коннектора>"
             tasks_max  = <лимит_задач>
             properties = {
               <дополнительные_свойства>
             }
             connector_config_iceberg_sink {
               topics             = "<список_топиков>"
               control_topic = "<имя_топика_управления>"

               metastore_connection {
                 catalog_uri = "<URI_для_подключения_к_кластеру_Metastore>"
                 warehouse   = "<корневая_директория_для_хранения_данных_управляемых_таблиц_в_S3>"
               }

               s3_connection {
                 external_s3 {
                   endpoint          = "<эндпоинт_S3-совместимого_хранилища>"
                   access_key_id     = "<идентификатор_AWS-совместимого_статического_ключа>"
                   secret_access_key = "<содержимое_AWS-совместимого_статического_ключа>"
                   region            = "<название_региона>"
                 }
               }

               tables_config {
                 default_commit_branch    = "<имя_ветки_по_умолчанию>"
                 default_id_columns       = "<список_столбцов_по_умолчанию_через_запятую>"
                 default_partition_by     = "<список_стобцов_или выражений_трансформации>"
                 evolve_schema_enabled    = <автоматически_изменять_схему_Iceberg-таблицы>
                 schema_force_optional    = <сделать_поля_схемы_Iceberg-таблицы_необязательными>
                 schema_case_insensitive  = <игнорировать_регистр_при_сопоставлении_полей>
               }

               control_config {
                 group_id_prefix      = "<префикс_для_Consumer_Group_ID>"
                 commit_interval_ms   = <интервал_коммита_данных_в_Iceberg-таблицу>
                 commit_timeout_ms    = <сколько_времени_координатор_ждет_подтверждения>
                 commit_threads       = <количество_потоков_для_коммита_данных_в_Iceberg-таблицу>
                 transactional_prefix = "<префикс_для_Transactional_ID>"
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

    Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_connector.md).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

       ```bash
       export IAM_TOKEN="<IAM-токен>"
       ```

    1. Воспользуйтесь методом [Connector.update](../api-ref/Connector/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

       {% note warning %}
       
       Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
       
       {% endnote %}

       ```bash
       curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>/connectors/<имя_коннектора>' \
         --data '{
                   "updateMask": "connectorSpec.tasksMax,connectorSpec.properties,connectorSpec.connectorConfigMirrormaker.<настройка_коннектора_Mirrormaker_1>,...,connectorSpec.connectorConfigMirrormaker.<настройка_коннектора_Mirrormaker_N>,connectorSpec.connectorConfigS3Sink.<настройка_коннектора_S3-Sink_1>,...,connectorSpec.connectorConfigS3Sink.<настройка_коннектора_S3-Sink_N>,connectorSpec.connectorConfigIcebergSink.<настройка_коннектора_IcebergSink_1>,...,connectorSpec.connectorConfigIcebergSink.<настройка_коннектора_IcebergSink_N>",
                   "connectorSpec": {
                     "tasksMax": "<лимит_задач>"
                     "properties": "<дополнительные_свойства_коннектора>"
                     "connectorConfigMirrormaker": {
                       <настройки_коннектора_Mirrormaker>
                     },
                     "connectorConfigS3Sink": {
                       <настройки_коннектора_S3-Sink>
                     },
                     "connectorConfigIcebergSink": {
                        <настройки_коннектора_IcebergSink>
                      }
                   }
                 }'
       ```

       Где:

       * `updateMask` — перечень изменяемых параметров коннектора в одну строку через запятую.

            Укажите нужные параметры:
            * `connectorSpec.tasksMax` – если нужно изменить лимит задач коннектора.
            * `connectorSpec.properties` – если нужно изменить дополнительные свойства коннектора.
            * `connectorSpec.connectorConfigMirrormaker.<настройка_конфигурации_коннектора_Mirrormaker>` – если нужно изменить настройки коннектора [Mirrormaker](#settings-mm2).
            * `connectorSpec.connectorConfigS3Sink.<настройка_конфигурации_коннектора_S3-Sink>` – если нужно изменить настройки коннектора [S3 Sink](#settings-s3).
            * `connectorSpec.connectorConfigIcebergSink.<настройка_конфигурации_коннектора_IcebergSink>` – если нужно изменить настройки коннектора [Iceberg Sink](#settings-iceberg).

       * `connectorSpec` – укажите настройки коннектора MirrorMaker, S3 Sink или Iceberg Sink.

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя коннектора — со [списком коннекторов в кластере](#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Connector/update.md#yandex.cloud.operation.Operation).

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

    1. Воспользуйтесь вызовом [ConnectorService/Update](../api-ref/grpc/Connector/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/connector_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "connector_name": "<имя_коннектора>",
                "update_mask": {
                  "paths": [
                    "connector_spec.tasks_max",
                    "connector_spec.properties",
                    "connector_spec.connector_config_mirrormaker.<настройка_коннектора_Mirrormaker_1>",
                    ...,
                    "connector_spec.connector_config_mirrormaker.<настройка_коннектора_Mirrormaker_N>",
                    "connector_spec.connector_config_s3_sink.<настройка_коннектора_S3-Sink_1>",
                    ...,
                    "connector_spec.connector_config_s3_sink.<настройка_коннектора_S3-Sink_N>",
                    "connector_spec.connector_config_iceberg_sink.<настройка_коннектора_IcebergSink_1>",
                    ...,
                    "connector_spec.connector_config_iceberg_sink.<настройка_коннектора_IcebergSink_N>"
                  ]
                },
                "connector_spec": {
                  "tasks_max": {
                    "value": "<лимит_задач>"
                  },
                  "properties": "<дополнительные_свойства_коннектора>"
                  "connector_config_mirrormaker": {
                    <настройки_коннектора_Mirrormaker>
                  },
                  "connector_config_s3_sink": {
                    <настройки_коннектора_S3-Sink>
                  },
                  "connector_config_iceberg_sink": {
                    <настройки_коннектора_IcebergSink>
                  }
                }
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.kafka.v1.ConnectorService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров коннектора в виде массива строк `paths[]`.

            Укажите нужные параметры:
            * `connector_spec.tasks_max` – если нужно изменить лимит задач коннектора.
            * `connector_spec.properties` – если нужно изменить дополнительные свойства коннектора.
            * `connector_spec.connector_config_mirrormaker.<настройка_конфигурации_коннектора_Mirrormaker>` – если нужно изменить настройки коннектора [Mirrormaker](#settings-mm2).
            * `connector_spec.connector_config_s3_sink.<настройка_конфигурации_коннектора_S3-Sink>` – если нужно изменить настройки коннектора [S3 Sink](#settings-s3).
            * `connector_spec.connector_config_iceberg_sink.<настройка_конфигурации_коннектора_IcebergSink>` – если нужно изменить настройки коннектора [Iceberg Sink](#settings-iceberg).
        * `connector_spec` – укажите настройки коннектора MirrorMaker или S3 Sink.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя коннектора — со [списком коннекторов в кластере](#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Connector/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Приостановить коннектор {#pause}

В процессе приостановки коннектора:

* разрывается подключение к приемнику;
* удаляются данные из служебных топиков коннектора.

Чтобы приостановить коннектор:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
    1. Выберите нужный кластер и перейдите на вкладку **Коннекторы**.
    1. Нажмите на значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) рядом с именем нужного коннектора и выберите пункт **Приостановить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы приостановить работу коннектора, выполните команду:

    ```bash
    yc managed-kafka connector pause <имя_коннектора> \
       --cluster-name=<имя_кластера>
    ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

       ```bash
       export IAM_TOKEN="<IAM-токен>"
       ```

    1. Воспользуйтесь методом [Connector.pause](../api-ref/Connector/pause.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

       ```bash
       curl \
         --request POST \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>/connectors/pause/<имя_коннектора>'
       ```

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя коннектора — со [списком коннекторов в кластере](#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Connector/pause.md#yandex.cloud.operation.Operation).

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

    1. Воспользуйтесь вызовом [ConnectorService/Pause](../api-ref/grpc/Connector/pause.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/connector_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "connector_name": "<имя_коннектора>"
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.kafka.v1.ConnectorService.Pause
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя коннектора — со [списком коннекторов в кластере](#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Connector/pause.md#yandex.cloud.operation.Operation).

{% endlist %}

## Возобновить работу коннектора {#resume}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
    1. Выберите нужный кластер и перейдите на вкладку **Коннекторы**.
    1. Нажмите на значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) рядом с именем нужного коннектора и выберите пункт **Возобновить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы возобновить работу коннектора, выполните команду:

    ```bash
    yc managed-kafka connector resume <имя_коннектора> \
       --cluster-name=<имя_кластера>
    ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

       ```bash
       export IAM_TOKEN="<IAM-токен>"
       ```

    1. Воспользуйтесь методом [Connector.pause](../api-ref/Connector/resume.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

       ```bash
       curl \
         --request POST \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>/connectors/resume/<имя_коннектора>'
       ```

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя коннектора — со [списком коннекторов в кластере](#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Connector/resume.md#yandex.cloud.operation.Operation).

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

    1. Воспользуйтесь вызовом [ConnectorService/Resume](../api-ref/grpc/Connector/resume.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/connector_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "connector_name": "<имя_коннектора>"
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.kafka.v1.ConnectorService.Resume
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя коннектора — со [списком коннекторов в кластере](#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Connector/resume.md#yandex.cloud.operation.Operation).

{% endlist %}

## Импортировать коннектор в Terraform {#import}

С помощью импорта вы можете передать существующие коннекторы под управление Terraform.

{% list tabs group=instructions %}

- Terraform {#tf}

    1. Укажите в конфигурационном файле Terraform коннектор, который необходимо импортировать:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_коннектора>" {}
        ```

    1. Выполните команду для импорта коннектора:

        ```hcl
        terraform import yandex_mdb_kafka_connector.<имя_коннектора> <идентификатор_кластера>:<имя_коннектора>
        ```

        Подробнее об импорте коннекторов в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_connector.md#import).

{% endlist %}

## Удалить коннектор {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
    1. Выберите нужный кластер и перейдите на вкладку **Коннекторы**.
    1. Нажмите на значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) рядом с именем нужного коннектора и выберите пункт **Удалить**.
    1. Нажмите кнопку **Удалить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы удалить коннектор, выполните команду:

    ```bash
    yc managed-kafka connector delete <имя_коннектора> \
       --cluster-name <имя_кластера>
    ```

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).

    1. Удалите ресурс `yandex_mdb_kafka_connector` с описанием нужного коннектора.
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

    Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_kafka_connector.md).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

       ```bash
       export IAM_TOKEN="<IAM-токен>"
       ```

    1. Воспользуйтесь методом [Connector.pause](../api-ref/Connector/delete.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

       ```bash
       curl \
         --request DELETE \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/<идентификатор_кластера>/connectors/<имя_коннектора>'
       ```

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя коннектора — со [списком коннекторов в кластере](#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Connector/delete.md#yandex.cloud.operation.Operation).

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

    1. Воспользуйтесь вызовом [ConnectorService/Delete](../api-ref/grpc/Connector/delete.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/connector_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "connector_name": "<имя_коннектора>"
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.kafka.v1.ConnectorService.Delete
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя коннектора — со [списком коннекторов в кластере](#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Connector/delete.md#yandex.cloud.operation.Operation).

{% endlist %}