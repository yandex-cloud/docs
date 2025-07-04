---
title: Управление хостами Elasticsearch
description: Вы можете получать список хостов в кластере Elasticsearch, а также добавлять и удалять хосты кластера. Вы можете управлять хостами только с ролью Data Node.
keywords:
  - управление хостами Elasticsearch
  - хосты Elasticsearch
  - Elasticsearch
---

# Управление хостами

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

Вы можете получить список хостов в кластере {{ ES }}, а также добавлять и удалять хосты кластера. О том, как перенести хосты кластера в другую зону доступности, читайте в [инструкции](host-migration.md).

{% note info %}

Вы можете добавлять и удалять только хосты с ролью [_Data node_](../concepts/index.md).

{% endnote %}

## Получить список хостов в кластере {#list-hosts}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Elasticsearch**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список хостов в кластере, выполните команду:

    ```bash
    {{ yc-mdb-es }} host list --cluster-name <имя_кластера>
    ```

    Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

  Чтобы получить список хостов в кластере, воспользуйтесь методом REST API [listHosts](../api-ref/Cluster/listHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListHosts](../api-ref/grpc/Cluster/listHosts.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

## Добавить хосты в кластер {#add-hosts}

{% note warning %}

Включить публичный доступ к хосту после его создания невозможно.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Elasticsearch**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
    1. Укажите параметры хоста:

        * Зону доступности.
        * Подсеть (если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md)).
        * Выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}. Эту настройку нельзя изменить после создания хоста.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы добавить хосты в кластер, выполните команду:

    ```bash
    {{ yc-mdb-es }} host add \
       --cluster-name <имя_кластера> \
       --host zone-id=<зона_доступности>,`
              `subnet-name=<имя_подсети>,`
              `assign-public-ip=<публичный_доступ>,`
              `type=<роль_хоста>
    ```

    Где:

    * `assign-public-ip` — публичный доступ к хосту: `true` или `false`.
    * `type` — роль хоста: `datanode` или `masternode`.

    Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    Чтобы добавить хост в кластере:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mes-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mes }}).

    1. Добавьте к описанию кластера {{ mes-name }} блок `host`.

        ```hcl
        resource "yandex_mdb_elasticsearch_cluster" "<имя_кластера>" {
          ...
          host {
            name             = "<имя_хоста>"
            zone             = "<зона_доступности>"
            type             = "<роль_хоста>"
            assign_public_ip = <публичный_доступ>
            subnet_id        = "<идентификатор_подсети>"
          }
        }
        ```

        Где:

        * `type` — роль хоста: `DATA_NODE` или `MASTER_NODE`.
        * `assign_public_ip` — публичный доступ к хосту: `true` или `false`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

  Чтобы добавить хосты в кластер, воспользуйтесь методом REST API [addHosts](../api-ref/Cluster/addHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/AddHosts](../api-ref/grpc/Cluster/addHosts.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

  * Настройки нового хоста в одном или нескольких параметрах `hostSpecs`.

{% endlist %}


{% note warning %}

Если после добавления хоста к нему невозможно [подключиться](cluster-connect.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера настроена корректно для подсети, в которую помещен хост.

{% endnote %}


## Удалить хосты из кластера {#delete-hosts}

При удалении хостов действуют ограничения:

* Нельзя удалить единственный хост с ролью _Data node_.
* Для кластеров, состоящих из нескольких хостов с ролью _Data node_, нельзя удалить последние два хоста.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Elasticsearch**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить хост из кластера, выполните команду:

    ```bash
    {{ yc-mdb-es }} host delete <имя_хоста> --cluster-name <имя_кластера>
    ```

    Имя хоста можно запросить со [списком хостов в кластере](#list-hosts), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  Чтобы удалить хост из кластера:
  
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mes-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mes }}).

  1. Удалите из описания кластера {{ mes-name }} блок `host`, соответствующий удаляемому хосту.
  
  1. Проверьте корректность настроек.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
 
  1. Подтвердите удаление ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

  Чтобы удалить хост, воспользуйтесь методом REST API [deleteHosts](../api-ref/Cluster/deleteHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}
    
  * Имя или массив имен удаляемых хостов в параметре `hostNames`.

{% endlist %}
