---
title: Миграция хостов кластера {{ KF }} в другую зону доступности
description: Следуя данной инструкции, вы сможете переместить хосты кластера {{ KF }} в другую зону доступности.
---

# Миграция хостов кластера {{ KF }} в другую зону доступности


Хосты кластера {{ mkf-name }} располагаются в зонах доступности {{ yandex-cloud }}. Хосты {{ KF }} можно перенести из одной зоны в другую. Процесс переноса различается для кластеров с одним и несколькими хостами.

{% include [zone-d-restrictions](../../_includes/mdb/ru-central1-d-restrictions.md) %}

Если кластер {{ mkf-name }} является эндпоинтом в сервисе {{ data-transfer-full-name }}, перезапустите трансфер для его корректной работы. Подробнее о том, какие трансферы нужно перезапускать и как это сделать, см. в разделе [Особенности миграции в сервисе {{ data-transfer-full-name }}](#data-transfer).

## Миграция кластера с одним хостом {#one-host}

Есть несколько способов провести миграцию:

* [Воспользоваться интерфейсами {{ yandex-cloud }}](#yandex-cloud-interfaces). В этом случае меняется зона доступности в конфигурации кластера. Создавать дополнительный кластер не нужно.

   Этот вариант проще в реализации, но во время миграции кластер будет простаивать, пока его зона доступности будет меняться. Это может занять несколько минут.

* [Воспользоваться вспомогательными инструментами](#auxiliary-instruments) MirrorMaker или {{ data-transfer-full-name }}. В этом случае создается новый кластер, в который переносятся данные из первоначального кластера.

   Этот вариант сложнее в реализации, так как требует создания и настройки инфраструктуры. Но он позволяет избежать простоя: вы можете поддерживать два кластера с актуальными данными, пока не удалите первоначальный кластер.

### Миграция кластера с одним хостом с помощью интерфейсов {{ yandex-cloud }} {#yandex-cloud-interfaces}

Чтобы в кластере {{ mkf-name }} перенести хост {{ KF }} в другую зону доступности:

1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в зоне доступности, в которую вы переносите кластер.
1. Если группа безопасности кластера настроена для подсети в зоне доступности, из которой переносится кластер, перенастройте группу для новой подсети. Для этого в правилах группы безопасности замените CIDR исходной подсети на CIDR новой подсети.
1. Измените зону доступности у кластера и его хоста {{ KF }}:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
      1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
      1. В разделе **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** укажите новую зону доступности.
      1. Укажите подсеть в новой зоне доступности, если в ней находится больше одной подсети.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Чтобы изменить зону доступности у кластера и его хоста {{ KF }}, выполните команду:

      ```bash
      {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
         --zone-ids <зона_доступности> \
         --subnet-ids <идентификатор_подсети>
      ```

      Если в новой зоне доступности находится только одна подсеть, параметр `--subnet-ids` указывать не обязательно.

   - {{ TF }} {#tf}

      1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

         О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

      1. Укажите в описании кластера {{ mkf-name }} новую подсеть в параметре `subnet_ids` и новую зону доступности в параметре `zones`:

         ```hcl
         resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
           ...
           subnet_ids = ["<подсеть>"]
           config {
             ...
             zones = ["<зона_доступности>"]
           }
           ...
         }
         ```

         Если в новой зоне доступности находится только одна подсеть, параметр `subnet_ids` указывать не обязательно.

      1. Проверьте корректность настроек.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Подтвердите изменение ресурсов.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

      {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

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
              -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>' \
              --data '{
                        "updateMask": "configSpec.zoneId,subnetIds",
                        "subnetIds": [
                          "<подсеть>"
                        ]
                        "configSpec": {
                          "zoneId": [
                            "<зона_доступности>"
                          ]
                        }
                      }'
          ```

          Где:

          * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

              Укажите нужные параметры:
              * `subnetIds` — если нужно изменить список подсетей.
              * `configSpec.zoneId` — если нужно изменить зону доступности.
          * `subnetIds` — массив строк. Каждая строка — идентификатор подсети. Если в новой зоне доступности находится только одна подсеть, параметр `subnetIds` указывать не обязательно.
          * `zoneId` — новая зона доступности кластера.

          Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

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
                -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<идентификатор_кластера>",
                      "update_mask": {
                        "paths": [
                          "subnet_ids",
                          "config_spec.zone_id"
                        ]
                      },
                      "subnet_ids": [
                        "<подсеть>"
                      ]
                      "config_spec": {
                        "zone_id": [
                          "<зона_доступности>"
                        ]
                      }
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.kafka.v1.ClusterService.Update
            ```

            Где:

            * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

               Укажите нужные параметры:
               * `subnet_ids` — если нужно изменить список подсетей.
               * `config_spec.zone_id` — если нужно изменить зону доступности.
            * `subnet_ids` — массив строк. Каждая строка — идентификатор подсети. Если в новой зоне доступности находится только одна подсеть, параметр `subnet_ids` указывать не обязательно.
            * `zone_id` — новая зона доступности кластера.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

       1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

   {% endlist %}

1. Чтобы успешно выполнять подключение к топикам после миграции, укажите FQDN нового брокера в вашем бэкенде или клиенте (например, в коде или графической IDE). Удалите FQDN прежнего брокера в первоначальной зоне доступности.

   Чтобы узнать FQDN, получите список хостов в кластере:

   {% include [list-hosts-quick](../../_includes/mdb/mkf/list-hosts-short.md) %}

### Миграция кластера с одним хостом с помощью вспомогательных инструментов {#auxiliary-instruments}

Чтобы в кластере {{ mkf-name }} перенести хост {{ KF }} в другую зону доступности:

1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в зоне доступности, в которую вы переносите кластер.
1. Если группа безопасности кластера настроена для подсети в зоне доступности, из которой переносится кластер, перенастройте группу для новой подсети. Для этого в правилах группы безопасности замените CIDR исходной подсети на CIDR новой подсети.
1. [Создайте кластер](cluster-create.md) {{ mkf-name }}, конфигурация которого отличается от конфигурации первоначального кластера только подсетью и группой безопасности.
1. Перенесите данные из первоначального кластера в новый с помощью одного из двух инструментов:

   * [MirrorMaker](../tutorials/kafka-connectors.md) — подойдет как встроенный в {{ mkf-name }} MirrorMaker-коннектор, так и утилита MirrorMaker.
   * [{{ data-transfer-name }}](../../data-transfer/tutorials/mkf-to-mkf.md).

1. Чтобы успешно выполнять подключение к топикам после миграции, укажите FQDN брокера нового кластера в вашем бэкенде или клиенте (например, в коде или графической IDE). Удалите FQDN брокера прежнего кластера в первоначальной зоне доступности.

   Чтобы узнать FQDN, получите список хостов в кластере:

   {% include [list-hosts-quick](../../_includes/mdb/mkf/list-hosts-short.md) %}

1. [Удалите первоначальный кластер](cluster-delete.md) {{ mkf-name }}.

## Миграция кластера с несколькими хостами {#multiple-hosts}

{% note info %}

В [кластерах с версией {{ KF }} 3.6 или выше](../concepts/index.md#kraft) не используются хосты {{ ZK }}. Миграция возможна только для конфигурации с тремя брокерами в одной зоне доступности.

{% endnote %}

Если создать кластер версии {{ KF }} 3.5 или ниже из более чем одного хоста-брокера, в кластер автоматически добавляются три выделенных хоста {{ ZK }}. Каждому из хостов назначается подсеть из разных зон доступности. После создания кластера для него нельзя сменить подсеть в зоне доступности.

Процесс миграции кластера версии {{ KF }} 3.5 или ниже зависит от того, в каких зонах доступности располагаются хосты {{ KF }} и {{ ZK }} до миграции и сколько подсетей находится в каждой зоне доступности. Ознакомьтесь с частными случаями в [примерах](#examples), чтобы лучше понять особенности миграции.

Чтобы в кластере с версией {{ KF }} 3.5 или ниже перенести хосты {{ KF }} в другую зону доступности:

1. Узнайте, в каких зонах доступности располагаются хосты {{ KF }} и {{ ZK }}:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
      1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**. Зона доступности каждого хоста указана в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_zone }}**.

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      ```bash
      {{ yc-mdb-kf }} cluster list-hosts <имя_или_идентификатор_кластера>
      ```

      Зона доступности указана в выводе команды, в столбце `ZONE ID`.

   - REST API {#api}

       1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

           {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

       1. Воспользуйтесь методом [Cluster.listHosts](../api-ref/Cluster/listHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

           ```bash
           curl \
               --request GET \
               --header "Authorization: Bearer $IAM_TOKEN" \
               --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>/hosts'
           ```

           Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

       1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse). Зона доступности указана в ответе в поле `hosts[].zoneId`.

   - gRPC API {#grpc-api}

       1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

           {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

       1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

       1. Воспользуйтесь вызовом [ClusterService/ListHosts](../api-ref/grpc/Cluster/listHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

           ```bash
           grpcurl \
               -format json \
               -import-path ~/cloudapi/ \
               -import-path ~/cloudapi/third_party/googleapis/ \
               -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
               -rpc-header "Authorization: Bearer $IAM_TOKEN" \
               -d '{
                       "cluster_id": "<идентификатор_кластера>"
                   }' \
               {{ api-host-mdb }}:443 \
               yandex.cloud.mdb.kafka.v1.ClusterService.ListHosts
           ```

           Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

       1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse). Зона доступности указана в ответе в поле `hosts[].zone_id`.

   {% endlist %}

1. Если в списке нет целевой зоны доступности, куда вы переносите хосты {{ KF }}, [создайте подсеть](../../vpc/operations/subnet-create.md) в этой зоне.

   Если в списке есть целевая зона доступности, во время миграции хосты {{ KF }} будут перенесены в подсеть, в которой уже располагаются хосты {{ KF }} или {{ ZK }} в этой зоне доступности.

1. Проверьте группу безопасности кластера. Если она настроена для подсети в исходной зоне доступности, перенастройте группу для подсети в целевой зоне доступности. Для этого в правилах группы безопасности замените CIDR исходной подсети на CIDR целевой подсети.
1. Измените зону доступности у кластера и его хостов {{ KF }}:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
      1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
      1. В разделе **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** укажите новый набор зон доступности. Их количество не должно уменьшиться.

         {% note warning %}

         Добавив новую зону доступности, снимите выбор с одной из старых. Если этого не сделать, после сохранения настроек вы не сможете удалить старую зону доступности.

         {% endnote %}

      1. Укажите подсеть в новой зоне доступности, если:

         * выполняется миграция в зону доступности, где хосты {{ KF }} или {{ ZK }} ранее не размещались;
         * в целевой зоне доступности находится больше одной подсети.

      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

   - CLI {#cli}

      Чтобы изменить набор зон доступности у кластера и его хостов {{ KF }}, выполните команду:

      ```bash
      {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
         --zone-ids <зоны_доступности> \
         --subnet-ids <идентификаторы_подсетей>
      ```

      В параметре `--zone-ids` перечислите зоны доступности через запятую. Их количество не должно уменьшиться.

      {% note warning %}

      Добавив новую зону доступности, удалите из списка одну из старых. Если этого не сделать, после выполнения команды вы не сможете удалить старую зону доступности.

      {% endnote %}

      В параметре `--subnet-ids` через запятую перечислите подсети для зон доступности `{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-d`. Подсети для этих зон должны быть указаны, даже если хосты {{ KF }} размещаются в меньшем количестве зон. Все три зоны доступности нужны для хостов {{ ZK }}.

   - {{ TF }} {#tf}

      1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

         О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

      1. Измените в описании кластера {{ mkf-name }} список зон доступности в параметре `zones`:

         ```hcl
         resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
           ...
           config {
             ...
             zones = ["<зоны_доступности>"]
           }
           ...
         }
         ```

         Количество зон доступности не должно уменьшиться.

         {% note warning %}

         Добавив новую зону доступности, удалите из списка одну из старых. Если этого не сделать, после сохранения настроек вы не сможете удалить старую зону доступности.

         {% endnote %}

      1. Измените в параметре `subnet_ids` список подсетей, если выполняются два условия:

         * вы переносите хосты {{ KF }} в зону доступности, где хосты {{ ZK }} ранее не размещались;
         * в целевой зоне доступности находится больше одной подсети.

         Если хосты кластера размещаются в зонах доступности `{{ region-id }}-a` и `{{ region-id }}-b` и вы меняете зоны доступности на `{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-d`, укажите подсеть, только если в зоне `{{ region-id }}-d` несколько подсетей. Иначе подсеть указывать не нужно.

         ```hcl
         resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
           ...
           subnet_ids = ["<подсети>"]
           ...
         }
         ```

      1. Проверьте корректность настроек.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Подтвердите изменение ресурсов.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

      {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

   - REST API {#api}

       1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

          {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

          ```bash
          curl \
              --request PATCH \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>' \
              --data '{
                        "updateMask": "configSpec.zoneId,subnetIds",
                        "subnetIds": [
                          <список_подсетей>
                        ],
                        "configSpec": {
                          "zoneId": [
                            <список_зон_доступности>
                          ]
                        }
                      }'
          ```

          Где:

          * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:
            * `subnetIds` — если нужно изменить список подсетей.
            * `configSpec.zoneId` — если нужно изменить список зон доступности.
          * `subnetIds` — массив строк. Каждая строка — идентификатор подсети. Измените список подсетей, если выполняются два условия:

            * вы переносите хосты {{ KF }} в зону доступности, где хосты {{ ZK }} ранее не размещались;
            * в целевой зоне доступности находится больше одной подсети.

            Если хосты кластера размещаются в зонах доступности `{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-c` и вы меняете зоны доступности на `{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-d`, укажите подсеть, только если в зоне `{{ region-id }}-d` несколько подсетей. Иначе подсеть указывать не нужно.
          * `zoneId` — новый набор зон доступности кластера. Их количество не должно уменьшиться.

          Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

       1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

   - gRPC API {#grpc-api}

       1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

           {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

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
                         "subnet_ids",
                         "config_spec.zone_id"
                       ]
                     },
                     "subnet_ids": [
                       <список_подсетей>
                     ],
                     "config_spec": {
                       "zone_id": [
                         <список_зон_доступности>
                       ]
                     }
                   }' \
               {{ api-host-mdb }}:{{ port-https }} \
               yandex.cloud.mdb.kafka.v1.ClusterService.Update
           ```

           Где:

           * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

              Укажите нужные параметры:
              * `subnet_ids` — если нужно изменить список подсетей.
              * `config_spec.zone_id` — если нужно изменить список зон доступности.
           * `subnet_ids` — массив строк. Каждая строка — идентификатор подсети. Измените список подсетей, если выполняются два условия:

             * вы переносите хосты {{ KF }} в зону доступности, где хосты {{ ZK }} ранее не размещались;
             * в целевой зоне доступности находится больше одной подсети.

             Если хосты кластера размещаются в зонах доступности `{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-c` и вы меняете зоны доступности на `{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-d`, укажите подсеть, только если в зоне `{{ region-id }}-d` несколько подсетей. Иначе подсеть указывать не нужно.
           * `zone_id` — новый набор зон доступности кластера. Их количество не должно уменьшиться.

           Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

       1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

   {% endlist %}

Чтобы в кластере с версией {{ KF }} 3.6 или выше перенести хосты {{ KF }} в другую зону доступности:

1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в целевой зоне доступности, куда вы переносите хосты {{ KF }}.
1. Проверьте группу безопасности кластера. Если она настроена для подсети в исходной зоне доступности, перенастройте группу для подсети в целевой зоне доступности. Для этого в правилах группы безопасности замените CIDR исходной подсети на CIDR целевой подсети.
1. Измените зону доступности у кластера и его хостов {{ KF }}:

   {% list tabs group=instructions %}

   - CLI {#cli}

      Чтобы изменить зону доступности у кластера и его хостов {{ KF }}, выполните команду:

      ```bash
      {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
         --zone-ids <зона_доступности> \
         --subnet-ids <идентификатор_подсети>
      ```

   - {{ TF }} {#tf}

      1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

         О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

      1. Измените в описании кластера {{ mkf-name }} зону доступности в параметре `zones`:

         ```hcl
         resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
           ...
           config {
             ...
             zones = ["<зона_доступности>"]
           }
           ...
         }
         ```

      1. Укажите в параметре `subnet_ids` подсеть в целевой зоне доступности.

         ```hcl
         resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
           ...
           subnet_ids = ["<подсеть>"]
           ...
         }
         ```

      1. Проверьте корректность настроек.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Подтвердите изменение ресурсов.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

      {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

   - REST API {#api}

       1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

          {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

          ```bash
          curl \
              --request PATCH \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>' \
              --data '{
                        "updateMask": "configSpec.zoneId,subnetIds",
                        "subnetIds": [
                          <подсеть_в_целевой_зоне_доступности>
                        ],
                        "configSpec": {
                          "zoneId": [
                            <целевая_зона_доступности>
                          ]
                        }
                      }'
          ```

          Где:

          * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

             В данном случае укажите параметры `subnetIds` и `configSpec.zoneId`.

          * `subnetIds` — массив строк. Каждая строка — идентификатор подсети. Укажите только подсеть в целевой зоне доступности.
          * `zoneId` — новый набор зон доступности кластера. Укажите только целевую зону доступности.

          Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

       1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

   - gRPC API {#grpc-api}

       1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

           {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

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
                         "subnet_ids",
                         "config_spec.zone_id"
                       ]
                     },
                     "subnet_ids": [
                       <подсеть_в_целевой_зоне_доступности>
                     ],
                     "config_spec": {
                       "zone_id": [
                         <целевая_зона_доступности>
                       ]
                     }
                   }' \
               {{ api-host-mdb }}:{{ port-https }} \
               yandex.cloud.mdb.kafka.v1.ClusterService.Update
           ```

           Где:

           * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

              В данном случае массив состоит из строк `subnetIds` и `configSpec.zoneId`.

           * `subnetIds` — массив строк. Каждая строка — идентификатор подсети. Укажите только подсеть в целевой зоне доступности.
           * `zoneId` — новый набор зон доступности кластера. Укажите только целевую зону доступности.

           Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

       1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

   {% endlist %}

Чтобы успешно выполнять подключение к топикам после миграции, укажите FQDN нового брокера в вашем бэкенде или клиенте (например, в коде или графической IDE). Удалите FQDN прежнего брокера в первоначальной зоне доступности.

Чтобы узнать FQDN, получите список хостов в кластере:

{% include [list-hosts-quick](../../_includes/mdb/mkf/list-hosts-short.md) %}

### Примеры миграции кластера с несколькими хостами {#examples}

Примеры ниже позволяют понять, в каких ситуациях нужно указывать подсеть, чтобы выполнить миграцию кластера {{ mkf-name }} версии 3.5 или ниже с несколькими хостами в другую зону доступности.

#### Хост {{ ZK }} уже расположен в целевой зоне доступности {#already-located}

Допустим, кластер содержит следующий набор хостов:

* хост {{ KF }} №1 — в зоне доступности `{{ region-id }}-a`;
* хост {{ KF }} №2 — в зоне доступности `{{ region-id }}-c`;
* хост {{ ZK }} №1 — в зоне доступности `{{ region-id }}-a`;
* хост {{ ZK }} №2 — в зоне доступности `{{ region-id }}-b`;
* хост {{ ZK }} №3 — в зоне доступности `{{ region-id }}-d`.

Нужно перенести хосты {{ KF }} в зоны доступности `{{ region-id }}-a` и `{{ region-id }}-d`.

Так как хост {{ ZK }} №3 уже расположен в зоне `{{ region-id }}-d`, значит, он размещается в определенной подсети в этой же зоне доступности. Эта подсеть будет использована при миграции, так как после создания кластера его подсети изменить нельзя. В результате при миграции не нужно указывать подсеть.

#### В целевой зоне доступности не располагается ни один хост, и есть одна подсеть {#one-subnet}

Допустим, кластер содержит следующий набор хостов:

* хост {{ KF }} №1 — в зоне доступности `{{ region-id }}-a`;
* хост {{ KF }} №2 — в зоне доступности `{{ region-id }}-b`;
* хост {{ KF }} №3 — в зоне доступности `{{ region-id }}-c`;
* хост {{ ZK }} №1 — в зоне доступности `{{ region-id }}-a`;
* хост {{ ZK }} №2 — в зоне доступности `{{ region-id }}-b`;
* хост {{ ZK }} №3 — в зоне доступности `{{ region-id }}-c`.

Нужно перенести хосты {{ KF }} в зоны доступности `{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-d`.

Ни один хост до миграции не размещается в зоне доступности `{{ region-id }}-d`. Но в ней находится только одна подсеть, поэтому при миграции не нужно указывать подсеть.

#### В целевой зоне доступности не располагается ни один хост, и в ней находятся несколько подсетей {#several-subnets}

Допустим, кластер содержит следующий набор хостов:

* хост {{ KF }} №1 — в зоне доступности `{{ region-id }}-a`;
* хост {{ KF }} №2 — в зоне доступности `{{ region-id }}-b`;
* хост {{ KF }} №3 — в зоне доступности `{{ region-id }}-c`;
* хост {{ ZK }} №1 — в зоне доступности `{{ region-id }}-a`;
* хост {{ ZK }} №2 — в зоне доступности `{{ region-id }}-b`;
* хост {{ ZK }} №3 — в зоне доступности `{{ region-id }}-c`.

Нужно перенести хосты {{ KF }} в зоны доступности `{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-d`.

Ни один хост до миграции не размещается в зоне доступности `{{ region-id }}-d`. В ней находится несколько подсетей, поэтому при миграции нужно указать подсеть.

{% include [migration-in-data-transfer](../../_includes/data-transfer/migration-in-data-transfer.md) %}

Пример переноса данных с помощью сервиса {{ data-transfer-name }} см. в [практическом руководстве](../../data-transfer/tutorials/mkf-to-mkf.md).
