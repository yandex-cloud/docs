---
title: Управление хостами {{ CK }}
description: Следуя данной инструкции, вы сможете управлять хостами {{ CK }}.
---

# Управление хостами {{ CK }}

После создания кластера с отдельными хостами {{ CK }} вы можете:

* [получить список хостов](#list-hosts);
* [создать хост](#add-ck);
* [изменить настройки {{ CK }}](#update-keeper-settings);
* [перезагрузить хост](#restart-host);
* [преобразовать нереплицируемые таблицы в реплицируемые](#replicated-tables);
* [удалить хост {{ CK }}](#delete-host).

Подробнее о работе хостов {{ CK }} читайте в разделе [{#T}](../concepts/replication.md#ck).

## Получить список хостов в кластере {#list-hosts}

{% include notitle [get-hosts](../../_includes/mdb/mch/get-hosts.md) %}


## Создать хост {{ CK }} {#add-ck}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-clickhouse-keeper }}**.
  1. Выберите [зону доступности](../../overview/concepts/geo-scope.md) и подсеть в указанной зоне доступности.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

{% endlist %}  

## Изменить настройки {{ CK }} {#update-keeper-settings}

{% include [note-change-disk-type-data-loss](../../_includes/mdb/mch/note-change-disk-type-data-loss.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Выберите кластер и  на панели сверху нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-resource }}** выберите платформу, тип виртуальной машины и нужный класс хоста {{ CK }}.
  1. В блоке **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-disk }}** задайте тип диска, размер хранилища и настройте [автоматическое увеличение размера хранилища](../concepts/storage.md#autoscaling).
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}

## Перезагрузить хост {#restart-host}

{% include notitle [restart-host](../../_includes/mdb/mch/restart-host.md) %}

## Преобразовать нереплицируемые таблицы в реплицируемые {#replicated-tables}

Чтобы автоматически преобразовать нереплицируемые таблицы на движке семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) в [реплицируемые](../concepts/replication.md#replicated-tables) на движке [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/), при [включении сервиса координации](update.md#enable-coordination) включите настройку **{{ ui-key.yacloud.clickhouse.field_convert_tables_to_replicated }}**.

## Удалить хост {{ CK }} {#delete-host}

{% note warning %}

Хосты {{ CK }} можно удалять только по одному за раз. При этом в кластере всегда должны оставаться минимум три хоста {{ CK }}.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. В строке нужного хоста нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. Подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить хост {{ CK }}:

  1. Посмотрите описание команды CLI для удаления хоста:
    
      ```bash
      {{ yc-mdb-ch }} hosts delete --help
      ```
      
  1. Удалите хост, выполнив команду:

      ```bash
      {{ yc-mdb-ch }} hosts delete <имя_хоста> \ 
        --cluster-id=<идентификатор_кластера>
      ```

      Имя хоста можно получить со [списком хостов](#list-hosts) в кластере.

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:
  
      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Воспользуйтесь методом [Cluster.DeleteHosts](../api-ref/Cluster/deleteHosts.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:
  
      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts:batchDelete' \
        --data '{
          "hostNames": [
            <имя_хоста>
          ]
        }'
      ```
  
      Имя хоста можно получить со [списком хостов](#list-hosts) в кластера.

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).
  
- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:
  
      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  
  1. Воспользуйтесь вызовом [ClusterService.DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:
  
      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
          "cluster_id": "<идентификатор_кластера>",
          "host_names": [
            <имя_хоста>
          ]
        }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteHosts
      ```
  
      Имя хоста можно получить со [списком хостов](#list-hosts) в кластере.

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}