---
title: "Управление хостами {{ PG }}-кластера"
description: "Из статьи вы узнаете, как управлять хостами {{ PG }}-кластера. Вы сможете добавлять и удалять хосты кластера, а также управлять настройками через консоль управления, CLI и API сервиса."
---

# Управление хостами {{ PG }}-кластера

Вы можете добавлять и удалять хосты кластера, а также управлять их настройками.

## Получить список хостов в кластере {#list}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список хостов в кластере, выполните команду:

  ```bash
  {{ yc-mdb-pg }} host list \
    --cluster-name <имя кластера>
  ```

  Результат:

  
  ```text
  +-----------------------+--------------+---------+--------+-------------------+
  |         NAME          |  CLUSTER ID  |  ROLE   | HEALTH |      ZONE ID      |
  +-----------------------+--------------+---------+--------+-------------------+
  | rc1b...{{ dns-zone }} | c9qp71dk1... | MASTER  | ALIVE  | {{ region-id }}-b |
  | rc1a...{{ dns-zone }} | c9qp71dk1... | REPLICA | ALIVE  | {{ region-id }}-a |
  +-----------------------+--------------+---------+--------+-------------------+
  ```


  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

  Чтобы получить список хостов кластера, воспользуйтесь методом REST API [listHosts](../api-ref/Cluster/listHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListHosts](../api-ref/grpc/cluster_service.md#ListHosts) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Добавить хост {#add}

Количество хостов в кластерах {{ mpg-short-name }} ограничено квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) и найдите блок **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

{% list tabs %}

