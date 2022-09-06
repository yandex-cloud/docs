# Работа с топиками и разделами

Кластер {{ mkf-name }} позволяет управлять топиками и разделами двумя способами (как отдельно, так и совместно):

* С помощью стандартных интерфейсов {{ yandex-cloud }} (CLI, API, консоль управления). Способ подходит, если вы хотите создавать, удалять и настраивать топики и разделы, используя возможности сервиса {{ mkf-full-name }}.
* С помощью [Admin API](https://kafka.apache.org/documentation/#adminapi) {{ KF }}. Способ подходит, если вы хотите использовать уже существующее у вас решение для управления топиками и разделами.

## Управление топиками и разделами через Admin API {{ KF }} {#admin-api}

Чтобы управлять топиками через [Admin API {{ KF }}](https://kafka.apache.org/documentation/#adminapi):

1. Включите настройку **Управление топиками через API** при [создании кластера](./cluster-create.md) или [изменении его настроек](./cluster-update.md).
1. [Создайте](./cluster-accounts.md#create-user) в кластере пользователя-администратора.
1. Управляйте топиками от имени этого пользователя с помощью запросов к [Admin API {{ KF }}](https://kafka.apache.org/documentation/#adminapi). О работе с Admin API читайте в документации выбранного языка программирования.

Подробнее о работе с Admin API и о действующих ограничениях читайте в разделе [{#T}](../concepts/topics.md#management) и в [документации {{ KF }}](https://kafka.apache.org/documentation/#adminapi).

## Создать топик {#create-topic}

Перед созданием топика рассчитайте [минимальный размер хранилища](../concepts/storage.md#minimal-storage-size).

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Топики**.
  1. Нажмите кнопку **Создать топик**.
  1. В блоке **Базовые параметры** задайте базовые параметры топика:
     * Имя топика (должно быть уникально в пределах кластера {{ KF }}).
     * Количество разделов в топике.
     * Фактор репликации. Значение этого параметра не должно превышать количество брокеров в кластере. Минимальное значение: `1`. Максимальное значение: `3`. Значение по умолчанию:
       * для кластера из одного или двух брокеров: `1`;
       * для кластера с тремя и более брокерами: `3`.
  1. В блоке **Настройки топика** задайте [настройки топика](../concepts/settings-list.md#topic-settings).
  1. Нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать топик:

  1. Посмотрите описание команды CLI для создания топиков:

     ```bash
     {{ yc-mdb-kf }} topic create --help
     ```

  1. Создайте топик:

     ```bash
     {{ yc-mdb-kf }} topic create <имя топика> \
       --cluster-name <имя кластера> \
       --partitions <количество разделов> \
       --replication-factor <фактор репликации>
     ```

     При необходимости здесь же задайте [настройки топика](../concepts/settings-list.md#topic-settings).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Добавьте ресурс `yandex_mdb_kafka_topic` и, при необходимости, задайте [настройки топика](../concepts/settings-list.md#topic-settings) в блоке `topic_config`:

        ```hcl
        resource "yandex_mdb_kafka_topic" "<имя топика>" {
          cluster_id         = "<идентификатор кластера>"
          name               = "<имя топика>"
          partitions         = <количество разделов>
          replication_factor = <фактор репликации>
          topic_config {
            compression_type = "<тип сжатия>"
            flush_messages   = <максимальное число сообщений в памяти>
            ...
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_kafka_topic).

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [create](../api-ref/Topic/create.md) и передайте в запросе:
  - Идентификатор кластера, в котором нужно создать топик, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  - Настройки топика в параметре `topicSpec`.

{% endif %}

{% endlist %}

{% note info %}

В процессе своей работы {{ mkf-name }} может создавать [служебные топики](../concepts/topics.md#service-topics). Записывать пользовательские данные в такие топики нельзя.

{% endnote %}

## Изменить настройки топика {#update-topic}

Количество разделов в топиках {{ mkf-name }} нельзя уменьшить. Если в хранилище не хватает места, создать новые разделы нельзя.

Подробнее см. в разделе [{#T}](../concepts/storage.md#minimal-storage-size).

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Топики**.
  1. Нажмите значок ![image](../../_assets/options.svg) для нужного топика и выберите пункт **Редактировать**.
  1. Измените базовые параметры топика:
     * Количество разделов в топике.
     * Фактор репликации. Значение этого параметра не должно превышать количество брокеров в кластере. Минимальное значение: `1`. Максимальное значение: `3`. Значение по умолчанию:
       * для кластера из одного или двух брокеров: `1`;
       * для кластера с тремя и более брокерами: `3`.
  1. Измените [дополнительные настройки топика](../concepts/settings-list.md#topic-settings).
  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить настройки топика:
  
  1. Посмотрите описание команды CLI для изменения топиков:

     ```
     {{ yc-mdb-kf }} topic update --help
     ```
     
  1. Измените [настройки топика](../concepts/settings-list.md#topic-settings):
  
     ```
     {{ yc-mdb-kf }} topic update <имя топика> \
       --cluster-name <имя кластера> \
       --partitions <количество разделов> \
       --replication-factor <фактор репликации>
     ```

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Измените значение параметров в описании ресурса `yandex_mdb_kafka_topic`:

        ```hcl
        resource "yandex_mdb_kafka_topic" "<имя топика>" {
          cluster_id         = "<идентификатор кластера>"
          name               = "<имя топика>"
          partitions         = <количество разделов>
          replication_factor = <фактор репликации>
          topic_config {
            compression_type = "<тип сжатия>"
            flush_messages   = <максимальное число сообщений в памяти>
            ...
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_kafka_topic).

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [update](../api-ref/Topic/update.md) и передайте в запросе:

  * Идентификатор кластера, в котором находится топик, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя топика в параметре `topicName`. Чтобы узнать имя, [получите список топиков в кластере](#list-topics).
  * Новые значения [настроек топика](../concepts/settings-list.md#topic-settings) в параметре `topicSpec`.
  * Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endif %}

{% endlist %}

## Удалить топик {#delete-topic}

{% include [mkf-deleted-topic-permissions-note](../../_includes/mdb/mkf-deleted-topic-permissions-note.md) %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Топики**.
  1. Нажмите значок ![image](../../_assets/options.svg) для нужного топика и выберите пункт **Удалить топик**.
  1. Подтвердите удаление топика и нажмите кнопку **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить топик:
  
  1. Посмотрите описание команды CLI для изменения топиков:

     ```
     {{ yc-mdb-kf }} topic delete --help
     ```
     
  1. Удалите топик:
  
     ```
     {{ yc-mdb-kf }} topic delete <имя топика> --cluster-name <имя кластера>
     ```

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Удалите ресурс `yandex_mdb_kafka_topic` с описанием нужного топика.
    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_kafka_topic).

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [delete](../api-ref/Topic/delete.md) и передайте в запросе:
  * Идентификатор кластера, в котором находится топик, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя топика в параметре `topicName`. Чтобы узнать имя, [получите список топиков в кластере](#list-topics).

{% endif %}

{% endlist %}

## Получить список топиков в кластере {#list-topics}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Топики**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список топиков, выполните следующую команду:
  
  ```
  {{ yc-mdb-kf }} topic list --cluster-name <имя кластера>
  ```

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [list](../api-ref/Topic/list.md) и передайте значение идентификатора требуемого кластера в параметре `clusterId` запроса.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

{% endif %}

{% endlist %}

## Получить детальную информацию о топике {#get-topic}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Топики**.
  1. Нажмите на имя нужного топика.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить детальную информацию о топике, выполните следующую команду:
  
  ```
  {{ yc-mdb-kf }} topic get <имя топика> --cluster-name <имя кластера>
  ```

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [get](../api-ref/Topic/get.md) и передайте в запросе:
  * Идентификатор кластера, в котором находится топик, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя топика в параметре `topicName`. Чтобы узнать имя, [получите список топиков в кластере](#list-topics).

{% endif %}

{% endlist %}
