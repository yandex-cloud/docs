---
title: Как изменить кластер {{ metastore-full-name }}
description: Следуя данной инструкции, вы сможете изменить кластер {{ metastore-full-name }}.
---

# Изменение кластера {{ metastore-full-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно изменить кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. В строке с нужным кластером нажмите на значок ![options](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:
  
        1. Измените имя и описание кластера.
        1. Удалите или добавьте новые [метки {{ yandex-cloud }}](../../../resource-manager/concepts/labels.md).
        1. Выберите другой [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) или создайте новый с ролью `{{ roles.metastore.integrationProvider }}`.
        1. Измените версию {{ metastore-name }}.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите другую [группу безопасности](configure-security-group.md) или создайте новую.
  1. В блоке **{{ ui-key.yacloud.metastore.label_resource-preset }}** измените [конфигурацию кластера](../../concepts/metastore.md#presets).
  1. В блоке **{{ ui-key.yacloud.logging.label_title }}** включите или выключите запись логов. Если логирование включено:
      * Укажите, в какую лог-группу или каталог будут записываться логи.
      * Выберите минимальный уровень логирования. 
      
      Подробнее см. в разделе [Передача логов кластера](logging.md).
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** включите или выключите защиту кластера от удаления.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы изменить настройки кластера {{ metastore-name }}:

  1. Посмотрите описание команды CLI для изменения кластера:
 
      ```bash
      {{ yc-metastore }} cluster update --help
      ```

  1. Передайте список настроек, которые хотите изменить, в команде изменения кластера:

      ```bash
      {{ yc-metastore }} cluster update <имя_или_идентификатор_кластера> \
         --new-name <имя_кластера> \
         --description <описание_кластера> \
         --labels <список_меток> \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --version <версия_Apache_Hive™_Metastore> \
         --security-group-ids <идентификаторы_групп_безопасности> \
         --resource-preset-id <идентификатор_вычислительных_ресурсов> \
         --maintenance-window type=<тип_технического_обслуживания>,`
                              `day=<день_недели>,`
                              `hour=<час_дня> \
         --deletion-protection \
         --log-enabled \
         --log-folder-id <идентификатор_каталога> \
         --log-min-level <уровень_логирования>
      ```
      Где:

      * `--new-name` — новое имя кластера.

      {% include [CLI cluster parameters description, part 1](../../../_includes/metadata-hub/metastore-cluster-parameters-cli-part-1.md) %}

      {% include [CLI cluster parameters description, part 2](../../../_includes/metadata-hub/metastore-cluster-parameters-cli-part-2.md) %}

      Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "updateMask": "<список_изменяемых_параметров>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": { "<список_меток>" },
          "deletionProtection": <защита_от_удаления>,
          "version": "<версия_Apache_Hive™_Metastore>",
          "configSpec": {
            "resources": {
            "resourcePresetId": "<идентификатор_конфигурации_ресурсов>"
            }
          },
          "serviceAccountId": "<идентификатор_сервисного_аккаунта>",
          "logging": {
            "enabled": <использование_логирования>,
            "folderId": "<идентификатор_каталога>",
            "minLevel": "<уровень_логирования>"
          },
          "networkSpec": {
            "securityGroupIds": [ "<список_идентификаторов_групп_безопасности>" ]
          },
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
            "day": "<день_недели>",
            "hour": "<час>"
            }
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          {% note warning %}

          При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

          {% endnote %}

        {% include [REST cluster parameters description](../../../_includes/metadata-hub/metastore-cluster-parameters-rest.md) %}

        * `networkSpec` — сетевые настройки:
          * `securityGroupIds` — список идентификаторов [групп безопасности](../../../vpc/concepts/network.md#security-groups).

        * {% include [metastore-maintenance-window-rest](../../../_includes/metadata-hub/metastore-maintenance-window-rest.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-metastore }}/managed-metastore/v1/clusters/<идентификатор_кластера>' \
            --data '@body.json'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": "<список_изменяемых_параметров>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": "{ <список_меток> }",
          "deletion_protection": <защита_от_удаления>,
          "version": "<версия_Apache_Hive™_Metastore>",
          "config_spec": {
            "resources": {
              "resource_preset_id": "<идентификатор_конфигурации_ресурсов>"
            }
          },
          "service_account_id": "<идентификатор_сервисного_аккаунта>",
          "logging": {
            "enabled": <использование_логирования>,
            "folder_id": "<идентификатор_каталога>",
            "min_level": "<уровень_логирования>"
          },
          "network_spec": {
            "security_group_ids": [ "<список_идентификаторов_групп_безопасности>" ]
          },
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<день_недели>",
              "hour": "<час>"
            }
          }
        }
        ```

        Где:

          * `cluster_id` — идентификатор кластера. Его можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
          * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

              {% cut "Формат перечисления настроек" %}

              ```yaml
              "update_mask": {
                  "paths": [
                      "<настройка_1>",
                      "<настройка_2>",
                      ...
                      "<настройка_N>"
                  ]
              }
              ```

              {% endcut %}

              {% note warning %}

              При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

              {% endnote %}

          {% include [gRPC cluster parameters description](../../../_includes/metadata-hub/metastore-cluster-parameters-grpc.md) %}

          * `network_spec` — сетевые настройки:
            * `security_group_ids` — список идентификаторов [групп безопасности](../../../vpc/concepts/network.md#security-groups).

          * {% include [metastore-maintenance-window-grpc](../../../_includes/metadata-hub/metastore-maintenance-window-grpc.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Update](../../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-metastore }}:{{ port-https }} \
            yandex.cloud.metastore.v1.ClusterService.Update \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [metastore-trademark](../../../_includes/metadata-hub/metastore-trademark.md) %}