- Консоль управления

  Чтобы добавить хост в кластере:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.
  1. Нажмите кнопку ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-host }}**.

  
  1. Укажите параметры хоста:
     * Зону доступности.
     * Подсеть (если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md)).
     * Источник репликации (если вы используете [каскадную репликацию](../concepts/replication.md#replication-manual)).
     * Выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.


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
     +-----------+-----------+------------+-------------------+------------------+
     |     ID    |   NAME    | NETWORK ID |       ZONE        |      RANGE       |
     +-----------+-----------+------------+-------------------+------------------+
     | b0cl69... | default-c | enp6rq7... | {{ region-id }}-c | [172.16.0.0/20]  |
     | e2lkj9... | default-b | enp6rq7... | {{ region-id }}-b | [10.10.0.0/16]   |
     | e9b0ph... | a-2       | enp6rq7... | {{ region-id }}-a | [172.16.32.0/20] |
     | e9b9v2... | default-a | enp6rq7... | {{ region-id }}-a | [172.16.16.0/20] |
     +-----------+-----------+------------+-------------------+------------------+
     ```

     Если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md).


  1. Посмотрите описание команды CLI для добавления хостов:

     ```bash
     {{ yc-mdb-pg }} host add --help
     ```

  1. Выполните команду добавления хоста:

     
     ```bash
     {{ yc-mdb-pg }} host add
       --cluster-name <имя кластера>
       --host zone-id=<зона доступности>,subnet-id=<ID подсети>
     ```


     
     Идентификатор подсети необходимо указать, если в зоне доступности больше одной подсети, в противном случае {{ mpg-short-name }} автоматически выберет единственную подсеть. Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


     Также вы можете указать несколько дополнительных опций в параметре `--host` для управления публичным доступом к хосту и репликацией в кластере:
     * Источник репликации для хоста в опции `replication-source` для того, чтобы [вручную управлять потоками репликации](../concepts/replication.md#replication-manual).
     * Доступность хоста извне {{ yandex-cloud }} в опции `assign-public-ip`:
       * `true` — публичный доступ включен.
       * `false` — публичный доступ выключен.

  {{ mpg-short-name }} запустит операцию добавления хоста.

- {{ TF }}

  Чтобы добавить хост в кластере:
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

     Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).
  1. Добавьте к описанию кластера {{ mpg-name }} блок `host`.

     ```hcl
     resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
       ...
       host {
         name                    = "<имя хоста>"
         zone                    = "<зона доступности>"
         subnet_id               = "<идентификатор подсети>"
         replication_source_name = "<источник репликации: атрибут name соответствующего блока host>"
         assign_public_ip        = <публичный доступ к хосту: true или false>
       }
     }
     ```

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

  Чтобы добавить хост в кластер, воспользуйтесь методом REST API [addHosts](../api-ref/Cluster/addHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/AddHosts](../api-ref/grpc/cluster_service.md#AddHosts) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}


{% note warning %}

Если после добавления хоста к нему невозможно [подключиться](connect.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера настроена корректно для подсети, в которую помещен хост. Группы безопасности находятся на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}


## Изменить хост {#update}

Для каждого хоста в кластере {{ mpg-short-name }} можно указать источник [репликации](../concepts/replication.md) и управлять [публичным доступом](../concepts/network.md#public-access-to-a-host) к хосту.

{% list tabs %}

- Консоль управления

  Чтобы изменить параметры хоста в кластере:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) в строке нужного хоста и выберите пункт **{{ ui-key.yacloud.common.edit }}**.
  1. Задайте новые настройки для хоста:
     1. Выберите источник репликации для хоста для того, чтобы [вручную управлять потоками репликации](../concepts/replication.md#replication-manual).
     1. Включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.postgresql.hosts.dialog.button_choose }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить параметры хоста в кластере, выполните команду:

  ```bash
  {{ yc-mdb-pg }} host update <имя хоста>
    --cluster-name <имя кластера>
    --replication-source <имя хоста-источника>
    --assign-public-ip=<публичный доступ к хосту: true или false>
  ```

  Имя хоста можно запросить со [списком хостов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  Чтобы [вручную управлять потоками репликации](../concepts/replication.md#replication-manual) в кластере, измените источник репликации для хоста в параметре `--replication-source`.

- {{ TF }}

  Чтобы изменить параметры хоста в кластере:
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

     Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).
  1. Измените в описании кластера {{ mpg-name }} атрибуты блока `host`, соответствующего изменяемому хосту.

     ```hcl
     resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
       ...
       host {
         replication_source_name = "<источник репликации>"
         assign_public_ip        = <публичный доступ к хосту: true или false>
       }
     }
     ```

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

  Чтобы изменить параметры хоста, воспользуйтесь методом REST API [updateHosts](../api-ref/Cluster/updateHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/UpdateHosts](../api-ref/grpc/cluster_service.md#UpdateHosts) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Один или несколько объектов с настройками изменяемых хостов в параметре `updateHostSpecs`.

    Для каждого хоста укажите:
    * Имя в поле `hostName`.
    * Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}


{% note warning %}

Если после изменения хоста к нему невозможно [подключиться](connect.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера настроена корректно для подсети, в которую помещен хост. Группы безопасности находятся на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}


## Удалить хост {#remove}

Вы можете удалить хост из {{ PG }}-кластера, если он не является единственным хостом. Чтобы заменить единственный хост, сначала создайте новый хост, а затем удалите старый.

Если хост является мастером в момент удаления, {{ mpg-short-name }} автоматически назначит мастером следующую по приоритету реплику.

{% list tabs %}

- Консоль управления

  Чтобы удалить хост из кластера:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) в строке нужного хоста, выберите пункт **{{ ui-key.yacloud.common.delete }}** и подтвердите удаление.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить хост из кластера, выполните команду:

  ```bash
  {{ yc-mdb-pg }} host delete <имя хоста>
    --cluster-name <имя кластера>
  ```

  Имя хоста можно запросить со [списком хостов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

  Чтобы удалить хост из кластера:
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

     Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).
  1. Удалите из описания кластера {{ mpg-name }} блок `host`, соответствующий удаляемому хосту.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Введите слово `yes` и нажмите **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

  Чтобы удалить хост, воспользуйтесь методом REST API [deleteHosts](../api-ref/Cluster/deleteHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/DeleteHosts](../api-ref/grpc/cluster_service.md#DeleteHosts) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}