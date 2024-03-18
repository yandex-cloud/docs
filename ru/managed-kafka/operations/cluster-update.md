---
title: "Как изменить настройки кластера {{ KF }} в {{ mkf-full-name }}"
description: "Следуя данной инструкции, вы сможете изменить настройки кластера {{ KF }}." 
---

# Изменение настроек кластера {{ KF }}

После создания кластера {{ mkf-name }} вы можете:

* [{#T}](#change-brokers).
* [{#T}](#change-zookeeper).
* [{#T}](#change-disk-size) (недоступно для [хранилища](../concepts/storage.md) на нереплицируемых SSD-дисках).
* [{#T}](#change-additional-settings).
* [{#T}](#change-kafka-settings).
* [{#T}](#move-cluster) из текущего каталога в другой каталог.
* [{#T}](#change-sg-set).

Если вы хотите переместить кластер в другую зону доступности, обратитесь к [инструкции](host-migration.md). В результате вы перенесете хосты кластера.

## Изменить класс и количество хостов-брокеров {#change-brokers}

Увеличить количество хостов-брокеров {{ KF }} можно, только если кластер содержит не менее двух хостов-брокеров в разных зонах доступности. Уменьшить количество хостов-брокеров нельзя. Для выполнения [условий отказоустойчивости](../concepts/index.md#fault-tolerance) кластера необходимо минимум три хоста-брокера.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. Измените требуемые настройки:
     * Чтобы изменить класс [хостов-брокеров](../concepts/brokers.md), выберите новый [**{{ ui-key.yacloud.mdb.forms.section_resource }}**](../concepts/instance-types.md).
     * Измените **{{ ui-key.yacloud.kafka.label_brokers-per-az }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить класс и количество хостов:
  
  1. Получите информацию о кластере:

     ```bash
     {{ yc-mdb-kf }} cluster list
     {{ yc-mdb-kf }} cluster get <имя_или_идентификатор_кластера>
     ```

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-kf }} cluster update --help
     ```

  1. Чтобы увеличить количество хостов-брокеров, выполните команду:
  
     ```bash
     {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> --brokers-count <число>
     ```

  1. Чтобы изменить класс хоста-брокера, выполните команду:

     ```bash
     {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> --resource-preset <класс_хоста>
     ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера {{ mkf-name }} значение параметра `brokers_count`, чтобы увеличить количество хостов-брокеров:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          config {
            brokers_count = <количество_хостов-брокеров>
            ...
          }
          ...
        }
        ```

    1. Измените в описании кластера {{ mkf-name }} значение параметра `resource_preset_id` в блоке `kafka.resources`, чтобы задать новый класс хостов-брокеров:

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

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API {#api}

  Чтобы изменить класс и количество хостов-брокеров, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Класс хостов-брокеров в параметре `configSpec.kafka.resources.resourcePresetId`.
  * Количество хостов-брокеров в параметре `configSpec.brokersCount`.
  * Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить класс хостов {{ ZK }} {#change-zookeeper}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. Выберите новый [**{{ ui-key.yacloud.kafka.section_zookeeper-resources }}**](../concepts/instance-types.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить класс хостов {{ ZK }}:
  
  1. Получите информацию о кластере:

     ```bash
     {{ yc-mdb-kf }} cluster list
     {{ yc-mdb-kf }} cluster get <имя_или_идентификатор_кластера>
     ```

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-kf }} cluster update --help
     ```

  1. Чтобы изменить класс хостов {{ ZK }}, выполните команду:

     ```bash
     {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
       --zookeeper-resource-preset <класс_хоста>
     ```

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера {{ mkf-name }} значение параметра `resource_preset_id` в блоке `zookeeper.resources`, чтобы задать новый класс хостов {{ ZK }}:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          zookeeper {
            resources {
              resource_preset_id = "<класс_хостов_{{ ZK }}>"
              ...
            }
          }
         }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API {#api}

  Чтобы изменить класс хостов {{ ZK }}, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Класс хостов {{ ZK }} в параметре `configSpec.zookeeper.resources.resourcePresetId`.
  * Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Увеличить размер хранилища {#change-disk-size}

{% note warning %}

Тип диска для кластера {{ KF }} нельзя изменить после создания.

{% endnote %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы увеличить размер хранилища для кластера:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. Измените настройки в блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы увеличить размер хранилища для хостов:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-kf }} cluster update --help
     ```

  1. Чтобы изменить объем хранилища хостов-брокеров, выполните команду:
  
     ```bash
     {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
       --disk-size <объем_хранилища>
     ```

     Если не указаны единицы размера, то используются гигабайты.

  1. Чтобы изменить объем хранилища хостов {{ ZK }}, выполните команду:

     ```bash
     {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
       --zookeeper-disk-size <размер_диска>
     ```

     Если не указаны единицы размера, то используются гигабайты.

- {{ TF }} {#tf}

  Чтобы увеличить размер хранилища для кластера

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера {{ mkf-name }} значение параметра `disk_size` в блоках `kafka.resources` и `zookeeper.resources` для хостов {{ KF }} и {{ ZK }} соответственно:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          kafka {
            resources {
              disk_size = <размер_хранилища_ГБ>
              ...
            }
            ...
          }
          zookeeper {
            resources {
              disk_size = <размер_хранилища_ГБ>
              ...
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API {#api}

  Чтобы увеличить размер хранилища для кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Новые настройки хранилища в параметре `configSpec.kafka.resources` (`configSpec.zookeeper.resources` — для хостов {{ ZK }}).
  * Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}


## Изменить настройки групп безопасности и публичного доступа {#change-sg-set}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите группы безопасности для сетевого трафика кластера.
  1. Установите или отключите публичный доступ к кластеру при помощи опции **Публичный доступ**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

  [Перезагрузите кластер](./cluster-stop.md), чтобы изменение настройки публичного доступа вступило в силу.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

  1. Укажите нужные группы безопасности и настройку публичного доступа в команде изменения кластера:

      ```bash
      {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
         --security-group-ids <список_групп_безопасности> \
         --assign-public-ip=<публичный_доступ>
      ```

      Где:

      * `--security-group-ids` — список идентификаторов групп безопасности кластера.
      * `--assign-public-ip` — публичный доступ к кластеру: `true` или `false`.

  [Перезагрузите кластер](./cluster-stop.md), чтобы изменение настройки публичного доступа вступило в силу.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените значения параметров `security_group_ids` и `assign_public_ip` в описании кластера:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          security_group_ids = [ <список_групп_безопасности> ]
          ...
          config {
            assign_public_ip = "<публичный_доступ>"
            ...
            }
        }
        ```

        Где:
        * `security_group_ids` — список идентификаторов групп безопасности кластера.
        * `assign_public_ip` — публичный доступ к кластеру: `true` или `false`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    [Перезагрузите кластер](./cluster-stop.md), чтобы изменение настройки публичного доступа вступило в силу.

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API {#api}

  Чтобы изменить настройки групп безопасности и публичного доступа, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

  - Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
  - Список идентификаторов групп безопасности в параметре `securityGroupIds`.
  - Значение настройки публичного доступа в параметре `configSpec.assignPublicIp`.
  - Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

  [Перезагрузите кластер](./cluster-stop.md), чтобы изменение настройки публичного доступа вступило в силу.

{% endlist %}

Для подключения к кластеру может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups).


## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. Измените дополнительные настройки кластера:

     {% include [extra-settings](../../_includes/mdb/mkf/extra-settings.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
           --maintenance-window type=<тип_технического_обслуживания>,`
                               `day=<день_недели>,`
                               `hour=<час_дня> \
           --datatransfer-access=<доступ_к_кластеру> \
           --deletion-protection=<защита_от_удаления> \
           --schema-registry=<управление_схемами_данных>
        ```

    Вы можете изменить следующие настройки:

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * {% include [datatransfer access](../../_includes/mdb/cli/datatransfer-access-update.md) %}

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Deletion protection](../../_includes/mdb/deletion-protection-limits-data.md) %}

    * `--schema-registry` – включите эту опцию, чтобы управлять схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md).

        {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

    1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          deletion_protection = <защита_от_удаления>
        }
        ```

        {% include [Deletion protection](../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. Чтобы включить управление схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md), добавьте к описанию кластера поле `config.schema_registry` со значением `true`:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя кластера>" {
          ...
          config {
            ...
            schema_registry  = <управление_схемами_данных>
          }
        }
        ```

        {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mkf }}).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API {#api}

    Чтобы изменить дополнительные настройки кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).

    * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.

    * Настройки доступа к кластеру из сервиса [{{ data-transfer-full-name }}](../../data-transfer/) в Serverless-режиме в параметре `configSpec.access.dataTransfer`.

        Это позволит через специальную сеть подключаться к {{ data-transfer-full-name }}, запущенному в {{ k8s }}. В результате будут быстрее выполняться, например, запуск и деактивация трансфера.

    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Deletion protection](../../_includes/mdb/deletion-protection-limits-data.md) %}

    * Настройки управления схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md) в параметре `configSpec.schemaRegistry`.

        {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

    * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить настройки {{ KF }} {#change-kafka-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings-kafka }}** нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.

     Подробнее см. в разделе [Настройки {{ KF }}](../concepts/settings-list.md).

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить настройки {{ KF }}:

    1. Посмотрите описание команды CLI для изменения настроек кластера:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Измените [настройки {{ KF }}](../concepts/settings-list.md#cluster-settings) в команде изменения кластера (в примере приведены не все настройки):

        ```bash
        {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
           --compression-type <тип_сжатия> \
           --log-flush-interval-messages <количество_сообщений_в_логе> \
           --log-flush-interval-ms <максимальное_время_хранения_сообщений>
        ```

        Где:

        * `--log-flush-interval-messages` — количество сообщений в логе, необходимое для их сброса на диск.
        * `--log-flush-interval-ms` — максимальное время хранения сообщений в памяти перед сбросом на диск.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера {{ mkf-name }} значения параметров в блоке `kafka.kafka_config` (в примере приведены не все [настройки](../concepts/settings-list.md#cluster-settings)):

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

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API {#api}

    Чтобы изменить настройки {{ KF }}, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

    * Новые значения [настроек {{ KF }}](../concepts/settings-list.md#cluster-settings) в параметре:
        * `configSpec.kafka.kafkaConfig_2_8`, если используете {{ KF }} версии `2.8`;
        * `configSpec.kafka.kafkaConfig_3`, если используете {{ KF }} версий `3.x`.

    * Список настроек, которые необходимо изменить, в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Переместить кластер {#move-cluster}

{% list tabs group=instructions %}


- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы переместить кластер:

    1. Посмотрите описание команды CLI для перемещения кластера:

        ```bash
        {{ yc-mdb-kf }} cluster move --help
        ```

    1. Укажите каталог назначения в команде перемещения кластера:

        ```bash
        {{ yc-mdb-kf }} cluster move <идентификатор_кластера> \
           --destination-folder-name=<имя_каталога_назначения>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

  Чтобы переместить кластер, воспользуйтесь методом REST API [move](../api-ref/Cluster/move.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Move](../api-ref/grpc/cluster_service.md#Move) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Идентификатор каталога назначения в параметре `destinationFolderId`.

{% endlist %}


## Изменить группы безопасности {#change-sg-set}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите группы безопасности для сетевого трафика кластера.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

  1. Укажите нужные группы безопасности в команде изменения кластера:

      ```bash
      {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
         --security-group-ids <список_групп_безопасности>
      ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените значение параметра `security_group_ids` в описании кластера:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          security_group_ids = [ <список_групп_безопасности> ]
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API {#api}

  Чтобы изменить группы безопасности, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

  - Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
  - Список идентификаторов групп безопасности в параметре `securityGroupIds`.
  - Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для подключения к кластеру.

