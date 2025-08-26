---
title: Управление хостами {{ ZK }}
description: Следуя данной инструкции, вы сможете управлять хостами {{ ZK }}.
---

# Управление хостами {{ ZK }}


{{ ZK }} — это сервис, который обеспечивает координацию и распределение запросов между хостами {{ CH }} для [репликации данных](../concepts/replication.md). Для обеспечения репликации в кластере {{ mch-name }} должно быть [три или пять хостов {{ ZK }}](../qa/cluster-settings.md#zookeeper-hosts-number). Такой кластер будет отказоустойчивым.

Если вы создаете кластер с двумя или более хостами {{ CH }} на шард, в кластер автоматически добавятся три хоста {{ ZK }}. При создании вы можете настроить только их конфигурацию. Если вы создали кластер из одного хоста или нескольких однохостовых шардов, хосты {{ ZK }} можно добавить позднее.

Подробнее о работе хостов {{ ZK }} читайте в разделе [{#T}](../concepts/replication.md#zk).

Вы можете выполнить следующие действия над хостами {{ ZK }}:

* [получить список хостов в кластере](#list-hosts);
* [добавить хосты {{ ZK }}](#add-zk);
* [изменить настройки хостов {{ ZK}}](#update-zk-settings);
* [перезагрузить хост](#restart);
* [перенести хосты {{ ZK }} в другую зону доступности](host-migration.md#zookeeper-hosts);
* [удалить хост](#delete-zk-host).

## Получить список хостов в кластере {#list-hosts}

{% include notitle [get-hosts](../../_includes/mdb/mch/get-hosts.md) %}


## Добавить хосты {{ ZK }} {#add-zk}

{% note info %}

В [зоне доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-d` недоступно использование платформы Intel Broadwell.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.mdb.cluster.hosts.button_create-coordinator }}**.
  1. Укажите [класс хостов](../concepts/instance-types.md).
  1. Задайте настройки хранилища.
  1. При необходимости измените настройки хостов {{ ZK }}. Чтобы это сделать, наведите курсор на строку нужного хоста и нажмите на значок ![image](../../_assets/console-icons/pencil.svg).
  1. Чтобы преобразовать нереплицируемые таблицы в [реплицируемые](../concepts/replication.md#replicated-tables), включите настройку **{{ ui-key.yacloud.clickhouse.field_convert_tables_to_replicated }}**. Нереплицируемые таблицы на движке семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree) будут автоматически преобразованы в реплицируемые на движке [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication).

     {% note warning %}

     После включения этой настройки ее нельзя отключить.

     {% endnote %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы добавить в кластер хосты {{ ZK }}:
  1. Посмотрите описание команды CLI для добавления хостов {{ ZK }}:

     ```bash
     {{ yc-mdb-ch }} cluster add-zookeeper --help
     ```

  1. Запустите операцию с характеристиками хостов по умолчанию:

     ```bash
     {{ yc-mdb-ch }} cluster add-zookeeper <имя_кластера> \
        --host zone-id={{ region-id }}-d,subnet-name=default-d \
        --host zone-id={{ region-id }}-a,subnet-name=default-a \
        --host zone-id={{ region-id }}-b,subnet-name=default-b
     ```

     Если в сети, в которой расположен кластер, ровно 3 подсети, по одной в каждой зоне доступности, то явно указывать подсети для хостов необязательно: {{ mch-name }} автоматически распределит хосты по этим подсетям.

     Чтобы преобразовать нереплицируемые таблицы в [реплицируемые](../concepts/replication.md#replicated-tables), добавьте в команду параметр `--convert-tables-to-replicated`. Нереплицируемые таблицы на движке семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree) будут автоматически преобразованы в реплицируемые на движке [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication).

     {% note warning %}

     После включения этой настройки ее нельзя отключить.

     {% endnote %}

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  Чтобы добавить в кластер хосты {{ ZK }}:

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Убедитесь, что в конфигурационном файле описаны три подсети — по одной для каждой зоны доступности. При необходимости добавьте недостающие:

     ```hcl
     resource "yandex_vpc_network" "<имя_сети>" {
       name = "<имя_сети>"
     }

     resource "yandex_vpc_subnet" "<имя_подсети_в_зоне_{{ region-id }}-a>" {
       name           = "<имя_подсети_в_зоне_{{ region-id }}-a>"
       zone           = "{{ region-id }}-a"
       network_id     = yandex_vpc_network.<имя_сети>.id
       v4_cidr_blocks = [ "<диапазон_адресов_подсети_в_зоне_{{ region-id }}-a>" ]
     }

     resource "yandex_vpc_subnet" "<имя_подсети_в_зоне_{{ region-id }}-b>" {
       name           = "<имя_подсети_в_зоне_{{ region-id }}-b>"
       zone           = "{{ region-id }}-b"
       network_id     = yandex_vpc_network.<имя_сети>.id
       v4_cidr_blocks = [ "<диапазон_адресов_подсети_в_зоне_{{ region-id }}-b>" ]
     }

     resource "yandex_vpc_subnet" "<имя_подсети_в_зоне_{{ region-id }}-d>" {
       name           = "<имя_подсети_в_зоне_{{ region-id }}-d>"
       zone           = "{{ region-id }}-d"
       network_id     = yandex_vpc_network.<имя_сети>.id
       v4_cidr_blocks = [ "<диапазон_адресов_подсети_в_зоне_{{ region-id }}-d>" ]
     }
     ```

  1. Добавьте к описанию кластера {{ CH }} блок с конфигурацией {{ ZK }} и не менее трех блоков `host` с типом `ZOOKEEPER`.

     Требования к хостам {{ ZK }}:
     * В каждой зоне доступности должно быть минимум по одному хосту.
     * Минимальный класс хоста — `b1.medium`.
     * Тип диска — `{{ disk-type-example }}`.
     * Минимальный размер хранилища — 10 гигабайт.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
       ...
       zookeeper {
         resources {
           resource_preset_id = "<класс_хостов>"
           disk_type_id       = "{{ disk-type-example }}"
           disk_size          = <размер_хранилища_ГБ>
         }
       }
       ...
       host {
         type      = "ZOOKEEPER"
         zone      = "{{ region-id }}-a"
         subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_{{ region-id }}-a>.id
       }
       host {
         type      = "ZOOKEEPER"
         zone      = "{{ region-id }}-b"
         subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_{{ region-id }}-b>.id
       }
       host {
         type      = "ZOOKEEPER"
         zone      = "{{ region-id }}-d"
         subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_{{ region-id }}-d>.id
       }
     }
     ```

     Где `resource_preset_id` — класс хоста: `b1.medium` или выше.

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  {% include [zk-hosts-rest](../../_includes/mdb/mch/api/zk-hosts-rest.md) %}

- gRPC API {#grpc-api}

  {% include [zk-hosts-grpc](../../_includes/mdb/mch/api/zk-hosts-grpc.md) %}

{% endlist %}

{% note info %}

По умолчанию для хостов {{ ZK }} задаются следующие характеристики:
* Класс хоста `b2.medium`.
* [Хранилище](../concepts/storage.md) на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 10 ГБ.

{% endnote %}

## Изменить настройки хостов {{ ZK }} {#update-zk-settings}

После создания хостов {{ ZK }} вы можете изменить только их класс и размер хранилища. Рекомендуется изменять класс хостов только во время отсутствия рабочей нагрузки на кластер.

Минимальное количество ядер для одного хоста {{ ZK }} зависит от суммарного количества ядер хостов {{ CH }}. Подробнее см. в разделе [Репликация](../concepts/replication.md#zk).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_zookeeper-resource }}** выберите платформу, тип виртуальной машины и нужный класс хоста {{ ZK }}.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_zookeeper-disk }}** задайте размер хранилища {{ ZK }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить конфигурацию хостов {{ ZK }}:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-ch }} cluster update --help
     ```

  1. Запросите список доступных классов хостов (в колонке `ZONE IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     ```bash
     {{ yc-mdb-ch }} resource-preset list

     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
     |           | {{ region-id }}-d                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```

  1. В команде на изменение кластера передайте новый класса хоста {{ ZK }} и размер хранилища:

     ```bash
     {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
        --zookepeer-resource-preset=<класс_хостов> \
        --zookeeper-disk-size=<размер_хранилища_ГБ>
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  Чтобы изменить настройки хостов {{ ZK }}:

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. В блоке с конфигурацией {{ ZK }} укажите новый класс хоста и размер хранилища.

     Требования к хостам {{ ZK }}:
     * Минимальный класс хоста — `b1.medium`.
     * Минимальный размер хранилища — 10 гигабайт.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
       ...
       zookeeper {
         resources {
           resource_preset_id = "<класс_хостов>"
           disk_type_id       = "{{ disk-type-example }}"
           disk_size          = <размер_хранилища_ГБ>
         }
       }
       ...
     }
     ```

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Запросите список доступных классов хостов:

      1. Воспользуйтесь методом [ResourcePreset.List](../api-ref/ResourcePreset/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

          ```bash
          curl \
              --request GET \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/resourcePresets'
          ```

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ResourcePreset/list.md#responses).

  1. Измените класс хостов и размер хранилища:

      1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

          {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

          ```bash
          curl \
              --request PATCH \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
              --data '{
                        "updateMask": "configSpec.zookeeper.resources.resourcePresetId,configSpec.zookeeper.resources.diskSize",
                        "configSpec": {
                          "zookeeper": {
                            "resources": {
                              "resourcePresetId": "<класс_хостов>",
                              "diskSize": "<размер_хранилища_ГБ>"
                            }
                          }
                        }
                      }'
          ```

          Где:

          * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

              Укажите нужные параметры:
              * `configSpec.zookeeper.resources.resourcePresetId` — если нужно изменить класс хостов {{ ZK }}.
              * `configSpec.zookeeper.resources.diskSize` — если нужно изменить размер хранилища {{ ZK }}.

          * `configSpec.zookeeper.resources.resourcePresetId` — идентификатор [класса хостов](../concepts/instance-types.md).
          * `configSpec.zookeeper.resources.diskSize` — размер хранилища в гигабайтах.

          Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Запросите список доступных классов хостов:

      1. Воспользуйтесь вызовом [ResourcePresetService.List](../api-ref/grpc/ResourcePreset/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

          ```bash
          grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/resource_preset_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ResourcePresetService.List
          ```

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.clickhouse.v1.ListResourcePresetsResponse).

  1. Измените класс хостов и размер хранилища:

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
                        "config_spec.zookeeper.resources.resource_preset_id",
                        "config_spec.zookeeper.resources.disk_size"
                      ]
                    },
                    "config_spec": {
                      "zookeeper": {
                        "resources": {
                          "resource_preset_id": "<класс_хостов>",
                          "disk_size": "<размер_хранилища_ГБ>"
                        }
                      }
                    }
                  }' \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
          ```

          Где:

          * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

              Укажите нужные параметры:
              * `config_spec.zookeeper.resources.resource_preset_id` — если нужно изменить класс хостов {{ ZK }}.
              * `config_spec.zookeeper.resources.disk_size` — если нужно изменить размер хранилища.

          * `config_spec.zookeeper.resources.resource_preset_id` — идентификатор [класса хостов](../concepts/instance-types.md).
          * `config_spec.zookeeper.resources.disk_size` — размер хранилища в гигабайтах.

          Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Перезагрузить хост {{ ZK }} {#restart}

{% include notitle [restart-host](../../_includes/mdb/mch/restart-host.md) %}

## Преобразовать нереплицируемые таблицы в реплицируемые {#replicated-tables}

Чтобы автоматически преобразовать нереплицируемые таблицы на движке семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) в [реплицируемые](../concepts/replication.md#replicated-tables) на движке [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/), добавьте хосты {{ ZK }} с включенным преобразованием таблиц.

Подробнее читайте в разделе [Добавить хосты {{ ZK }}](#add-zk) и в [документации {{ CH }}]({{ ch.docs }}/development/architecture#replication).

## Удалить хост {{ ZK }} {#delete-zk-host}

{% note warning %}

Если в кластере уже созданы хосты {{ ZK }}, то удалить их полностью невозможно — в кластере всегда будет минимум три хоста {{ ZK }}.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Наведите курсор на строку нужного хоста и нажмите на значок ![image](../../_assets/console-icons/xmark.svg).
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить хост из кластера, выполните команду:

  ```bash
  {{ yc-mdb-ch }} hosts delete <имя_хоста> \
    --cluster-name=<имя_кластера>
  ```

  Имя хоста можно запросить со [списком хостов в кластере](hosts.md#list-hosts), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   Чтобы удалить хост {{ ZK }}:

   1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
   1. Удалите из описания кластера {{ mch-name }} блок `host` с типом `ZOOKEEPER`.
   1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Введите слово `yes` и нажмите **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  {% include [zk-hosts-rest](../../_includes/mdb/mch/api/delete-zk-hosts-rest.md) %}

- gRPC API {#grpc-api}

  {% include [zk-hosts-grpc](../../_includes/mdb/mch/api/delete-zk-hosts-grpc.md) %}

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
