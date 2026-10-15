---
title: Работа с гибридным хранилищем
description: Следуя данной инструкции, вы сможете включить для кластера {{ mch-name }} гибридное хранилище, а также задать настройки гибридного хранилища и политики хранения данных.
---

# Работа с гибридным хранилищем

[Гибридное хранилище](../concepts/storage.md#hybrid-storage-features) позволяет хранить часто используемые данные в кластерном хранилище (на сетевых дисках кластера {{ mch-name }}), а редко используемые данные — в [{{ objstorage-full-name }}](../../storage/).


## Включить для кластера гибридное хранилище {#enable-hybrid-storage}

{% include [hybrid-storage-cannot-be-switched-off](../../_includes/mdb/mch/hybrid-storage-cannot-be-switched-off.md) %}


### Включить гибридное хранилище при создании кластера {#cluster-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ CH }}.
    1. [Перейдите]({{ link-console-main }}/link/managed-clickhouse) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}** и задайте параметры кластера. Подробнее о параметрах читайте в [инструкции по созданию кластера](cluster-create.md).
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** включите опцию **{{ ui-key.yacloud.mdb.forms.additional-field-cloud-storage }}** и (опционально) задайте настройки гибридного хранилища:

        {% include [hybrid-storage-settings-console](../../_includes/mdb/mch/hybrid-storage-settings-console.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать кластер с включенным гибридным хранилищем и (опционально) задать его настройки:

    1. Посмотрите описание команды CLI для создания кластера:

        ```bash
        {{ yc-mdb-ch }} cluster create --help
        ```

    1. Выполните команду с указанием настроек гибридного хранилища:

        ```bash
        {{ yc-mdb-ch }} cluster create \
           ...
           --cloud-storage=true \
           --cloud-storage-data-cache=<кешировать_данные> \
           --cloud-storage-data-cache-max-size=<максимальный_объем_памяти_в_байтах> \
           --cloud-storage-move-factor=<доля_свободного_места> \
           --cloud-storage-prefer-not-to-merge=<отключить_слияние_кусков_данных>
          ...
        ```

        Где:

        * `--cloud-storage` — включает гибридное хранилище.

        {% include [hybrid-storage-settings-cli](../../_includes/mdb/mch/hybrid-storage-settings-cli.md) %}

        Подробнее о других параметрах команды `{{ yc-mdb-ch }} cluster create` читайте в [инструкции по созданию кластера](cluster-create.md).

- {{ TF }} {#tf}

    1. Создайте конфигурационный файл {{ TF }} с [планом инфраструктуры](cluster-create.md).
    1. Добавьте в конфигурационный файл блок `cloud_storage`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          cloud_storage = {
            enabled             = true
            move_factor         = <доля_свободного_места>
            data_cache_enabled  = <кешировать_данные>
            data_cache_max_size = <максимальный_объем_памяти_в_байтах>
            prefer_not_to_merge = <отключить_слияние_кусков_данных>
          }
        }
        ```

        Где:

        * `enabled` — включает гибридное хранилище.

        {% include [tf-hybrid-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

    1. Проверьте корректность файла конфигурации {{ TF }}:

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            ```json
            {
              <Параметры_кластера>
              ...
              "configSpec": {
                "cloudStorage": {
                  "enabled": true,
                  "moveFactor": "<доля_свободного_места>",
                  "dataCacheEnabled": <кешировать_данные>,
                  "dataCacheMaxSize": "<максимальный_объем_памяти_в_байтах>",
                  "preferNotToMerge": <отключить_слияние_кусков_данных>
                },
                ...
              }
            }
            ```

            Где:

            * `enabled` — включает гибридное хранилище.

            {% include [rest-cloud-storage-settings](../../_includes/mdb/mch/api/rest-cloud-storage-settings.md) %}

            Подробнее о других параметрах читайте в [инструкции по созданию кластера](cluster-create.md).

        1. Выполните запрос:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters' \
              --data '@body.json'
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            ```json
            {
              <Параметры_кластера>
              ...
              "config_spec": {
                "cloud_storage": {
                  "enabled": true,
                  "move_factor": "<доля_свободного_места>",
                  "data_cache_enabled": <кешировать_данные>,
                  "data_cache_max_size": "<максимальный_объем_памяти_в_байтах>",
                  "prefer_not_to_merge": <отключить_слияние_кусков_данных>
                },
                ...
              }
            }
            ```

            Где:

            * `enabled` — включает гибридное хранилище.

            {% include [grpc-cloud-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

            Подробнее о других параметрах читайте в [инструкции по созданию кластера](cluster-create.md).

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
              yandex.cloud.mdb.clickhouse.v1.ClusterService.Create \
              < body.json
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}


### Включить гибридное хранилище в существующем кластере {#cluster-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
    1. [Перейдите]({{ link-console-main }}/link/managed-clickhouse) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** включите опцию **{{ ui-key.yacloud.mdb.forms.additional-field-cloud-storage }}** и (опционально) задайте настройки гибридного хранилища:

        {% include [hybrid-storage-settings-console](../../_includes/mdb/mch/hybrid-storage-settings-console.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы включить в кластере гибридное хранилище и (опционально) задать его настройки, выполните команду:

    ```bash
    {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
       --cloud-storage=true \
       --cloud-storage-data-cache=<кешировать_данные> \
       --cloud-storage-data-cache-max-size=<максимальный_объем_памяти_в_байтах> \
       --cloud-storage-move-factor=<доля_свободного_места> \
       --cloud-storage-prefer-not-to-merge=<отключить_слияние_кусков_данных>
    ```

    Где:

    * `<имя_или_идентификатор_кластера>` — имя или идентификатор кластера, которые можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
    * `--cloud-storage` — включает гибридное хранилище.

    {% include [hybrid-storage-settings-cli](../../_includes/mdb/mch/hybrid-storage-settings-cli.md) %}

- {{ TF }} {#tf}

    Чтобы включить в кластере гибридное хранилище и (опционально) задать его настройки:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Инструкция по созданию такого файла приведена в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mch-name }} приведен в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

    1. Добавьте в описание кластера {{ mch-name }} блок `cloud_storage`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          cloud_storage = {
            enabled             = true
            move_factor         = <доля_свободного_места>
            data_cache_enabled  = <кешировать_данные>
            data_cache_max_size = <максимальный_объем_памяти_в_байтах>
            prefer_not_to_merge = <отключить_слияние_кусков_данных>
          }
        }
        ```

        Где:

        * `enabled` — включает гибридное хранилище.

        {% include [tf-hybrid-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

    1. Проверьте корректность файла конфигурации {{ TF }}:

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

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
                          "enabled": true,
                          "moveFactor": "<доля_свободного_места>",
                          "dataCacheEnabled": <кешировать_данные>,
                          "dataCacheMaxSize": "<максимальный_объем_памяти_в_байтах>",
                          "preferNotToMerge": <отключить_слияние_кусков_данных>
                        }
                      }
                    }'
        ```

        Где:

        * `<идентификатор_кластера>` — идентификатор кластера, который можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
        * `configSpec.cloudStorage` — настройки гибридного хранилища:

            * `enabled` — включает гибридное хранилище.

            {% include [rest-cloud-storage-settings](../../_includes/mdb/mch/api/rest-cloud-storage-settings.md) %}

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
                      "enabled": true,
                      "move_factor": "<доля_свободного_места>",
                      "data_cache_enabled": <кешировать_данные>,
                      "data_cache_max_size": "<максимальный_объем_памяти_в_байтах>",
                      "prefer_not_to_merge": <отключить_слияние_кусков_данных>
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:

        * `<идентификатор_кластера>` — идентификатор кластера, который можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
        * `config_spec.cloud_storage` — настройки гибридного хранилища:

            * `enabled` — включает гибридное хранилище.

            {% include [grpc-cloud-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

        Идентификатор кластера можно запросить со [списком кластеров](./cluster-list.md#list-clusters) в каталоге.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}


## Изменить настройки гибридного хранилища {#change-hybrid-storage}

Если в кластере {{ mch-name }} включено гибридное хранилище, можно изменить его настройки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
    1. [Перейдите]({{ link-console-main }}/link/managed-clickhouse) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** измените настройки гибридного хранилища:

        {% include [hybrid-storage-settings-console](../../_includes/mdb/mch/hybrid-storage-settings-console.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить настройки гибридного хранилища, выполните команду:

    ```bash
    {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
        --cloud-storage-data-cache=<кешировать_данные> \
        --cloud-storage-data-cache-max-size=<максимальный_объем_памяти_в_байтах> \
        --cloud-storage-move-factor=<доля_свободного_места> \
        --cloud-storage-prefer-not-to-merge=<отключить_слияние_кусков_данных>
    ```

    Где:

    * `<имя_или_идентификатор_кластера>` — имя или идентификатор кластера, которые можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

    {% include [hybrid-storage-settings-cli](../../_includes/mdb/mch/hybrid-storage-settings-cli.md) %}

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Инструкция по созданию такого файла приведена в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mch-name }} приведен в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

    1. Измените в описании кластера {{ mch-name }} атрибуты блока `cloud_storage`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          cloud_storage = {
            ...
            move_factor         = <доля_свободного_места>
            data_cache_enabled  = <кешировать_данные>
            data_cache_max_size = <максимальный_объем_памяти_в_байтах>
            prefer_not_to_merge = <отключить_слияние_кусков_данных>
          }
        }
        ```

        Где:

        {% include [tf-hybrid-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

    1. Проверьте корректность файла конфигурации {{ TF }}:

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

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
                          "moveFactor": "<доля_свободного_места>",
                          "dataCacheEnabled": <кешировать_данные>,
                          "dataCacheMaxSize": "<максимальный_объем_памяти_в_байтах>",
                          "preferNotToMerge": <отключить_слияние_кусков_данных>
                        }
                      }
                    }'
        ```

        Где:

        * `<идентификатор_кластера>` — идентификатор кластера, который можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
        * `configSpec.cloudStorage` — настройки гибридного хранилища:

            {% include [rest-cloud-storage-settings](../../_includes/mdb/mch/api/rest-cloud-storage-settings.md) %}

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
                      "move_factor": "<доля_свободного_места>",
                      "data_cache_enabled": <кешировать_данные>,
                      "data_cache_max_size": "<максимальный_объем_памяти_в_байтах>",
                      "prefer_not_to_merge": <отключить_слияние_кусков_данных>
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:

        * `<идентификатор_кластера>` — идентификатор кластера, который можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
        * `config_spec.cloud_storage` — настройки гибридного хранилища:

            {% include [grpc-cloud-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Задать политики хранения данных {#policies-create}

В кластере {{ mch-name }} с включенным гибридным хранилищем доступны три [политики хранения](../concepts/storage.md#storage-policies): `default` (по умолчанию), `local` и `object_storage`. Для таблиц БД можно указать одну из них. Создавать новые политики хранения или изменять уже существующие нельзя.

### Получить информацию о политиках {#get-info}

Чтобы посмотреть настройки политик, выполните запрос:

{% list tabs group=instructions %}

- SQL {#sql}

    ```sql
    SELECT *
    FROM system.storage_policies;
    ```

{% endlist %}


### Задать политику при создании таблицы {#table-create}

Чтобы задать политику при создании таблицы, выполните запрос:

{% list tabs group=instructions %}

- SQL {#sql}

    ```sql
    CREATE TABLE <имя_таблицы> (
        <схема_таблицы>
    ) ENGINE = MergeTree
    ...
    SETTINGS storage_policy = '<политика_хранения>';
    ```

{% endlist %}

### Задать политику для существующей таблицы {#table-update}

Чтобы задать или изменить политику для существующей таблицы, выполните запрос:

{% list tabs group=instructions %}

- SQL {#sql}

    ```sql
    ALTER TABLE <имя_таблицы>
    MODIFY SETTING storage_policy = '<политика_хранения>';
    ```

{% endlist %}


## Отслеживать объем, занимаемый данными в {{ objstorage-name }} {#metrics}

{% include [hybrid-storage-monitoring](../../_includes/mdb/mch/hybrid-storage-monitoring.md) %}


## Примеры использования {#examples}

* [{#T}](../tutorials/hybrid-storage.md)
