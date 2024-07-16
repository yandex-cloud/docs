# Управление хостами кластера {{ CH }}

Вы можете выполнить следующие действия над хостами {{ CH }}:

* [получить список хостов в кластере](#list-hosts);
* [создать хост](#add-host);
* [изменить настройки {{ CH }} для хоста](#update);
* [перезапустить хост](#restart);
* [удалить хост](#remove-host).

О том, как перенести хосты {{ CH }} в другую [зону доступности](../../overview/concepts/geo-scope.md), читайте в [инструкции](host-migration.md#clickhouse-hosts).

{% note warning %}

Если вы создали кластер без поддержки [{{ CK }}](../concepts/replication.md#ck), то прежде чем добавлять новые хосты в любой из [шардов](../concepts/sharding.md), [включите отказоустойчивость](zk-hosts.md#add-zk) с использованием хостов {{ ZK }}.

{% endnote %}

## Получить список хостов в кластере {#list-hosts}

{% include notitle [get-hosts](../../_includes/mdb/mch/get-hosts.md) %}

## Создать хост {#add-host}

Количество хостов в кластерах {{ mch-name }} ограничено квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

С помощью CLI, {{ TF }} и API можно создать сразу несколько хостов в кластере.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.

  
  1. Укажите параметры хоста:
     * Зону доступности.
     * Подсеть (если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md)).
     * Выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.
     * Имя шарда.
     * Выберите опцию **{{ ui-key.yacloud.clickhouse.hosts.dialog.field_copy_schema }}**, чтобы скопировать схему со случайной реплики на новый хост.


- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать один или несколько хостов:

  
  1. Запросите список подсетей кластера, чтобы выбрать подсеть для нового хоста:

     ```bash
     yc vpc subnet list
     ```

     Результат:

     ```text
     +-----------+-----------+------------+---------------+------------------+
     |     ID    |   NAME    | NETWORK ID |     ZONE      |      RANGE       |
     +-----------+-----------+------------+---------------+------------------+
     | b0cl69... | default-d | enp6rq7... | {{ region-id }}-d | [172.16.0.0/20]  |
     | e2lkj9... | default-b | enp6rq7... | {{ region-id }}-b | [10.10.0.0/16]   |
     | e9b0ph... | a-2       | enp6rq7... | {{ region-id }}-a | [172.16.32.0/20] |
     | e9b9v2... | default-a | enp6rq7... | {{ region-id }}-a | [172.16.16.0/20] |
     +-----------+-----------+------------+---------------+------------------+
     ```

     Если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md).


  1. Посмотрите описание команды CLI для создания хостов:

     ```bash
     {{ yc-mdb-ch }} hosts add --help
     ```

  1. Выполните команду создания хостов.

     Укажите в команде один или несколько параметров `--host`: по одному параметру на каждый хост, который нужно создать.

     Команда для создания одного хоста имеет вид:

     
     ```bash
     {{ yc-mdb-ch }} hosts add \
       --cluster-name=<имя_кластера> \
       --host zone-id=<зона_доступности>,`
         `subnet-id=<идентификатор_подсети>,`
         `assign-public-ip=<публичный_доступ_к_хосту>,`
         `shard-name=<имя_шарда>,`
         `type=clickhouse
     ```

     Где `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.


     Чтобы скопировать схему данных со случайной реплики на новый хост, укажите необязательный параметр `--copy-schema`.

     {{ mch-name }} запустит операцию создания хостов.

     
     Идентификатор подсети необходимо указать, если в зоне доступности больше одной подсети, в противном случае {{ mch-name }} автоматически выберет единственную подсеть. Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Добавьте к описанию кластера {{ mch-name }} один или несколько блоков `host`: по одному блоку на каждый хост, который нужно создать.

     Единичный блок `host` имеет вид:

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
       ...
       host {
         type             = "CLICKHOUSE"
         zone             = "<зона_доступности>"
         subnet_id        = "<идентификатор_подсети>"
         assign_public_ip = <публичный_доступ_к_хосту>
       }
     }
     ```

     Где `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

  Чтобы создать один или несколько хостов в кластере, воспользуйтесь методом REST API [addHosts](../api-ref/Cluster/addHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/AddHosts](../api-ref/grpc/cluster_service.md#AddHosts) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Один или несколько параметров `hostSpecs`: по одному параметру на каждый хост, который нужно создать.

  Чтобы скопировать схему данных со случайной реплики на новый хост, передайте в запросе параметр `copySchema` со значением `true`.

{% endlist %}

{% note warning %}


Если после создания хоста к нему невозможно [подключиться](connect/clients.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера настроена корректно для подсети, в которую помещен хост.


Используйте опцию копирования схемы данных только в том случае, когда схема одинакова на всех хостах-репликах кластера.

{% endnote %}

## Изменить хост {#update}

Для каждого хоста в кластере {{ mch-name }} можно изменить настройки публичного доступа.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить параметры хоста в кластере:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **{{ ui-key.yacloud.common.edit }}**.
  1. Включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить параметры хоста, выполните команду:

  ```bash
  {{ yc-mdb-ch }} host update <имя_хоста> \
    --cluster-name=<имя_кластера> \
    --assign-public-ip=<публичный_доступ_к_хосту>
  ```

  Где `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

  Имя хоста можно запросить со [списком хостов в кластере](#list-hosts), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. В блоке `host` нужного хоста добавьте параметр `assign_public_ip` или измените его значение.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
       ...
       host {
         ...
         assign_public_ip = <публичный_доступ_к_хосту>
       }
       ...
     }
     ```

     Где `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

- API {#api}

  Чтобы изменить параметры хоста, воспользуйтесь методом REST API [updateHosts](../api-ref/Cluster/updateHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/UpdateHosts](../api-ref/grpc/cluster_service.md#UpdateHosts) и передайте в запросе:
  * Идентификатор кластера, в котором нужно изменить хост, в параметре `clusterId`. Чтобы узнать идентификатор, получите [список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя хоста, который нужно изменить, в параметре `updateHostSpecs.hostName`. Чтобы узнать имя, получите [список хостов в кластере](#list-hosts).
  * Настройки публичного доступа к хосту в параметре `updateHostSpecs.assignPublicIp`.
  * Список полей конфигурации кластера, подлежащих изменению (в данном случае — `assignPublicIp`), в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}


{% note warning %}

Если после изменения хоста к нему невозможно [подключиться](connect/clients.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера настроена корректно для подсети, в которую помещен хост.

{% endnote %}


## Перезапустить хост {#restart}

{% include notitle [restart-host](../../_includes/mdb/mch/restart-host.md) %}

## Удалить хост {#remove-host}

С помощью CLI, {{ TF }} и API можно удалить сразу несколько хостов из кластера.

{% note warning %}

Нельзя удалить хост из кластера или шарда, если достигнут [соответствующий лимит на минимальное количество хостов](../concepts/limits.md#mch-limits).

Нельзя удалить хосты, на которых размещается [{{ CK }}](../concepts/replication.md#ck), если при создании кластера была включена поддержка этого механизма репликации.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить один или несколько хостов из кластера, выполните команду, передав нужные имена хостов. Используйте пробел в качестве разделителя.

  Команда для удаления одного хоста имеет вид:

  ```bash
  {{ yc-mdb-ch }} hosts delete --cluster-name=<имя_кластера> \
    <имя_хоста>
     
  ```

  Имена хостов можно запросить со [списком хостов в кластере](#list-hosts), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Удалите из описания кластера {{ mch-name }} один или несколько блоков `host` с типом `CLICKHOUSE`.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Введите слово `yes` и нажмите **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

  Чтобы удалить один или несколько хостов, воспользуйтесь методом REST API [deleteHosts](../api-ref/Cluster/deleteHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/DeleteHosts](../api-ref/grpc/cluster_service.md#DeleteHosts) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Массив с именами хостов, которые нужно удалить, в параметре `hostNames`.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
