# Обновление версии Apache Kafka®

{% note info %}

С 1 марта 2025 года прекращена поддержка Apache Kafka® версий 2.8, 3.0, 3.1, 3.2 и 3.3. Создать кластер с этими версиями невозможно. Рекомендуется обновить существующие кластеры до версии 3.9.

{% endnote %}

Со списком поддерживаемых версий можно ознакомиться в разделе [Политика работы с версиями Apache Kafka®](../concepts/update-policy.md). Рекомендуется обновлять версию Apache Kafka® поэтапно, без пропуска версий. Например, обновление версии с 3.1 до 3.5 выполняется в такой последовательности: 3.1 → 3.2 → 3.3 → 3.4 → 3.5.

Об обновлениях в рамках одной версии и обслуживании хостов в разделе [Техническое обслуживание в Managed Service for Apache Kafka®](../concepts/maintenance.md).

## Перед обновлением версии {#before-update}

Убедитесь, что это не нарушит работу ваших приложений — изучите [историю изменений](https://kafka.apache.org/community/downloads/) Apache Kafka®.

## Обновить кластер {#start-update}

{% note alert %}

После обновления версии Apache Kafka® вернуть кластер к предыдущей версии невозможно.

{% endnote %}

Во время обновления топики могут быть недоступны, если их [фактор репликации](../concepts/settings-list.md#settings-topic-replication-factor) равен единице.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. Перейдите в сервис **Managed Service for&nbsp;Kafka**.
    1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **Редактировать**.
    1. В поле **Версия** выберите номер новой версии.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Получите список ваших кластеров Managed Service for Apache Kafka®:

        ```bash
        yc managed-kafka cluster list
        ```

    1. Получите информацию о нужном кластере и проверьте версию в свойстве `config.version`:

        ```bash
        yc managed-kafka cluster get <имя_или_идентификатор_кластера>
        ```

    1. Запустите обновление Apache Kafka®:

        ```bash
        yc managed-kafka cluster update <имя_или_идентификатор_кластера> \
           --version=<номер_новой_версии>
        ```

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, описано в разделе [Создание кластера Apache Kafka®](cluster-create.md).

    1. Добавьте в блок `config` нужного кластера Managed Service for Apache Kafka® поле `version` (версия Apache Kafka®) или измените его значение, если оно уже существует:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          config {
            version = "<версия>"
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
                      "updateMask": "configSpec.version",
                      "configSpec": {
                        "version": "<версия>"
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае указан только один параметр: `configSpec.version`.

        * `configSpec.version` — версия Apache Kafka®, до которой нужно обновиться: 3.6, 3.7, 3.8 или 3.9.

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
                      "config_spec.version"
                    ]
                  },
                  "config_spec": {
                    "version": "<версия>"
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае указан только один параметр: `config_spec.version`.

        * `config_spec.version` — версия Apache Kafka®, до которой нужно обновиться: 3.6, 3.7, 3.8 или 3.9.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Примеры {#examples}

Допустим, нужно обновить кластер с версии 2.8 до версии 3.0.

{% list tabs group=instructions %}

- CLI {#cli}

    1. Чтобы получить список кластеров и узнать их идентификаторы и имена, выполните команду:

        ```bash
        yc managed-kafka cluster list
        ```

        ```text
        +----------------------+---------------+---------------------+--------+---------+
        |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
        +----------------------+---------------+---------------------+--------+---------+
        | c9q8p8j2gaih******** |    kafka35    | 2021-10-23 12:44:17 | ALIVE  | RUNNING |
        +----------------------+---------------+---------------------+--------+---------+
        ```

    1. Чтобы получить информацию о кластере с именем `kafka35`, выполните команду:

        ```bash
        yc managed-kafka cluster get kafka35
        ```

        ```text
          id: c9q8p8j2gaih********
          ...
          config:
            version: "2.8"
            ...
        ```

    1. Для обновления кластера `kafka35` до версии 3.0 выполните команду:

        ```bash
        yc managed-kafka cluster update kafka35 --version=3.0
        ```

{% endlist %}