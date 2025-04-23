---
title: Как изменить конфигурацию кластера {{ GP }} в {{ mgp-full-name }}
description: Следуя данной инструкции, вы сможете изменить конфигурацию кластера {{ GP }}.
---

# Изменение конфигурации кластера {{ GP }}


После создания кластера вы можете:

* [Изменить класс хостов](#change-resource-preset).
* [Изменить тип диска и увеличить размер хранилища](#change-disk-size).
* [Расширить кластер](#add-hosts): добавить хосты-сегменты или увеличить количество сегментов на хост.
* [Изменить зону доступности кластера](#change-cluster-zone).

## Изменить класс хостов {#change-resource-preset}

Вы можете изменить класс как хостов-мастеров, так и хостов-сегментов. При смене класса хостов в кластере сменится первичный хост-мастер.

{% include [warn-preset-change](../../_includes/mdb/mgp/warn-preset-change.md) %}

При изменении класса хостов-сегментов убедитесь, что нового объема памяти в хостах-сегментах достаточно для поддержания количества подключений, указанного в настройке [Max connections](../concepts/settings-list.md#setting-max-connections).

Рекомендуется изменять класс хостов только во время отсутствия рабочей нагрузки на кластер.

{% include [note-change-resource-preset](../../_includes/mdb/note-change-resource-preset.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите нужный класс для хостов-мастеров или хостов-сегментов {{ GP }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Запросите список доступных классов (в колонке `ZONE IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):
     * для хостов-мастеров:

        ```bash
        {{ yc-mdb-gp }} resource-preset list master
        ```

     * для хостов-сегментов:

        ```bash
        {{ yc-mdb-gp }} resource-preset list segment
        ```

     
     ```text
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     |     ID      |            ZONE IDS            |           DISK TYPES           | CORES |  MEMORY  | HOST COUNT DIVIDER | MAX SEGMENT IN HOST |
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     | i2.2xlarge  | {{ region-id }}-a, {{ region-id }}-b   | local-ssd,                     |    16 | 128.0 GB |                  1 |                   0 |
     |             |                                | network-ssd-nonreplicated      |       |          |                    |                     |
     | ...                                                                                                                                         |
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     ```


  1. Укажите нужные классы в команде изменения кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update <имя_или_идентификатор_кластера> \
          --master-config resource-id=<идентификатор_класса_хостов-мастеров> \
          --segment-config resource-id=<идентификатор_класса_хостов-сегментов>
      ```

      {{ mgp-short-name }} запустит операцию изменения класса хостов для кластера.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mgp-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mgp }}).

  1. Измените в описании кластера {{ mgp-name }} значение атрибута `resource_preset_id` в блоке `master_subcluster.resources` или `segment_subcluster.resources`:

      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
        ...
        master_subcluster {
          resources {
            resource_preset_id = "<класс_хоста>"
            ...
          }
        }
        segment_subcluster {
          resources {
            resource_preset_id = "<класс_хоста>"
            ...
          }
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "masterConfig.resources.resourcePresetId,segmentConfig.resources.resourcePresetId",
                      "masterConfig": {
                        "resources": {
                          "resourcePresetId": "<класс_хостов>"
                        }
                      },
                      "segmentConfig": {
                        "resources": {
                          "resourcePresetId": "<класс_хостов>"
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `masterConfig.resources.resourcePresetId`, `segmentConfig.resources.resourcePresetId` — новый [класс хостов](../concepts/instance-types.md) для хостов-мастеров и хостов-сегментов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ 
                      "master_config.resources.resource_preset_id",
                      "segment_config.resources.resource_preset_id"
                    ]
                  },
                  "master_config": {
                    "resources": {
                      "resource_preset_id": "<класс_хостов>"
                    }
                  },
                  "segment_config": {
                    "resources": {
                      "resource_preset_id": "<класс_хостов>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `master_config.resources.resource_preset_id`, `segment_config.resources.resource_preset_id` — новый [класс хостов](../concepts/instance-types.md) для хостов-мастеров и хостов-сегментов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить тип диска и увеличить размер хранилища {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% include [warn-disk-size-increase](../../_includes/mdb/mgp/warn-disk-size-change.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Выберите нужный кластер.
  1. В верхней части страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}**:

      * Выберите [тип диска](../concepts/storage.md).
      * Укажите нужный размер диска.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы увеличить размер хранилища для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Укажите нужный размер хранилища для хостов-мастеров или хостов-сегментов в команде изменения кластера (размер хранилища должен быть не меньше, чем значение `disk_size` в свойствах кластера):

      ```bash
      {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера> \
         --master-config disk-size <размер_хранилища_в_гигабайтах> \
         --segment-config disk-size <размер_хранилища_в_гигабайтах>
      ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mgp-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mgp }}).

    1. Измените в описании кластера {{ mgp-name }} значения атрибутов `disk_type_id` и `disk_size` в блоке `master_subcluster.resources` или `segment_subcluster.resources`:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
          ...
          master_subcluster {
            resources {
              disk_type_id = "<тип_диска>"
              disk_size    = <размер_хранилища_в_гигабайтах>
              ...
            }
          }
          segment_subcluster {
            resources {
              disk_type_id = "<тип_диска>"
              disk_size    = <размер_хранилища_в_гигабайтах>
              ...
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "masterConfig.resources.diskTypeId,masterConfig.resources.diskSize,segmentConfig.resources.diskTypeId,segmentConfig.resources.diskSize",
                      "masterConfig": {
                        "resources": {
                          "diskTypeId": "<тип_диска>",
                          "diskSize": "<размер_хранилища_в_байтах>"
                        }
                      },
                      "segmentConfig": {
                        "resources": {
                          "diskTypeId": "<тип_диска>",
                          "diskSize": "<размер_хранилища_в_байтах>"
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `masterConfig.resources`, `segmentConfig.resources` — параметры хранилища для хостов-мастеров и хостов-сегментов:

            * `diskTypeId` — [тип диска](../concepts/storage.md).
            * `diskSize` — новый размер хранилища в байтах.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ 
                      "master_config.resources.disk_type_id",
                      "master_config.resources.disk_size",
                      "segment_config.resources.disk_type_id",
                      "segment_config.resources.disk_size"
                    ]
                  },
                  "master_config": {
                    "resources": {
                      "disk_type_id": "<тип_диска>",
                      "disk_size": "<размер_хранилища_в_байтах>"
                    }
                  },
                  "segment_config": {
                    "resources": {
                      "disk_type_id": "<тип_диска>",
                      "disk_size": "<размер_хранилища_в_байтах>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `master_config.resources`, `segment_config.resources` — параметры хранилища для хостов-мастеров и хостов-сегментов:

            * `disk_type_id` — [тип диска](../concepts/storage.md).
            * `disk_size` — новый размер хранилища в байтах.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Расширить кластер {#add-hosts}

Вы можете добавить хосты-сегменты в кластер {{ mgp-name }}, выполнив процедуру [расширения кластера](cluster-expand.md). Количество добавляемых хостов не может быть меньше двух. Вы также можете увеличить [количество сегментов на хост](../concepts/index.md) при расширении кластера.

## Изменить зону доступности кластера {#change-cluster-zone}

Все хосты кластера {{ mgp-name }} располагаются в одной [зоне доступности](../../overview/concepts/geo-scope.md) {{ yandex-cloud }}. Перенести кластер в другую зону доступности нельзя. При необходимости сменить зону доступности [восстановите кластер из резервной копии](cluster-backups.md#restore). При восстановлении из резервной копии укажите новую зону доступности в настройках нового кластера.

{% include [zone-d-disk-restrictions](../../_includes/mdb/ru-central1-d-local-ssd.md) %}


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
