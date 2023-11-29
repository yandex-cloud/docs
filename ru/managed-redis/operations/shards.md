# Управление шардами кластера

Вы можете добавлять и удалять шарды кластера, запрашивать список шардов в выбранном кластере, а также выполнять ребалансировку кластера.

{% note warning %}

Управлять шардами можно только в шардированном кластере. Шардировать существующий нешардированный кластер невозможно. Как создать шардированный кластер см. в разделе [Создание кластера](cluster-create.md#create-cluster).

{% endnote %}

## Получить список шардов в кластере {#list}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.redis.cluster.switch_shards }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список шардов в кластере, выполните команду:

  ```bash
  {{ yc-mdb-rd }} shards list --cluster-name <имя_кластера>
  ```

  Результат:

  ```text
  +--------------+
  |     NAME     |
  +--------------+
  | test-shard-1 |
  | test-shard-2 |
  | test-shard-3 |
  +--------------+
  ```

- API

  Чтобы получить список шардов в кластере, воспользуйтесь методом REST API [listShards](../api-ref/Cluster/listShards.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListShards](../api-ref/grpc/cluster_service.md#ListShards) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

{% endlist %}

## Получить детальную информацию о шарде {#get}

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить информацию о шарде, выполните команду:

  ```bash
  {{ yc-mdb-rd }} shards get <имя_шарда> --cluster-name <имя_кластера>
  ```

- API

  Чтобы получить детальную информацию о шарде, воспользуйтесь методом REST API [getShard](../api-ref/Cluster/getShard.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/GetShard](../api-ref/grpc/cluster_service.md#GetShard) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`.
  * Имя нужного шарда в параметре `shardName`.

{% endlist %}

Имя шарда можно запросить со [списком шардов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md).

## Добавить шард {#add}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с кластером, в который нужно добавить шард.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.redis.cluster.switch_shards }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.shards.button_add }}**.
  1. Укажите **{{ ui-key.yacloud.mdb.forms.base_field_shard-name }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}**:
     * (Опционально) Отредактируйте настройки хоста.
     * Нажмите **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.
     * В поле **{{ ui-key.yacloud.mdb.forms.host_column_zone }}** выберите зону доступности, выберите **{{ ui-key.yacloud.mdb.forms.host_column_subnetwork }}** и включите опцию **{{ ui-key.yacloud.mdb.forms.host_column_assign_public_ip }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create-shard }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Посмотрите описание команды CLI для добавления шардов:

  ```bash
  {{ yc-mdb-rd }} shards add --help
  ```

  Чтобы добавить шард с двумя хостами в кластер, один с публичным доступом, а другой с [приоритетом хоста](../concepts/replication.md#master-failover) `50`:

  ```bash
  {{ yc-mdb-rd }} shards add --name=<имя_нового_шарда> \
    --cluster-name=<имя_кластера> \
    --host zone-id=<зона_доступности>,`
      `subnet-name=<имя_подсети>,`
      `assign-public-ip=true \
    --host zone-id=<зона_доступности>,`
      `subnet-name=<имя_подсети>,`
      `replica-priority=50
  ```

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  1. Добавьте к описанию кластера {{ mrd-name }} нужное количество блоков `host` с указанием имени шарда в параметре `shard_name`:

     ```hcl
     resource "yandex_mdb_redis_cluster" "<имя_кластера>" {
       ...
       host {
         zone             = "<зона_доступности>"
         subnet_id        = <идентификатор_подсети>
         assign_public_ip = <публичный_доступ>
         replica_priority = <приоритет_хоста>
         shard_name       = "<имя_шарда>"
       }
     }
     ```

     Где `assign_public_ip` — публичный доступ к хосту: `true` или `false`.

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mrd }}).

  {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

  Чтобы добавить шард, воспользуйтесь методом REST API [addShard](../api-ref/Cluster/addShard.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/AddShard](../api-ref/grpc/cluster_service.md#AddShard) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`.
  * Имя шарда в параметре `shardName`.
  * Конфигурацию хоста для шарда в массиве параметров `hostSpecs`.

  Имя шарда можно запросить со [списком шардов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md).

{% endlist %}

Чтобы получить возможность размещать данные в новом шарде, запустите [ребалансировку кластера](#rebalance-cluster) {{ mrd-name }}.

## Удалить шард {#remove}

{% note alert %}

Вместе с шардом удаляются все находящиеся в нем хосты.

{% endnote %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с кластером, из которого нужно удалить шард.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.redis.cluster.switch_shards }}**.
  1. В строке нужного шарда нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.mdb.cluster.shards.button_action-remove }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.shards.popup-confirm_button_delete }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить шард из кластера, выполните команду:

  ```bash
  {{ yc-mdb-rd }} shards delete <имя_шарда> \
    --cluster-name=<имя_кластера>
  ```

  Имя шарда можно запросить со [списком шардов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  1. Удалите из описания кластера {{ mrd-name }} все блоки `host`, которые относятся к шарду.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Введите слово `yes` и нажмите **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mrd }}).

  {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

  Чтобы удалить шард, воспользуйтесь методом REST API [deleteShard](../api-ref/Cluster/deleteShard.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/DeleteShard](../api-ref/grpc/cluster_service.md#DeleteShard) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`.
  * Имя удаляемого шарда в параметре `shardName`.

  Имя шарда можно запросить со [списком шардов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md).

{% endlist %}

## Ребалансировать кластер {#rebalance-cluster}

Новый шард создается без хеш-слотов и не может принимать данные. Чтобы данные начали размещаться на новом шарде, выполните ребалансировку кластера — эта процедура выделит часть хеш-слотов кластера новому шарду. Данные в переназначенных хеш-слотах будут перемещены в соответствующий шард. Ребалансировка может выполняться на работающем кластере и не влияет на доступность и целостность данных.

Подробнее см. в разделе [{#T}](../concepts/sharding.md#scaling).

{% list tabs %}

- Консоль управления

  Чтобы ребалансировать кластер:
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера.
  1. На вкладке **{{ ui-key.yacloud.common.overview }}** нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.button_rebalance-cluster-short }}**.

  {% note tip %}

  Также можно ребалансировать кластер с помощью кнопки **{{ ui-key.yacloud.mdb.cluster.hosts.button_rebalance-cluster }}** на вкладке **{{ ui-key.yacloud.redis.cluster.switch_shards }}**.

  {% endnote %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы ребалансировать кластер, выполните команду:

  ```bash
  {{ yc-mdb-rd }} cluster rebalance \
    --name=<имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- API

  Чтобы ребалансировать кластер, воспользуйтесь методом REST API [rebalance](../api-ref/Cluster/rebalance.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Rebalance](../api-ref/grpc/cluster_service.md#Rebalance).

{% endlist %}