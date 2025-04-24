---
title: Управление дисковым пространством в кластере {{ mkf-name }}
description: Вы можете отслеживать степень заполнения хранилища и увеличивать его размер вручную или автоматически.
---

# Управление дисковым пространством в кластере {{ mkf-name }}

Когда [хранилище](../concepts/storage.md) заполнено на 97% или больше, хост автоматически переходит в режим read-only. Чтобы избежать проблем с операциями записи в топик, воспользуйтесь одним из способов:


* [Настройте алерты в {{ monitoring-full-name }}](#set-alert), чтобы отслеживать степень заполнения хранилища.


* [Увеличьте размер хранилища](#change-disk-size), чтобы снять режим read-only автоматически.
* [Настройте автоматическое увеличение размера хранилища](#disk-size-autoscale), чтобы предотвратить ситуации, когда место на диске заканчивается и хост переходит в режим read-only.


## Настроить алерты в {{ monitoring-full-name }} {#set-alert}

1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. [Создайте канал уведомлений](../../monitoring/operations/alert/create-channel.md).
1. [Создайте алерт](../../monitoring/operations/alert/create-alert.md) со следующими параметрами:

    1. **{{ ui-key.yacloud_monitoring.alert.section_metrics }}** — задайте параметры метрики:

        * Облако.
        * Каталог.
        * Сервис **{{ ui-key.yacloud_monitoring.services.label_managed-kafka }}**.
        * Идентификатор кластера {{ mkf-name }}.

            Идентификатор можно [получить со списком кластеров в каталоге](../operations/cluster-list.md#list-clusters).

        * Метка `disk.free_bytes`.

    1. **{{ ui-key.yacloud_monitoring.alert.title_conditions }}** — задайте условие для заполнения свободного дискового пространства, при котором сработает алерт:

        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.min }}` (минимальное значение метрики за период).
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}`.
        * **{{ ui-key.yacloud_monitoring.alert.status_warn }}** — `95` (95% от размера хранилища).
        * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}** — `90` (90% от размера хранилища).
        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** — желаемый период, с которым будет обновляться значение метрики.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.time-shift }}** — предпочтительный сдвиг по времени назад в секундах. Позволяет исключить срабатывания алерта, когда в нем указано несколько метрик и они собираются с разным интервалом. Подробнее о задержке вычисления см. в [документации {{ monitoring-full-name }}](../../monitoring/concepts/alerting/alert.md#evaluation-delay).

    1. **Уведомления** — добавьте созданный ранее канал уведомлений.


## Увеличить размер хранилища {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

* Консоль управления {#console}

    Чтобы увеличить размер хранилища для кластера:

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. В строке с нужным кластером нажмите ![image](../../_assets/console-icons/ellipsis.svg), затем выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Измените настройки в блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}**.

        Тип диска для кластера {{ KF }} нельзя изменить после создания.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

* CLI {#cli}

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

    Тип диска для кластера {{ KF }} нельзя изменить после создания.

* {{ TF }} {#tf}

  Чтобы увеличить размер хранилища для кластера:

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

        Тип диска для кластера {{ KF }} нельзя изменить после создания.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

* REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.kafka.resources.diskSize,configSpec.zookeeper.resources.diskSize",
                      "configSpec": {
                        "kafka": {
                          "resources": {
                            "diskSize": "<размер_хранилища_байт>"
                          }
                        },
                        "zookeeper": {
                          "resources": {
                            "diskSize": "<размер_хранилища_байт>"
                          }
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:
            * `configSpec.kafka.resources.diskSize` — если нужно изменить размер хранилища хостов-брокеров.
            * `configSpec.zookeeper.resources.diskSize` — если нужно изменить размер хранилища хостов {{ ZK }}. Применяется только для кластеров с версией {{ KF }} 3.5.
        * `configSpec.kafka.resources.diskSize` – размер хранилища хостов-брокеров в байтах.
        * `configSpec.zookeeper.resources.diskSize` — размер хранилища хостов {{ ZK }} в байтах. Применяется только для кластеров с версией {{ KF }} 3.5.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#responses).

* gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

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
                      "config_spec.kafka.resources.disk_size",
                      "config_spec.zookeeper.resources.disk_size"
                    ]
                  },
                  "config_spec": {
                    "kafka": {
                      "resources": {
                        "disk_size": "<размер_хранилища_байт>"
                      }
                    },
                    "zookeeper": {
                      "resources": {
                        "disk_size": "<размер_хранилища_байт>"
                      }
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:
            * `config_spec.kafka.resources.disk_size` — если нужно изменить размер хранилища хостов-брокеров.
            * `config_spec.brokers_count` — если нужно изменить размер хранилища хостов {{ ZK }}. Применяется только для кластеров с версией {{ KF }} 3.5.
        * `config_spec.kafka.resources.disk_size` — размер хранилища хостов-брокеров в байтах.
        * `config_spec.zookeeper.resources.disk_size` — размер хранилища хостов {{ ZK }} в байтах. Применяется только для кластеров с версией {{ KF }} 3.5.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Настроить автоматическое увеличение размера хранилища {#disk-size-autoscale}

Чтобы место на диске кластера не заканчивалось и хосты не переходили в режим read-only, настройте [автоматическое увеличение размера хранилища](../concepts/storage.md#auto-rescale).

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}


{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


{% list tabs group=instructions %}

* Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}** задайте [пороги заполненности](../concepts/storage.md#auto-rescale) хранилища, при достижении которых его размер будет увеличиваться: 
    
        {% include [autoscale-settings](../../_includes/mdb/mkf/autoscale-settings.md) %}        

* CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы настроить автоматическое увеличение размера хранилища:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Укажите максимальный размер хранилища и условия для его увеличения в команде изменения кластера:

        ```bash
        {{ yc-mdb-kf }} cluster update <идентификатор_или_имя_кластера> \
           --disk-size-autoscaling planned-usage-threshold=<процент_для_планового_увеличения>,`
                                  `emergency-usage-threshold=<процент_для_незамедлительного_увеличения>,`
                                  `disk-size-limit=<максимальный_размер_хранилища_в_байтах>
        ```

        {% include [description-of-parameters](../../_includes/mdb/mkf/disk-auto-scaling.md) %}

* REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.diskSizeAutoscaling.plannedUsageThreshold,configSpec.diskSizeAutoscaling.plannedUsageThreshold,configSpec.diskSizeAutoscaling.plannedUsageThreshold",
                      "configSpec": {
                        "diskSizeAutoscaling": {
                          "plannedUsageThreshold": "<процент_для_планового_увеличения>",
                          "emergencyUsageThreshold": "<процент_для_незамедлительного_увеличения>",
                          "diskSizeLimit": "<максимальный_размер_хранилища_в_байтах>"
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:
            * `configSpec.diskSizeAutoscaling.plannedUsageThreshold` — если нужно изменить процент заполнения хранилища для его планового увеличения.
            * `configSpec.diskSizeAutoscaling.emergencyUsageThreshold` — если нужно изменить процент заполнения хранилища для его внепланового увеличения.
            * `configSpec.diskSizeAutoscaling.diskSizeLimit` — если нужно изменить максимальный размер хранилища при его автоматическом расширении.

        {% include [autoscale-settings](../../_includes/mdb/mkf/api/rest-autoscale-settings.md) %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#responses).

* gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

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
                      "config_spec.disk_size_autoscaling.planned_usage_threshold",
                      "config_spec.disk_size_autoscaling.emergency_usage_threshold",
                      "config_spec.disk_size_autoscaling.disk_size_limit"
                    ]
                  },
                  "config_spec": {
                    "disk_size_autoscaling": {
                        "planned_usage_threshold": "<процент_для_планового_увеличения>",
                        "emergency_usage_threshold": "<процент_для_незамедлительного_увеличения>",
                        "disk_size_limit": "<максимальный_размер_хранилища_в_байтах>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:
            * `config_spec.disk_size_autoscaling.planned_usage_threshold` — если нужно изменить процент заполнения хранилища для его планового увеличения.
            * `config_spec.disk_size_autoscaling.emergency_usage_threshold` — если нужно изменить процент заполнения хранилища для его внепланового увеличения.
            * `config_spec.disk_size_autoscaling.disk_size_limit` — если нужно изменить максимальный размер хранилища при его автоматическом расширении.

        {% include [autoscale-settings](../../_includes/mdb/mkf/api/grpc-autoscale-settings.md) %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [storage-resize-steps](../../_includes/mdb/mkf/storage-resize-steps.md) %}


{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}

