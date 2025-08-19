---
title: Создание кластера {{ TR }}
description: Каждый кластер {{ mtr-name }} состоит из набора компонентов {{ TR }}, каждый из которых может быть представлен в нескольких экземплярах. Экземпляры могут находиться в разных зонах доступности.
keywords:
  - создание кластера {{ TR }}
  - кластер {{ TR }}
  - '{{ TR }}'
---

# Создание кластера {{ TR }}

Каждый [кластер](../../glossary/cluster.md) {{ mtr-name }} состоит из набора компонентов {{ TR }}: [координатора](../concepts/index.md#coordinator) и [воркеров](../concepts/index.md#workers), которые могут быть представлены в нескольких экземплярах.

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
    1. В блоке **Политика перезапросов** задайте параметры [отказоустойчивого выполнения запросов](../concepts/retry-policy.md):
        1. Выберите **Тип объекта для перезапроса**:
           * **Задача** — в рамках запроса повторно выполняется промежуточное задание, вызвавшее сбой воркера.
           * **Запрос** — повторно выполняются все [этапы запроса](../concepts/index.md#query-execution), в котором произошел сбой воркера.
        1. (Опционально) В поле **Параметры перезапросов** задайте дополнительные параметры в формате `ключ: значение`. Подробнее о параметрах см. в [документации {{ TR }}](https://trino.io/docs/current/admin/fault-tolerant-execution.html#advanced-configuration).
        1. (Опционально) В поле **Параметры хранилища** задайте дополнительные параметры хранилища Exchange Manager в формате `ключ: значение`. Подробнее о параметрах см. в [документации {{ TR }}](https://trino.io/docs/current/admin/fault-tolerant-execution.html#id1).

    1. Задайте конфигурацию [координатора](../concepts/index.md#coordinator) и [воркеров](../concepts/index.md#workers).
    1. В блоке **{{ ui-key.yacloud.trino.title_catalogs }}** добавьте необходимые [каталоги Trino](../concepts/index.md#catalog). Вы можете сделать это как при создании кластера, так и позже. Подробнее см. в разделе [Создание каталога {{ TR }}](catalog-create.md).
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}**:

        1. (Опционально) Включите защиту от удаления кластера.
        1. (Опционально) Выберите время [технического обслуживания](../concepts/maintenance.md) кластера:

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

        1. (Опционально) Настройте логирование:

            1. Включите настройку **{{ ui-key.yacloud.logging.field_logging }}**.
            1. Выберите место записи логов:
                * **{{ ui-key.yacloud.common.folder }}** — выберите каталог из списка. Логи будут записываться в лог-группу по умолчанию выбранного каталога.
                * **{{ ui-key.yacloud.logging.label_group }}** — выберите [лог-группу](../../logging/concepts/log-group.md) из списка или создайте новую.
            1. Выберите **{{ ui-key.yacloud.logging.label_minlevel }}** из списка.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать кластер {{ mtr-name }}:

    
    1. Проверьте, есть ли в каталоге подсети для хостов кластера:

        ```bash
        yc vpc subnet list
        ```

        Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.


    1. Посмотрите описание команды CLI для создания кластера:

        ```bash
        {{ yc-mdb-tr }} cluster create --help
        ```

    1. Укажите параметры кластера в команде создания (в примере приведены не все доступные параметры):

        ```bash
        {{ yc-mdb-tr }} cluster create \
           --name <имя_кластера> \
           --service-account-id <идентификатор_сервисного_аккаунта> \
           --subnet-ids <список_идентификаторов_подсетей> \
           --security-group-ids <список_идентификаторов_групп_безопасности> \
           --coordinator resource-preset-id=<класс_вычислительных_ресурсов> \
           --worker resource-preset-id=<класс_вычислительных_ресурсов>,count=<количество_воркеров> \
           --deletion-protection
        ```

        Где:

        * `--name` — имя кластера. Оно должно быть уникальным в рамках каталога.
        * `--service-account-id` — идентификатор сервисного аккаунта.
        * `--subnet-ids` — список идентификаторов подсетей.
        * `--security-group-ids` — список идентификаторов групп безопасности.
        * `--coordinator` — конфигурация [координатора](../concepts/index.md#coordinator):

            * `resource-preset-id` — [класс вычислительных ресурсов](../concepts/instance-types.md) координатора.

        * `--worker` — конфигурация [воркера](../concepts/index.md#workers):

            * `resource-preset-id` — [класс вычислительных ресурсов](../concepts/instance-types.md) воркера.
            * `count` — фиксированное количество воркеров.
            * `minCount` — минимальное количество воркеров для автоматического масштабирования.
            * `maxCount` — максимальное количество воркеров для автоматического масштабирования.

            Укажите либо фиксированное количество воркеров (`count`), либо минимальное и максимальное количество воркеров (`minCount`, `maxCount`) для автоматического масштабирования.

        * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

            Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

    1. Чтобы включить отправку логов {{ TR }} в сервис [{{ cloud-logging-full-name }}](../../logging/), задайте параметры логирования:

        ```bash
        {{ yc-mdb-tr }} cluster create <имя_кластера> \
           ...
           --log-enabled \
           --log-folder-id <идентификатор_каталога> \
           --log-min-level <уровень_логирования>
        ```

        Где:

        * `--log-enabled` — включает логирование.
        * `--log-folder-id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
        * `--log-group-id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

            Вы можете указать только один из параметров: `--log-folder-id` или `--log-group-id`.

        * `--log-min-level` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO` (значение по умолчанию), `WARN`, `ERROR` и `FATAL`.

    1. Чтобы включить политику [отказоустойчивого выполнения запросов](../concepts/retry-policy.md), задайте параметры:

        ```bash
        {{ yc-mdb-tr }} cluster create <имя_кластера> \
           ...
           --retry-policy-enabled \
           --retry-policy \
           --retry-policy-additional-properties <список_дополнительных_параметров_политики_перезапросов> \
           --retry-policy-exchange-manager-service-s3 \
           --retry-policy-exchange-manager-additional-properties <список_дополнительных_параметров_хранилища>
        ```

        Где:

        * `--retry-policy-enabled` — включает политику перезапросов.
        * `--retry-policy` — способ повторного выполнения запросов. Возможные значения:

            * `task` — в рамках запроса повторно выполняется промежуточное задание, вызвавшее сбой воркера.
            * `query` — повторно выполняются все [этапы запроса](../concepts/index.md#query-execution), в котором произошел сбой воркера.

        * `--retry-policy-additional-properties` — дополнительные параметры повторного выполнения запросов в формате `<ключ>=<значение>`. Подробнее о параметрах см. в [документации {{ TR }}]({{ tr.docs}}/admin/fault-tolerant-execution.html#advanced-configuration).
        * `--retry-policy-exchange-manager-service-s3` — использование S3-хранилища для записи данных при перезапросах.
        * `--retry-policy-exchange-manager-additional-properties` — дополнительные параметры хранилища в формате `<ключ>=<значение>`. Подробнее о параметрах см. в [документации {{ TR }}]({{ tr.docs}}/admin/fault-tolerant-execution.html#id1).

    1. Чтобы настроить время технического обслуживания (в т. ч. для выключенных кластеров), передайте нужное значение в параметре `--maintenance-window`:

        ```bash
        {{ yc-mdb-tr }} cluster create <имя_кластера> \
           ...
           --maintenance-window type=<тип_технического_обслуживания>,`
                               `day=<день_недели>,`
                               `hour=<час_дня> \
        ```

        Где `type` — тип технического обслуживания:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    Чтобы создать кластер {{ mtr-name }}:

    1. Опишите в конфигурационном файле создаваемые ресурсы:

        * Кластер {{ mtr-name }} — описание кластера.

        * Каталог {{ mtr-name }} — описание каталога.

        * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

        * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

        {% include [Terraform cluster parameters description](../../_includes/managed-trino/terraform/cluster-parameters.md) %}

    1. Чтобы создать в кластере [каталоги {{ TR }}](../concepts/index.md#catalog), добавьте в конфигурационный файл нужное количество ресурсов `yandex_trino_catalog`. Вы можете сделать это как при создании кластера, так и позже. Подробнее см. в разделе [Создание каталога {{ TR }}](catalog-create.md).

    1. Чтобы включить отправку логов {{ TR }} в сервис [{{ cloud-logging-full-name }}](../../logging/), добавьте к описанию кластера блок `logging`:

        {% include [Terraform logging parameters description](../../_includes/managed-trino/terraform/logging-parameters.md) %}

    1. Чтобы включить политику [отказоустойчивого выполнения запросов](../concepts/retry-policy.md), добавьте к описанию кластера блок `retry_policy`:

        {% include [Terraform retry policy parameters description](../../_includes/managed-trino/terraform/retry-policy-parameters.md) %}

    1. Чтобы настроить время технического обслуживания (в т. ч. для выключенных кластеров), добавьте к описанию кластера блок `maintenance_window`:

        {% include [Terraform maintenance window parameters description](../../_includes/managed-trino/terraform/maintenance-window-parameters.md) %}

    Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mtr }}).

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
                "resourcePresetId": "<класс_вычислительных_ресурсов>"
              }
            },
            "workerConfig": {
              "resources": {
                "resourcePresetId": "<класс_вычислительных_ресурсов>"
              },
              "scalePolicy": {
                "autoScale": {
                  "minCount": "<минимальное_количество_экземпляров>",
                  "maxCount": "<максимальное_количество_экземпляров>"
                }
              }
            }
          },
          "retryPolicy": {
            "policy": "<тип_объекта_для_перезапроса>",
            "exchangeManager": {
              "storage": {
                "serviceS3": {}
              },
              "additionalProperties": {<дополнительные_параметры_хранилища>}
            },
            "additionalProperties": {<дополнительные_параметры_перезапросов>}
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

               * `resources.resourcePresetId` — [класс вычислительных ресурсов](../concepts/instance-types.md) координатора.

            * `workerConfig` — конфигурация воркера.

               * `resources.resourcePresetId` — [класс вычислительных ресурсов](../concepts/instance-types.md) воркера.

               * `scalePolicy` — политика масштабирования воркеров:

                  * `fixedScale` — фиксированная политика масштабирования.

                     * `count` — количество воркеров.

                  * `autoScale` — автоматическая политика масштабирования.

                      * `minCount` — минимальное количество воркеров.
                      * `maxCount` — максимальное количество воркеров.

                  Укажите один из двух параметров: `fixedScale` либо `autoScale`. 

            * `retryPolicy` — параметры [отказоустойчивого выполнения запросов](../concepts/retry-policy.md).

               * `policy` – способ повторного выполнения запросов. Возможные значения:

                  * `TASK` — в рамках запроса повторно выполняется промежуточное задание, вызвавшее сбой воркера.
                  * `QUERY` – повторно выполняются все [этапы запроса](../concepts/index.md#query-execution), в котором произошел сбой воркера.

               * `exchangeManager.additionalProperties` – дополнительные параметры хранилища Exchange Manager в формате `ключ: значение`. Подробнее о параметрах см. в [документации {{ TR }}](https://trino.io/docs/current/admin/fault-tolerant-execution.html#id1).

               * `additionalProperties` – дополнительные параметры в формате `ключ: значение`. Подробнее о параметрах см. в [документации {{ TR }}](https://trino.io/docs/current/admin/fault-tolerant-execution.html#advanced-configuration).

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
                "resource_preset_id": "<класс_вычислительных_ресурсов>"
              }
            },
            "worker_config": {
              "resources": {
                "resource_preset_id": "<класс_вычислительных_ресурсов>"
              },
              "scale_policy": {
                "auto_scale": {
                  "min_count": "<минимальное_количество_экземпляров>",
                  "max_count": "<максимальное_количество_экземпляров>"
                }
              }
            },
            "retry_policy": {
              "policy": "<тип_объекта_для_перезапроса>",
              "exchange_manager": {
                "storage": {
                  "service_s3": ""
                },
                "additional_properties": {<дополнительные_параметры_хранилища>}
              },
              "additional_properties": {<дополнительные_параметры_перезапросов>}
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

               * `resources.resource_preset_id` — [класс вычислительных ресурсов](../concepts/instance-types.md) координатора.

            * `worker_config` — конфигурация воркера.

               * `resources.resource_preset_id` — [класс вычислительных ресурсов](../concepts/instance-types.md) воркера.

               * `scale_policy` — политика масштабирования воркеров:

                   * `fixed_scale` — фиксированная политика масштабирования.

                      * `count` — количество воркеров.

                   * `auto_scale` — автоматическая политика масштабирования.

                      * `min_count` — минимальное количество воркеров.
                      * `max_count` — максимальное количество воркеров.

                    Укажите один из двух параметров: `fixed_scale` либо `auto_scale`.

            * `retry_policy` — параметры [отказоустойчивого выполнения запросов](../concepts/retry-policy.md).

               * `policy` – способ повторного выполнения запросов. Возможные значения:

                  * `TASK` — в рамках запроса повторно выполняется промежуточное задание, вызвавшее сбой воркера.
                  * `QUERY` – повторно выполняются все [этапы запроса](../concepts/index.md#query-execution), в котором произошел сбой воркера.

               * `exchange_manager.additional_properties` – дополнительные параметры хранилища Exchange Manager в формате `ключ: значение`. Подробнее о параметрах см. в [документации {{ TR }}](https://trino.io/docs/current/admin/fault-tolerant-execution.html#id1).

               * `additional_properties` – дополнительные параметры в формате `ключ: значение`. Подробнее о параметрах см. в [документации {{ TR }}](https://trino.io/docs/current/admin/fault-tolerant-execution.html#advanced-configuration).

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

## Примеры {#examples}

{% list tabs group=instructions %}

- CLI {#cli}

    Создайте кластер {{ mtr-name }} с тестовыми характеристиками:

    * Имя — `mytr`.
    * Сервисный аккаунт — `ajev56jp96ji********`.
    * Подсеть — `{{ subnet-id }}`.
    * Группа безопасности — `{{ security-group }}`.
    * Координатор с [классом вычислительных ресурсов](../concepts/instance-types.md) — `c4-m16`.
    * 4 воркера с [классом вычислительных ресурсов](../concepts/instance-types.md) — `c4-m16`.
    * Защита от непреднамеренного удаления.

    Выполните следующую команду:

    ```bash
    {{ yc-mdb-tr }} cluster create \
       --name mytr \
       --service-account-id ajev56jp96ji******** \
       --subnet-ids {{ subnet-id }} \
       --security-group-ids {{ security-group }} \
       --coordinator resource-preset-id=c4-m16 \
       --worker resource-preset-id=c4-m16,count=4 \
       --deletion-protection
    ```

- {{ TF }} {#tf}

    Создайте кластер {{ mtr-name }} и сеть для него с тестовыми характеристиками:

    * Имя — `mytr`.
    * Сервисный аккаунт — `ajev56jp96ji********`.
    * Сеть — `mtr-network`.
    * Подсеть — `mtr-subnet`. Зона доступности подсети — `ru-central1-a`, диапазон — `10.1.0.0/16`.
    * Координатор с [классом вычислительных ресурсов](../concepts/instance-types.md) — `c4-m16`.
    * 4 воркера с [классом вычислительных ресурсов](../concepts/instance-types.md) — `c4-m16`.
    * Защита от непреднамеренного удаления.

    Конфигурационный файл для такого кластера выглядит так:

    ```hcl
    resource "yandex_trino_cluster" "mytr" {
      name                = "mytr"
      service_account_id  = "ajev56jp96ji********"
      deletion_protection = true
      subnet_ids          = [yandex_vpc_subnet.mtr-subnet.id]

      coordinator = {
        resource_preset_id = "c4-m16"
      }

      worker = {
        fixed_scale = {
          count = 4
        }
        resource_preset_id = "c4-m16"
      }
    }

    resource "yandex_vpc_network" "mtr-network" {
      name = "mtr-network"
    }

    resource "yandex_vpc_subnet" "mtr-subnet" {
      name           = "mtr-subnet"
      zone           = "ru-central1-a"
      network_id     = yandex_vpc_network.mtr-network.id
      v4_cidr_blocks = ["10.1.0.0/16"]
    }
    ```

{% endlist %}
