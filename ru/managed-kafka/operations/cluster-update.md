# Изменение настроек кластера


После создания кластера {{ KF }} вы можете:

* [{#T}](#change-resource-preset).
* [{#T}](#change-disk-size) (доступно только для стандартного `network-hdd` и быстрого сетевого `network-ssd` хранилищ).
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

  1. Перейдите на страницу каталога и выберите сервис **{{ mkf-name }}**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. Измените требуемые настройки:
     * Чтобы изменить класс [хостов-брокеров](../concepts/brokers.md), выберите новый [класс хостов](../concepts/instance-types.md) в соответствующем блоке.
     * Чтобы изменить количество хостов-брокеров в каждой из зон доступности, которые были выбраны при [создании кластера](cluster-create.md#create-cluster), задайте значение соответствующей настройки.

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

    Чтобы изменить [класс и количество хостов](../concepts/instance-types.md) для кластера:

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


- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Список настроек, которые необходимо изменить, в параметре `updateMask` (одной строкой через запятую). Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.
  * Новую конфигурацию кластера в параметре `configSpec`.

{% endlist %}

## Изменить настройки хранилища {#change-disk-size}

{% note warning %}

На данный момент тип диска для кластера {{ KF }} нельзя изменить после создания.

{% endnote %}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mkf-name }}**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. Измените размер хранилища в соответствующем блоке.
  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить настройки хранилища для хостов:
  
  1. Проверьте, что нужный кластер использует именно стандартное или быстрое сетевое хранилище (увеличить размер локального или нереплицируемого сетевого хранилища невозможно). Для этого запросите информацию о кластере и найдите поле `disk_type_id` — его значение должно быть `network-hdd` или `network-ssd`:

     ```
     {{ yc-mdb-kf }} cluster list
     {{ yc-mdb-kf }} cluster get <имя или идентификатор кластера>
     ```

  1. Посмотрите описание команды CLI для изменения кластера:

     ```
     {{ yc-mdb-kf }} cluster update --help
     ```
 
  1. Чтобы изменить размер дисков хостов-брокеров, выполните команду:
  
     ```
     {{ yc-mdb-kf }} cluster update <имя или идентификатор кластера> --disk-size <размер диска>
     ```
     
     Если не указаны единицы размера, то используются гигабайты.

  1. Чтобы изменить размер дисков хостов {{ ZK }}, выполните команду:

     ```
     {{ yc-mdb-kf }} cluster update <имя или идентификатор кластера> \
     --zookeeper-disk-size <размер диска>
     ```
     
     Если не указаны единицы размера, то используются гигабайты.

- Terraform

    Чтобы увеличить размер хранилища для кластера:

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


- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Список настроек, которые необходимо изменить, в параметре `updateMask` (одной строкой через запятую). Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.
  * Новую конфигурацию кластера в параметре `configSpec`.

{% endlist %}

## Изменить настройки {{ KF }} {#change-kafka-settings}

{% list tabs %}

- Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ mkf-name }}**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. Измените настройки {{ KF }}, нажав кнопку **Настроить** в блоке **Настройки Kafka**.

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
        {{ yc-mdb-kf }} cluster update <имя кластера> \
           --compression-type <тип сжатия> \
           --log-flush-interval-messages <количество сообщений в логе, необходимое для их сброса на диск> \
           --log-flush-interval-ms <максимальное время хранения сообщений в памяти перед сбросом на диск>
        ```

- Terraform

    Чтобы изменить [настройки кластера](../concepts/settings-list.md#cluster-settings):

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Измените в описании кластера {{ mkf-name }} значения параметров в блоке `kafka.kafka_config` (в примере приведены не все настройки):

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

    2. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    3. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера Terraform](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).


- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Список настроек, которые необходимо изменить, в параметре `updateMask` (одной строкой через запятую). Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.
    * Новые значения [настроек {{ KF }}](../concepts/settings-list.md#cluster-settings) в параметре:
        * `configSpec.kafka.kafkaConfig_2_1`, если используете {{ KF }} версии `2.1`;
        * `configSpec.kafka.kafkaConfig_2_6`, если используете {{ KF }} версии `2.6`.

{% endlist %}

## Переместить кластер {#move-cluster}

{% list tabs %}


- API

  Чтобы переместить кластер из текущего каталога в другой, воспользуйтесь методом API [move](../api-ref/Cluster/move.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Идентификатор каталога назначения в параметре `destinationFolderId`.

{% endlist %}

## Изменить группы безопасности {#change-sg-set}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mkf-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В блоке **Сетевые настройки** выберите группы безопасности для сетевого трафика кластера.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```
      $ {{ yc-mdb-kf }} cluster update --help
      ```

  1. Укажите нужные группы безопасности в команде изменения кластера:

      ```
      $ {{ yc-mdb-kf }} cluster update <имя кластера>
           --security-group-ids <список групп безопасности>
      ```

- Terraform

    Для изменения групп безопасности кластера:

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

  Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) кластера, воспользуйтесь методом API `update` и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
  * Список групп в параметре `securityGroupIds`.
  * Список настроек, которые необходимо изменить, в параметре `updateMask`. Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}
