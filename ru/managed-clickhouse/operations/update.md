---
title: Как изменить настройки кластера {{ CH }} в {{ mch-full-name }}
description: Следуя данной инструкции, вы сможете изменить настройки кластера {{ CH }}.
---

# Изменение настроек кластера {{ CH }}

После создания кластера вы можете:

* [Изменить настройки сервисного аккаунта](#change-service-account).
* [Изменить класс хостов](#change-resource-preset).
* [Увеличить размер хранилища](#change-disk-size).
* [Включить управление пользователями и базами данных через SQL](#SQL-management).
* [Изменить дополнительные настройки кластера](#change-additional-settings).
* [Переместить кластер](#move-cluster) в другой каталог.
* [Изменить группы безопасности кластера](#change-sg-set).
* [Изменить настройки гибридного хранилища](#change-hybrid-storage).

Подробнее о других изменениях кластера:

* [Перенос кластера в другую зону доступности](host-migration.md).
* [Настройка серверов {{ CH }}](change-server-level-settings.md) согласно [документации {{ CH }}]({{ ch.docs }}/operations/server-configuration-parameters/settings).
* [Изменение настроек {{ CH }} на уровне запроса](change-query-level-settings.md).


## Изменить настройки сервисного аккаунта {#change-service-account}


Для привязки сервисного аккаунта к кластеру {{ mch-name }} [убедитесь](../../iam/operations/roles/get-assigned-roles.md), что вашему аккаунту в {{ yandex-cloud }} назначена роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.


{% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы изменить настройки сервисного аккаунта:

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. В разделе **{{ ui-key.yacloud.mdb.forms.section_service-settings }}** выберите нужный сервисный аккаунт из списка или [создайте новый](../../iam/operations/sa/create.md). Подробнее о настройке сервисного аккаунта см. в разделе [{#T}](s3-access.md).

{% endlist %}


## Изменить класс хостов {#change-resource-preset}

{% note info %}

В кластерах с поддержкой {{ CK }} хосты {{ ZK }} не используются. Подробнее см. в разделе [Репликация](../concepts/replication.md).

{% endnote %}

При смене класса хостов:

* Кластер из одного хоста будет недоступен несколько минут, соединения с БД будут прерваны.
* В кластере из нескольких хостов каждый хост по очереди будет остановлен и обновлен. Остановленный хост будет недоступен несколько минут.
* Подключение по [особому FQDN](connect/fqdn.md#auto) не гарантирует стабильность соединения с БД: пользовательские сессии могут быть прерваны.

Рекомендуется изменять класс хостов только во время отсутствия рабочей нагрузки на кластер.

Класс хостов влияет на количество оперативной памяти, доступной для использования {{ CH }}. Подробнее см. в разделе [Управление памятью](../concepts/memory-management.md).

Минимальное количество ядер для одного хоста {{ ZK }} зависит от суммарного количества ядер хостов {{ CH }}. Подробнее см. в разделе [Репликация](../concepts/replication.md#zk).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. Чтобы изменить класс хостов {{ CH }}, в блоке **{{ ui-key.yacloud.mdb.forms.new_section_resource }}** выберите платформу, тип виртуальной машины и нужный класс хоста.
  1. Чтобы изменить класс хостов {{ ZK }}, в блоке **{{ ui-key.yacloud.mdb.forms.section_zookeeper-resource }}** выберите платформу, тип виртуальной машины и нужный класс хоста {{ ZK }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-ch }} cluster update --help
     ```

  1. Запросите список доступных классов хостов (в колонке `ZONE IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     
     ```bash
     {{ yc-mdb-ch }} resource-preset list

     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
     |           | {{ region-id }}-d                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```


  1. Укажите нужный класс в команде изменения кластера:

     ```bash
     {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
        --clickhouse-resource-preset=<идентификатор_класса>
     ```

     {{ mch-short-name }} запустит операцию изменения класса хостов для кластера.

  1. Чтобы изменить класс хостов {{ ZK }}, передайте нужное значение в параметре `--zookeeper-resource-preset`.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера {{ mch-name }} значение параметра `resource_preset_id` в блоках `clickhouse.resources` и `zookeeper.resources` для хостов {{ CH }} и {{ ZK }} соответственно:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          clickhouse {
            resources {
              resource_preset_id = "<класс_хостов_{{ CH }}>"
              ...
            }
          }
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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Запросите список доступных классов хостов:

        1. Воспользуйтесь методом [ResourcePreset.List](../api-ref/ResourcePreset/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/resourcePresets'
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ResourcePreset/list.md#responses).

    1. Измените класс хостов на нужный:

        1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
                --data '{
                          "updateMask": "configSpec.clickhouse.resources.resourcePresetId,configSpec.zookeeper.resources.resourcePresetId",
                          "configSpec": {
                            "clickhouse": {
                              "resources": {
                                "resourcePresetId": "<идентификатор_класса_хостов_{{ CH }}>"
                              }
                            },
                            "zookeeper": {
                              "resources": {
                                "resourcePresetId": "<идентификатор_класса_хостов_{{ ZK }}>"
                              }
                            }
                          }
                        }'
            ```

            Где:

            * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

                Укажите нужные параметры:
                * `configSpec.clickhouse.resources.resourcePresetId` — если нужно изменить класс хостов {{ CH }}.
                * `configSpec.zookeeper.resources.resourcePresetId` — если нужно изменить класс хостов {{ ZK }}.

                В примере запроса изменяется как класс хостов {{ CH }}, так и класс хостов {{ ZK }}.

            * `configSpec.clickhouse.resources.resourcePresetId` — идентификатор класса хостов {{ CH }}.
            * `configSpec.zookeeper.resources.resourcePresetId` — идентификатор класса хостов {{ ZK }}.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Запросите список доступных классов хостов:

        1. Воспользуйтесь вызовом [ResourcePresetService.List](../api-ref/grpc/ResourcePreset/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/resource_preset_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.clickhouse.v1.ResourcePresetService.List
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.clickhouse.v1.ListResourcePresetsResponse).

    1. Измените класс хостов на нужный:

        1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<идентификатор_кластера>",
                      "update_mask": {
                        "paths": [
                          "config_spec.clickhouse.resources.resource_preset_id",
                          "config_spec.zookeeper.resources.resource_preset_id"
                        ]
                      },
                      "config_spec": {
                        "clickhouse": {
                          "resources": {
                            "resource_preset_id": "<идентификатор_класса_хостов_{{ CH }}>"
                          }
                        },
                        "zookeeper": {
                          "resources": {
                            "resource_preset_id": "<идентификатор_класса_хостов_{{ ZK }}>"
                          }
                        }
                      }
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
            ```

            Где:

            * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

                Укажите нужные параметры:
                * `config_spec.clickhouse.resources.resource_preset_id` — если нужно изменить класс хостов {{ CH }}.
                * `config_spec.zookeeper.resources.resource_preset_id` — если нужно изменить класс хостов {{ ZK }}.

                В примере запроса изменяется как класс хостов {{ CH }}, так и класс хостов {{ ZK }}.

            * `config_spec.clickhouse.resources.resource_preset_id` — идентификатор класса хостов {{ CH }}.
            * `config_spec.zookeeper.resources.resource_preset_id` — идентификатор класса хостов {{ ZK }}.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Увеличить размер хранилища {#change-disk-size}

{% note info %}

В кластерах с поддержкой {{ CK }} хосты {{ ZK }} не используются. Подробнее см. в разделе [Репликация](../concepts/replication.md).

{% endnote %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы увеличить размер хранилища для кластера:

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}** укажите необходимое значение.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы увеличить размер хранилища для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-ch }} cluster update --help
     ```

  1. Укажите нужный размер хранилища в команде изменения кластера (должен быть не меньше, чем значение `disk_size` в свойствах кластера):

     ```bash
     {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
       --clickhouse-disk-size <размер_хранилища_ГБ>
     ```

  1. Чтобы увеличить размер хранилища хостов {{ ZK }}, передайте нужное значение в параметре `--zookeeper-disk-size`.

- {{ TF }} {#tf}

  Чтобы увеличить размер хранилища:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера {{ mch-name }} значение параметра `disk_size` в блоках `clickhouse.resources` и `zookeeper.resources` для хостов {{ CH }} и {{ ZK }} соответственно:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          clickhouse {
            resources {
              disk_size = <размер_хранилища_ГБ>
              ...
            }
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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.clickhouse.resources.diskSize,configSpec.zookeeper.resources.diskSize",
                      "configSpec": {
                        "clickhouse": {
                          "resources": {
                            "diskSize": "<размер_хранилища_в_байтах>"
                          }
                        },
                        "zookeeper": {
                          "resources": {
                            "diskSize": "<размер_хранилища_в_байтах>"
                          }
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:

            * `configSpec.clickhouse.resources.diskSize` — если нужно увеличить размер хранилища хостов {{ CH }}.
            * `configSpec.zookeeper.resources.diskSize` — если нужно увеличить размер хранилища хостов {{ ZK }}.

            В примере запроса размер хранилища увеличивается как для хостов {{ CH }}, так и для хостов {{ ZK }}.

        * `configSpec.clickhouse.resources.diskSize` — размер хранилища хостов {{ CH }} в байтах.
        * `configSpec.zookeeper.resources.diskSize` — размер хранилища хостов {{ ZK }} в байтах.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

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
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.clickhouse.resources.disk_size",
                      "config_spec.zookeeper.resources.disk_size"
                    ]
                  },
                  "config_spec": {
                    "clickhouse": {
                      "resources": {
                        "disk_size": "<размер_хранилища_в_байтах>"
                      }
                    },
                    "zookeeper": {
                      "resources": {
                        "disk_size": "<размер_хранилища_в_байтах>"
                      }
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:

            * `config_spec.clickhouse.resources.disk_size` — если нужно увеличить размер хранилища хостов {{ CH }}.
            * `config_spec.zookeeper.resources.disk_size` — если нужно увеличить размер хранилища хостов {{ ZK }}.

            В примере запроса размер хранилища увеличивается как для хостов {{ CH }}, так и для хостов {{ ZK }}.

        * `config_spec.clickhouse.resources.disk_size` — размер хранилища хостов {{ CH }} в байтах.
        * `config_spec.zookeeper.resources.disk_size` — размер хранилища хостов {{ ZK }} в байтах.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Включить управление пользователями и базами данных через SQL {#SQL-management}

Сервис {{ mch-name }} позволяет включить управление [пользователями](./cluster-users.md#sql-user-management) и [базами данных](./databases.md#sql-database-management) кластера через SQL.

{% note alert %}

Управление пользователями и базами данных через стандартные интерфейсы {{ yandex-cloud }} (консоль управления, CLI, {{ TF }}, API) станет недоступно.

Включенные настройки управления пользователями или базами данных через SQL невозможно выключить.

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. Для [управления пользователями через SQL](./cluster-users.md#sql-user-management), в блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** включите настройку **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** и укажите пароль пользователя `admin`.
  1. Для [управления базами данных через SQL](./databases.md#sql-database-management), в блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** включите настройки **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** и **{{ ui-key.yacloud.mdb.forms.database_field_sql-database-management }}**, укажите пароль пользователя `admin`.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Чтобы включить [режим управления пользователями через SQL](./cluster-users.md#sql-user-management):

        * задайте значение `true` для параметра `--enable-sql-user-management`;
        * задайте пароль для пользователя `admin` в параметре `--admin-password`.

        ```bash
        {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
           ...
           --enable-sql-user-management true \
           --admin-password "<пароль_пользователя_admin>"
        ```

    1. Чтобы включить [режим управления базами данных через SQL](./databases.md#sql-database-management):

        * задайте значение `true` для параметров `--enable-sql-user-management` и `--enable-sql-database-management`;
        * задайте пароль для пользователя `admin` в параметре `--admin-password`.

        ```bash
        {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
           ...
           --enable-sql-user-management true \
           --enable-sql-database-management true \
           --admin-password "<пароль_пользователя_admin>"
        ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. {% include [Enable SQL user management with Terraform](../../_includes/mdb/mch/terraform/sql-management-users.md) %}

    1. {% include [Enable SQL database management with Terraform](../../_includes/mdb/mch/terraform/sql-management-databases.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.adminPassword,configSpec.sqlUserManagement,configSpec.sqlDatabaseManagement",
                      "configSpec": {
                        "adminPassword": "<пароль_пользователя_admin>",
                        "sqlUserManagement": <управление_пользователями_через_SQL>,
                        "sqlDatabaseManagement": <управление_базами_данных_через_SQL>
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:

            * `configSpec.adminPassword` — пароль пользователя `admin`, с помощью которого осуществляется управление.
            * `configSpec.sqlUserManagement` — если нужно включить управление пользователями через SQL.
            * `configSpec.sqlDatabaseManagement` — если нужно включить управление базами данных через SQL.

            В примере запроса включается и управление пользователями, и управление базами данных черех SQL.

        * `configSpec.adminPassword` — пароль пользователя `admin`.
        * `configSpec.sqlUserManagement` — режим управления пользователями через SQL: `true` или `false`.
        * `configSpec.sqlDatabaseManagement` — режим управления базами данных через SQL: `true` или `false`. Необходимо, чтобы был включен режим управления пользователями через SQL.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

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
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.admin_password",
                      "config_spec.sql_user_management",
                      "config_spec.sql_database_management"
                    ]
                  },
                  "config_spec": {
                    "admin_password": "<пароль_пользователя_admin>",
                    "sql_user_management": <управление_пользователями_через_SQL>,
                    "sql_database_management": <управление_базами_данных_через_SQL>
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:

            * `config_spec.admin_password` — пароль пользователя `admin`, с помощью которого осуществляется управление.
            * `config_spec.sql_user_management` — если нужно включить управление пользователями через SQL.
            * `config_spec.sql_database_management` — если нужно включить управление базами данных через SQL.

            В примере запроса включается и управление пользователями, и управление базами данных черех SQL.

        * `config_spec.admin_password` — пароль пользователя `admin`.
        * `config_spec.sql_user_management` — режим управления пользователями через SQL: `true` или `false`.
        * `config_spec.sql_database_management` — режим управления базами данных через SQL: `true` или `false`. Необходимо, чтобы был включен режим управления пользователями через SQL.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_service-settings }}** измените дополнительные настройки кластера:

     {% include [mch-extra-settings](../../_includes/mdb/mch/extra-settings-web-console.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-ch }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        
        ```bash
        {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
           --backup-window-start <время_начала_резервного_копирования> \
           --backup-retain-period-days <срок_хранения_автоматических_резервных_копий> \
           --datalens-access=<true_или_false> \
           --metrika-access=<true_или_false> \
           --serverless-access=<true_или_false> \
           --websql-access=<true_или_false> \
           --yandexquery-access=<true_или_false> \
           --deletion-protection \
           --maintenance-window type=<тип_технического_обслуживания>,`
                               `day=<день_недели>,`
                               `hour=<час_дня>
        ```


    Вы можете изменить следующие настройки:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--backup-retain-period-days` – срок хранения автоматических резервных копий (в днях).

    * `--datalens-access` — разрешает доступ из {{ datalens-name }}. Значение по умолчанию — `false`. Подробнее о настройке подключения см. в разделе [Подключение из {{ datalens-name }}](datalens-connect.md).

    
    * `--metrika-access` — разрешает [импорт данных из AppMetrika в кластер](https://appmetrica.yandex.ru/docs/common/cloud/about.html). Значение по умолчанию — `false`.

    * `--serverless-access` — разрешает доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md). Значение по умолчанию — `false`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).


    * `--websql-access` — разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}. Значение по умолчанию — `false`.


    * `--yandexquery-access=true` — разрешает доступ к кластеру из сервиса [{{ yq-full-name }}](../../query/concepts/index.md). Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Значение по умолчанию — `false`.

    * {% include [Защита от удаления кластера](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Чтобы изменить время начала резервного копирования, добавьте к описанию кластера {{ mch-name }} блок `backup_window_start`.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          backup_window_start {
            hours   = <час_начала_резервного_копирования>
            minutes = <минута_начала_резервного_копирования>
          }
          ...
        }
        ```

    1. Чтобы разрешить доступ к кластеру из других сервисов и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью {{ websql-full-name }}, измените значения соответствующих полей в блоке `access`:

        
        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          access {
            data_lens    = <доступ_из_{{ datalens-name }}>
            metrika      = <доступ_из_Метрики_и_AppMetrika>
            serverless   = <доступ_из_Cloud_Functions>
            web_sql      = <выполнение_SQL-запросов_из_консоли_управления>
            yandex_query = <доступ_из_Yandex_Query>
          }
          ...
        }
        ```


        Где:

        * `data_lens` — доступ из {{ datalens-name }}: `true` или `false`.

        
        * `metrika` — доступ из Метрики и AppMetrika: `true` или `false`.
        * `serverless` — доступ из {{ sf-name }}: `true` или `false`.


        * `yandex_query` — доступ из {{ yq-full-name }}: `true` или `false`.
        * `web_sql` — выполнение SQL-запросов из консоли управления: `true` или `false`.

    1. {% include [Maintenance window](../../_includes/mdb/mch/terraform/maintenance-window.md) %}

    1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          deletion_protection = <защита_кластера_от_удаления>
        }
        ```

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            
            ```json
            {
              "updateMask": "<перечень_изменяемых_настроек>",
              "configSpec": {
                "backupWindowStart": {
                  "hours": "<часы>",
                  "minutes": "<минуты>",
                  "seconds": "<секунды>",
                  "nanos": "<наносекунды>"
                },
                "access": {
                  "dataLens": <доступ_из_{{ datalens-name }}>,
                  "webSql": <выполнение_SQL-запросов>,
                  "metrika": <импорт_данных_из_AppMetrica>,
                  "serverless": <доступ_из_{{ sf-full-name }}>,
                  "dataTransfer": <доступ_из_{{ data-transfer-full-name }}>,
                  "yandexQuery": <доступ_из_{{ yq-full-name }}>
                }    
              },
              "maintenanceWindow": {
                "anytime": {},
                "weeklyMaintenanceWindow": {
                  "day": "<день_недели>",
                  "hour": "<час_дня_по_UTC>"
                }
              },
              "deletionProtection": <защита_кластера_от_удаления>
            }
            ```


            Где:

            * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            * {% include [backup-windows-start-rest](../../_includes/mdb/api/backup-windows-start-rest.md) %}

            * `configSpec.access` — настройки, которые разрешают доступ к кластеру из других сервисов и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью {{ websql-full-name }}:

                {% include [rest-access-settings](../../_includes/mdb/mch/api/rest-access-settings.md) %}

            * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Выберите один из вариантов:

                * `anytime` — (по умолчанию) — в любое время.
                * `weeklyMaintenanceWindow` — по расписанию:
                    * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                    * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

            * `deletionProtection` — защита кластера от непреднамеренного удаления: `true` или `false`. Значение по умолчанию — `false`.

                {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

        1. Выполните запрос:

            ```bash
            curl \
              --request PATCH \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
              --data '@body.json'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            
            ```json
            {
              "cluster_id": "<идентификатор_кластера>",
              "update_mask": {
                "paths": [
                  <перечень_изменяемых_настроек>
                ]
              },
              "config_spec": {
                "backup_window_start": {
                  "hours": "<часы>",
                  "minutes": "<минуты>",
                  "seconds": "<секунды>",
                  "nanos": "<наносекунды>"
                },
                "access": {
                  "data_lens": <доступ_из_{{ datalens-name }}>,
                  "web_sql": <выполнение_SQL-запросов>,
                  "metrika": <импорт_данных_из_AppMetrica>,
                  "serverless": <доступ_из_{{ sf-full-name }}>,
                  "data_transfer": <доступ_из_{{ data-transfer-full-name }}>,
                  "yandex_query": <доступ_из_{{ yq-full-name }}>
                }
              },
              "maintenance_window": {
                "anytime": {},
                "weekly_maintenance_window": {
                  "day": "<день_недели>",
                  "hour": "<час_дня_по_UTC>"
                }
              },
              "deletion_protection": <защита_кластера_от_удаления>
            }
            ```


            Где:

            * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            * {% include [backup-windows-start-grpc](../../_includes/mdb/api/backup-windows-start-grpc.md) %}

            * `config_spec.access` — настройки, которые разрешают доступ к кластеру из других сервисов и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью {{ websql-full-name }}:

                {% include [grpc-access-settings](../../_includes/mdb/mch/api/grpc-access-settings.md) %}

            * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Выберите один из вариантов:

                * `anytime` — (по умолчанию) — в любое время.
                * `weekly_maintenance_window` — по расписанию:
                    * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                    * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

            * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`. Значение по умолчанию — `false`.

                {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

        1. Выполните запрос:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.Update \
              < body.json
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Переместить кластер {#move-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке кластера, который вы хотите переместить.
    1. Выберите пункт **{{ ui-key.yacloud.common.move }}**.
    1. Выберите каталог, в который вы хотите переместить кластер.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы переместить кластер:

    1. Посмотрите описание команды CLI для перемещения кластера:

        ```bash
        {{ yc-mdb-ch }} cluster move --help
        ```

    1. Укажите каталог назначения в команде перемещения кластера:

        ```bash
        {{ yc-mdb-ch }} cluster move <имя_или_идентификатор_кластера> \
           --destination-folder-name=<имя_каталога_назначения>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

    1. Измените или добавьте в описании кластера {{ mch-name }} значение параметра `folder_id`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          folder_id = "<идентификатор_каталога_назначения>"
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Move](../api-ref/Cluster/move.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>:move' \
            --data '{
                      "destinationFolderId": "<идентификатор_каталога_назначения>"
                    }'
        ```

        Где `destinationFolderId` — идентификатор каталога назначения, в который нужно переместить кластер. Этот идентификатор можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/move.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Move](../api-ref/grpc/Cluster/move.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "destination_folder_id": "<идентификатор_каталога_назначения>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Move
        ```

        Где `destination_folder_id` — идентификатор каталога назначения, в который нужно переместить кластер. Этот идентификатор можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/move.md#yandex.cloud.operation.Operation).

{% endlist %}


## Изменить группы безопасности {#change-sg-set}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите группы безопасности для сетевого трафика кластера.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-ch }} cluster update --help
      ```

  1. Укажите нужные группы безопасности в команде изменения кластера:

      ```bash
      {{ yc-mdb-ch }} cluster update <имя_кластера> \
         --security-group-ids <список_идентификаторов_групп_безопасности>
      ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените значение параметра `security_group_ids` в описании кластера:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          security_group_ids = [ <список_идентификаторов_групп_безопасности_кластера> ]
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "securityGroupIds",
                      "securityGroupIds": [
                        <список_идентификаторов_групп_безопасности>
                      ]
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае указан только один параметр: `securityGroupIds`.

        * `securityGroupIds` — массив строк. Каждая строка — идентификатор группы безопасности.

            {% note warning %}

            Список назначенных кластеру групп безопасности будет полностью перезаписан списком, переданным в параметре `securityGroupIds`.

            Перед выполнением запроса убедитесь, что вы включили в этот список все нужные идентификаторы групп безопасности, в том числе существующие.

            {% endnote %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

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
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "security_group_ids"
                    ]
                  },
                  "security_group_ids": [
                    <список_идентификаторов_групп_безопасности>
                  ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае указан только один параметр: `security_group_ids`.

        * `security_group_ids` — массив строк. Каждая строка — идентификатор группы безопасности.

            {% note warning %}

            Список назначенных кластеру групп безопасности будет полностью перезаписан списком, переданным в параметре `security_group_ids`.

            Перед выполнением запроса убедитесь, что вы включили в этот список все нужные идентификаторы групп безопасности, в том числе существующие.

            {% endnote %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}


## Изменить настройки гибридного хранилища {#change-hybrid-storage}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [настройки гибридного хранилища](../concepts/storage.md#hybrid-storage-settings):

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-ch }} cluster update --help
      ```

  1. Если гибридное хранилище в кластере выключено, включите его:

      ```bash
      {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
          --cloud-storage=true
      ```

      {% include [Hybrid Storage cannot be switched off](../../_includes/mdb/mch/hybrid-storage-cannot-be-switched-off.md) %}

  1. Передайте список настроек, которые хотите изменить:

      ```bash
      {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
          --cloud-storage-data-cache=<хранение_файлов> \
          --cloud-storage-data-cache-max-size=<объем_памяти_в_байтах> \
          --cloud-storage-move-factor=<доля_свободного_места> \
          --cloud-storage-prefer-not-to-merge=<слияние_кусков_данных>
      ```

      Вы можете изменить следующие настройки:

      {% include [Hybrid Storage settings CLI](../../_includes/mdb/mch/hybrid-storage-settings-cli.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "<перечень_изменяемых_настроек>",
                      "configSpec": {
                        "cloudStorage": {
                          "enabled": <использование_гибридного_хранилища>,
                          "moveFactor": "<доля_свободного_места>",
                          "dataCacheEnabled": <временное_хранение_файлов>,
                          "dataCacheMaxSize": "<максимальный_объем_памяти_для_хранения_файлов>",
                          "preferNotToMerge": <отключение_слияния_кусков_данных>
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `configSpec.cloudStorage` — настройки гибридного хранилища:

            {% include [rest-cloud-storage-settings](../../_includes/mdb/mch/api/rest-cloud-storage-settings.md) %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

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
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      <перечень_изменяемых_настроек>
                    ]
                  },
                  "config_spec": {
                    "cloud_storage": {
                      "enabled": <использование_гибридного_хранилища>,
                      "move_factor": "<доля_свободного_места>",
                      "data_cache_enabled": <временное_хранение_файлов>,
                      "data_cache_max_size": "<максимальный_объем_памяти_для_хранения_файлов>",
                      "prefer_not_to_merge": <отключение_слияния_кусков_данных>
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `config_spec.cloud_storage` — настройки гибридного хранилища:

            {% include [grpc-cloud-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
