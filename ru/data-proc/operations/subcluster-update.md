---
title: "Как изменить подкластер в {{ dataproc-full-name }}"
description: "Следуя данной инструкции, вы сможете изменить подкластер." 
---

# Изменение подкластера

Для каждого созданного подкластера вы можете:

* [{#T}](#change-host-number).
* [{#T}](#change-resource-preset).
* [{#T}](#change-autoscaling-rule).
* [{#T}](#change-disk-size).
* [{#T}](#change-sg-set).

У подкластеров также можно изменить зону доступности. В этом случае они переносятся в другую зону доступности вместе с кластером {{ dataproc-name }}. Процесс зависит от типа кластера:

* [Миграция легковесного кластера в другую зону доступности](migration-to-an-availability-zone.md).
* [Миграция кластера с файловой системой HDFS в другую зону доступности](../tutorials/hdfs-cluster-migration.md).

## Изменить количество хостов {#change-host-number}

Вы можете изменить количество хостов в подкластерах для хранения и обработки данных:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного подкластера и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Введите или выберите нужное количество хостов в поле **{{ ui-key.yacloud.mdb.forms.base_field_hosts-count }}**.
    1. (Опционально) Укажите таймаут [декомиссии](../concepts/decommission.md).
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

    {{ dataproc-name }} запустит операцию добавления хостов.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить количество хостов для подкластера:

    1. Посмотрите описание команды CLI для изменения подкластера:

        ```bash
        {{ yc-dp }} subcluster update --help
        ```
    
    1. Укажите новое количество хостов в команде изменения подкластера:

        ```bash
        {{ yc-dp }} subcluster update <имя_или_идентификатор_подкластера> \
           --cluster-name=<имя_кластера> \
           --hosts-count=<количество_хостов>
        ```

        Идентификатор и имя подкластера можно получить со [списком подкластеров в кластере](subclusters.md#list-subclusters), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера {{ dataproc-name }} значение параметра `hosts_count` в блоке `subcluster_spec` соответствующего подкластера для хранения или обработки данных:

        ```hcl
        resource "yandex_dataproc_cluster" "data_cluster" {
          ...
          cluster_config {
            ...
            subcluster_spec {
              name        = "<имя_подкластера>"
              ...
              hosts_count = <число_хостов_в_подкластере>
            }
          }
        }
        ```

{% endlist %}

## Изменить класс хостов {#change-resource-preset}

{% include [dedicated-hosts-edit-restrictions](../../_includes/data-proc/note-vm-edit-restrictions.md) %}

Вы можете изменить вычислительную мощность хостов в отдельном подкластере. Она зависит от режима размещения драйвера:

{% include [subcluster-computing-nodes](../../_includes/data-proc/subcluster-computing-nodes.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы изменить [класс хостов](../concepts/instance-types.md) для подкластера:

    1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, в котором нужно изменить подкластер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}** и выберите нужный кластер.
    1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного подкластера и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Выберите нужную платформу и конфигурацию в блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}**.
    1. Укажите опциональный таймаут [декомиссии](../concepts/decommission.md).
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить [класс хостов](../concepts/instance-types.md) для подкластера:

    1. Посмотрите описание команды CLI для изменения подкластера:

        ```bash
        {{ yc-dp }} subcluster update --help
        ```

    1. Запросите список доступных классов хостов (в колонке `ZONE IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):

        ```bash
        {{ yc-dp }} resource-preset list
        ```

        Результат:

        ```text
        +-----------+--------------------------------+-------+----------+
        |    ID     |            ZONE IDS            | CORES |  MEMORY  |
        +-----------+--------------------------------+-------+----------+
        | b3-c1-m4  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 4.0 GB   |
        |           | {{ region-id }}-с                  |       |          |
        | ...                                                           |
        +-----------+--------------------------------+-------+----------+
        ```

    1. Укажите нужный класс в команде изменения подкластера:

        ```bash
        {{ yc-dp }} subcluster update <имя_или_идентификатор_подкластера> \
           --cluster-name=<имя_кластера> \
           --resource-preset=<класса_хоста>
        ```

        Идентификатор и имя подкластера можно получить со [списком подкластеров в кластере](subclusters.md#list-subclusters), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера {{ dataproc-name }} значение параметра `resource_preset_id` в блоке `subcluster_spec.resources` соответствующего подкластера:

        ```hcl
        resource "yandex_dataproc_cluster" data_cluster {
          ...
          cluster_config {
            ...
            subcluster_spec {
              name = "<имя_подкластера>"
              ...
              resources {
                resource_preset_id = "<класс_хостов_подкластера>"
              ...
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}

{{ dataproc-name }} запустит операцию изменения подкластера. При этом все хосты изменяемого подкластера будут перезапущены.

## Изменить правило автомасштабирования подкластеров для обработки данных {#change-autoscaling-rule}

Вы можете настроить правило [автомасштабирования](../concepts/autoscaling.md) в подкластерах для обработки данных.

Проверьте, что в облаке хватает квоты на увеличение ресурсов виртуальных машин. Откройте страницу [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) для вашего облака и проверьте, что в секции **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** не исчерпано место в строках:

* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.hddDisks.size }}**;
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.ssdDisks.size }}**;
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.disks.count }}**;
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.instanceCores.count }}**;
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.instances.count }}**.

Для работы автоматического масштабирования убедитесь, что сервисному аккаунту кластера {{ dataproc-name }} [назначены роли](../../iam/operations/sa/assign-role-for-sa.md):

{% include [sa-roles](../../_includes/data-proc/sa-roles.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы настроить автомасштабирование для подкластеров:

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Выберите кластер и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}**.
    1. Нажмите на значок ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) для нужного подкластера и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_scaling }}** включите настройку **{{ ui-key.yacloud.mdb.forms.label_autoscaling-activated }}**, если она выключена.
    1. Укажите параметры автоматического масштабирования.
    1. По умолчанию в качестве метрики для автоматического масштабирования используется `yarn.cluster.containersPending`. Чтобы включить масштабирование на основе загрузки CPU, выключите настройку **{{ ui-key.yacloud.compute.groups.create.field_default-utilization-target }}** и укажите целевой уровень загрузки CPU.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы настроить автомасштабирование для подкластеров:

    1. Посмотрите описание команды CLI для изменения подкластера:

        ```bash
        {{ yc-dp }} subcluster update --help
        ```

    1. Укажите параметры автомасштабирования в команде изменения подкластера:

        ```bash
        {{ yc-dp }} subcluster update <имя_или_идентификатор_подкластера> \
           --cluster-name=<имя_кластера> \
           --hosts-count=<минимальное_количество_хостов> \
           --max-hosts-count=<максимальное_количество_хостов> \
           --enable-preemptible=<использование_прерываемых_ВМ> \
           --warmup-duration=<время_на_разогрев_ВМ> \
           --stabilization-duration=<период_стабилизации> \
           --measurement-duration=<промежуток_измерения_нагрузки> \
           --cpu-utilization-target=<целевой_уровень_загрузки_CPU> \
           --autoscaling-decommission-timeout=<таймаут_декомиссии>
        ```

        Где:

        * `--hosts-count` — минимальное количество хостов (виртуальных машин) в подкластере. Минимальное значение — `1`, максимальное — `32`.
        * `--max-hosts-count` — максимальное количество хостов (виртуальных машин) в подкластере. Минимальное значение — `1`, максимальное — `100`.
        * `--enable-preemptible` — использование [прерываемых ВМ](../../compute/concepts/preemptible-vm.md). Может принимать значения `true` или `false`.
        * `--warmup-duration` — время в секундах на разогрев ВМ, в формате `<значение>s`. Минимальное значение — `0s`, максимальное — `600s` (10 минут).
        * `--stabilization-duration` — период в секундах, в течение которого требуемое количество ВМ не может быть снижено, в формате `<значение>s`. Минимальное значение — `60s` (1 минута), максимальное — `1800s` (30 минут).
        * `--measurement-duration` — период в секундах, за который замеры нагрузки усредняются для каждой ВМ, в формате `<значение>s`. Минимальное значение — `60s` (1 минута), максимальное — `600s` (10 минут).
        * `--cpu-utilization-target` — целевой уровень загрузки CPU, в процентах. Используйте эту настройку, чтобы включить [масштабирование](../concepts/autoscaling.md) на основе загрузки CPU, иначе в качестве метрики будет использоваться `yarn.cluster.containersPending` (на основе количества ожидающих задания ресурсов). Минимальное значение — `10`, максимальное — `100`.
        * `--autoscaling-decommission-timeout` — [таймаут декомиссии](../concepts/decommission.md) в секундах. Минимальное значение — `0`, максимальное — `86400` (сутки).

        Идентификатор и имя подкластера можно получить со [списком подкластеров в кластере](#list-subclusters), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list).

- {{ TF }} {#tf}

    Чтобы настроить автомасштабирование для подкластеров:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте в описании кластера {{ dataproc-name }} блок `subcluster_spec.autoscaling_config` с нужными вам параметрами автоматического масштабирования для соответствующего подкластера :

        ```hcl
        resource "yandex_dataproc_cluster" "data_cluster" {
          ...
          cluster_config {
            ...
            subcluster_spec {
              name = "<имя_подкластера>"
              role = "COMPUTENODE"
              ...
              autoscaling_config {
              max_hosts_count        = <максимальное_количество_ВМ_в_группе>
              measurement_duration   = <промежуток_измерения_нагрузки>
              warmup_duration        = <время_на_разогрев>
              stabilization_duration = <период_стабилизации>
              preemptible            = <использование_прерываемых_ВМ>
              cpu_utilization_target = <целевой_уровень_загрузки_vCPU>
              decommission_timeout   = <таймаут_декомиссии>
            }
          }
       ```

       Где:

       * `max_hosts_count` — максимальное количество хостов (виртуальных машин) в подкластере. Минимальное значение — `1`, максимальное — `100`.
       * `measurement_duration` — период в секундах, за который замеры нагрузки усредняются для каждой ВМ, в формате `<значение>s`. Минимальное значение — `60s` (1 минута), максимальное — `600s` (10 минут).
       * `warmup_duration` — время в секундах на разогрев ВМ, в формате `<значение>s`. Минимальное значение — `0s`, максимальное — `600s` (10 минут).
       * `stabilization_duration` — период в секундах, в течение которого требуемое количество ВМ не может быть снижено, в формате `<значение>s`. Минимальное значение — `60s` (1 минута), максимальное — `1800s` (30 минут).
       * `preemptible` — использование [прерываемых ВМ](../../compute/concepts/preemptible-vm.md). Может принимать значения `true` или `false`.
       * `cpu_utilization_target` — целевой уровень загрузки CPU, в процентах. Используйте эту настройку, чтобы включить [масштабирование](../concepts/autoscaling.md) на основе загрузки CPU, иначе в качестве метрики будет использоваться `yarn.cluster.containersPending` (на основе количества ожидающих задания ресурсов). Минимальное значение — `10`, максимальное — `100`.
       * `decommission_timeout` — [таймаут декомиссии](../concepts/decommission.md) в секундах. Минимальное значение — `0`, максимальное — `86400` (сутки).

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}

## Увеличить размер хранилища {#change-disk-size}

{% include [dedicated-hosts-edit-restrictions](../../_includes/data-proc/note-vm-edit-restrictions.md) %}

Вы можете увеличить размер хранилища, доступного каждому хосту в определенном подкластере.

{% note info %}

Уменьшить размер хранилища на данный момент невозможно. Если это необходимо, пересоздайте подкластер {{ dataproc-name }}.

{% endnote %}

Проверьте, что в облаке хватает квоты на увеличение ресурсов виртуальных машин. Откройте страницу [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) для вашего облака и проверьте, что в секции **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** не исчерпано место в строках:

* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.hddDisks.size }}**;
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.ssdDisks.size }}**;
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.disks.count }}**.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить размер хранилища для подкластера:

    1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, в котором нужно изменить подкластер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}** и выберите нужный кластер.
    1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного подкластера и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Введите или выберите нужный объем хранилища в блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

    {{ dataproc-name }} запустит операцию изменения подкластера.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить размер хранилища для подкластера:

    1. Посмотрите описание команды CLI для изменения подкластера:

        ```bash
        {{ yc-dp }} subcluster update --help
        ```

    1. Укажите нужный объем хранилища в команде изменения подкластера:

        ```bash
        {{ yc-dp }} subcluster update <имя_или_идентификатор_подкластера> \
           --cluster-name=<имя_кластера> \
           --disk-size=<размер_хранилища_ГБ>
        ```

        Идентификатор и имя подкластера можно получить со [списком подкластеров в кластере](#list-subclusters), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list).

    Если все условия выполнены, {{ dataproc-name }} запустит операцию по увеличению объема хранилища.

- {{ TF }} {#tf}

    Чтобы увеличить размер хранилища для подкластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера {{ dataproc-name }} значение параметра `disk_size` в блоке `subcluster_spec.resources` соответствующего подкластера:

        ```hcl
        resource "yandex_dataproc_cluster" "data_cluster" {
          ...
          cluster_config {
            ...
            subcluster_spec {
              name = "<имя_подкластера>"
              ...
              resources {
                disk_size = <объем_хранилища_ГБ>
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

    Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}

## Изменить группы безопасности {#change-sg-set}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.
    1. Нажмите на имя нужного хоста.
    1. В блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
    1. Выберите нужные группы безопасности.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените значение параметра `security_group_ids` в описании кластера:

        ```hcl
        resource "yandex_dataproc_cluster" "data_cluster" {
          ...
          security_group_ids = [ "<список_идентификаторов_групп_безопасности_кластера>" ]
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](./connect.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}
