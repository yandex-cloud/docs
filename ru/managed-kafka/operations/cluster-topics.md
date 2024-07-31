---
title: "Как работать с топиками и разделами кластера {{ KF }} в {{ mkf-full-name }}"
description: "Следуя данной инструкции, вы сможете работать с топиками и разделами." 
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


- API {#api}

  Чтобы создать топик, воспользуйтесь методом REST API [create](../api-ref/Topic/create.md) для ресурса [Topic](../api-ref/Topic/index.md) или вызовом gRPC API [TopicService/Create](../api-ref/grpc/topic_service.md#Create) и передайте в запросе:
  * Идентификатор кластера, в котором нужно создать топик, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Настройки топика в параметре `topicSpec`.


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


- API {#api}

  Чтобы изменить настройки топика, воспользуйтесь методом REST API [update](../api-ref/Topic/update.md) для ресурса [Topic](../api-ref/Topic/index.md) или вызовом gRPC API [TopicService/Update](../api-ref/grpc/topic_service.md#Update) и передайте в запросе:
  * Идентификатор кластера, в котором находится топик, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя топика в параметре `topicName`. Чтобы узнать имя, [получите список топиков в кластере](#list-topics).
  * Новые значения [настроек топика](../concepts/settings-list.md#topic-settings) в параметре `topicSpec`.
  * Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}


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


- API {#api}

  Чтобы получить список топиков в кластере, воспользуйтесь методом REST API [list](../api-ref/Topic/list.md) для ресурса [Topic](../api-ref/Topic/index.md) или вызовом gRPC API [TopicService/List](../api-ref/grpc/topic_service.md#List) и передайте в запросе идентификатор требуемого кластера в параметре `clusterId`.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).


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


- API {#api}

  Чтобы получить детальную информацию о топике, воспользуйтесь методом REST API [get](../api-ref/Topic/get.md) для ресурса [Topic](../api-ref/Topic/index.md) или вызовом gRPC API [TopicService/Get](../api-ref/grpc/topic_service.md#Get) и передайте в запросе:
  * Идентификатор кластера, в котором находится топик, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя топика в параметре `topicName`. Чтобы узнать имя, [получите список топиков в кластере](#list-topics).


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


- API {#api}

  Чтобы удалить топик, воспользуйтесь методом REST API [delete](../api-ref/Topic/delete.md) для ресурса [Topic](../api-ref/Topic/index.md) или вызовом gRPC API [TopicService/Delete](../api-ref/grpc/topic_service.md#Delete) и передайте в запросе:
  * Идентификатор кластера, в котором находится топик, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя топика в параметре `topicName`. Чтобы узнать имя, [получите список топиков в кластере](#list-topics).


{% endlist %}

## Управление топиками через Admin API {{ KF }} {#admin-api}

Чтобы управлять топиками через Admin API {{ KF }}:
1. [Создайте](cluster-accounts.md#create-account) в кластере пользователя-администратора с ролью `ACCESS_ROLE_ADMIN`.
1. Управляйте топиками от имени этого пользователя с помощью запросов к Admin API {{ KF }}. О работе с Admin API читайте в документации выбранного языка программирования.

Подробнее о работе с Admin API и о действующих ограничениях читайте в разделе [{#T}](../concepts/topics.md#management) и в [документации {{ KF }}](https://kafka.apache.org/documentation/#adminapi).
