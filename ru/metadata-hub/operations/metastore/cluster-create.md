---
title: Как создать кластер {{ metastore-full-name }}
description: Следуя данной инструкции, вы сможете создать кластер {{ metastore-full-name }}.
---

# Создание кластера {{ metastore-full-name }}

Подробнее о кластерах {{ metastore-name }} в сервисе {{ metadata-hub-name }} см. в разделе [{#T}](../../concepts/metastore.md).

## Перед началом работы {#before-you-begin}

1. Для привязки [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) к кластеру {{ metastore-name }} [убедитесь](../../../iam/operations/roles/get-assigned-roles.md), что вашему аккаунту в {{ yandex-cloud }} назначена роль [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user) или выше.
1. [Настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) в подсети, к которой будет подключен кластер. Это необходимо, чтобы кластер мог взаимодействовать с сервисами {{ yandex-cloud }}.
1. [Настройте группу безопасности](configure-security-group.md).
1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту](../../../iam/operations/sa/assign-role-for-sa.md) роль `{{ roles.metastore.integrationProvider }}`. Она позволяет кластеру от имени сервисного аккаунта [взаимодействовать с сервисами](../../concepts/metastore-impersonation.md) {{ yandex-cloud }}, например, с {{ cloud-logging-full-name }} и {{ monitoring-full-name }}.

    Вы можете добавить дополнительные роли. Их набор зависит от сценария работы. Сервисные роли приведены в [разделе для {{ metastore-name }}](../../security/metastore-roles.md), все доступные роли — в [справочнике](../../../iam/roles-reference.md).

1. Если вы хотите сохранять логи кластера в пользовательскую лог-группу, [создайте ее](../../../logging/operations/create-group.md).

    Подробнее см. в разделе [Передача логов кластера](logging.md).

## Создание кластера {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать сервер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Введите имя кластера. Оно должно быть уникальным в рамках каталога.
    1. (Опционально) Введите описание кластера.
    1. (Опционально) Добавьте [метки {{ yandex-cloud }}](../../../resource-manager/concepts/labels.md) для разделения ресурсов на логические группы.
    1. Укажите сервисный аккаунт, созданный ранее.
    1. Выберите версию {{ metastore-name }}.

        {% include [metastore-version](../../../_includes/metadata-hub/metastore-version-cluster-create.md) %}

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите сеть и подсеть, в которых будет размещен кластер {{ metastore-name }}. Укажите заранее настроенную группу безопасности.
    1. В блоке **{{ ui-key.yacloud.metastore.label_resource-preset }}** выберите [конфигурацию кластера](../../concepts/metastore.md#presets).
    1. (Опционально) Задайте настройки логирования:

        1. Включите опцию **{{ ui-key.yacloud.logging.field_logging }}**.
        1. Выберите, куда записывать логи кластера:

            * В лог-группу по умолчанию — выберите значение **{{ ui-key.yacloud.common.folder }}** в поле **{{ ui-key.yacloud.logging.label_destination }}** и укажите нужный каталог. Логи будут храниться в лог-группе, которая действует по умолчанию в выбранном каталоге.
            * В пользовательскую лог-группу — выберите значение **{{ ui-key.yacloud.logging.label_loggroup }}** в поле **{{ ui-key.yacloud.logging.label_destination }}** и укажите заранее созданную лог-группу.

        1. Выберите минимальный уровень логирования.

            В журнал выполнения записываются логи указанного уровня и выше. Доступные уровни — `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Уровень по умолчанию — `INFO`.
    1. При необходимости включите защиту кластера от непреднамеренного удаления пользователем.

        {% include [Ограничения защиты от удаления кластера](../../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы создать кластер {{ metastore-name }}:

  1. Посмотрите описание команды CLI для создания кластера:
 
      ```bash
      {{ yc-metastore }} cluster create --help
      ```

  1. Укажите параметры кластера в команде создания:

      ```bash
      {{ yc-metastore }} cluster create \
         --name <имя_кластера> \
         --description <описание_кластера> \
         --labels <список_меток> \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --version <версия_Apache_Hive™_Metastore> \
         --subnet-ids <идентификаторы_подсетей> \
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

      * `--name` — имя кластера.

      {% include [CLI cluster parameters description, part 1](../../../_includes/metadata-hub/metastore-cluster-parameters-cli-part-1.md) %}

      * `--subnet-ids` — список идентификаторов подсетей.

      {% include [CLI cluster parameters description, part 2](../../../_includes/metadata-hub/metastore-cluster-parameters-cli-part-2.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "folderId": "<идентификатор_каталога>",
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
          "network": {
            "subnetIds": [ "<список_идентификаторов_подсетей>" ],
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

        * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../../resource-manager/operations/folder/get-id.md).

        {% include [REST cluster parameters description](../../../_includes/metadata-hub/metastore-cluster-parameters-rest.md) %}

        * `network` — сетевые настройки:
          * `subnetIds` — список идентификаторов подсетей.
          * `securityGroupIds` — список идентификаторов [групп безопасности](../../../vpc/concepts/network.md#security-groups).

        * {% include [metastore-maintenance-window-rest](../../../_includes/metadata-hub/metastore-maintenance-window-rest.md) %}

    1. Воспользуйтесь методом [Cluster.Create](../../api-ref/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-metastore }}/managed-metastore/v1/clusters' \
            --data '@body.json'
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "folder_id": "<идентификатор_каталога>",
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
          "network": {
            "subnet_ids": [ "<список_идентификаторов_подсетей>" ],
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

        * `folder_id` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../../resource-manager/operations/folder/get-id.md).

        {% include [gRPC cluster parameters description](../../../_includes/metadata-hub/metastore-cluster-parameters-grpc.md) %}

        * `network` — сетевые настройки:
            * `subnet_ids` — список идентификаторов подсетей.
            * `security_group_ids` — список идентификаторов [групп безопасности](../../../vpc/concepts/network.md#security-groups).

        * {% include [metastore-maintenance-window-grpc](../../../_includes/metadata-hub/metastore-maintenance-window-grpc.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Create](../../api-ref/grpc/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-metastore }}:{{ port-https }} \
            yandex.cloud.metastore.v1.ClusterService.Create \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [metastore-trademark](../../../_includes/metadata-hub/metastore-trademark.md) %}
