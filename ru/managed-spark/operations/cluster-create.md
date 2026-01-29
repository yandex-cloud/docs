---
title: Создание кластера {{ SPRK }}
description: Каждый кластер {{ SPRK }} содержит вычислительные ресурсы, на которых запускаются Spark-приложения.
keywords:
  - создание кластера {{ SPRK }}
  - кластер {{ SPRK }}
  - '{{ SPRK }}'
---

# Создание кластера {{ SPRK }}

Каждый [кластер](../../glossary/cluster.md) {{ SPRK }} содержит вычислительные ресурсы, на которых запускаются Spark-приложения.

## Роли для создания кластера {#roles}

Для создания кластера {{ SPRK }} вашему аккаунту в {{ yandex-cloud }} нужны роли:

* [managed-spark.admin](../security.md#managed-spark-admin) — чтобы создать кластер;
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../../vpc/concepts/network.md#network) кластера;
* [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) — чтобы привязать сервисный аккаунт к кластеру.

Сервисному аккаунту кластера должны быть назначены роли `managed-spark.integrationProvider` и `storage.editor`. Это даст кластеру нужные права для работы с пользовательскими ресурсами.


О назначении ролей читайте в [документации {{ iam-full-name }}](../../iam/operations/roles/grant.md).


## Создать кластер {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ SPRK }}.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Задайте имя кластера. Имя должно быть уникальным в рамках каталога.
        1. (Опционально) Введите описание кластера.
        1. (Опционально) Создайте [метки](../../resource-manager/concepts/labels.md):

            1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.

        1. Выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) или [создайте новый](../../iam/operations/sa/create.md).

            Сервисному аккаунту должна быть назначена роль `managed-spark.integrationProvider`.

        1. Выберите версию {{ SPRK }}.

           {% include [change-version-note](../../_includes/managed-spark/change-version-note.md) %}

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите [сеть](../../vpc/operations/network-create.md), [подсеть](../../vpc/operations/subnet-create.md) и [группу безопасности](../../vpc/concepts/security-groups.md) для кластера.

    1. Задайте вычислительные ресурсы, на которых будут запускаться Spark-приложения:

       * Конфигурация драйвера — количество хостов и [их класс](../concepts/instance-types.md) для драйвера (driver). Может быть фиксированным или автомасштабируемым.
       * Конфигурация исполнителя — количество хостов и [их класс](../concepts/instance-types.md) для исполнителя (executor). Может быть фиксированным или автомасштабируемым.

    1. При необходимости задайте дополнительные настройки кластера:
        
        1. **{{ ui-key.yacloud.mdb.forms.title_pip-packages }}** и **{{ ui-key.yacloud.mdb.forms.title_deb-packages }}** — названия pip- и deb-пакетов, чтобы установить в кластер дополнительные библиотеки и приложения.
           
           Чтобы указать более одного пакета, нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

           Формат названия пакета и выбор версии определены командой установки: `pip install` — для pip-пакетов, `apt install` — для deb-пакетов.
        
        1. **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени технического обслуживания:

           {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

        1. **{{ ui-key.yacloud.spark.label_metastore }}** — [metastore-сервер](../../metadata-hub/concepts/metastore.md), подключенный к вашему кластеру.

        1.  **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}** — управляет защитой кластера от непреднамеренного удаления.
        1. Чтобы использовать сервис для мониторинга приложений [Spark History Server](https://spark.apache.org/docs/latest/monitoring.html), включите настройку **{{ ui-key.yacloud.spark.label_history-server }}**. После создания кластера сервис будет доступен по ссылке.
        1. Настройте логирование:

            1. Включите настройку **{{ ui-key.yacloud.logging.field_logging }}**.
            1. Выберите место записи логов:
                * **{{ ui-key.yacloud.common.folder }}** — выберите каталог из списка.
                * **{{ ui-key.yacloud.logging.label_group }}** — выберите [лог-группу](../../logging/concepts/log-group.md) из списка или создайте новую.
            1. Выберите **{{ ui-key.yacloud.logging.label_minlevel }}** из списка.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать кластер {{ SPRK }}:

    1. Проверьте, есть ли в каталоге подсети для хостов кластера:

        ```bash
        yc vpc subnet list
        ```

        Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.

    1. Посмотрите описание команды CLI для создания кластера:

        ```bash
        {{ yc-mdb-sp }} cluster create --help
        ```

    1. Укажите параметры кластера в команде создания (в примере приведены не все доступные параметры):

        ```bash
        {{ yc-mdb-sp }} cluster create \
           --name <имя_кластера> \
           --spark-version <<версия_Apache_Spark>> \
           --service-account-id <идентификатор_сервисного_аккаунта> \
           --subnet-ids <список_идентификаторов_подсетей> \
           --security-group-ids <список_идентификаторов_групп_безопасности> \
           --driver-preset-id=<класс_вычислительных_ресурсов_драйвера> \
           --driver-fixed-size <количество_хостов_драйвера> \
           --executor-preset-id <класс_вычислительных_ресурсов_исполнителя> \
           --executor-min-size <минимальное_количество_хостов_исполнителя> \
           --executor-max-size <максимальное_количество_хостов_исполнителя> \
           --pip-packages <список_pip-пакетов> \
           --deb-packages <список_deb-пакетов>\
           --history-server-enabled \ 
           --metastore-cluster-id <идентификатор_кластера> \
           --deletion-protection
        ```

        Где:

        * `--name` — имя кластера. Оно должно быть уникальным в рамках каталога.
        * `--version` — версия {{ SPRK }}.

           {% include [change-version-note](../../_includes/managed-spark/change-version-note.md) %}

        * `--service-account-id` — идентификатор сервисного аккаунта.
        * `--subnet-ids` — список идентификаторов подсетей.
        * `--security-group-ids` — список идентификаторов групп безопасности.
        * `--driver-preset-id` — [класс вычислительных ресурсов](../concepts/instance-types.md) [драйвера](../concepts/index.md#concepts).
        * `--driver-fixed-size` — фиксированное количество экземпляров драйвера.
        * `--driver-min-size` — минимальное количество экземпляров драйвера.
        * `--driver-max-size` — максимальное количество экземпляров драйвера.

           Укажите либо фиксированное количество драйверов, либо минимальное и максимальное количество драйверов для автоматического масштабирования.

        * `--executor-preset-id` — [класс вычислительных ресурсов](../concepts/instance-types.md) исполнителя.
        * `--executor-fixed-size` — фиксированное количество экземпляров исполнителя.
        * `--executor-min-size` — минимальное количество экземпляров исполнителя.
        * `--executor-max-size` — максимальное количество экземпляров исполнителя.

           Укажите либо фиксированное количество исполнителей, либо минимальное и максимальное количество исполнителей для автоматического масштабирования.

        * `--pip-packages` — список pip-пакетов, который позволяет установить в кластер дополнительные библиотеки и приложения.

            Формат названия пакета и выбор версии определены командой установки `pip install`.

        * `--deb-packages` — список deb-пакетов, который позволяет установить в кластер дополнительные библиотеки и приложения.

            Формат названия пакета и выбор версии определены командой установки `apt install`.

        * `--history-server-enabled` — флаг включения сервера истории. Позволяет использовать сервис для мониторинга приложений Spark History Server.

        * `--metastore-cluster-id` — идентификатор кластера [{{ metastore-name }}](../../metadata-hub/concepts/metastore.md) для использования в качестве хранилища метаданных.

        * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

            Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

    1. Чтобы включить отправку логов {{ SPRK }} в сервис [{{ cloud-logging-full-name }}](../../logging/), задайте параметры логирования:

        ```bash
        {{ yc-mdb-sp }} cluster create <имя_кластера> \
           ...
           --log-enabled \
           --log-folder-id <идентификатор_каталога>
        ```

        Где:

        * `--log-enabled` — включает логирование.
        * `--log-folder-id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
        * `--log-group-id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

            Укажите либо идентификатор каталога, либо идентификатор пользовательской лог-группы.

    1. Чтобы настроить время технического обслуживания (в т. ч. для выключенных кластеров), передайте нужное значение в параметре `--maintenance-window`:

        ```bash
        {{ yc-mdb-sp }} cluster create <имя_кластера> \
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

    Чтобы создать кластер {{ msp-full-name }}:

    1. Опишите в конфигурационном файле создаваемые ресурсы:

        * Кластер {{ msp-full-name }} — описание кластера.

        * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

        * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

        {% include [Terraform cluster parameters description](../../_includes/mdb/msp/terraform/cluster-parameters.md) %}

    1. При необходимости задайте дополнительные настройки:

        {% include [Terraform cluster additional parameters description](../../_includes/mdb/msp/terraform/cluster-parameters-additional.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер {{ msp-full-name }}.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-msp }}).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:
    
       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
    
    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    
    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

       ```json
       {
         "folder_id": "<идентификатор_каталога>",
         "name": "<имя_кластера>",
         "description": "<описание_кластера>",
         "labels": { <список_меток> },
         "config": {
           "resource_pools": {
             "driver": {
               "resource_preset_id": "<идентификатор_ресурсов>",
               "scale_policy": {
                 "fixed_scale": {
                   "size": "<количество_экземпляров>"
                 }
               }
             },
             "executor": {
               "resource_preset_id": "<идентификатор_ресурсов>",
               "scale_policy": {
                 "auto_scale": {
                   "min_size": "<минимальное_количество_экземпляров>",
                   "max_size": "<максимальное_количество_экземпляров>"
                 }
               }
             },
             "spark_version": "<версия_Apache_Spark>"
           },
           "history_server": {
             "enabled": <использование_Apache_Spark_History_Server>
           },
           "dependencies": {
             "pip_packages": [ <список_pip-пакетов> ],
             "deb_packages": [ <список_deb-пакетов> ]
           },
           "metastore": {
             "cluster_id": "<идентификатор_кластера>"
           }
         },
         "network": {
           "subnet_ids": [ <список_идентификаторов_подсетей> ],
           "security_group_ids": [ <список_идентификаторов_групп_безопасности> ]
         },
         "deletion_protection": <защита_от_удаления>,
         "service_account_id": "<идентификатор_сервисного_аккаунта>",
         "logging": {
           "enabled": <использование_логирования>,
           "folder_id": "<идентификатор_каталога>"
         }
       }
       ```

       Где:

       * `folder_id` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
       * `name` — имя кластера.
       * `description` — описание кластера.
       * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
       * `config` — конфигурация кластера:

           * `resource_pools` — конфигурация пулов ресурсов:

               * `driver` — конфигурация хостов для запуска драйверов {{ SPRK }}.

                   * `resource_preset_id` — [класс хостов](../concepts/instance-types.md) драйвера.
                   * `scale_policy` — политика масштабирования групп хостов для драйвера:

                       * `fixed_scale` — фиксированная политика масштабирования.
                           * `size` — количество хостов для драйвера.

                       * `auto_scale` — автоматическая политика масштабирования.
                           * `min_size` — минимальное количество хостов для драйвера.
                           * `max_size` — максимальное количество для драйвера.

                           Укажите один из двух параметров: `fixed_scale` либо `auto_scale`.

               * `executor` — конфигурация хостов для запуска исполнителей {{ SPRK }}.

                   * `resource_preset_id` — [класс хостов](../concepts/instance-types.md) исполнителя.
                   * `scale_policy` — политика масштабирования групп хостов для исполнителя:

                       * `fixed_scale` — фиксированная политика масштабирования.
                           * `size` — количество хостов для исполнителя.

                       * `auto_scale` — автоматическая политика масштабирования.
                           * `min_size` — минимальное количество хостов для исполнителя.
                           * `max_size` — максимальное количество для исполнителя.

                           Укажите один из двух параметров: `fixed_scale` либо `auto_scale`. 

           * `history_server` — параметры сервера истории.
              * `enabled` — флаг включения сервера истории. Позволяет использовать сервис для мониторинга приложений Spark History Server.

           * `dependencies` — списки пакетов, которые позволяют установить в кластер дополнительные библиотеки и приложения.
              * `pip_packages` — список pip-пакетов.
              * `deb_packages` — список deb-пакетов.

              Формат названия пакета и выбор версии определены командой установки: `pip install` — для pip-пакетов, `apt install` — для deb-пакетов.

           * `metastore` — параметры метахранилища.
              * `cluster_id` — идентификатор кластера [{{ metastore-name }}](../../metadata-hub/concepts/metastore.md).

           * `spark_version` — версия {{ SPRK }}.

              {% include [change-version-note](../../_includes/managed-spark/change-version-note.md) %}

       * `network` — сетевые настройки:
          * `subnet_ids` — список идентификаторов подсетей.
          * `security_group_ids` — список идентификаторов групп безопасности.

       * `deletion_protection` — позволяет включить защиту кластера от непреднамеренного удаления. Возможные значения: `true` или `false`.

          Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

       * `service_account_id` — идентификатор сервисного аккаунта.

       * `logging` — параметры логирования:
          * `enabled` — позволяет включить логирование. Логи, сгенерированные Spark-приложениями, будут отправляться в {{ cloud-logging-full-name }}. Возможные значения: `true` или `false`.
          * `folder_id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
          * `log_group_id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

          Укажите один из двух параметров: `folder_id` либо `log_group_id`.

    1. Воспользуйтесь вызовом [ClusterService/Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

       ```bash
       grpcurl \
           -format json \
           -import-path ~/cloudapi/ \
           -import-path ~/cloudapi/third_party/googleapis/ \
           -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
           -rpc-header "Authorization: Bearer $IAM_TOKEN" \
           -d @ \
           {{ api-host-spark }}:{{ port-https }} \
           yandex.cloud.spark.v1.ClusterService.Create \
           < body.json
       ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Примеры {#examples}

{% list tabs group=instructions %}

- CLI {#cli}

    Создайте кластер {{ SPRK }} с тестовыми характеристиками:

    * Имя — `myspark`.
    * Сервисный аккаунт — `ajev56jp96ji********`.
    * Подсеть — `{{ subnet-id }}`.
    * Группа безопасности — `{{ security-group }}`.
    * 2 драйвера с [классом вычислительных ресурсов](../concepts/instance-types.md) — `c2-m16`.
    * 4 исполнителя с классом вычислительных ресурсов — `c2-m16`.
    * Включенный сервер истории.
    * Защита от непреднамеренного удаления.

    Выполните следующую команду:

    ```bash
    {{ yc-mdb-sp }} cluster create \
       --name myspark \
       --service-account-id ajev56jp96ji******** \
       --subnet-ids {{ subnet-id }} \
       --security-group-ids {{ security-group }} \
       --driver-preset-id c2-m16 \
       --driver-fixed-size 2 \
       --executor-preset-id c2-m16 \
       --executor-fixed-size 4 \
       --history-server-enabled \
       --deletion-protection
    ```

- {{ TF }} {#tf}

    Создайте кластер {{ SPRK }} и сеть для него с тестовыми характеристиками:

    * Имя — `myspark`.
    * Сервисный аккаунт — `ajev56jp96ji********`.
    * Сеть — `msp-network`.
    * Подсеть — `msp-subnet`. Зона доступности подсети — `ru-central1-a`, диапазон — `10.1.0.0/16`.
    * 2 драйвера с [классом вычислительных ресурсов](../concepts/instance-types.md) — `c2-m16`.
    * 4 исполнителя с классом вычислительных ресурсов — `c2-m16`.
    * Включенный сервер истории.
    * Защита от непреднамеренного удаления.
    * Отключенное логирование.

    Конфигурационный файл для такого кластера выглядит так:

    ```hcl
    resource "yandex_spark_cluster" "myspark" {
      name                = "myspark"
      service_account_id  = "ajev56jp96ji********"
      deletion_protection = true

      network = {
        subnet_ids = [yandex_vpc_subnet.msp-subnet.id]
      }

      config = {
        resource_pools = {
          driver = {
            resource_preset_id = "c2-m16"
            size               = 2
          }
          executor = {
            resource_preset_id = "c2-m16"
            size               = 4
          }
        }
        history_server = {
          enabled = true
        }
      }

      logging = {
        enabled = false
      }
    }

    resource "yandex_vpc_network" "msp-network" {
      name = "msp-network"
    }

    resource "yandex_vpc_subnet" "msp-subnet" {
      name           = "msp-subnet"
      zone           = "ru-central1-a"
      network_id     = yandex_vpc_network.msp-network.id
      v4_cidr_blocks = ["10.1.0.0/16"]
    }
    ```

{% endlist %}
