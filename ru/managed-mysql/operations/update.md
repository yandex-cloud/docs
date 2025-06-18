---
title: Инструкция по изменению настроек кластера {{ MY }} в {{ mmy-full-name }}
description: Из статьи вы узнаете, как изменить настройки кластера {{ MY }}.
---

# Изменение настроек кластера {{ MY }}

После создания кластера вы можете:

* [Изменить класс хостов](#change-resource-preset).
* [Изменить тип диска и увеличить размер хранилища](#change-disk-size).
* [Изменить настройки {{ MY }}](#change-mysql-config).

    {% note warning %}

    Вы не можете менять настройки {{ MY }} с помощью команд SQL.

    {% endnote %}

* [Изменить дополнительные настройки кластера](#change-additional-settings).
* [Переместить кластер](#move-cluster) в другой каталог.
* [Изменить группы безопасности](#change-sg-set).

Подробнее о других изменениях кластера:

* [{#T}](cluster-version-update.md).
* [Миграция хостов кластера в другую зону доступности](host-migration.md).

## Изменить класс хостов {#change-resource-preset}

Выбор [класса хостов](../concepts/instance-types.md) в кластерах {{ mmy-short-name }} ограничен квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

{% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}

При смене класса хостов:

* Кластер из одного хоста будет недоступен несколько минут, соединения с БД будут прерваны.
* В кластере из нескольких хостов сменится мастер. Каждый хост по очереди будет остановлен и обновлен, остановленный хост будет недоступен несколько минут.
* Подключение по [особому FQDN](./connect.md#fqdn-master) не гарантирует стабильность соединения с БД: пользовательские сессии могут быть прерваны.

Рекомендуется изменять класс хостов только во время отсутствия рабочей нагрузки на кластер.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. Чтобы изменить класс хостов {{ MY }}, в блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите нужный класс.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить класс хостов для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-my }} cluster update --help
      ```

  1. Запросите список доступных классов хостов (в колонке `ZONE IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     
     ```bash
     {{ yc-mdb-my }} resource-preset list
     ```

     Результат:

     ```text
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
      {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера>
        --resource-preset <идентификатор_класса>
      ```

      {{ mmy-short-name }} запустит операцию изменения класса хостов для кластера.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

  1. Измените в описании кластера {{ mmy-name }} значение параметра `resource_preset_id` в блоке `resources`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        resources {
          resource_preset_id = "<класс_хоста>"
          ...
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

    {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

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
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "configSpec.resources.resourcePresetId",
                    "configSpec": {
                      "resources": {
                        "resourcePresetId": "<класс_хостов>"
                      }
                    }
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае передается только один параметр.

      * `configSpec.resources.resourcePresetId` — новый класс хостов.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

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
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                  "paths": [
                    "config_spec.resources.resource_preset_id"
                  ]
                },
                "config_spec": {
                  "resources": {
                    "resource_preset_id": "<класс_хостов>"
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается только один параметр.

      * `config_spec.resources.resource_preset_id` — новый класс хостов.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить тип диска и увеличить размер хранилища {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить тип диска и увеличить размер хранилища для кластера:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

      * Выберите [тип диска](../concepts/storage.md).
      * Укажите нужный размер диска.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить тип диска и увеличить размер хранилища для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-my }} cluster update --help
      ```

  1. Укажите [тип диска](../concepts/storage.md) и нужный размер хранилища в команде изменения кластера (размер хранилища должен быть не меньше, чем значение `disk_size` в свойствах кластера):

      ```bash
      {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера> \
        --disk-type <тип_диска> \
        --disk-size <размер_хранилища_ГБ>
      ```

- {{ TF }} {#tf}

  Чтобы изменить тип диска и увеличить размер хранилища для кластера:

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

  1. Измените значения параметров `disk_type_id` и `disk_size` в блоке `resources`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        resources {
          disk_type_id = "<тип_диска>"
          disk_size    = <размер_хранилища_ГБ>
          ...
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

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
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "configSpec.resources.diskTypeId,configSpec.resources.diskSize",
                    "configSpec": {
                      "resources": {
                        "diskTypeId": "<тип_диска>",
                        "diskSize": "<размер_хранилища_в_байтах>"
                      }
                    }
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

      * `configSpec.resources` — параметры хранилища:

          * `diskTypeId` — [тип диска](../concepts/storage.md).
          * `diskSize` — новый размер хранилища в байтах.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

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
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                  "paths": [
                    "config_spec.resources.disk_type_id",
                    "config_spec.resources.disk_size"
                  ]
                },
                "config_spec": {
                  "resources": {
                    "disk_type_id": "<тип_диска>",
                    "disk_size": "<размер_хранилища_в_байтах>"
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

      * `config_spec.resources` — параметры хранилища:

          * `disk_type_id` — [тип диска](../concepts/storage.md).
          * `disk_size` — новый размер хранилища в байтах.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки {{ MY }} {#change-mysql-config}

{% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. Измените [настройки {{ MY }}](../concepts/settings-list.md#dbms-cluster-settings), нажав на кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** в блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [настройки {{ MY }}](../concepts/settings-list.md#dbms-cluster-settings):

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      {{ yc-mdb-my }} cluster update-config --help
      ```

  1. Установите нужные значения параметров.

     Все поддерживаемые параметры перечислены в [формате запроса для метода update](../api-ref/Cluster/update.md), в поле `mysql_config_5_7`. Чтобы указать имя параметра в вызове CLI, преобразуйте его имя из вида <q>lowerCamelCase</q> в <q>snake_case</q>, например, параметр `logMinDurationStatement` из запроса к API преобразуется в `log_min_duration_statement` для команды CLI:

     ```bash
     {{ yc-mdb-my }} cluster update-config <имя_кластера>
       --set log_min_duration_statement=100,<имя_параметра>=<значение>,...
     ```

     {{ mmy-short-name }} запустит операцию по изменению настроек кластера.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

  1. Добавьте или измените в описании кластера {{ mmy-name }} параметры [настроек СУБД](../concepts/settings-list.md) в блоке `mysql_config`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        mysql_config = {
          <имя_настройки_{{ MY }}> = <значение>
          ...
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mysql_cluster#mysql-config).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

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
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "configSpec.mysqlConfig_<версия_{{ MY }}>",
                    "configSpec": {
                      "mysqlConfig_<версия_{{ MY }}>": {
                        "<настройка_1>": "<значение_1>",
                        "<настройка_2>": "<значение_2>",
                        ...
                        "<настройка_N>": "<значение_N>"
                      }
                    }
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае передается только один параметр.

      * `configSpec.mysqlConfig_<версия_{{ MY }}>` — набор настроек {{ MY }}. Укажите каждую настройку на отдельной строке через запятую.

          Список версий {{ MY }}, доступных для параметра, см. в [описании метода](../api-ref/Cluster/update.md#yandex.cloud.mdb.mysql.v1.UpdateClusterRequest). Описание и возможные значения настроек см. в разделе [{#T}](../concepts/settings-list.md#dbms-cluster-settings).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

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
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                  "paths": [
                    "config_spec.mysql_config_<версия_{{ MY }}>"
                  ]
                },
                "config_spec": {
                  "mysql_config_<версия_{{ MY }}>": {
                    "<настройка_1>": "<значение_1>",
                    "<настройка_2>": "<значение_2>",
                    ...
                    "<настройка_N>": "<значение_N>"
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается только один параметр.

      * `configSpec.mysqlConfig_<версия_{{ MY }}>` — набор настроек {{ MY }}. Укажите каждую настройку на отдельной строке через запятую.

          Список версий {{ MY }}, доступных для параметра, см. в [описании метода](../api-ref/Cluster/update.md#yandex.cloud.mdb.mysql.v1.UpdateClusterReques). Описание и возможные значения настроек см. в разделе [{#T}](../concepts/settings-list.md#dbms-cluster-settings).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

Подробнее об изменении настроек {{ MY }} см. в разделе [Вопросы и ответы](../qa/configuring.md).

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. Измените дополнительные настройки кластера:

     {% include [mmy-extra-settings](../../_includes/mdb/mmy-extra-settings-web-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-my }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера> \
          --backup-window-start <время_начала_резервного_копирования> \
          --backup-retain-period-days=<срок_хранения_копий> \
          --datalens-access=<true_или_false> \
          --websql-access=<true_или_false> \
          --maintenance-window type=<тип_технического_обслуживания>,`
                              `day=<день_недели>,`
                              `hour=<час_дня> \
          --deletion-protection \
          --performance-diagnostics enabled=true,`
                                   `sessions-sampling-interval=<интервал_сбора_сессий>,`
                                   `statements-sampling-interval=<интервал_сбора_запросов>
        ```

    Вы можете изменить следующие настройки:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--backup-retain-period-days` — срок хранения автоматических резервных копий (в днях). Допустимые значения: от `7` до `60`. Значение по умолчанию — `7`.

    * `--datalens-access` — разрешает доступ из {{ datalens-name }}. Значение по умолчанию — `false`. Подробнее о настройке подключения см в разделе [{#T}](datalens-connect.md).

    * `--websql-access` — разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}. Значение по умолчанию — `false`.

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * `performance-diagnostics` — активация сбора статистики для [диагностики производительности кластера](performance-diagnostics.md). Допустимые значения параметров `sessions-sampling-interval` и `statements-sampling-interval` — от `1` до `86400` секунд.

    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Чтобы изменить время начала резервного копирования, добавьте к описанию кластера {{ mmy-name }} блок `backup_window_start`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        backup_window_start {
          hours   = <час>
          minutes = <минута>
        }
        ...
      }
      ```

      Где:

      * `hours` — час начала резервного копирования.
      * `minutes` — минута начала резервного копирования.

  1. Чтобы изменить срок хранения резервных копий, укажите в описании кластера параметр `backup_retain_period_days`:

      ```hcl
        resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
          ...
          backup_retain_period_days = <срок_хранения_копий>
          ...
        }
      ```

      Где `backup_retain_period_days` — срок хранения автоматических резервных копий в днях. Допустимые значения: от `7` до `60`. Значение по умолчанию — `7`.

  1. {% include [Access settings](../../_includes/mdb/mmy/terraform/access-settings.md) %}

  1. {% include [Maintenance window](../../_includes/mdb/mmy/terraform/maintenance-window.md) %}

  1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        deletion_protection = <защита_кластера_от_удаления>
      }
      ```

      Где `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

      {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

  1. Чтобы активировать сбор статистики для [диагностики производительности кластера](performance-diagnostics.md), добавьте к описанию кластера {{ mmy-name }} блок `performance_diagnostics`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<название_кластера>" {
        ...
        performance_diagnostics {
          enabled = true
          sessions_sampling_interval = <интервал_сбора_сессий>
          statements_sampling_interval = <интервал_сбора_запросов>
        }
        ...
      }
      ```

      Допустимые значения параметров `sessions_sampling_interval` и `statements_sampling_interval` — от `1` до `86400` секунд.

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      
      ```json
      {
          "updateMask": "configSpec.backupWindowStart,configSpec.backupRetainPeriodDays,configSpec.access,configSpec.performanceDiagnostics,maintenanceWindow,deletionProtection",
          "configSpec": {
              "backupWindowStart": {
                  "hours": "<часы>",
                  "minutes": "<минуты>",
                  "seconds": "<секунды>",
                  "nanos": "<наносекунды>"
              },
              "backupRetainPeriodDays": "<количество_дней>",
              "access": {
                  "dataLens": <доступ_к_{{ datalens-name }}:_true_или_false>,
                  "webSql": <доступ_к_{{ websql-name }}:_true_или_false>,
                  "dataTransfer": <доступ_к_Data_Transfer:_true_или_false>
              },
              "performanceDiagnostics": {
                  "enabled": <активация_сбора_статистики:_true_или_false>,
                  "sessionsSamplingInterval": "<интервал_сбора_сессий>",
                  "statementsSamplingInterval": "<интервал_сбора_запросов>"
              }
          },
          "maintenanceWindow": {
              "weeklyMaintenanceWindow": {
                  "day": "<день_недели>",
                  "hour": "<час>"
              }
          },
          "deletionProtection": <защита_кластера_от_удаления:_true_или_false>
      }
      ```


      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
      * `configSpec` — настройки кластера:

          * `backupWindowStart` — настройки окна [резервного копирования](../concepts/backup.md).

              В параметре укажите время, когда начинать резервное копирование:

              * `hours` — от `0` до `23` часов;
              * `minutes` — от `0` до `59` минут;
              * `seconds` — от `0` до `59` секунд;
              * `nanos` — от `0` до `999999999` наносекунд.

          * `backupRetainPeriodDays` — сколько дней хранить резервную копию кластера: от `7` до `60` дней.

          
          * `access` — настройки доступа кластера к следующим сервисам {{ yandex-cloud }}:

              * `dataLens` — [{{ datalens-full-name }}](../../datalens/index.yaml);
              * `webSql` — [{{ websql-full-name }}](../../websql/index.yaml);
              * `dataTransfer` — [{{ data-transfer-full-name }}](../../data-transfer/index.yaml).


          * `performanceDiagnostics` — настройки для [сбора статистики](performance-diagnostics.md#activate-stats-collector):

              * `enabled` — активация сбора статистики;
              * `sessionsSamplingInterval` — интервал сбора сессий: от `1` до `86400` секунд;
              * `statementsSamplingInterval` — интервал сбора запросов: от `1` до `86400` секунд.

      * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). В `maintenanceWindow` передайте один из двух параметров:

          * `anytime` — техническое обслуживание происходит в любое время.
          * `weeklyMaintenanceWindow` — техническое обслуживание происходит раз в неделю, в указанное время:

              * `day` — день недели в формате `DDD`;
              * `hour` — час в формате `HH`. Возможные значения: от `1` до `24` часов.

      * `deletionProtection` — защита кластера от непреднамеренного удаления.

          {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

  1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>' \
          --data "@body.json"
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      
      ```json
      {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": {
              "paths": [
                  "config_spec.backup_window_start",
                  "config_spec.backup_retain_period_days",
                  "config_spec.access",
                  "config_spec.performance_diagnostics",
                  "maintenance_window",
                  "deletion_protection"
              ]
          },
          "config_spec": {
              "backup_window_start": {
                  "hours": "<часы>",
                  "minutes": "<минуты>",
                  "seconds": "<секунды>",
                  "nanos": "<наносекунды>"
              },
              "backup_retain_period_days": "<количество_дней>",
              "access": {
                  "data_lens": <доступ_к_{{ datalens-name }}:_true_или_false>,
                  "web_sql": <доступ_к_{{ websql-name }}:_true_или_false>,
                  "data_transfer": <доступ_к_Data_Transfer:_true_или_false>
              },
              "performance_diagnostics": {
                  "enabled": <активация_сбора_статистики:_true_или_false>,
                  "sessions_sampling_interval": "<интервал_сбора_сессий>",
                  "statements_sampling_interval": "<интервал_сбора_запросов>"
              }
          },
          "maintenance_window": {
              "weekly_maintenance_window": {
                  "day": "<день_недели>",
                  "hour": "<час>"
              }
          },
          "deletion_protection": <защита_кластера_от_удаления:_true_или_false>
      }
      ```


      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
      * `config_spec` — настройки кластера:

          * `backup_window_start` — настройки окна [резервного копирования](../concepts/backup.md).

              В параметре укажите время, когда начинать резервное копирование:

              * `hours` — от `0` до `23` часов;
              * `minutes` — от `0` до `59` минут;
              * `seconds` — от `0` до `59` секунд;
              * `nanos` — от `0` до `999999999` наносекунд.

          * `backup_retain_period_days` — сколько дней хранить резервную копию кластера: от `7` до `60` дней.

          
          * `access` — настройки доступа кластера к следующим сервисам {{ yandex-cloud }}:

              * `data_lens` — [{{ datalens-full-name }}](../../datalens/index.yaml);
              * `web_sql` — [{{ websql-full-name }}](../../websql/index.yaml);
              * `data_transfer` — [{{ data-transfer-full-name }}](../../data-transfer/index.yaml).


          * `performance_diagnostics` — настройки для [сбора статистики](performance-diagnostics.md#activate-stats-collector):

              * `enabled` — активация сбора статистики;
              * `sessions_sampling_interval` — интервал сбора сессий: от `1` до `86400` секунд;
              * `statements_sampling_interval` — интервал сбора запросов: от `1` до `86400` секунд.

      * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). В `maintenance_window` передайте один из двух параметров:

          * `anytime` — техническое обслуживание происходит в любое время.
          * `weekly_maintenance_window` — техническое обслуживание происходит раз в неделю, в указанное время:

              * `day` — день недели в формате `DDD`;
              * `hour` — час в формате `HH`. Возможные значения: от `1` до `24` часов.

      * `deletion_protection` — защита кластера от непреднамеренного удаления.

          {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Update \
          < body.json
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

### {{ connection-manager-name }} {#conn-man}

Если в кластере не включена интеграция с сервисом {{ connection-manager-name }}, включите опцию **{{ ui-key.yacloud.mdb.forms.additional-field-connman }}**. Она доступна только в [консоли управления]({{ link-console-main }}).

Для каждого пользователя БД будут созданы:

* [Подключение](../../metadata-hub/concepts/connection-manager.md) {{ connection-manager-name }} с информацией о соединении с БД.

* [Секрет {{ lockbox-name }}](../../metadata-hub/concepts/secret.md), в котором хранится пароль пользователя. Хранение паролей в сервисе {{ lockbox-name }} обеспечивает их безопасность.

  Подключение и секрет создаются для каждого нового пользователя БД. Чтобы увидеть все подключения, на странице кластера выберите вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**.

  Для просмотра информации о подключении требуется роль `connection-manager.viewer`. Вы можете [настраивать доступ к подключениям в {{ connection-manager-name }}](../../metadata-hub/operations/connection-access.md).

  {% note info %}

  Использование сервиса {{ connection-manager-name }} и секретов, созданных с его помощью, не тарифицируется.

  {% endnote %}

## Переместить кластер {#move-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке кластера, который вы хотите переместить.
    1. Выберите пункт **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.
    1. Выберите каталог, в который вы хотите переместить кластер.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы переместить кластер:

    1. Посмотрите описание команды CLI для перемещения кластера:

        ```bash
        {{ yc-mdb-my }} cluster move --help
        ```

    1. Укажите каталог назначения в команде перемещения кластера:

        ```bash
        {{ yc-mdb-my }} cluster move <идентификатор_кластера> \
           --destination-folder-name=<имя_каталога_назначения>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

    1. Измените или добавьте в описании кластера {{ mmy-name }} значение параметра `folder_id`:

        ```hcl
        resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
          ...
          folder_id = "<идентификатор_каталога_назначения>"
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

    {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.move](../api-ref/Cluster/move.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>:move' \
          --data '{
                    "destinationFolderId": "<идентификатор_каталога>"
                  }'
      ```

      Где `destinationFolderId` — идентификатор каталога, куда перемещается кластер. Идентификатор можно получить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/move.md#yandex.cloud.operation.Operation).

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
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "destination_folder_id": "<идентификатор_каталога>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Move
      ```

      Где `destination_folder_id` — идентификатор каталога, куда перемещается кластер. Идентификатор можно получить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}


## Изменить группы безопасности {#change-sg-set}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите группы безопасности для сетевого трафика кластера.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-my }} cluster update --help
        ```

    1. Укажите нужные группы безопасности в команде изменения кластера:

        ```bash
        {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера> \
          --security-group-ids <список_идентификаторов_групп_безопасности>
        ```

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

  1. Измените в описании кластера {{ mmy-name }} значение параметра `security_group_ids`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        security_group_ids = [<список_идентификаторов_групп_безопасности>]
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

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
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "securityGroupIds",
                      "securityGroupIds": [
                        "<идентификатор_группы_безопасности_1>",
                        "<идентификатор_группы_безопасности_2>",
                        ...
                        "<идентификатор_группы_безопасности_N>"
                      ]
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае передается только один параметр.

      * `securityGroupIds` — новый список [групп безопасности](../concepts/network.md#security-groups), представленный в виде элементов массива.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

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
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                  "paths": [
                    "security_group_ids"
                  ]
                },
                "security_group_ids": [
                  "<идентификатор_группы_безопасности_1>",
                  "<идентификатор_группы_безопасности_2>",
                  ...
                  "<идентификатор_группы_безопасности_N>"
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается только один параметр.

      * `security_group_ids` — новый список [групп безопасности](../concepts/network.md#security-groups), представленный в виде элементов массива.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect.md#configure-security-groups) для подключения к кластеру.

{% endnote %}

