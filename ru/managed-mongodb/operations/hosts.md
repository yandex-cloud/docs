# Управление хостами {{ MG }}-кластера

Вы можете добавлять и удалять [хосты кластера ](../concepts/index.md), запускать повторную синхронизацию хостов, а также [управлять настройками {{ MG }}](update.md) для отдельных кластеров.

## Получить список хостов в кластере {#list-hosts}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
  1. Нажмите на имя нужного кластера {{ mmg-name }}.
  1. Выберите вкладку **Хосты**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список хостов в кластере {{ mmg-name }}, выполните команду:

  ```bash
  {{ yc-mdb-mg }} host list \
    --cluster-name <имя кластера>
  ```

  Результат:

  
  ```text
  +-----------------------+--------------+--------+------------+-----------+----------+-------------------+-----------+
  |         NAME          |  CLUSTER ID  |  TYPE  | SHARD NAME |   ROLE    |  HEALTH  |      ZONE ID      | PUBLIC IP |
  +-----------------------+--------------+--------+------------+-----------+----------+-------------------+-----------+
  | rc1b...{{ dns-zone }} | c9qp71dk1... | MONGOD | rs01       | PRIMARY   | ALIVE    | {{ region-id }}-b | false     |
  | rc1a...{{ dns-zone }} | c9qp71dk1... | MONGOD | rs01       | SECONDARY | ALIVE    | {{ region-id }}-a | false     |
  +-----------------------+--------------+--------+------------+-----------+----------+-------------------+-----------+
  ```


  Имя кластера {{ mmg-name }} можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

  Чтобы получить список хостов кластера {{ mmg-name }}, воспользуйтесь методом REST API [listHosts](../api-ref/Cluster/listHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListHosts](../api-ref/grpc/cluster_service.md#ListHosts) и передайте в запросе идентификатор кластера в параметре `clusterId`.

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

{% list tabs %}

- Консоль управления

  Чтобы добавить хост в кластере {{ mmg-name }}:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
  1. Нажмите на имя нужного кластера {{ mmg-name }} и перейдите на вкладку **Хосты**.
  1. Нажмите кнопку **Добавить хост**.
  1. Укажите параметры хоста:
     * [Зону доступности](../../overview/concepts/geo-scope.md).
     * [Подсеть](../../vpc/concepts/network.md#subnet) (если нужной подсети в списке нет, создайте ее).
     * Выберите опцию **Публичный доступ**, если хост должен быть доступен извне {{ yandex-cloud }}.
     * Тип хоста и название шарда, если в кластере {{ mmg-name }} включено шардирование.
  1. Нажмите **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы добавить хост в кластере {{ mmg-name }}:
  1. Запросите список подсетей кластера {{ mmg-name }}, чтобы выбрать [подсеть](../../vpc/concepts/network.md#subnet) для нового хоста:

     ```bash
     yc vpc subnet list
     ```

     Результат:

     ```text
     +-----------+-----------+------------+-------------------+------------------+
     |     ID    |   NAME    | NETWORK ID |       ZONE        |      RANGE       |
     +-----------+-----------+------------+-------------------+------------------+
     | b0cl69... | default-c | enp6rq7... | {{ region-id }}-c | [172.16.0.0/20]  |
     | e2lkj9... | default-b | enp6rq7... | {{ region-id }}-b | [10.10.0.0/16]   |
     | e9b0ph... | a-2       | enp6rq7... | {{ region-id }}-a | [172.16.32.0/20] |
     | e9b9v2... | default-a | enp6rq7... | {{ region-id }}-a | [172.16.16.0/20] |
     +-----------+-----------+------------+-------------------+------------------+
     ```

     Если нужной подсети в списке нет, создайте ее.
  1. Посмотрите описание команды CLI для добавления хостов:

     ```bash
     {{ yc-mdb-mg }} host add --help
     ```

  1. Выполните команду добавления хоста:

      ```bash
      {{ yc-mdb-mg }} host add \
        --cluster-name <имя кластера> \
        --host zone-id=<зона доступности>,subnet-id=<ID подсети>
      ```

     {{ mmg-name }} запустит операцию добавления хоста.

     Идентификатор подсети необходимо указать, если в [зоне доступности](../../overview/concepts/geo-scope.md) больше одной подсети, в противном случае {{ mmg-name }} автоматически выберет единственную подсеть. Имя кластера {{ mmg-name }} можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

  Чтобы добавить хост в кластере {{ mmg-name }}:
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  1. Добавьте к описанию кластера {{ mmg-name }}:
     * Ресурсы, соответствующие типу шардирования, если вы добавляете хост в шардированный кластер:
       * `resources_mongoinfra` — для стандартного шардирования.
       * `resources_mongos` и `resources_mongocfg` — для расширенного шардирования.
     * Блок `host`.

     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<имя кластера>" {
       ...
       resources_mongod {
         resource_preset_id = "<класс хоста>"
         disk_type_id       = "<тип диска>"
         disk_size          = <размер хранилища, ГБ>
       }

       resources_mongoinfra { # Добавьте для стандартного шардирования.
         resource_preset_id = "<класс хоста>"
         disk_type_id       = "<тип диска>"
         disk_size          = <размер хранилища, ГБ>
       }

       resources_mongos { # Добавьте для расширенного шардирования.
         resource_preset_id = "<класс хоста>"
         disk_type_id       = "<тип диска>"
         disk_size          = <размер хранилища, ГБ>
       }

       resources_mongocfg { # Добавьте для расширенного шардирования.
         resource_preset_id = "<класс хоста>"
         disk_type_id       = "<тип диска>"
         disk_size          = <размер хранилища, ГБ>
       }

       host {
         role             = "<тип реплики: PRIMARY или SECONDARY>"
         zone_id          = "<зона доступности>"
         subnet_id        = "<подсеть в зоне доступности>"
         assign_public_ip = true / false
         shard_name       = "<имя шарда в шардированном кластере>"
         type             = "<тип хоста в шардированном кластере: MONGOD, MONGOINFRA, MONGOS или MONGOCFG>"
         ...
       }
     }
     ```

  1. Проверьте корректность настроек.
  
     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_mongodb_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

  Чтобы добавить хост в кластер, воспользуйтесь методом REST API [addHosts](../api-ref/Cluster/addHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/AddHosts](../api-ref/grpc/cluster_service.md#AddHosts) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Настройки нового хоста в одном или нескольких параметрах `hostSpecs`.

{% endlist %}


[Группы безопасности](../../vpc/concepts/security-groups.md) находятся на [стадии Preview](../../overview/concepts/launch-stages.md). Если они недоступны в вашей [сети](../../vpc/concepts/network.md#network), для ресурсов будет разрешен весь входящий и исходящий трафик. Дополнительной настройки не требуется.

Чтобы включить группы безопасности, [запросите в технической поддержке]({{ link-console-support }}/create-ticket) доступ к этой функции.

{% note warning %}

Если после добавления хоста к нему невозможно [подключиться](connect/index.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера {{ mmg-name }} настроена корректно для подсети, в которую помещен хост. Группы безопасности находятся на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}


## Удалить хост {#remove-host}

Вы можете удалить хост `MONGOD` из кластера {{ mmg-name }}, если он не является единственным хостом. Чтобы заменить единственный хост, сначала создайте новый хост, а затем удалите старый.

Если хост является первичным в момент удаления, {{ mmg-name }} автоматически выберет новую первичную реплику.

Также в кластере {{ mmg-name }} с [включенным шардированием](../operations/shards.md#enable) допустимо удалить хосты `MONGOS`, `MONGOCFG` или `MONGOINFRA`, если их в кластере больше, чем [минимальное количество](#hosts-table), которое требуется для обеспечения работы шардирования.

{% list tabs %}

- Консоль управления

  Чтобы удалить хост из кластера {{ mmg-name }}:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
  1. Нажмите на имя нужного кластера {{ mmg-name }} и выберите вкладку **Хосты**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) в строке нужного хоста и выберите пункт **Удалить**.
  1. В открывшемся окне отметьте опцию **Я удаляю хост** и нажмите кнопку **Подтвердить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить хост из кластера {{ mmg-name }}, выполните команду:

  ```bash
  {{ yc-mdb-mg }} host delete <имя хоста>
       --cluster-name <имя кластера>
  ```

  Имя хоста можно запросить со [списком хостов в кластере {{ mmg-name }}](#list-hosts), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

  Чтобы удалить хост из кластера {{ mmg-name }}:
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  1. Удалите из описания кластера {{ mmg-name }} блок `host`, соответствующий удаляемому хосту.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Введите слово `yes` и нажмите **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_mongodb_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

  Чтобы удалить хост, воспользуйтесь методом REST API [deleteHosts](../api-ref/Cluster/deleteHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/DeleteHosts](../api-ref/grpc/cluster_service.md#DeleteHosts) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя или массив имен удаляемых хостов в параметре `hostNames`.

{% endlist %}

## Запустить ресинхронизацию хоста {#resetup}

Чтобы [повторно синхронизировать хост](https://docs.mongodb.com/manual/tutorial/resync-replica-set-member/) с остальными репликами в кластере или шарде {{ mmg-name }}, выполните операцию принудительной синхронизации. Операция применяется только к одному хосту `MONGOD` за раз и только для кластеров {{ mmg-name }} с более чем двумя репликами, независимо от класса и типа хостов. Ресинхронизация также позволяет освободить хранилище хоста от коллекций и документов, которые помечены как удаленные.

При выполнении этой операции:
1. Хост перестает принимать запросы на запись. Если хост был первичной репликой (`PRIMARY`), {{ mmg-name }} попытается [сделать его вторичной репликой](https://docs.mongodb.com/manual/reference/method/rs.stepDown/#rs.stepDown) (`SECONDARY`). В случае неудачи операция прерывается.
1. Инстанс {{ MG }} на хосте останавливается, и все данные удаляются.
1. Инстанс {{ MG }} снова запускается и заново скачивает данные с хостов-реплик.
1. После того как хост синхронизировался другими репликами в кластере {{ mmg-name }}, он становится вторичной репликой.

   {% note info %}

   * Во время синхронизации хост не сможет полноценно отвечать на запросы, так как на нем будет находиться только часть данных кластера {{ mmg-name }}.
   * Оценочная скорость синхронизации: от 300 ГБ в сутки.

   {% endnote %}

{% list tabs %}

- Консоль управления

  Чтобы запустить принудительную ресинхронизацию хоста:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
  1. Нажмите на имя нужного кластера {{ mmg-name }} и выберите вкладку **Хосты**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) в строке нужного хоста и выберите пункт **Ресинхронизировать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы запустить принудительную ресинхронизацию хоста, выполните команду:

  ```bash
  {{ yc-mdb-mg }} hosts resetup <имя_хоста>
     --cluster-name <имя кластера>
  ```

  Имя хоста можно запросить со [списком хостов в каталоге](hosts.md#list-hosts). Имя кластера {{ mmg-name }} можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

  Чтобы запустить ресинхронизацию хоста, воспользуйтесь методом REST API [resetupHosts](../api-ref/Cluster/resetupHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ResetupHosts](../api-ref/grpc/cluster_service.md#ResetupHosts) и передайте в запросе:
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

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы перезагрузить хост, выполните команду:

  ```bash
  {{ yc-mdb-mg }} hosts restart <имя хоста> \
    --cluster-name <имя кластера>
  ```

- API

  Чтобы перезагрузить хост, воспользуйтесь методом REST API [restartHosts](../api-ref/Cluster/restartHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/RestartHosts](../api-ref/grpc/cluster_service.md#RestartHosts) и передайте в запросе:
  * Идентификатор кластера {{ mmg-name }} в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
  * Имя хоста в параметре `hostNames`. Чтобы узнать имя, [получите список хостов в кластере](#list-hosts).

{% endlist %}
