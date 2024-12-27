---
title: Как работать с топиками и разделами кластера {{ KF }} в {{ mkf-full-name }}
description: 'Следуя данной инструкции, вы сможете работать с топиками и разделами: создавать топик, изменять настройки топика, получать список топиков в кластере, получать детальную информацию о топике, импортировать топик в {{ TF }}, удалять топик.'
---

# Управление топиками {{ KF }}

Кластер {{ mkf-name }} позволяет управлять топиками и разделами двумя способами (как отдельно, так и совместно):

* С помощью [стандартных интерфейсов {{ yandex-cloud }}](#yandex-cloud) (CLI, [API](../../glossary/rest-api.md), консоль управления). Способ подходит, если вы хотите управлять топиками, используя возможности сервиса {{ mkf-name }}.

    Вы можете выполнить следующие действия над топиками {{ mkf-name }}:

    * [cоздать топик](#create-topic);
    * [изменить настройки топика](#update-topic);
    * [получить список топиков в кластере](#list-topics);
    * [получить детальную информацию о топике](#get-topic);
    * [импортировать топик в {{ TF }}](#import-topic);
    * [удалить топик](#delete-topic).

* С помощью [Admin API {{ KF }}](#admin-api). Способ подходит, если вы хотите использовать уже существующее у вас решение для управления топиками и разделами.

## Управление топиками через интерфейсы {{ yandex-cloud }} {#yandex-cloud}

### Создать топик {#create-topic}

Перед созданием топика рассчитайте [минимальный размер хранилища](../concepts/storage.md#minimal-storage-size).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.kafka.label_topics }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.kafka.button_create-topic }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** задайте базовые параметры топика:
     * Имя топика (должно быть уникально в пределах кластера {{ KF }}).
     * Количество разделов в топике.
     * Фактор репликации. Значение этого параметра не должно превышать количество брокеров в кластере. Минимальное значение: `1`. Максимальное значение: `3`. Значение по умолчанию:
       * для кластера из одного или двух брокеров: `1`;
       * для кластера с тремя и более брокерами: `3`.
  1. В блоке **{{ ui-key.yacloud.kafka.section_topic-config }}** задайте [настройки топика](../concepts/settings-list.md#topic-settings).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать топик:
  1. Посмотрите описание команды CLI для создания топиков:

     ```bash
     {{ yc-mdb-kf }} topic create --help
     ```

  1. Создайте топик:

     ```bash
     {{ yc-mdb-kf }} topic create <имя_топика> \
       --cluster-name <имя_кластера> \
       --partitions <количество_разделов> \
       --replication-factor <фактор_репликации>
     ```

     При необходимости здесь же задайте [настройки топика](../concepts/settings-list.md#topic-settings).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
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

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_topic).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Topic.create](../api-ref/Topic/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>/topics' \
       --data '{
                 "topicSpec": {
                  "name": "<имя_топика>",
                  "partitions": "<количество_партиций>",
                  "replicationFactor": "<фактор_репликации>"
               }'
     ```

     Где:

     * `topicSpec` — настройки топика:

        {% include [rest-topic-specs](../../_includes/mdb/mkf/api/rest-topic-specs.md) %}

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Topic/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [TopicService/Create](../api-ref/grpc/Topic/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.TopicService.Create
     ```

     Где:

     * `topic_spec` — настройки топика:

        {% include [grpc-topic-specs](../../_includes/mdb/mkf/api/grpc-topic-specs.md) %}

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Topic/create.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note info %}

В процессе своей работы {{ mkf-name }} может создавать [служебные топики](../concepts/topics.md#service-topics). Записывать пользовательские данные в такие топики нельзя.

{% endnote %}

### Изменить настройки топика {#update-topic}

Количество разделов в топиках {{ mkf-name }} нельзя уменьшить. Если в хранилище не хватает места, создать новые разделы нельзя.

Подробнее см. в разделе [{#T}](../concepts/storage.md#minimal-storage-size).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.kafka.label_topics }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного топика и выберите пункт **{{ ui-key.yacloud.common.edit }}**.
  1. Измените базовые параметры топика:
     * Количество разделов в топике.
     * Фактор репликации. Значение этого параметра не должно превышать количество брокеров в кластере. Минимальное значение: `1`. Максимальное значение: `3`. Значение по умолчанию:
       * Для кластера из одного или двух брокеров: `1`.
       * Для кластера с тремя и более брокерами: `3`.
  1. Измените [дополнительные настройки топика](../concepts/settings-list.md#topic-settings).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить настройки топика:
  1. Посмотрите описание команды CLI для изменения топиков:

     ```bash
     {{ yc-mdb-kf }} topic update --help
     ```

  1. Измените [настройки топика](../concepts/settings-list.md#topic-settings):

     ```bash
     {{ yc-mdb-kf }} topic update <имя_топика> \
       --cluster-name <имя_кластера> \
       --partitions <количество_разделов> \
       --replication-factor <фактор_репликации>
     ```

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
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

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_topic).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Topic.update](../api-ref/Topic/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     {% include [note-rest-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>/topics/<имя_топика>' \
       --data '{
                 "clusterId": "<идентификатор_кластера>",
                 "updateMask": "topicSpec.partitions,topicSpec.replicationFactor,topicSpec.topicConfig_2_8.<настройка_1>,...,topicSpec.topicConfig_2_8.<настройка_N>,topicSpec.topicConfig_3.<настройка_1>,...,topicSpec.topicConfig_3.<настройка_N>",
                 "topicSpec": {
                   "partitions": "<количество_партиций>",
                   "replicationFactor": "<фактор_репликации>",
                   "topicConfig_2_8": {
                     "<настройка_1_топика_{{ KF }}_версии_2.8>": "<значение_1>",
                     "<настройка_2_топика_{{ KF }}_версии_2.8>": "<значение_2>",
                     ...
                     "<настройка_N_топика_{{ KF }}_версии_2.8>": "<значение_N>"
                   },
                   "topicConfig_3": {
                     "<настройка_1_топика_{{ KF }}_версии_3.x>": "<значение_1>",
                     "<настройка_2_топика_{{ KF }}_версии_3.x>": "<значение_2>",
                     ...
                     "<настройка_N_топика_{{ KF }}_версии_3.x>": "<значение_N>"
                   }
                 } 
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае перечислите все изменяемые настройки топика.

     * `topicSpec` — новые настройки топика:

        {% include [rest-topic-specs](../../_includes/mdb/mkf/api/rest-topic-specs-update.md) %}

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Topic/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [TopicService/Update](../api-ref/grpc/Topic/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

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
                  "topic_сonfig_2_8": {
                     "<настройка_1_топика_{{ KF }}_версии_2.8>": "<значение_1>",
                     "<настройка_2_топика_{{ KF }}_версии_2.8>": "<значение_2>",
                     ...
                     "<настройка_N_топика_{{ KF }}_версии_2.8>": "<значение_N>"
                   },
                   "topic_сonfig_3": {
                     "<настройка_1_топика_{{ KF }}_версии_3.x>": "<значение_1>",
                     "<настройка_2_топика_{{ KF }}_версии_3.x>": "<значение_2>",
                     ...
                     "<настройка_N_топика_{{ KF }}_версии_3.x>": "<значение_N>"
                   }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.TopicService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае перечислите все изменяемые настройки топика.

     * `topic_spec` — новые настройки топика:

        {% include [grpc-topic-specs](../../_includes/mdb/mkf/api/grpc-topic-specs-update.md) %}

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Topic/update.md#yandex.cloud.operation.Operation).

{% endlist %}

### Получить список топиков в кластере {#list-topics}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.kafka.label_topics }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список топиков, выполните следующую команду:

  ```bash
  {{ yc-mdb-kf }} topic list --cluster-name <имя_кластера>
  ```

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Topic.list](../api-ref/Topic/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>/topics'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Topic/list.md#yandex.cloud.mdb.kafka.v1.ListTopicsResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [TopicService/List](../api-ref/grpc/Topic/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.TopicService.List
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Topic/list.md#yandex.cloud.mdb.kafka.v1.ListTopicsResponse).

{% endlist %}

### Получить детальную информацию о топике {#get-topic}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.kafka.label_topics }}**.
  1. Нажмите на имя нужного топика.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить детальную информацию о топике, выполните следующую команду:

  ```bash
  {{ yc-mdb-kf }} topic get <имя_топика> --cluster-name <имя_кластера>
  ```

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Topic.list](../api-ref/Topic/get.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>/topics/<имя_топика>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя топика — со [списком топиков в кластере](#list-topics).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Topic/get.md#yandex.cloud.mdb.kafka.v1.Topic).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [TopicService/Get](../api-ref/grpc/Topic/get.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.TopicService.Get
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя топика — со [списком топиков в кластере](#list-topics).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Topic/list.md#yandex.cloud.mdb.kafka.v1.Topic).

{% endlist %}

### Импортировать топик в {{ TF }} {#import-topic}

С помощью импорта вы можете передать существующие в кластере топики под управление {{ TF }}.

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. Укажите в конфигурационном файле {{ TF }} топик, который необходимо импортировать:

        ```hcl
        resource "yandex_mdb_kafka_topic" "<имя_топика>" {}
        ```

    1. Выполните команду для импорта топика:

        ```hcl
        terraform import yandex_mdb_kafka_topic.<имя_топика> <идентификатор_кластера>:<имя_топика>
        ```

        Подробнее об импорте топиков см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_topic#import).

{% endlist %}

### Удалить топик {#delete-topic}

{% include [mkf-deleted-topic-permissions-note](../../_includes/mdb/mkf-deleted-topic-permissions-note.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.kafka.label_topics }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного топика и выберите пункт **{{ ui-key.yacloud.kafka.button_delete-topic }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить топик:
  1. Посмотрите описание команды CLI для изменения топиков:

     ```bash
     {{ yc-mdb-kf }} topic delete --help
     ```

  1. Удалите топик:

     ```bash
     {{ yc-mdb-kf }} topic delete <имя_топика> --cluster-name <имя_кластера>
     ```

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Удалите ресурс `yandex_mdb_kafka_topic` с описанием нужного топика.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_topic).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Topic.delete](../api-ref/Topic/delete.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>/topics/<имя_топика>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя топика — со [списком топиков в кластере](#list-topics).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Topic/delete.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [TopicService/Delete](../api-ref/grpc/Topic/delete.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.TopicService.Delete
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя топика — со [списком топиков в кластере](#list-topics).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Topic/delete.md#yandex.cloud.operation.Operation).

{% endlist %}

## Управление топиками через Admin API {{ KF }} {#admin-api}

Чтобы управлять топиками через Admin API {{ KF }}:
1. [Создайте](cluster-accounts.md#create-account) в кластере пользователя-администратора с ролью `ACCESS_ROLE_ADMIN`.
1. Управляйте топиками от имени этого пользователя с помощью запросов к Admin API {{ KF }}. О работе с Admin API читайте в документации выбранного языка программирования.

Подробнее о работе с Admin API и о действующих ограничениях читайте в разделе [{#T}](../concepts/topics.md#management) и в [документации {{ KF }}](https://kafka.apache.org/documentation/#adminapi).
