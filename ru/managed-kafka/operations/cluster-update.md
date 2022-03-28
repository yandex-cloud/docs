# Изменение настроек кластера

После создания кластера {{ KF }} вы можете:

* [{#T}](#change-resource-preset).
* [{#T}](#change-disk-size){% if audience != "internal" %} (недоступно для [хранилища](../concepts/storage.md) на нереплицируемых SSD-дисках){% endif %}.
* [{#T}](#change-additional-settings).
* [Изменить настройки {{ KF }}](#change-kafka-settings).
* [Переместить кластер](#move-cluster) из текущего каталога в другой каталог.
* [Изменить группы безопасности кластера](#change-sg-set).

## Изменить класс и количество хостов {#change-resource-preset}

Вы можете изменить:
* класс и количество хостов-брокеров {{ KF }};
* класс хостов {{ ZK }}. 

{% note warning %}

Количество хостов-брокеров {{ KF }} нельзя уменьшить.

{% endnote %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Выберите кластер.
  1. В правом верхнем углу нажмите значок ![image](../../_assets/horizontal-ellipsis.svg), затем **Редактировать**.
  1. Измените требуемые настройки:
     * Чтобы изменить класс [хостов-брокеров](../concepts/brokers.md), выберите новый [**Класс хоста**](../concepts/instance-types.md).
     * Измените **Количество брокеров в зоне**.

  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить класс и количество хостов:
  
  1. Получите информацию о кластере:

     ```
     {{ yc-mdb-kf }} cluster list
     {{ yc-mdb-kf }} cluster get <имя или идентификатор кластера>
     ```

  1. Посмотрите описание команды CLI для изменения кластера:

     ```
     {{ yc-mdb-kf }} cluster update --help
     ```
 
  1. Чтобы увеличить количество хостов-брокеров, выполните команду:
  
     ```
     {{ yc-mdb-kf }} cluster update <имя или идентификатор кластера> --brokers-count <число>
     ```
     
  1. Чтобы изменить класс хоста-брокера, выполните команду:

     ```
     {{ yc-mdb-kf }} cluster update <имя или идентификатор кластера> --resource-preset <класс хоста>
     ```
  
  1. Чтобы изменить класс хоста {{ ZK }}, выполните команду:

     ```
     {{ yc-mdb-kf }} cluster update <имя или идентификатор кластера> \
       --zookeeper-resource-preset <класс хоста>
     ```

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Измените в описании кластера {{ mkf-name }} значение параметра `brokers_count`, чтобы увеличить количество хостов-брокеров:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя кластера>" {
          config {
            brokers_count = <количество хостов-брокеров>
            ...
          }
          ...
        }
        ```

    1. Измените в описании кластера {{ mkf-name }} значение параметра `resource_preset_id` в блоках `kafka.resources` и `zookeeper.resources` для хостов {{ KF }} и {{ ZK }} соответственно:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя кластера>" {
          ...
          kafka {
            resources {
              resource_preset_id = "<класс хостов Apache Kafka>"
              ...
            }
          }
          zookeeper {
            resources {
              resource_preset_id = "<класс хостов {{ ZK }}>"
              ...
            }
          }
         }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Список настроек, которые необходимо изменить, в параметре `updateMask` (одной строкой через запятую). Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.
  * Новую конфигурацию кластера в параметре `configSpec`.
  
{% endif %}

{% endlist %}

## {% if audience != "internal" %}Увеличить{% else %}Изменить{% endif %} размер хранилища {#change-disk-size}

{% note warning %}

Тип диска для кластера {{ KF }} нельзя изменить после создания.

{% endnote %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Консоль управления

  Чтобы {% if audience != "internal" %}увеличить{% else %}изменить{% endif %} размер хранилища для кластера:

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Выберите кластер.
  1. В правом верхнем углу нажмите значок ![image](../../_assets/horizontal-ellipsis.svg), затем **Редактировать**.
  1. Измените настройки блока **Хранилище**.
  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы {% if audience != "internal" %}увеличить{% else %}изменить{% endif %} размер хранилища для хостов:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-kf }} cluster update --help
     ```
 
  1. Чтобы изменить объем хранилища хостов-брокеров, выполните команду:
  
     ```bash
     {{ yc-mdb-kf }} cluster update <имя или идентификатор кластера> \
       --disk-size <объем хранилища>
     ```
     
     Если не указаны единицы размера, то используются гигабайты.

  1. Чтобы изменить объем хранилища хостов {{ ZK }}, выполните команду:

     ```bash
     {{ yc-mdb-kf }} cluster update <имя или идентификатор кластера> \
       --zookeeper-disk-size <размер диска>
     ```
     
     Если не указаны единицы размера, то используются гигабайты.

- Terraform

  Чтобы {% if audience != "internal" %}увеличить{% else %}изменить{% endif %} размер хранилища для кластера

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Измените в описании кластера {{ mkf-name }} значение параметра `disk_size` в блоках `kafka.resources` и `zookeeper.resources` для хостов {{ KF }} и {{ ZK }} соответственно:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя кластера>" {
          ...
          kafka {
            resources {
              disk_size = <размер хранилища в гигабайтах>
              ...
            }
          }
          zookeeper {
            resources {
              disk_size = <размер хранилища в гигабайтах>
              ...
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

{% if api != "noshow" %}

- API

  Чтобы {% if audience != "internal" %}увеличить{% else %}изменить{% endif %} размер хранилища для кластера, воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Список настроек, которые необходимо изменить, в параметре `updateMask` (одной строкой через запятую). Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.
  * Новую конфигурацию кластера в параметре `configSpec`.
  
{% endif %}

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Выберите кластер.
  1. В правом верхнем углу нажмите значок ![image](../../_assets/horizontal-ellipsis.svg), затем **Редактировать**.
  1. Измените дополнительные настройки кластера:

     {% include [Дополнительные настройки кластера MKF](../../_includes/mdb/mkf/extra-settings.md) %}

  1. Нажмите кнопку **Сохранить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        {{ yc-mdb-kf }} cluster update <идентификатор или имя кластера> \
           --maintenance-window type=<тип технического обслуживания: anytime или weekly>,`
                               `day=<день недели для типа weekly>,`
                               `hour=<час дня для типа weekly>
           --deletion-protection=<защита от удаления кластера: true или false>
        ```

    Вы можете изменить следующие настройки:

    * {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window.md) %}

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. {% include [maintenance-window](../../_includes/mdb/mkf/terraform-maintenance-window.md) %}

    1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя кластера>" {
          ...
          deletion_protection = <защита от удаления кластера: true или false>
        }
        ```

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mkf }}).

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

    * {% include [maintenance-window](../../_includes/mdb/api/maintenance-window.md) %}

    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

    * Список полей конфигурации кластера, подлежащих изменению, в параметре `updateMask`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    {% note warning %}

    Этот метод API сбросит все настройки кластера, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, обязательно передайте название полей, подлежащих изменению, в параметре `updateMask`.

    {% endnote %}

{% endlist %}

## Изменить настройки {{ KF }} {#change-kafka-settings}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Выберите кластер.
  1. В правом верхнем углу нажмите значок ![image](../../_assets/horizontal-ellipsis.svg), затем **Редактировать**.
  1. В блоке **Настройки Kafka** нажмите кнопку **Настроить**.

     Подробнее см. в разделе [Настройки {{ KF }}](../concepts/settings-list.md).

  1. Нажмите кнопку **Сохранить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить настройки {{ KF }}:

    1. Посмотрите описание команды CLI для изменения настроек кластера:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Измените [настройки {{ KF }}](../concepts/settings-list.md#cluster-settings) в команде изменения кластера (в примере приведены не все настройки):

        ```bash
        {{ yc-mdb-kf }} cluster update <идентификатор или имя кластера> \
           --compression-type <тип сжатия> \
           --log-flush-interval-messages <количество сообщений в логе, необходимое для их сброса на диск> \
           --log-flush-interval-ms <максимальное время хранения сообщений в памяти перед сбросом на диск>
        ```

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Измените в описании кластера {{ mkf-name }} значения параметров в блоке `kafka.kafka_config` (в примере приведены не все [настройки](../concepts/settings-list.md#cluster-settings)):

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя кластера>" {
          ...
          config {
            kafka {
              ...
              kafka_config {
                compression_type            = "<тип сжатия>"
                log_flush_interval_messages = <максимальное число сообщений в памяти>
                ...
              }
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера Terraform](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

{% if api != "noshow" %}

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Список настроек, которые необходимо изменить, в параметре `updateMask` (одной строкой через запятую). Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.
    * Новые значения [настроек {{ KF }}](../concepts/settings-list.md#cluster-settings) в параметре:
        * `configSpec.kafka.kafkaConfig_2_1`, если используете {{ KF }} версии `2.1`;
        * `configSpec.kafka.kafkaConfig_2_6`, если используете {{ KF }} версии `2.6`;
        * `configSpec.kafka.kafkaConfig_2_8`, если используете {{ KF }} версии `2.8`.

{% endif %}

{% endlist %}

## Переместить кластер {#move-cluster}

{% list tabs %}

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [move](../api-ref/Cluster/move.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Идентификатор каталога назначения в параметре `destinationFolderId`.

{% endif %}

{% endlist %}

## Изменить группы безопасности {#change-sg-set}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Выберите кластер.
  1. В правом верхнем углу нажмите значок ![image](../../_assets/horizontal-ellipsis.svg), затем **Редактировать**.
  1. В блоке **Сетевые настройки** выберите группы безопасности для сетевого трафика кластера.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```
      {{ yc-mdb-kf }} cluster update --help
      ```

  1. Укажите нужные группы безопасности в команде изменения кластера:

      ```
      {{ yc-mdb-kf }} cluster update <имя кластера>
        --security-group-ids <список групп безопасности>
      ```

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Измените значение параметра `security_group_ids` в описании кластера:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя кластера>" {
          ...
          security_group_ids = [ <список идентификаторов групп безопасности кластера> ]
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера Terraform](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:
  - Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
  - Список групп в параметре `securityGroupIds`.
  - Список настроек, которые необходимо изменить, в параметре `updateMask`. Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}
