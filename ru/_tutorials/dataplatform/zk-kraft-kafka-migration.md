# Обновление кластера {{ mkf-name }} с {{ ZK }} на кластер с поддержкой {{ kraft-short-name }}


Многохостовые кластеры {{ mkf-name }} версии 3.5 и ниже используют {{ ZK }} для управления метаданными. С версией {{ KF }} 4.0 поддержка {{ ZK }} [прекратится](../../managed-kafka/concepts/update-policy.md#version-schedule). Для кластеров с хостами {{ ZK }} поддерживается переход на протокол {{ kraft-short-name }}. Начиная с версии 3.6 {{ KF }} использует [{{ kraft-short-name }}](../../managed-kafka/concepts/kraft.md) как основной протокол синхронизации метаданных.

Чтобы перейти на протокол {{ kraft-short-name }} в кластере с {{ ZK }}:

1. [Обновите версию кластера](#update-version).
1. [Выполните миграцию кластера на протокол {{ kraft-short-name }}](#migrate-to-kraft).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ mkf-name }}: использование вычислительных ресурсов, выделенных хостам (в том числе хостам {{ kraft-short-name }}), и дискового пространства (см. [тарифы {{ mkf-name }}](../../managed-kafka/pricing.md)).
* Плата за использование публичных IP-адресов для хостов кластеров (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).


## Обновите версию кластера {#update-version}

Обновите версию {{ KF }} вашего кластера с {{ ZK }} до версии `3.9` поэтапно, без пропуска версий. Обновление выполняется в такой последовательности: 3.5 → 3.6 → 3.7 → 3.8 → 3.9. Если версия кластера ниже `3.5`, вначале [обновите кластер](../../managed-kafka/operations/cluster-version-update.md) до этой версии.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. В строке с вашим кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите версию 3.6.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
    1. Повторите действия для остальных версий {{ KF }} в указанной последовательности.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Запустите обновление {{ KF }} вашего кластера командой:

        ```bash
        {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
           --version=3.6
        ```

    1. Повторите команду для остальных версий в указанной последовательности.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
    1. В блоке `config` кластера {{ mkf-name }} задайте новую версию {{ KF }} в поле `version` — `3.6`:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          config {
            version = "3.6"
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    1. Повторите действия для остальных версий {{ KF }} в указанной последовательности.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../managed-kafka/api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.update](../../managed-kafka/api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.version",
                      "configSpec": {
                        "version": "3.6"
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае указан только один параметр: `configSpec.version`.

        * `configSpec.version` — версия {{ KF }}.

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../managed-kafka/api-ref/Cluster/update.md#yandex.cloud.operation.Operation).
    1. Повторите действия для остальных версий {{ KF }} в указанной последовательности.

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../managed-kafka/api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь вызовом [ClusterService/Update](../../managed-kafka/api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
                      "config_spec.version"
                    ]
                  },
                  "config_spec": {
                    "version": "3.6"
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае указан только один параметр: `config_spec.version`.

        * `config_spec.version` — версия {{ KF }}.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../managed-kafka/api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).
    1. Повторите действия для остальных версий {{ KF }} в указанной последовательности.

{% endlist %}

## Выполните миграцию кластера на протокол {{ kraft-short-name }} {#migrate-to-kraft}

Для миграции кластера {{ mkf-name }} с хостами {{ ZK }} на протокол {{ kraft-short-name }} задайте конфигурацию ресурсов для контроллеров {{ kraft-short-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Нажмите на имя нужного кластера.
    1. В верхней части экрана нажмите кнопку **Мигрировать**.
    1. Выберите [платформу](../../compute/concepts/vm-platforms.md), тип хостов и класс хостов для контроллеров {{ kraft-short-name }}.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
    1. Дождитесь завершения миграции.

- CLI {#cli}

    Запустите миграцию вашего кластера командой:

     ```bash
     {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
        --controller-resource-preset "<класс_хостов_{{ kraft-short-name }}>" \
        --controller-disk-size <размер_хранилища> \
        --controller-disk-type <тип_диска>
     ```

     Где:

     * `--controller-resource-preset` — [класс хостов {{ kraft-short-name }}](../../managed-kafka/concepts/instance-types.md).
     * `--controller-disk-type` — тип диска хостов {{ kraft-short-name }}.

     {% include [kraft-resources](../../_includes/mdb/mkf/note-kraft-resources-limits.md) %}

     Чтобы узнать имя или идентификатор кластера, [получите список кластеров в каталоге](../../managed-kafka/operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
    1. Удалите блок `config.zookeeper` кластера {{ mkf-name }}.
    1. Добавьте блок `config.kraft` с описанием ресурсов контроллеров {{ kraft-short-name }}:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          config {
            ...
            kraft {
              resources {
                disk_size          = <размер_хранилища_ГБ>
                disk_type_id       = "<тип_диска>"
                resource_preset_id = "<класс_хостов_{{ kraft-short-name }}>"
              }
            }
          }
        }
        ```

        Где:

        * `kraft.resources.resource_preset_id` — [класс хостов {{ kraft-short-name }}](../../managed-kafka/concepts/instance-types.md).
        * `kraft.resources.disk_type_id` — тип диска хостов {{ kraft-short-name }}.

        {% include [kraft-resources](../../_includes/mdb/mkf/note-kraft-resources-limits.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../managed-kafka/api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.update](../../managed-kafka/api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.kraft.resources.resourcePresetId,configSpec.kraft.resources.diskSize,configSpec.kraft.resources.diskTypeId",
                      "configSpec": {
                        "kraft": {
                          "resources": {
                            "resourcePresetId": "<класс_хостов_{{ kraft-short-name }}>",
                            "diskSize": "<размер_хранилища_в_байтах>",
                            "diskTypeId": "<тип_диска>"
                          }
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае должны быть указаны все параметры добавляемых ресурсов: `configSpec.kraft.resources.resourcePresetId`, `configSpec.kraft.resources.diskSize`, `configSpec.kraft.resources.diskTypeId`.

        * `configSpec.kraft` — конфигурация контроллеров {{ kraft-short-name }}:

            * `resources.resourcePresetId` — идентификатор класса хостов. Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.list](../../managed-kafka/api-ref/ResourcePreset/list.md).
            * `resources.diskSize` — размер диска в байтах.
            * `resources.diskTypeId` — тип диска.

            {% include [kraft-resources](../../_includes/mdb/mkf/note-kraft-resources-limits.md) %}

       Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../managed-kafka/api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../managed-kafka/api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь вызовом [ClusterService/Update](../../managed-kafka/api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
                      "config_spec.kraft.resources.resource_preset_id",
                      "config_spec.kraft.resources.disk_size",
                      "config_spec.kraft.resources.disk_type_id"
                    ]
                  },
                  "config_spec": {
                    "kraft": {
                      "resources": {
                        "resource_preset_id": "<класс_хостов_{{ kraft-short-name }}>",
                        "disk_size": "<размер_хранилища_в_байтах>",
                        "disk_type_id": "<тип_диска>"
                      }
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае должны быть указаны все параметры добавляемых ресурсов: `config_spec.kraft.resources.resource_preset_id`, `config_spec.kraft.resources.disk_size`, `config_spec.kraft.resources.disk_type_id`.

        * `config_spec.kraft` — конфигурация контроллеров {{ kraft-short-name }}:

            * `resources.resource_preset_id` — идентификатор класса хостов. Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.list](../../managed-kafka/api-ref/grpc/ResourcePreset/list.md).
            * `resources.disk_size` — размер диска в байтах.
            * `resources.disk_type_id` — тип диска.

            {% include [kraft-resources](../../_includes/mdb/mkf/note-kraft-resources-limits.md) %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../managed-kafka/api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    [Удалите кластер {{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}