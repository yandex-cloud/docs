---
title: Как изменить настройки кластера {{ KF }} в {{ mkf-full-name }}
description: Следуя данной инструкции, вы сможете изменить настройки кластера {{ KF }}.
---

# Изменение настроек кластера {{ KF }}


После создания кластера {{ mkf-name }} вы можете:

* [изменить имя и описание кластера](#change-name-and-description);
* [изменить класс и количество хостов-брокеров](#change-brokers);
* [изменить класс хостов {{ ZK }}](#change-zookeeper);
* [изменить настройки групп безопасности и публичного доступа](#change-sg-set);
* [изменить дополнительные настройки кластера](#change-additional-settings);
* [изменить настройки {{ KF }}](#change-kafka-settings);
* [переместить кластер в другой каталог](#move-cluster).

Подробнее о других изменениях кластера:

* [{#T}](cluster-version-update.md).
* [{#T}](storage-space.md).
* [{#T}](host-migration.md).
* [{#T}](kafka-ui-enable.md).

## Изменить имя и описание кластера {#change-name-and-description}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** задайте новые имя и описание кластера.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить имя и описание кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Укажите новые имя и описание в команде изменения кластера:

        ```bash
        {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
          --new-name <новое_имя_кластера> \
          --description <новое_описание_кластера>
        ```

        Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    {% note alert %}

    Не изменяйте имя кластера с помощью {{ TF }}. Это приведет к удалению существующего кластера и созданию нового.

    {% endnote %}

    Чтобы изменить описание кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

    1. Измените в описании кластера {{ mkf-name }} значение параметра `description`:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          name        = "<имя_кластера>"
          description = "<новое_описание_кластера>"
          ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mkf }}).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

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
                      "updateMask": "name,description",
                      "name": "<имя_кластера>",
                      "description": "<новое_описание_кластера>"
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:
            * `name` — если нужно изменить имя кластера.
            * `description` — если нужно изменить описание кластера.
        * `name` — новое имя кластера.
        * `description` — новое описание кластера.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#responses).

- gRPC API {#grpc-api}

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
                      "name",
                      "description"
                    ]
                  },
                  "name": "<имя_кластера>",
                  "description": "<новое_описание_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:
            * `name` — если нужно изменить имя кластера.
            * `description` — если нужно изменить описание кластера.
        * `name` — новое имя кластера.
        * `description` — новое описание кластера.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить класс и количество хостов-брокеров {#change-brokers}

Увеличить количество [хостов-брокеров](../concepts/brokers.md) можно, если выполняются условия:

* В кластере используется версия {{ KF }} 3.5. В кластерах с версией {{ KF }} 3.6 или выше используется [протокол {{ kraft-name }}](../concepts/kraft.md), из-за чего в таких кластерах всегда ровно три хоста {{ KF }}.
* Кластер содержит не менее двух хостов-брокеров в разных зонах доступности.

Уменьшить количество хостов-брокеров нельзя. Для выполнения [условий высокой доступности](../concepts/ha-cluster.md) кластера необходимо минимум три хоста-брокера.

При смене класса хостов-брокеров:

* Кластер из одного хоста-брокера будет недоступен несколько минут, соединения с топиками будут прерваны.
* В кластере из нескольких хостов-брокеров каждый хост по очереди будет остановлен и обновлен, остановленный хост будет недоступен несколько минут.

Рекомендуется изменять класс хостов-брокеров только во время отсутствия рабочей нагрузки на кластер.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить класс и количество хостов:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. Измените требуемые настройки:
     * Чтобы изменить класс хостов-брокеров, выберите новый [**{{ ui-key.yacloud.mdb.forms.section_resource }}**](../concepts/instance-types.md).
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

  1. Чтобы изменить [класс хоста-брокера](../concepts/instance-types.md), выполните команду:

     ```bash
     {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> --resource-preset <класс_хоста>
     ```

  Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

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

    1. Измените в описании кластера {{ mkf-name }} значение параметра `resource_preset_id` в блоке `kafka.resources`, чтобы задать новый [класс хостов-брокеров](../concepts/instance-types.md):

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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Запросите список доступных классов хостов:

        1. Воспользуйтесь методом [ResourcePreset.list](../api-ref/ResourcePreset/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-kafka/v1/resourcePresets'
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ResourcePreset/list.md#responses).

    1. Измените класс и количество хостов-брокеров на нужные:

        1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>' \
                --data '{
                          "updateMask": "configSpec.kafka.resources.resourcePresetId,configSpec.brokersCount",
                          "configSpec": {
                            "kafka": {
                              "resources": {
                                "resourcePresetId": "<идентификатор_класса_хостов-брокеров>"
                              }
                            },
                            "brokersCount": "<количество_хостов-брокеров>"
                          }
                        }'
            ```

            Где:

            * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

                Укажите нужные параметры:
                * `configSpec.kafka.resources.resourcePresetId` — если нужно изменить класс хостов-брокеров.
                * `configSpec.brokersCount` — если нужно изменить количество хостов-брокеров.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#responses).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Запросите список доступных классов хостов:

        1. Воспользуйтесь вызовом [ResourcePresetService/List](../api-ref/grpc/ResourcePreset/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/resource_preset_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.kafka.v1.ResourcePresetService.List
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.kafka.v1.ListResourcePresetsResponse).

    1. Измените класс хостов на нужный:

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
                          "config_spec.kafka.resources.resource_preset_id",
                          "config_spec.brokers_count"
                        ]
                      },
                      "config_spec": {
                        "kafka": {
                          "resources": {
                            "resource_preset_id": "<идентификатор_класса_хостов-брокеров>"
                          }
                        },
                        "brokers_count": {
                          "value": "<количество_хостов-брокеров>"
                        }
                      }
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.kafka.v1.ClusterService.Update
            ```

            Где:

            * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

                Укажите нужные параметры:
                * `config_spec.kafka.resources.resource_preset_id` — если нужно изменить класс хостов-брокеров.
                * `config_spec.brokers_count` — если нужно изменить количество хостов-брокеров.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить класс хостов {{ ZK }} {#change-zookeeper}

{% note info %}

Класс хостов {{ ZK }} используется только в кластерах с версией {{ KF }} 3.5 и ниже.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
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

  1. Чтобы изменить [класс хостов](../concepts/instance-types.md) {{ ZK }}, выполните команду:

     ```bash
     {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
       --zookeeper-resource-preset <класс_хоста>
     ```

  Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера {{ mkf-name }} значение параметра `resource_preset_id` в блоке `zookeeper.resources`, чтобы задать новый [класс хостов](../concepts/instance-types.md) {{ ZK }}:

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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Запросите список доступных классов хостов:

        1. Воспользуйтесь методом [ResourcePreset.list](../api-ref/ResourcePreset/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-kafka/v1/resourcePresets'
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ResourcePreset/list.md#yandex.cloud.mdb.kafka.v1.ListResourcePresetsResponse).

    1. Измените класс хостов на нужный:

        1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>' \
                --data '{
                          "updateMask": "configSpec.zookeeper.resources.resourcePresetId",
                          "configSpec": {
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
                * `configSpec.zookeeper.resources.resourcePresetId` — если нужно изменить класс хостов {{ ZK }}.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Запросите список доступных классов хостов:

        1. Воспользуйтесь вызовом [ResourcePresetService/List](../api-ref/grpc/ResourcePreset/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/resource_preset_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.kafka.v1.ResourcePresetService.List
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.kafka.v1.ListResourcePresetsResponse).

    1. Измените класс хостов на нужный:

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
                          "config_spec.zookeeper.resources.resource_preset_id"
                        ]
                      },
                      "config_spec": {
                        "zookeeper": {
                          "resources": {
                            "resource_preset_id": "<идентификатор_класса_хостов_{{ ZK }}>"
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
                * `config_spec.zookeeper.resources.resource_preset_id` — если нужно изменить класс хостов {{ ZK }}.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}


## Изменить настройки групп безопасности и публичного доступа {#change-sg-set}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите группы безопасности для сетевого трафика кластера.
  1. Установите или отключите публичный доступ к кластеру при помощи опции **Публичный доступ**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

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

      Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "securityGroupIds,configSpec.assignPublicIp",
                      "securityGroupIds": [
                        <список_идентификаторов_групп_безопасности>
                      ],
                      "configSpec": {
                        "assignPublicIp": "<публичный_доступ:_true_или_false>"
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:
            * `securityGroupIds` — если нужно изменить список групп безопасности.
            * `configSpec.assignPublicIp` — если нужно изменить настройку публичного доступа.
        * `securityGroupIds` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md) в виде массива строк. Каждая строка — идентификатор группы безопасности.

            {% note warning %}

            Список назначенных кластеру групп безопасности будет полностью перезаписан списком, переданным в параметре `securityGroupIds`.

            Перед выполнением запроса убедитесь, что вы включили в этот список все нужные идентификаторы групп безопасности, в том числе существующие.

            {% endnote %}

        * `assignPublicIp` — доступность хостов-брокеров из интернета: `true` или `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

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
                      "security_group_ids",
                      "config_spec.assign_public_ip"
                    ]
                  },
                  "security_group_ids": [
                    <список_идентификаторов_групп_безопасности>
                  ],
                  "config_spec": {
                    "assign_public_ip": "<публичный_доступ:_true_или_false>"
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:
            * `security_group_ids` — если нужно изменить список групп безопасности.
            * `config_spec.assign_public_ip` — если нужно изменить настройку публичного доступа.
        * `security_group_ids` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md) в виде массива строк. Каждая строка — идентификатор группы безопасности.

            {% note warning %}

            Список назначенных кластеру групп безопасности будет полностью перезаписан списком, переданным в параметре `security_group_ids`.

            Перед выполнением запроса убедитесь, что вы включили в этот список все нужные идентификаторы групп безопасности, в том числе существующие.

            {% endnote %}

        * `assign_public_ip` — доступность хостов-брокеров из интернета: `true` или `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

[Перезагрузите кластер](./cluster-stop.md), чтобы изменение настройки публичного доступа вступило в силу.

Для подключения к кластеру может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups).


## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
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
           --deletion-protection \
           --schema-registry=<управление_схемами_данных>
        ```


    Вы можете изменить следующие настройки:

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}


    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        Включенная защита кластера от удаления не помешает удалить пользователя или топик, а также подключиться вручную и удалить данные.

    * `--schema-registry` — управление схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md): `true` или `false`.

        {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

    Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

    1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          deletion_protection = <защита_кластера_от_удаления>
        }
        ```

        Включенная защита кластера от удаления не помешает удалить пользователя или топик, а также подключиться вручную и удалить данные.

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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        
        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.restApiConfig.emabled,configSpec.schemaRegistry,maintenanceWindow,deletionProtection",
                      "configSpec": {
                        "schemaRegistry": true,
                        "restApiConfig": {
                          "enabled": true
                        }
                      },
                      "maintenanceWindow": {
                        "anytime": {},
                        "weeklyMaintenanceWindow": {
                          "day": "<день_недели>",
                          "hour": "<час_дня_по_UTC>"
                        }
                      },
                      "deletionProtection": <защита_кластера_от_удаления:_true_или_false>
                    }'
        ```


        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:
            * `configSpec.schemaRegistry` – если нужно включить настройки управления схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md).
            * `configSpec.restApiConfig.enabled` — если нужно включить доступ к отправке запросов к REST API {{ KF }}.


            * `maintenanceWindow` — если нужно изменить настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров).
            * `deletionProtection` — если нужно включить или выключить защиту кластера от непреднамеренного удаления.

              Включенная защита кластера от удаления не помешает удалить пользователя или топик, а также подключиться вручную и удалить данные.

        * `configSpec.schemaRegistry` – укажите `true`, чтобы управлять схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md). Эту настройку невозможно изменить после включения.
        * `configSpec.restApiConfig.enabled` – для доступа к отправке запросов к REST API {{ KF }} укажите `true`. Эту настройку невозможно изменить после включения.


        * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Выберите один из вариантов:

            * `anytime` — (по умолчанию) — в любое время.
            * `weeklyMaintenanceWindow` — по расписанию:
                * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

        * `deletionProtection` — включить или выключить защиту кластера от непреднамеренного удаления.

            Включенная защита кластера от удаления не помешает удалить пользователя или топик, а также подключиться вручную и удалить данные.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

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
                      "maintenance_window",
                      "deletion_protection",
                      "config_spec.schema_registry",
                      "config_spec.rest_api_config.enabled"
                    ]
                  },
                  "config_spec": {
                    "schema_registry": true,
                    "rest_api_config": {
                      "enabled": true
                    }
                  },
                  "maintenance_window": {
                    "anytime": {},
                    "weekly_maintenance_window": {
                      "day": "<день_недели>",
                      "hour": "<час_дня_по_UTC>"
                    }
                  },
                  "deletion_protection": <защита_кластера_от_удаления:_true_или_false>
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```


        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:
            * `config_spec.schema_registry` – если нужно управлять схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md).
            * `config_spec.rest_api_config.enabled` – если нужно включить доступ к отправке запросов к REST API {{ KF }}.


            * `maintenance_window` — если нужно изменить настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров).
            * `deletion_protection` — если нужно включить или выключить защиту кластера, его баз данных и пользователей от непреднамеренного удаления.
        * `schema_registry` – укажите `true`, чтобы управлять схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md). Эту настройку невозможно изменить после включения.
        * `rest_api_config.enabled` – для доступа к отправке запросов к REST API {{ KF }} укажите `true`. Эту настройку невозможно изменить после включения.


        * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md). Выберите один из вариантов:

            * `anytime` — в любое время.
            * `weekly_maintenance_window` — по расписанию:
                * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

        * `deletion_protection` — включить (`true`) или выключить (`false`) защиту кластера от непреднамеренного удаления.

            Включенная защита кластера от удаления не помешает удалить пользователя или топик, а также подключиться вручную и удалить данные.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки {{ KF }} {#change-kafka-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
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

        Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.kafka.kafkaConfig_2_8.<настройка_1_конфигурации_{{ KF }}_версии_2.8>,...,configSpec.kafka.kafkaConfig_2_8.<настройка_N_конфигурации_{{ KF }}_версии_2.8>,configSpec.kafka.kafkaConfig_3.<настройка_1_конфигурации_{{ KF }}_версии_3.x>,...,configSpec.kafka.kafkaConfig_3.<настройка_N_конфигурации_{{ KF }}_версии_3.x>",
                      "configSpec": {
                        "kafka": {
                          "kafkaConfig_2_8": {
                            "<настройка_1_конфигурации_{{ KF }}_версии_2.8>": "<значение_настройки>",
                            "<настройка_2_конфигурации_{{ KF }}_версии_2.8>": "<значение_настройки>",
                            ...,
                            "<настройка_N_конфигурации_{{ KF }}_версии_2.8>": "<значение_настройки>"
                          },
                          "kafkaConfig_3": {
                            "<настройка_1_конфигурации_{{ KF }}_версии_3.x>": "<значение_настройки>",
                            "<настройка_2_конфигурации_{{ KF }}_версии_3.x>": "<значение_настройки>",
                            ...,
                            "<настройка_N_конфигурации_{{ KF }}_версии_3.x>": "<значение_настройки>"
                          }
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:
            * `configSpec.kafka.kafkaConfig_2_8.<настройка_конфигурации_{{ KF }}_версии_2.8>` – если используете {{ KF }} версии `2.8`.
            * `configSpec.kafka.kafkaConfig_3.<настройка_конфигурации_{{ KF }}_версии_3.x>` – если используете {{ KF }} версий `3.x`.
        * `configSpec.kafka.kafkaConfig_2_8.<настройка_конфигурации_{{ KF }}_версии_2.8` – укажите новое значение настройки, если используете {{ KF }} версии `2.8`.
        * `configSpec.kafka.kafkaConfig_3.<настройка_конфигурации_{{ KF }}_версии_3.x` – укажите новое значение настройки, если используете {{ KF }} версий `3.x`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

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
                      "config_spec.kafka.kafka_config_2_8.<настройка_1_конфигурации_{{ KF }}_версии_2.8>",
                      ...,
                      "config_spec.kafka.kafka_config_2_8.<настройка_N_конфигурации_{{ KF }}_версии_2.8>",
                      "config_spec.kafka.kafka_config_3.<настройка_1_конфигурации_{{ KF }}_версии_3.x>",
                      ...,
                      "config_spec.kafka.kafka_config_3.<настройка_N_конфигурации_{{ KF }}_версии_3.x>"
                    ]
                  }
                  "config_spec": {
                    "kafka": {
                      "kafka_config_2_8": {
                        "<настройка_1_конфигурации_{{ KF }}_версии_2.8>": "<значение_настройки>",
                        "<настройка_2_конфигурации_{{ KF }}_версии_2.8>": "<значение_настройки>",
                        ...,
                        "<настройка_N_конфигурации_{{ KF }}_версии_2.8>": "<значение_настройки>"
                      },
                      "kafka_config_3": {
                        "<настройка_1_конфигурации_{{ KF }}_версии_3.x>": "<значение_настройки>",
                        "<настройка_2_конфигурации_{{ KF }}_версии_3.x>": "<значение_настройки>",
                        ...,
                        "<настройка_N_конфигурации_{{ KF }}_версии_3.x>": "<значение_настройки>"
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
            * `config_spec.kafka.kafka_config_2_8.<настройка_конфигурации_{{ KF }}_версии_2.8>` – если используете {{ KF }} версии `2.8`.
            * `config_spec.kafka.kafka_config_3.<настройка_конфигурации_{{ KF }}_версии_3.x>` – если используете {{ KF }} версий `3.x`.
        * `config_spec.kafka.kafka_config_2_8.<настройка_конфигурации_{{ KF }}_версии_2.8` – укажите новое значение настройки, если используете {{ KF }} версии `2.8`.
        * `config_spec.kafka.kafka_config_3.<настройка_конфигурации_{{ KF }}_версии_3.x` – укажите новое значение настройки, если используете {{ KF }} версий `3.x`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Переместить кластер в другой каталог {#move-cluster}

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
        {{ yc-mdb-kf }} cluster move <имя_или_идентификатор_кластера> \
           --destination-folder-name=<имя_каталога_назначения>
        ```

        Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

    1. Измените или добавьте в описании кластера {{ mkf-name }} значение параметра `folder_id`:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          folder_id = "<идентификатор_каталога_назначения>"
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mkf }}).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.move](../api-ref/Cluster/move.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>:move' \
            --data '{
                      "destinationFolderId": "<идентификатор_каталога>"
                    }'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/Move](../api-ref/grpc/Cluster/move.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "destination_folder_id": "<идентификатор_каталога>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Move
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}
