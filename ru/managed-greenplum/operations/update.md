---
title: Как изменить настройки кластера {{ GP }} в {{ mgp-full-name }}
description: Следуя данной инструкции, вы сможете изменить настройки кластера {{ GP }}.
---

# Изменение настроек кластера {{ GP }}


После создания кластера вы можете:

* [Изменить имя и описание кластера](#change-name-and-description).
* [Изменить настройку публичного доступа](#change-public-access).
* [Изменить дополнительные настройки кластера](#change-additional-settings).
* [Изменить настройки регламентных операций технического обслуживания](#change-background-settings).
* [Изменить настройки {{ GP }}](#change-gp-settings) согласно документации {{ GP }}.
* [Изменить класс хостов](#change-resource-preset).
* [Изменить тип диска и увеличить размер хранилища](#change-disk-size).

Если вы хотите переместить кластер в другую зону доступности, [восстановите его из резервной копии](cluster-backups.md#restore). Во время восстановления укажите новую зону доступности. В результате вы перенесете хосты кластера.

Если вы используете [внешние источники данных](../concepts/external-tables.md) для работы по протоколу PXF, [узнайте, как настроить протокол](./pxf/settings.md). Так можно оптимизировать работу с внешними данными.

## Изменить имя и описание кластера {#change-name-and-description}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** в верхней части страницы.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** задайте новые имя и описание кластера.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить имя и описание кластера {{ GP }}:

  1. Посмотрите текущие имя (`name`) и описание (`description`) кластера:

     ```bash
     {{ yc-mdb-gp }} cluster get <имя_или_идентификатор_кластера>
     ```

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Задайте новое имя и описание кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update <имя_или_идентификатор_кластера> \
         --new-name <новое_имя_кластера> \
         --description <новое_описание_кластера>
      ```

- {{ TF }} {#tf}

    {% note alert %}

    Не изменяйте имя кластера с помощью {{ TF }}. Это приведет к удалению существующего кластера и созданию нового.

    {% endnote %}

    Чтобы изменить описание кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mgp-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mgp }}).

    1. Измените в описании кластера {{ mgp-name }} значение атрибута `description`:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
          name        = "<имя_кластера>"
          description = "<новое_описание_кластера>"
          ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "name,description",
                      "name": "<новое_имя_кластера>",
                      "description": "<новое_описание_кластера>"
                    }'
        ```

        Где `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ "name", "description" ]
                  },
                  "name": "<новое_имя_кластера>",
                  "description": "<новое_описание_кластера>" 
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройку публичного доступа {#change-public-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** в верхней части страницы.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** установите или отключите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить настройку публичного доступа {{ GP }}:

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Задайте настройку публичного доступа в параметре `--assign-public-ip`:

      ```bash
      {{ yc-mdb-gp }} cluster update <имя_или_идентификатор_кластера> \
         --assign-public-ip=<публичный_доступ_к_кластеру>
      ```

      Где `assign-public-ip` — публичный доступ к кластеру: true или false.

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
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "config.assignPublicIp",
                      "config": {
                        "assignPublicIp": <публичный_доступ_к_хостам_кластера>
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае передается только один параметр.

        * `assignPublicIp` — публичный доступ к хостам кластера: `true` или `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ "config.assign_public_ip" ]
                  },
                  "config": {
                    "assign_public_ip": <публичный_доступ_к_хостам_кластера> 
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае передается только один параметр.

        * `assign_public_ip` — публичный доступ к хостам кластера: `true` или `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note tip %}

Если вы включили публичный доступ к кластеру, но подключение через интернет не срабатывает:

* Проверьте [настройки групп безопасности](./connect#configuring-security-groups).
* Подождите некоторое время. Включение публичного доступа иногда вступает в силу не сразу.

{% endnote %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. Измените дополнительные настройки кластера:

        * {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}
        * **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../concepts/maintenance.md):

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}


        * {% include [Datalens access](../../_includes/mdb/console/datalens-access.md) %}
        * {% include [Query access](../../_includes/mdb/console/query-access.md) %}



        * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

            {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

        * **{{ ui-key.yacloud.greenplum.section_cloud-storage }}** — включает [гибридное хранилище](../concepts/hybrid-storage.md).

            Гибридное хранилище нельзя отключить после сохранения настроек кластера.

            {% include [hybrid-storage-description](../../_includes/mdb/mgp/hybrid-storage-description.md) %}


            {% include [Cloud storage Preview](../../_includes/mdb/mgp/cloud-storage-preview.md) %}


        * **{{ ui-key.yacloud.mdb.forms.section_pooler }}** — режим работы и параметры [менеджера подключений](../concepts/pooling.md):

            {% include [Pooling mode](../../_includes/mdb/mgp/pooling-mode.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-gp }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:


        ```bash
        {{ yc-mdb-gp }} cluster update <имя_или_идентификатор_кластера> \
            --backup-window-start <время_начала_резервного_копирования> \
            --datalens-access=<доступ_из_{{ datalens-name }}> \
            --yandexquery-access=<доступ_из_Yandex_Query> \
            --maintenance-window type=<тип_технического_обслуживания>,`
                                `day=<день_недели>,`
                                `hour=<час_дня> \
            --deletion-protection
        ```




    Вы можете изменить следующие настройки:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}


    * `--datalens-access` — доступ к кластеру из сервиса [{{ datalens-full-name }}](../../datalens/concepts/index.md): `true` или `false`.

    * `--yandexquery-access` — доступ к кластеру из сервиса [{{ yq-full-name }}](../../query/concepts/index.md): `true` или `false`.



    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mgp-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mgp }}).

    1. Измените в описании кластера {{ mgp-name }} значения нужных дополнительных настроек:


        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
          ...
          backup_window_start {
            hours = <начало_периода_резервного_копирования>
          }

          maintenance_window {
            type = <тип_технического_обслуживания>
            day  = <день_недели>
            hour = <час_дня>
          }

          access {
            data_lens    = <доступ_из_{{ datalens-name }}>
            yandex_query = <доступ_из_Yandex_Query>
          }

          deletion_protection = <защита_от_удаления>

          cloud_storage {
            enable = <использование_гибридного_хранилища>
          }

          pooler_config {
            pooling_mode             = <режим_работы>
            pool_size                = <размер>
            pool_client_idle_timeout = <время_ожидания_клиента>
          }
        }
        ```




        Вы можете изменить следующие настройки:

        * `backup_window_start.hours` — начало периода, в течение которого начинается [резервное копирование](../concepts/backup.md) кластера. Задается по UTC в формате `HH`: от `0` до `23`.

        * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров):

            * `type` — тип технического обслуживания. Принимает значения:
                * `ANYTIME` — в любое время.
                * `WEEKLY` — по расписанию.
            * `day` — день недели для типа `WEEKLY` в формате `DDD`. Например, `MON`.
            * `hour` — час дня по UTC для типа `WEEKLY` в формате `HH`. Например, `21`.


        * `access.data_lens` — доступ к кластеру из сервиса [{{ datalens-full-name }}](../../datalens/concepts/index.md): `true` или `false`.

        * `access.yandex_query` — доступ к кластеру из сервиса [{{ yq-full-name }}](../../query/concepts/index.md): `true` или `false`.



        * `deletion_protection` — защита от удаления кластера, его баз данных и пользователей: `true` или `false`.

            {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

        * `cloud_storage.enable` — использование [гибридного хранилища](../concepts/hybrid-storage.md).

            Установите значение `true`, чтобы включить гибридное хранилище. Гибридное хранилище нельзя отключить после сохранения настроек кластера.

            {% include [hybrid-storage-description](../../_includes/mdb/mgp/hybrid-storage-description.md) %}


            {% include [Cloud storage Preview](../../_includes/mdb/mgp/cloud-storage-preview.md) %}


        * `pooler_config` — настройки [менеджера подключений](../concepts/pooling.md):

            * `pooling_mode` — режим работы: `SESSION` или `TRANSACTION`.
            * `pool_size` — количество клиентских соединений.
            * `pool_client_idle_timeout` — время неактивности клиентского соединения в миллисекундах, после которого соединение разрывается.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}


        ```json
        {
          "updateMask": "config.backupWindowStart,config.access.dataLens,config.access.yandexQuery,maintenanceWindow,deletionProtection,configSpec.pool.mode,configSpec.pool.size,configSpec.pool.clientIdleTimeout,cloudStorage",
          "config": {
            "backupWindowStart": {
              "hours": "<часы>",
              "minutes": "<минуты>",
              "seconds": "<секунды>",
              "nanos": "<наносекунды>"
            },
            "access": {
              "dataLens": <доступ_из_{{ datalens-name }}>,
              "yandexQuery": <доступ_из_Yandex_Query>
            }
          },
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<день_недели>",
              "hour": "<час>"
            }
          },
          "deletionProtection": <защита_от_удаления_кластера>,
          "configSpec": {
            "pool": {
              "mode": "<режим_работы>",
              "size": "<количество_клиентских_соединений>",
              "clientIdleTimeout": "<время_ожидания_клиента>"
            }
          },
          "cloudStorage": {
            "enable": <использование_гибридного_хранилища>
          }
        }
        ```




        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `config` — настройки кластера:

            * `backupWindowStart` — настройки окна [резервного копирования](../concepts/backup.md).

                В параметре укажите время, когда начинать резервное копирование:

                * `hours` — от `0` до `23` часов;
                * `minutes` — от `0` до `59` минут;
                * `seconds` — от `0` до `59` секунд;
                * `nanos` — от `0` до `999999999` наносекунд.


            * `access` — настройки доступа кластера к следующим сервисам {{ yandex-cloud }}:

                * `dataLens` — [{{ datalens-full-name }}](../../datalens/index.yaml): `true` или `false`.
                * `yandexQuery` — [{{ yq-full-name }}](../../query/concepts/index.md): `true` или `false`.



        * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Передайте один из двух параметров:

            * `anytime` — техническое обслуживание происходит в любое время.
            * `weeklyMaintenanceWindow` — техническое обслуживание происходит раз в неделю, в указанное время:

                * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                * `hour` — час дня по UTC от `1` до `24`.

        * `deletionProtection` — защита от удаления кластера: `true` или `false`.

            {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

        * `configSpec.pool` — настройки [менеджера подключений](../concepts/pooling.md):

            * `mode` — режим работы: `SESSION` или `TRANSACTION`.
            * `size` — количество клиентских соединений.
            * `clientIdleTimeout` — время неактивности клиентского соединения в миллисекундах, после которого соединение разрывается.

        * `cloudStorage.enable` — использование гибридного хранилища в кластерах с версией {{ GP }} 6.25 и выше. Установите значение `true`, чтобы включить в кластере [расширение {{ YZ }}](https://github.com/yezzey-gp/yezzey/) от {{ yandex-cloud }}. Оно применяется, чтобы [выгрузить таблицы AO и AOCO](../tutorials/yezzey.md) с дисков кластера {{ mgp-name }} в холодное хранилище {{ objstorage-full-name }}. Так данные хранятся в служебном бакете в сжатом и зашифрованном виде. Это [более экономичный способ хранения](../../storage/pricing.md).

            Гибридное хранилище нельзя отключить после сохранения настроек кластера.


            {% include [Cloud storage Preview](../../_includes/mdb/mgp/cloud-storage-preview.md) %}


    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
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
          "cluster_id": "<идентификатор_кластера>"
          "update_mask": {
            "paths": [
              "config.backup_window_start",
              "config.access.data_lens",
              "config.access.yandex_query",
              "maintenance_window",
              "deletion_protection",
              "config_spec.pool.mode",
              "config_spec.pool.size",
              "config_spec.pool.client_idle_timeout",
              "cloud_storage"
            ]
          },
          "config": {
            "backup_window_start": {
              "hours": "<часы>",
              "minutes": "<минуты>",
              "seconds": "<секунды>",
              "nanos": "<наносекунды>"
            },
            "access": {
              "data_lens": <доступ_из_{{ datalens-name }}>,
              "yandex_query": <доступ_из_Yandex_Query>
            }
          },
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<день_недели>",
              "hour": "<час>"
            }
          },
          "deletion_protection": <защита_от_удаления_кластера>,
          "config_spec": {
            "pool": {
              "mode": "<режим_работы>",
              "size": "<количество_клиентских_соединений>",
              "client_idle_timeout": "<время_ожидания_клиента>"
            }
          },
          "cloud_storage": {
            "enable": <использование_гибридного_хранилища>
          }
        }
        ```




        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `config` — настройки кластера:

            * `backup_window_start` — настройки окна [резервного копирования](../concepts/backup.md).

                В параметре укажите время, когда начинать резервное копирование:

                * `hours` — от `0` до `23` часов;
                * `minutes` — от `0` до `59` минут;
                * `seconds` — от `0` до `59` секунд;
                * `nanos` — от `0` до `999999999` наносекунд.


            * `access` — настройки доступа кластера к следующим сервисам {{ yandex-cloud }}:

                * `data_lens` — [{{ datalens-full-name }}](../../datalens/index.yaml): `true` или `false`.
                * `yandex_query` — [{{ yq-full-name }}](../../query/concepts/index.md): `true` или `false`.



        * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Передайте один из двух параметров:

            * `anytime` — техническое обслуживание происходит в любое время.
            * `weekly_maintenance_window` — техническое обслуживание происходит раз в неделю, в указанное время:

                * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                * `hour` — час дня по UTC от `1` до `24`.

        * `deletion_protection` — защита от удаления кластера: `true` или `false`.

            {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

        * `config_spec.pool` — настройки [менеджера подключений](../concepts/pooling.md):

            * `mode` — режим работы: `SESSION` или `TRANSACTION`.
            * `size` — количество клиентских соединений.
            * `client_idle_timeout` — время неактивности клиентского соединения в миллисекундах, после которого соединение разрывается.

        * `cloud_storage.enable` — использование гибридного хранилища в кластерах с версией {{ GP }} 6.25 и выше. Установите значение `true`, чтобы включить в кластере [расширение {{ YZ }}](https://github.com/yezzey-gp/yezzey/) от {{ yandex-cloud }}. Оно применяется, чтобы [выгрузить таблицы AO и AOCO](../tutorials/yezzey.md) с дисков кластера {{ mgp-name }} в холодное хранилище {{ objstorage-full-name }}. Так данные хранятся в служебном бакете в сжатом и зашифрованном виде. Это [более экономичный способ хранения](../../storage/pricing.md).

            Гибридное хранилище нельзя отключить после сохранения настроек кластера.


            {% include [Cloud storage Preview](../../_includes/mdb/mgp/cloud-storage-preview.md) %}


        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки регламентных операций технического обслуживания {#change-background-settings}

Вы можете изменить настройки [регламентных операций технического обслуживания](../concepts/maintenance.md#regular-ops) вашего кластера.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.greenplum.section_background-activities }}** измените параметры:

        {% include [background activities](../../_includes/mdb/mgp/background-activities-console.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

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
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.backgroundActivities.analyzeAndVacuum.start,configSpec.backgroundActivities.analyzeAndVacuum.analyzeTimeout,configSpec.backgroundActivities.analyzeAndVacuum.vacuumTimeout",
                      "configSpec": {
                        "backgroundActivities": {
                          "analyzeAndVacuum": {
                            "start": {
                              "hours": "<час_начала_операции>",
                              "minutes": "<минута_начала_операции>"
                            },
                            "analyzeTimeout": "<длительность_выполнения_операции_ANALYZE>",
                            "vacuumTimeout": "<длительность_выполнения_операции_VACUUM>"
                          }
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `configSpec.backgroundActivities.analyzeAndVacuum` — настройки управления фоновыми процессами:

            * `start.hours` — час начала операции `VACUUM` по UTC. Возможные значения: от `0` до `23`, по умолчанию — `19`.
            * `start.minutes` — минута начала операции `VACUUM` по UTC. Возможные значения: от `0` до `59`, по умолчанию — `0`.
            * `analyzeTimeout` — максимальная длительность выполнения операции `ANALYZE`, в секундах. Возможные значения: от `7200` до `86399`, по умолчанию — `36000`. Когда указанное время истечет, операция `ANALYZE` будет принудительно завершена.
            * `vacuumTimeout` — максимальная длительность выполнения операции `VACUUM`, в секундах. Возможные значения: от `7200` до `86399`, по умолчанию — `36000`. Когда указанное время истечет, операция `VACUUM` будет принудительно завершена.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ 
                      "config_spec.background_activities.analyze_and_vacuum.start",
                      "config_spec.background_activities.analyze_and_vacuum.analyze_timeout",
                      "config_spec.background_activities.analyze_and_vacuum.vacuumTimeout"
                    ]
                  },
                  "config_spec": {
                    "background_activities": {
                      "analyze_and_vacuum": {
                        "start": {
                          "hours": "<час_начала_операции>",
                          "minutes": "<минута_начала_операции>"
                        },
                        "analyze_timeout": "<длительность_выполнения_операции_ANALYZE>",
                        "vacuum_timeout": "<длительность_выполнения_операции_VACUUM>"
                      }
                    }
                  } 
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `config_spec.background_activities.analyze_and_vacuum` — настройки управления фоновыми процессами:

            * `start.hours` — час начала операции `VACUUM` по UTC. Возможные значения: от `0` до `23`, по умолчанию — `19`.
            * `start.minutes` — минута начала операции `VACUUM` по UTC. Возможные значения: от `0` до `59`, по умолчанию — `0`.
            * `analyze_timeout` — максимальная длительность выполнения операции `ANALYZE`, в секундах. Возможные значения: от `7200` до `86399`, по умолчанию — `36000`. Когда указанное время истечет, операция `ANALYZE` будет принудительно завершена.
            * `vacuum_timeout` — максимальная длительность выполнения операции `VACUUM`, в секундах. Возможные значения: от `7200` до `86399`, по умолчанию — `36000`. Когда указанное время истечет, операция `VACUUM` будет принудительно завершена.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки {{ GP }} {#change-gp-settings}

Вы можете изменить настройки СУБД для хостов вашего кластера.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. Измените [настройки {{ GP }}](../concepts/settings-list.md), нажав кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** в блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [настройки СУБД {{ GP }}](../concepts/settings-list.md):

  1. Посмотрите полный список настроек, установленных для кластера:

     ```bash
     {{ yc-mdb-gp }} cluster get <имя_или_идентификатор_кластера>
     ```

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update-config --help
      ```

  1. Установите нужные значения параметров:

      Все поддерживаемые параметры перечислены в [формате запроса для метода update](../api-ref/Cluster/update.md), в поле `greenplumConfig_<версия_Greenplum>`. Чтобы указать имя параметра в вызове CLI, преобразуйте его имя из вида <q>lowerCamelCase</q> в <q>snake_case</q>, например, параметр `maxConnections` из запроса к API преобразуется в `max_connections` для команды CLI:

      ```bash
      {{ yc-mdb-gp }} cluster update-config <имя_или_идентификатор_кластера> \
         --set <имя_параметра1>=<значение1>,<имя_параметра2>=<значение2>,...
      ```

      {{ mgp-short-name }} запустит операцию по изменению настроек кластера.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mgp-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mgp }}).

    1. Измените в описании кластера [настройки {{ GP }}](../concepts/settings-list.md) в блоке `greenplum_config`:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
          ...
          greenplum_config = {
            max_connections         = <максимальное_количество_соединений>
            gp_workfile_compression = <true_или_false>
            ...
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.greenplumConfig_<версия_{{ GP }}>.<настройка_1>,...,configSpec.greenplumConfig_<версия_{{ GP }}>.<настройка_N>",
                      "configSpec": {
                        "greenplumConfig_<версия_{{ GP }}>": {
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

            В данном случае перечислите все изменяемые настройки {{ GP }}.

        * `configSpec.greenplumConfig_<версия_{{ GP }}>` — набор настроек {{ GP }}. Укажите каждую настройку на отдельной строке через запятую.

            Список версий {{ GP }}, доступных для параметра, см. в [описании метода](../api-ref/Cluster/update.md#yandex.cloud.mdb.greenplum.v1.UpdateClusterRequest). Описание и возможные значения настроек см. в разделе [{#T}](../concepts/settings-list.md#dbms-cluster-settings).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ 
                      "config_spec.greenplum_config_<версия_{{ GP }}>.<настройка_1>",
                      "config_spec.greenplum_config_<версия_{{ GP }}>.<настройка_2>",
                      ...
                      "config_spec.greenplum_config_<версия_{{ GP }}>.<настройка_N>"
                    ]
                  },
                  "config_spec": {
                    "greenplum_config_<версия_{{ GP }}>": {
                      "<настройка_1>": "<значение_1>",
                      "<настройка_2>": "<значение_2>",
                      ...
                      "<настройка_N>": "<значение_N>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае перечислите все изменяемые настройки {{ GP }}.

        * `config_spec.greenplum_config_<версия_{{ GP }}>` — набор настроек {{ GP }}. Укажите каждую настройку на отдельной строке через запятую.

            Список версий {{ GP }}, доступных для параметра, см. в [описании метода](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.greenplum.v1.UpdateClusterRequest). Описание и возможные значения настроек см. в разделе [{#T}](../concepts/settings-list.md).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить класс хостов {#change-resource-preset}

Вы можете изменить класс как хостов-мастеров, так и хостов-сегментов. При смене класса хостов:

* В кластере сменится первичный хост-мастер.
* Подключение по [особому FQDN](./connect.md#fqdn-master) не гарантирует стабильность соединения с БД: пользовательские сессии могут быть прерваны.

Изменение класса хостов-сегментов [влияет](../concepts/instance-types.md#select-class-segment-hosts) на максимальный объем памяти, выделенный на каждый серверный процесс {{ GP }}.

Рекомендуется изменять класс хостов только во время отсутствия рабочей нагрузки на кластер.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите нужный класс для хостов-мастеров или хостов-сегментов {{ GP }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Запросите список доступных классов (в колонке `ZONE IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):
     * для хостов-мастеров:

        ```bash
        {{ yc-mdb-gp }} resource-preset list master
        ```

     * для хостов-сегментов:

        ```bash
        {{ yc-mdb-gp }} resource-preset list segment
        ```


     ```text
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     |     ID      |            ZONE IDS            |           DISK TYPES           | CORES |  MEMORY  | HOST COUNT DIVIDER | MAX SEGMENT IN HOST |
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     | i2.2xlarge  | {{ region-id }}-a, {{ region-id }}-b   | local-ssd,                     |    16 | 128.0 GB |                  1 |                   0 |
     |             |                                | network-ssd-nonreplicated      |       |          |                    |                     |
     | ...                                                                                                                                         |
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     ```


  1. Укажите нужные классы в команде изменения кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update <имя_или_идентификатор_кластера> \
          --master-config resource-id=<идентификатор_класса_хостов-мастеров> \
          --segment-config resource-id=<идентификатор_класса_хостов-сегментов>
      ```

      {{ mgp-short-name }} запустит операцию изменения класса хостов для кластера.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mgp-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mgp }}).

  1. Измените в описании кластера {{ mgp-name }} значение атрибута `resource_preset_id` в блоке `master_subcluster.resources` или `segment_subcluster.resources`:

      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
        ...
        master_subcluster {
          resources {
            resource_preset_id = "<класс_хоста>"
            ...
          }
        }
        segment_subcluster {
          resources {
            resource_preset_id = "<класс_хоста>"
            ...
          }
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "masterConfig.resources.resourcePresetId,segmentConfig.resources.resourcePresetId",
                      "masterConfig": {
                        "resources": {
                          "resourcePresetId": "<класс_хостов>"
                        }
                      },
                      "segmentConfig": {
                        "resources": {
                          "resourcePresetId": "<класс_хостов>"
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `masterConfig.resources.resourcePresetId`, `segmentConfig.resources.resourcePresetId` — новый [класс хостов](../concepts/instance-types.md) для хостов-мастеров и хостов-сегментов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ 
                      "master_config.resources.resource_preset_id",
                      "segment_config.resources.resource_preset_id"
                    ]
                  },
                  "master_config": {
                    "resources": {
                      "resource_preset_id": "<класс_хостов>"
                    }
                  },
                  "segment_config": {
                    "resources": {
                      "resource_preset_id": "<класс_хостов>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `master_config.resources.resource_preset_id`, `segment_config.resources.resource_preset_id` — новый [класс хостов](../concepts/instance-types.md) для хостов-мастеров и хостов-сегментов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить тип диска и увеличить размер хранилища {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить тип диска и увеличить размер хранилища для кластера:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Выберите нужный кластер.
  1. В верхней части страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}**:

      * Выберите [тип диска](../concepts/storage.md).
      * Укажите нужный размер диска.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы увеличить размер хранилища для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Укажите нужный размер хранилища для хостов-мастеров или хостов-сегментов в команде изменения кластера (размер хранилища должен быть не меньше, чем значение `disk_size` в свойствах кластера):

      ```bash
      {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера> \
         --master-config disk-size <размер_хранилища_в_гигабайтах> \
         --segment-config disk-size <размер_хранилища_в_гигабайтах>
      ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mgp-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mgp }}).

    1. Измените в описании кластера {{ mgp-name }} значения атрибутов `disk_type_id` и `disk_size` в блоке `master_subcluster.resources` или `segment_subcluster.resources`:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
          ...
          master_subcluster {
            resources {
              disk_type_id = "<тип_диска>"
              disk_size    = <размер_хранилища_в_гигабайтах>
              ...
            }
          }
          segment_subcluster {
            resources {
              disk_type_id = "<тип_диска>"
              disk_size    = <размер_хранилища_в_гигабайтах>
              ...
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "masterConfig.resources.diskTypeId,masterConfig.resources.diskSize,segmentConfig.resources.diskTypeId,segmentConfig.resources.diskSize",
                      "masterConfig": {
                        "resources": {
                          "diskTypeId": "<тип_диска>",
                          "diskSize": "<размер_хранилища_в_байтах>"
                        }
                      },
                      "segmentConfig": {
                        "resources": {
                          "diskTypeId": "<тип_диска>",
                          "diskSize": "<размер_хранилища_в_байтах>"
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `masterConfig.resources`, `segmentConfig.resources` — параметры хранилища для хостов-мастеров и хостов-сегментов:

            * `diskTypeId` — [тип диска](../concepts/storage.md).
            * `diskSize` — новый размер хранилища в байтах.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ 
                      "master_config.resources.disk_type_id",
                      "master_config.resources.disk_size",
                      "segment_config.resources.disk_type_id",
                      "segment_config.resources.disk_size"
                    ]
                  },
                  "master_config": {
                    "resources": {
                      "disk_type_id": "<тип_диска>",
                      "disk_size": "<размер_хранилища_в_байтах>"
                    }
                  },
                  "segment_config": {
                    "resources": {
                      "disk_type_id": "<тип_диска>",
                      "disk_size": "<размер_хранилища_в_байтах>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `master_config.resources`, `segment_config.resources` — параметры хранилища для хостов-мастеров и хостов-сегментов:

            * `disk_type_id` — [тип диска](../concepts/storage.md).
            * `disk_size` — новый размер хранилища в байтах.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
