# Управление хостами {{ RD }}-кластера

Вы можете добавлять и удалять хосты кластера, а также управлять их настройками.

## Получить список хостов в кластере {#list}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список хостов в кластере, выполните команду:

  ```bash
  {{ yc-mdb-rd }} host list \
    --cluster-name=<имя кластера>
  ```

  Результат:

  
  
  ```text
  +---------------------------------+--------------+------------+---------+--------+-------------------+
  |              NAME               |  CLUSTER ID  | SHARD NAME |  ROLE   | HEALTH |      ZONE ID      |
  +---------------------------------+--------------+------------+---------+--------+-------------------+
  | rc1a-...caf.{{ dns-zone }} | c9qb2...0gg  | shard1     | MASTER  | ALIVE  | {{ region-id }}-a     |
  | rc1b-...bgc.{{ dns-zone }} | c9qb2...0gg  | shard1     | REPLICA | ALIVE  | {{ region-id }}-b     |
  +---------------------------------+--------------+------------+---------+--------+-------------------+
  ```




  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

  Чтобы получить список хостов в кластере, воспользуйтесь методом REST API [listHosts](../api-ref/Cluster/listHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListHosts](../api-ref/grpc/cluster_service.md#ListHosts) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md).

{% endlist %}

## Добавить хост {#add}

Количество хостов в кластерах {{ mrd-name }} ограничено квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

{% note info %}

Публичный доступ к хостам можно настроить только для кластеров, созданных с включенной поддержкой TLS.

{% endnote %}

{% list tabs %}

- Консоль управления

  Чтобы добавить хост в кластере:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Нажмите кнопку ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-host }}**.
  1. Укажите параметры хоста:
     * Зону доступности.

     
     * Подсеть (если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md)).


     * При необходимости настройте публичный доступ к хосту.
     * Если вы добавляете хост в шардированный кластер, выберите шард.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы добавить хост в кластере:
  1. Запросите список подсетей кластера, чтобы выбрать подсеть для нового хоста:

     ```bash
     yc vpc subnet list
	 ```

	 Результат:

     
     ```text
     +-----------+-----------+------------+---------------+------------------+
     |     ID    |   NAME    | NETWORK ID |     ZONE      |      RANGE       |
     +-----------+-----------+------------+---------------+------------------+
     | b0cl69... | default-c | enp6rq7... | {{ region-id }}-c | [172.16.0.0/20]  |
     | e2lkj9... | default-b | enp6rq7... | {{ region-id }}-b | [10.10.0.0/16]   |
     | e9b0ph... | a-2       | enp6rq7... | {{ region-id }}-a | [172.16.32.0/20] |
     | e9b9v2... | default-a | enp6rq7... | {{ region-id }}-a | [172.16.16.0/20] |
     +-----------+-----------+------------+---------------+------------------+
     ```



     
     Если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md).


  1. Посмотрите описание команды CLI для добавления хостов:

     ```bash
     {{ yc-mdb-rd }} host add --help
     ```

  1. Выполните команду добавления хоста:

     ```bash
     {{ yc-mdb-rd }} host add \
       --cluster-name=<имя кластера> \
       --host zone-id=<зона доступности>,`
         `subnet-id=<идентификатор подсети>,`
         `assign-public-ip=<публичный доступ к хосту: true или false>,`
         `replica-priority=<приоритет хоста>,`
         `shard-name=<имя шарда>
     ```

     Где:
     * `--cluster-name` — имя кластера {{ mrd-name }}. Его можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `--host` — параметры хоста:
       * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
       * `subnet-id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или больше подсетей.
       * `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу.
       * `replica-priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover). Доступен только для нешардированного кластера.
       * `shard-name` — имя шарда, в который следует добавить хост, если кластер шардированный.

- {{ TF }}

  Чтобы добавить хост в кластере:
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  1. Добавьте к описанию кластера {{ mrd-name }} блок `host`.

     ```hcl
     resource "yandex_mdb_redis_cluster" "<имя кластера>" {
       ...
       host {
         zone             = "<зона доступности>"
         subnet_id        = "<идентификатор подсети>"
         assign_public_ip = <публичный доступ к хосту: true или false>
         replica_priority = <приоритет хоста>
         shard_name       = "<имя шарда>"
       }
     }
     ```

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mrd }}).

  {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

  Чтобы добавить хост, воспользуйтесь методом REST API [addHosts](../api-ref/Cluster/addHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/AddHosts](../api-ref/grpc/cluster_service.md#AddHosts) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Настройки нового хоста в одном или нескольких параметрах `hostSpecs`.

{% endlist %}


{% note warning %}

Если после добавления хоста к нему невозможно [подключиться](connect/index.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера настроена корректно для подсети, в которую помещен хост.

{% endnote %}


## Изменить хост {#update}

{% include [mrd-public-access](../../_includes/mdb/mrd/note-public-access.md) %}

{% list tabs %}

- Консоль управления

  Чтобы изменить параметры хоста в кластере:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Нажмите на значок ![image](../../_assets/options.svg) в строке нужного хоста и выберите пункт **{{ ui-key.yacloud.common.edit }}**.
  1. Включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить параметры хоста, выполните команду:

  ```bash
  {{ yc-mdb-rd }} host update <имя хоста> \
    --cluster-name=<имя кластера> \
    --assign-public-ip=<публичный доступ к хосту: true или false> \
    --replica-priority=<приоритет хоста>
  ```

  Имя хоста можно запросить со [списком хостов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

  Чтобы изменить параметры хоста в кластере:
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  1. Измените в описании кластера {{ mrd-name }} атрибуты блока `host`, соответствующего изменяемому хосту.

     ```hcl
     resource "yandex_mdb_redis_cluster" "<имя кластера>" {
       ...
       host {
         zone             = "<зона доступности>"
         subnet_id        = "<идентификатор подсети>"
         assign_public_ip = <публичный доступ к хосту: true или false>
         replica_priority = <приоритет хоста>
         shard_name       = "<имя шарда>"
       }
     }
     ```

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mrd }}).

- API

  Чтобы изменить параметры хоста, воспользуйтесь методом REST API [updateHosts](../api-ref/Cluster/updateHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/UpdateHosts](../api-ref/grpc/cluster_service.md#UpdateHosts) и передайте в запросе:
  * Идентификатор кластера, в котором нужно изменить хост, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя хоста, который нужно изменить, в параметре `updateHostSpecs.hostName`. Чтобы узнать имя, [получите список хостов в кластере](#list).
  * Настройки публичного доступа к хосту в параметре `updateHostSpecs.assignPublicIp`.
  * [Приоритет хоста](../concepts/replication.md#master-failover) в параметре `updateHostSpecs.replicaPriority`.
  * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}


{% note warning %}

Если после добавления хоста к нему невозможно [подключиться](connect/index.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера настроена корректно для подсети, в которую помещен хост. Группы безопасности находятся на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}


## Удалить хост {#remove}

Вы можете удалить хост из {{ RD }}-кластера, если он не является единственным хостом. Чтобы заменить единственный хост, сначала создайте новый хост, а затем удалите старый.

Если хост является мастером в момент удаления, {{ mrd-name }} автоматически назначит мастером другую реплику.

{% list tabs %}

- Консоль управления

  Чтобы удалить хост из кластера:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. В строке с нужным кластером нажмите на значок ![image](../../_assets/options.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне включите опцию **Я удаляю хост** и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.popup-confirm_button }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить хост из кластера, выполните команду:

  ```bash
  {{ yc-mdb-rd }} host delete <имя хоста> \
    --cluster-name=<имя кластера>
  ```

  Имя хоста можно запросить со [списком хостов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

  Чтобы удалить хост из кластера:
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  1. Удалите из описания кластера {{ mrd-name }} блок `host`.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Введите слово `yes` и нажмите **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mrd }}).

  {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

  Чтобы удалить хост, воспользуйтесь методом REST API [deleteHosts](../api-ref/Cluster/deleteHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/DeleteHosts](../api-ref/grpc/cluster_service.md#DeleteHosts) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя или массив имен удаляемых хостов в параметре `hostNames`.

{% endlist %}
