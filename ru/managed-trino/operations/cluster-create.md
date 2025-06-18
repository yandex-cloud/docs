---
title: Создание кластера {{ TR }}
description: Каждый кластер {{ mtr-name }} состоит из набора компонентов {{ TR }}, каждый из которых может быть представлен в нескольких экземплярах. Экземпляры могут находиться в разных зонах доступности.
keywords:
  - создание кластера {{ TR }}
  - кластер {{ TR }}
  - '{{ TR }}'
---

# Создание кластера {{ TR }}

{% include [preview](../../_includes/managed-trino/note-preview.md) %}

Каждый [кластер](../../glossary/cluster.md) {{ mtr-name }} состоит из набора компонентов {{ TR }}: координатора и воркеров, которые могут быть представлены в нескольких экземплярах.

## Роли для создания кластера {#roles}

Для создания кластера {{ mtr-name }} вашему аккаунту в {{ yandex-cloud }} нужны роли:

* [managed-trino.admin](../security.md#managed-trino-admin) — чтобы создать кластер;
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../../vpc/concepts/network.md#network) кластера;
* [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) — чтобы привязать сервисный аккаунт к кластеру.

[Сервисному аккаунту](../../iam/concepts/users/service-accounts.md) кластера должны быть назначены роли `managed-trino.integrationProvider` и `storage.editor`. Это даст кластеру нужные права для работы с пользовательскими ресурсами. Подробнее см. в разделе [Имперсонация](../concepts/impersonation.md).

О назначении ролей читайте в [документации {{ iam-full-name }}](../../iam/operations/roles/grant.md).

## Создать кластер {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ mtr-name }}.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Задайте имя кластера. Имя должно быть уникальным в рамках каталога.
        1. (Опционально) Введите описание кластера.
        1. (Опционально) Создайте [метки](../../resource-manager/concepts/labels.md):

            1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.

        1. Выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) или [создайте новый](../../iam/operations/sa/create.md).

            Сервисному аккаунту должны быть назначены роли `managed-trino.integrationProvider` и `storage.editor`.

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите [сеть](../../vpc/operations/network-create.md), [подсеть](../../vpc/operations/subnet-create.md) и [группу безопасности](../../vpc/concepts/security-groups.md) для кластера.
    1. Задайте конфигурацию [координатора](../concepts/index.md#coordinator) и [воркеров](../concepts/index.md#workers).
    1. В блоке **{{ ui-key.yacloud.trino.title_catalogs }}** добавьте необходимые [каталоги Trino](../concepts/index.md#catalog). Вы можете сделать это как при создании кластера, так и позже. Подробнее см. в разделе [Создание каталога {{ TR }}](catalog-create.md).
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}**:

        1. (Опционально) Включите защиту от удаления кластера.
        1. (Опционально) Настройте логирование:

            1. Включите настройку **{{ ui-key.yacloud.logging.field_logging }}**.
            1. Выберите место записи логов:
                * **{{ ui-key.yacloud.common.folder }}** — выберите каталог из списка. Логи будут записываться в лог-группу по умолчанию выбранного каталога.
                * **{{ ui-key.yacloud.logging.label_group }}** — выберите [лог-группу](../../logging/concepts/log-group.md) из списка или создайте новую.
            1. Выберите **{{ ui-key.yacloud.logging.label_minlevel }}** из списка.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

       {% note info %}

       В примере приведены не все доступные параметры. Список всех параметров см. в [документации по API](../api-ref/Cluster/create.md#yandex.cloud.trino.v1.CreateClusterRequest).

       {% endnote %}

        ```json
        {
          "folderId": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": { <список_меток> },
          "trino": {
            "coordinatorConfig": {
              "resources": {
                "resourcePresetId": "<идентификатор_ресурсов>"
              }
            },
            "workerConfig": {
              "resources": {
                "resourcePresetId": "<идентификатор_ресурсов>"
              },
              "scalePolicy": {
                "autoScale": {
                  "minCount": "<минимальное_количество_экземпляров>",
                  "maxCount": "<максимальное_количество_экземпляров>"
                }
              }
            }
          },
          "network": {
            "subnetIds": [ <список_идентификаторов_подсетей> ],
            "securityGroupIds": [ <список_идентификаторов_групп_безопасности> ]
          },
          "deletionProtection": "<защита_от_удаления>",
          "serviceAccountId": "<идентификатор_сервисного_аккаунта>",
          "logging": {
            "enabled": "<использование_логирования>",
            "folderId": "<идентификатор_каталога>",
            "minLevel": "<уровень_логирования>"
          }
        }
        ```

        Где:

        * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `trino` — конфигурация [компонентов](../concepts/index.md#cluster-architecture) кластера {{ TR }}.

            * `coordinatorConfig` — конфигурация координатора.

               * `resources.resourcePresetId` — идентификатор вычислительных ресурсов координатора. Возможные значения:

                    * `c4-m16` — 4 vCPU, 16 ГБ RAM.
                    * `c8-m32` — 8 vCPU, 32 ГБ RAM.
              
            * `workerConfig` — конфигурация воркера.

               * `resources.resourcePresetId` — идентификатор вычислительных ресурсов воркера. Возможные значения:

                    * `c4-m16` — 4 vCPU, 16 ГБ RAM.
                    * `c8-m32` — 8 vCPU, 32 ГБ RAM.
              
               * `scalePolicy` — политика масштабирования воркеров:

                  * `fixedScale` — фиксированная политика масштабирования.

                     * `count` — количество воркеров.

                  * `autoScale` — автоматическая политика масштабирования.

                      * `minCount` — минимальное количество воркеров.
                      * `maxCount` — максимальное количество воркеров.

                  Укажите один из двух параметров: `fixedScale` либо `autoScale`. 

        * `network` — сетевые настройки:

            * `subnetIds` — список идентификаторов подсетей.
            * `securityGroupIds` — список идентификаторов групп безопасности.

        * `deletionProtection` — позволяет включить защиту кластера от непреднамеренного удаления. Возможные значения: `true` или `false`.

            Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

        * `serviceAccountId` — идентификатор сервисного аккаунта.
        * `logging` — параметры логирования:

            * `enabled` — позволяет включить логирование. Логи, сгенерированные компонентами {{ TR }}, будут отправляться в {{ cloud-logging-full-name }}. Возможные значения: `true` или `false`.
            * `minLevel` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`.
            * `folderId` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
            * `logGroupId` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

            Укажите один из двух параметров: `folderId` либо `logGroupId`.

    1. Воспользуйтесь методом [Cluster.create](../api-ref/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters'
            --data '@body.json'
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

       {% note info %}

       В примере приведены не все доступные параметры. Список всех параметров см. в [документации по API](../api-ref/grpc/Cluster/create.md#yandex.cloud.trino.v1.CreateClusterRequest).

       {% endnote %}

        ```json
        {
          "folder_id": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": { <список_меток> },
          "trino": {
            "coordinator_config": {
              "resources": {
                "resource_preset_id": "<идентификатор_ресурсов>"
              }
            },
            "worker_config": {
              "resources": {
                "resource_preset_id": "<идентификатор_ресурсов>"
              },
              "scale_policy": {
                "auto_scale": {
                  "min_count": "<минимальное_количество_экземпляров>",
                  "max_count": "<максимальное_количество_экземпляров>"
                }
              }
            }
          },
          "network": {
            "subnet_ids": [ <список_идентификаторов_подсетей> ],
            "security_group_ids": [ <список_идентификаторов_групп_безопасности> ]
          },
          "deletion_protection": "<защита_от_удаления>",
          "service_account_id": "<идентификатор_сервисного_аккаунта>",
          "logging": {
            "enabled": "<использование_логирования>",
            "folder_id": "<идентификатор_каталога>",
            "min_level": "<уровень_логирования>"
          }
        }
        ```

        Где:

        * `folder_id` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `trino` — конфигурация [компонентов](../concepts/index.md#cluster-architecture) кластера {{ TR }}.

            * `coordinator_config` — конфигурация координатора.

               * `resources.resource_preset_id` — идентификатор вычислительных ресурсов координатора. Возможные значения:

                    * `c4-m16` — 4 vCPU, 16 ГБ RAM.
                    * `c8-m32` — 8 vCPU, 32 ГБ RAM.
              
            * `worker_config` — конфигурация воркера.

               * `resources.resource_preset_id` — идентификатор вычислительных ресурсов воркера. Возможные значения:

                    * `c4-m16` — 4 vCPU, 16 ГБ RAM.
                    * `c8-m32` — 8 vCPU, 32 ГБ RAM.
              
               * `scale_policy` — политика масштабирования воркеров:

                    * `fixed_scale` — фиксированная политика масштабирования.

                       * `count` — количество воркеров.

                    * `auto_scale` — автоматическая политика масштабирования.

                       * `min_count` — минимальное количество воркеров.
                       * `max_count` — максимальное количество воркеров.

                    Укажите один из двух параметров: `fixed_scale` либо `auto_scale`. 

        * `network` — сетевые настройки:

            * `subnet_ids` — список идентификаторов подсетей.
            * `security_group_ids` — список идентификаторов групп безопасности.

        * `deletion_protection` — позволяет включить защиту кластера от непреднамеренного удаления. Возможные значения: `true` или `false`.

            Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

        * `service_account_id` — идентификатор сервисного аккаунта.
        * `logging` — параметры логирования:

            * `enabled` — позволяет включить логирование. Логи, сгенерированные компонентами {{ TR }}, будут отправляться в {{ cloud-logging-full-name }}. Возможные значения: `true` или `false`.
            * `min_level` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`.
            * `folder_id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
            * `log_group_id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

            Укажите один из двух параметров: `folder_id` либо `log_group_id`.

    1. Воспользуйтесь вызовом [ClusterService/Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.ClusterService.Create \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}
