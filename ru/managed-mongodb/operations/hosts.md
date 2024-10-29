# Управление хостами кластера {{ MG }}

Вы можете добавлять и удалять [хосты кластера](../concepts/index.md), запускать повторную синхронизацию хостов, а также [управлять настройками {{ MG }}](update.md) для отдельных кластеров. О том, как перенести хосты кластера в другую зону доступности, читайте в [инструкции](host-migration.md).

## Получить список хостов в кластере {#list-hosts}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера {{ mmg-name }}.
  1. Выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список хостов в кластере {{ mmg-name }}, выполните команду:

  ```bash
  {{ yc-mdb-mg }} host list \
    --cluster-name <имя_кластера>
  ```

  Результат:

  ```text
  +----------------------------+----------------------+--------+------------+--------------+----------+---------------+-----------+
  |           NAME             |      CLUSTER ID      |  TYPE  | SHARD NAME |     ROLE     |  HEALTH  |    ZONE ID    | PUBLIC IP |
  +----------------------------+----------------------+--------+------------+--------------+----------+---------------+-----------+
  | rc1b...{{ dns-zone }} | c9qp71dk1q1w******** | MONGOD | rs01       | PRIMARY      | ALIVE    | {{ region-id }}-b | false     |
  | rc1a...{{ dns-zone }} | c9qp71dk1q1w******** | MONGOD | rs01       | SECONDARY    | ALIVE    | {{ region-id }}-a | false     |
  +----------------------------+----------------------+--------+------------+--------------+----------+---------------+-----------+
  ```

  Имя кластера {{ mmg-name }} можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

  Чтобы получить список хостов кластера {{ mmg-name }}, воспользуйтесь методом REST API [listHosts](../api-ref/Cluster/listHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListHosts](../api-ref/grpc/Cluster/listHosts.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Добавить хост {#add-host}

Количество хостов в кластерах {{ mmg-name }} ограничено квотами на количество CPU и объем памяти, которые доступны кластерам базы данных в вашем [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud). Чтобы проверить используемые ресурсы, откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **{{ mmg-name }}**.

Вы можете добавлять в кластер {{ mmg-name }} хосты разных типов. Их количество зависит от [типа шардирования](../concepts/sharding.md#shard-management):

{#hosts-table}

Тип шардирования | MONGOD | MONGOINFRA | MONGOS | MONGOCFG
--- | --- | --- | --- | ---
Без шардирования | ⩾ 1 | — | — | —
Стандартный | ⩾ 1 | ⩾ 3 | — | —
Расширенный | ⩾ 1 | — | ⩾ 2 | ⩾ 3

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы добавить хост в кластере {{ mmg-name }}:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера {{ mmg-name }} и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
  1. Укажите параметры хоста:
     * [Зону доступности](../../overview/concepts/geo-scope.md).
     * [Подсеть](../../vpc/concepts/network.md#subnet) (если нужной подсети в списке нет, создайте ее).
     * Выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}. Эту настройку нельзя изменить после создания хоста.
     * Тип хоста и название шарда, если в кластере {{ mmg-name }} включено шардирование.
  1. Нажмите **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы добавить хост в кластере {{ mmg-name }}:
  1. Запросите список подсетей кластера {{ mmg-name }}, чтобы выбрать [подсеть](../../vpc/concepts/network.md#subnet) для нового хоста:

     ```bash
     yc vpc subnet list
     ```

     Результат:

     ```text
     +----------------------+-----------+-----------------------+---------------+------------------+
     |          ID          |   NAME    |       NETWORK ID      |       ZONE    |      RANGE       |
     +----------------------+-----------+-----------------------+---------------+------------------+
     | b0cl69a2b4c6******** | default-d | enp6rq72rndgr******** | {{ region-id }}-d | [172.16.0.0/20]  |
     | e2lkj9qwe762******** | default-b | enp6rq72rndgr******** | {{ region-id }}-b | [10.10.0.0/16]   |
     | e9b0ph42bn96******** | a-2       | enp6rq72rndgr******** | {{ region-id }}-a | [172.16.32.0/20] |
     | e9b9v22r88io******** | default-a | enp6rq72rndgr******** | {{ region-id }}-a | [172.16.16.0/20] |
     +----------------------+-----------+-----------------------+---------------+------------------+
     ```

     Если нужной подсети в списке нет, создайте ее.
  1. Посмотрите описание команды CLI для добавления хостов:

     ```bash
     {{ yc-mdb-mg }} host add --help
     ```

  1. Выполните команду добавления хоста:

      ```bash
      {{ yc-mdb-mg }} host add \
        --cluster-name <имя_кластера> \
        --host zone-id=<зона_доступности>,`
              `subnet-id=<идентификатор_подсети>,`
              `assign-public-ip=<публичный_доступ>
      ```

      Где `assign-public-ip` — публичный доступ к хосту: `true` или `false`.

     {{ mmg-name }} запустит операцию добавления хоста.

     Идентификатор подсети необходимо указать, если в [зоне доступности](../../overview/concepts/geo-scope.md) больше одной подсети, в противном случае {{ mmg-name }} автоматически выберет единственную подсеть. Имя кластера {{ mmg-name }} можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  Чтобы добавить хост в кластере {{ mmg-name }}:
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Добавьте к описанию кластера {{ mmg-name }}:
     * Ресурсы, соответствующие типу шардирования, если вы добавляете хост в шардированный кластер:
       * `resources_mongoinfra` — для стандартного шардирования.
       * `resources_mongos` и `resources_mongocfg` — для расширенного шардирования.
     * Блок `host`.

     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
       ...
       resources_mongod {
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       resources_mongoinfra { # Добавьте для стандартного шардирования.
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       resources_mongos { # Добавьте для расширенного шардирования.
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       resources_mongocfg { # Добавьте для расширенного шардирования.
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       host {
         role             = "<тип_реплики>"
         zone_id          = "<зона_доступности>"
         subnet_id        = "<идентификатор_подсети>"
         assign_public_ip = <публичный_доступ>
         shard_name       = "<имя_шарда>"
         type             = "<тип_хоста>"
         ...
       }
     }
     ```

     Где:

     * `host` — параметры хоста:
       * `role` — тип реплики: `PRIMARY` или `SECONDARY`.
       * `zone_id` — зона доступности.
       * `subnet_id` — идентификатор подсети в выбранной зоне доступности.
       * `assign_public_ip` — публичный доступ к хосту: `true` или `false`.
       * `shard_name` — имя шарда в шардированном кластере.
       * `type` — тип хоста в шардированном кластере: `MONGOD`, `MONGOINFRA`, `MONGOS` или `MONGOCFG`.

  1. Проверьте корректность настроек.
  
     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API {#api}

  Чтобы добавить хост в кластер, воспользуйтесь методом REST API [addHosts](../api-ref/Cluster/addHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/AddHosts](../api-ref/grpc/Cluster/addHosts.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Настройки нового хоста в одном или нескольких параметрах `hostSpecs`.

{% endlist %}


[Группы безопасности](../../vpc/concepts/security-groups.md) находятся на [стадии Preview](../../overview/concepts/launch-stages.md). Если они недоступны в вашей [сети](../../vpc/concepts/network.md#network), для ресурсов будет разрешен весь входящий и исходящий трафик. Дополнительной настройки не требуется.

Чтобы включить группы безопасности, [запросите в технической поддержке]({{ link-console-support }}) доступ к этой функции.

{% note warning %}

Если после добавления хоста к нему невозможно [подключиться](connect/index.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера {{ mmg-name }} настроена корректно для подсети, в которую помещен хост.

{% endnote %}


## Удалить хост {#remove-host}

Вы можете удалить хост `MONGOD` из кластера {{ mmg-name }}, если он не является единственным хостом. Чтобы заменить единственный хост, сначала создайте новый хост, а затем удалите старый.

Если хост является первичным в момент удаления, {{ mmg-name }} автоматически выберет новую первичную реплику.

Также в кластере {{ mmg-name }} с [включенным шардированием](../operations/shards.md#enable) допустимо удалить хосты `MONGOS`, `MONGOCFG` или `MONGOINFRA`, если их в кластере больше, чем [минимальное количество](#hosts-table), которое требуется для обеспечения работы шардирования.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить хост из кластера {{ mmg-name }}:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера {{ mmg-name }} и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне отметьте опцию **Я удаляю хост** и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.popup-confirm_button }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить хост из кластера {{ mmg-name }}, выполните команду:

  ```bash
  {{ yc-mdb-mg }} host delete <имя_хоста>
       --cluster-name <имя_кластера>
  ```

  Имя хоста можно запросить со [списком хостов в кластере {{ mmg-name }}](#list-hosts), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  Чтобы удалить хост из кластера {{ mmg-name }}:
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Удалите из описания кластера {{ mmg-name }} блок `host`, соответствующий удаляемому хосту.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Введите слово `yes` и нажмите **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API {#api}

  Чтобы удалить хост, воспользуйтесь методом REST API [deleteHosts](../api-ref/Cluster/deleteHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя или массив имен удаляемых хостов в параметре `hostNames`.

{% endlist %}

## Запустить ресинхронизацию хоста {#resetup}

Чтобы [повторно синхронизировать хост](https://docs.mongodb.com/manual/tutorial/resync-replica-set-member/) с остальными репликами в кластере или шарде {{ mmg-name }}, выполните операцию принудительной синхронизации. Операция применяется только к одному хосту `MONGOD` за раз и только для кластеров {{ mmg-name }} с более чем двумя репликами, независимо от класса и типа хостов. Ресинхронизация также позволяет освободить хранилище хоста от коллекций и документов, которые помечены как удаленные.

При выполнении этой операции:
1. Хост перестает принимать запросы на запись. Если хост был первичной репликой (`PRIMARY`), {{ mmg-name }} попытается [сделать его вторичной репликой](https://docs.mongodb.com/manual/reference/method/rs.stepDown/#rs.stepDown) (`SECONDARY`). В случае неудачи операция прерывается.
1. Инстанс {{ MG }} на хосте останавливается, и все данные удаляются.
1. Инстанс {{ MG }} снова запускается и заново скачивает данные с хостов-реплик.
1. После синхронизации с другими репликами в кластере {{ mmg-name }} хост становится вторичной репликой.

   {% note info %}

   * Во время синхронизации хост не сможет полноценно отвечать на запросы, так как на нем будет находиться только часть данных кластера {{ mmg-name }}.
   * Оценочная скорость синхронизации: от 300 ГБ в сутки.

   {% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы запустить принудительную ресинхронизацию хоста:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера {{ mmg-name }} и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-resetup }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы запустить принудительную ресинхронизацию хоста, выполните команду:

  ```bash
  {{ yc-mdb-mg }} hosts resetup <имя_хоста>
     --cluster-name <имя_кластера>
  ```

  Имя хоста можно запросить со [списком хостов в каталоге](hosts.md#list-hosts). Имя кластера {{ mmg-name }} можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

  Чтобы запустить ресинхронизацию хоста, воспользуйтесь методом REST API [resetupHosts](../api-ref/Cluster/resetupHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ResetupHosts](../api-ref/grpc/Cluster/resetupHosts.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
  * Имя хоста в параметре `hostNames`. Чтобы узнать имя, [получите список хостов в кластере](#list-hosts).

{% endlist %}

## Перезагрузить хост {#restart}

Вы можете вручную перезагрузить хост кластера {{ mmg-name }}.

Перезагрузка может привести к временной недоступности кластера или [шарда](../concepts/sharding.md) {{ mmg-name }}:
* Если в кластере только один хост.
* Если хост является [первичной репликой](../concepts/replication.md).

При перезагрузке первичной реплики не происходит ее автоматического переключения. Чтобы избежать недоступности кластера {{ mmg-name }}, [переключите первичную реплику](stepdown.md) кластера до ее перезагрузки.

{% note info %}

Вы можете перезагрузить только один хост за раз.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы перезагрузить хост:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера {{ mmg-name }} и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **{{ ui-key.yacloud.mdb.cluster.hosts.action_restart-host }}**.
  1. Подтвердите перезагрузку хоста.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы перезагрузить хост, выполните команду:

  ```bash
  {{ yc-mdb-mg }} hosts restart <имя_хоста> \
    --cluster-name <имя_кластера>
  ```

- API {#api}

  Чтобы перезагрузить хост, воспользуйтесь методом REST API [restartHosts](../api-ref/Cluster/restartHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/RestartHosts](../api-ref/grpc/Cluster/restartHosts.md) и передайте в запросе:
  * Идентификатор кластера {{ mmg-name }} в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
  * Имя хоста в параметре `hostNames`. Чтобы узнать имя, [получите список хостов в кластере](#list-hosts).

{% endlist %}
