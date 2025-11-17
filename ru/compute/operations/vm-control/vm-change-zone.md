---
title: Как перенести виртуальную машину в другую зону доступности
description: Следуя данной инструкции, вы сможете перенести виртуальную машину в другую зону доступности.
---

# Перенести виртуальную машину в другую зону доступности

При создании виртуальной машины можно выбрать, в какой из [зон доступности](../../../overview/concepts/geo-scope.md) {{ yandex-cloud }} она будет размещена.

Перенести существующую ВМ в другую зону доступности можно путем создания копии ВМ в нужной зоне доступности с помощью снимков дисков.

Также вы можете перенести ВМ из зон `{{ region-id }}-a` и `{{ region-id }}-b` в зону `{{ region-id }}-d` с помощью специальной команды [CLI](../../../cli/cli-ref/compute/cli-ref/instance/relocate.md).


{% include [relocate-note](../../../_includes/compute/relocate-note.md) %}


{% note warning %}

В зоне `{{ region-id }}-d` не поддерживаются ВМ на [платформе](../../concepts/vm-platforms.md) Intel Broadwell. Чтобы перенести ВМ с такой платформы в зону `{{ region-id }}-d`, вы можете:

* Сделать снимок диска и создать из него новую ВМ в зоне `{{ region-id }}-d` на другой платформе.
* Остановить ВМ, изменить платформу и переместить ВМ командой `yc compute instance relocate`.

{% endnote %}

## Перенести ВМ с помощью снимков дисков {#relocate-snapshots}

Чтобы перенести ВМ в другую зону доступности с помощью снимков дисков, создайте копию этой ВМ в нужной зоне доступности и затем удалите исходную ВМ.

### Создайте снимок каждого из дисков виртуальной машины {#create-snapshot}

#### Подготовьте диски {#prepare-disks}

{% include [prepare-snapshots](../../../_includes/compute/prepare-snapshots.md) %}

#### Создайте снимки {#create}

Чтобы [создать](../disk-control/create-snapshot.md) снимок диска:

{% include [create-snapshot](../../../_includes/compute/create-snapshot.md) %}

Аналогичным образом создайте снимки всех дисков.

### Создайте виртуальную машину в другой зоне доступности с дисками из снимков {#create-vm}

Чтобы [создать](../vm-create/create-from-snapshots.md) виртуальную машину в другой зоне доступности с дисками из снимков:

{% include [create-from-snapshot](../../../_includes/compute/create-from-snapshot.md) %}

### Удалите исходную виртуальную машину {#delete-vm}

Чтобы [удалить](vm-delete.md) исходную виртуальную машину:

{% include [delete-vm](../../../_includes/compute/delete-vm.md) %}

## Перенести ВМ в зону {{ region-id }}-d с помощью специальной команды {#relocate-command}

С помощью специальной команды CLI можно перенести виртуальную машину только в зону доступности `{{ region-id }}-d`. В таком случае у ВМ сохраняются идентификатор и метаданные. Вместе с ВМ в новую зону доступности будут перенесены и все подключенные к ней диски.

{% note info %}

Продолжительность операции переноса в другую зону доступности зависит от размера дисков виртуальной машины. Перенос диска размером 100 ГБ занимает больше 10 минут.

{% endnote %}

{% list tabs group=instructions %}


- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для переноса виртуальной машины в другую зону доступности:

      ```bash
      yc compute instance relocate --help
      ```

  1. Получите список всех подсетей в каталоге по умолчанию:

      ```bash
      yc vpc subnet list
      ```

      Результат:

      ```text
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      |          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE      |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      | e2l5iit0t6dr******** | default-{{ region-id }}-b | enpnohfm8jb5******** |                | {{ region-id }}-b | [10.129.0.0/24] |
      | e9b2ljn7h9pj******** | default-{{ region-id }}-a | enpnohfm8jb5******** |                | {{ region-id }}-a | [10.128.0.0/24] |
      | fl8in4sila9i******** | default-{{ region-id }}-d | enpnohfm8jb5******** |                | {{ region-id }}-d | [10.130.0.0/24] |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      ```

  1. Получите список всех групп безопасности в каталоге по умолчанию:

      ```bash
      yc vpc sg list
      ```

      Результат:

      ```text
      +----------------------+---------------------------------+--------------------------------+----------------------+
      |          ID          |              NAME               |          DESCRIPTION           |      NETWORK-ID      |
      +----------------------+---------------------------------+--------------------------------+----------------------+
      | enpagmu40nj577vbbsl5 | my-sg-group                     |                                | enpnohfm8jb52d4c9av8 |
      | enpe9n88cellg5p3av6g | default-sg-enpnohfm8jb52d4c9av8 | Default security group for     | enpnohfm8jb52d4c9av8 |
      |                      |                                 | network                        |                      |
      +----------------------+---------------------------------+--------------------------------+----------------------+
      ```

  1. Получите список всех виртуальных машин в каталоге по умолчанию:

      ```bash
      yc compute instance list
      ```

      Результат:

      ```text
      +----------------------+---------+---------------+---------+--------------+-------------+
      |          ID          |  NAME   |    ZONE ID    | STATUS  | EXTERNAL IP  | INTERNAL IP |
      +----------------------+---------+---------------+---------+--------------+-------------+
      | epdi9vnr8i6n******** | my-vm-1 | {{ region-id }}-b | RUNNING | 84.201.166.2 | 10.129.0.31 |
      | epdjhkhtqjfp******** | my-vm-2 | {{ region-id }}-d | RUNNING |              | 10.130.0.6  |
      +----------------------+---------+---------------+---------+--------------+-------------+
      ```

  1. Получите список [сетевых интерфейсов](../../concepts/network.md) нужной ВМ, указав ее идентификатор:

     ```bash
     yc compute instance get <идентификатор_ВМ>
     ```

     Результат:

     ```yml
     ...
     network_interfaces:
       - index: "0"
         mac_address: d0:0d:12:4f:ef:b4
         subnet_id: e2l5iit0t6dr********
         primary_v4_address:
           address: 10.129.0.31
           one_to_one_nat:
             address: 84.201.166.2
             ip_version: IPV4
     ...
     ```

  1. Перенесите нужную виртуальную машину в другую зону доступности:

      ```bash
      yc compute instance relocate <идентификатор_ВМ> \
        --destination-zone-id {{ region-id }}-d \
        --network-interface subnet-id=<идентификатор_подсети>,security-group-ids=<идентификатор_группы_безопасности>
      ```

      Где:

      * `<идентификатор_ВМ>` — идентификатор ВМ, которую требуется перенести в другую зону доступности.
      * `--destination-zone-id` — идентификатор [зоны доступности](../../../overview/concepts/geo-scope.md). Поддерживается только `{{ region-id }}-d`.
      * `--network-interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ:
          * `subnet-id` — идентификатор подсети, соответствующей зоне доступности, в которую требуется перенести ВМ.
          * `security-group-ids` — идентификатор [группы безопасности](../../../vpc/concepts/security-groups.md), которую требуется привязать к переносимой ВМ. К одной ВМ можно привязать одновременно несколько групп безопасности, в этом случае передайте их идентификаторы через запятую в формате `[id1,id2]`.

          Если у ВМ несколько сетевых интерфейсов, задайте параметр `--network-interface` необходимое количество раз (для каждого сетевого интерфейса).

      Подробнее о команде `yc compute instance relocate` см. в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/relocate.md).

      Если вы переносите ВМ с [диском в группе размещения](../../concepts/disk-placement-group.md), используйте команду:

      ```bash
      yc compute instance relocate <идентификатор_ВМ> \
        --destination-zone-id {{ region-id }}-d \
        --network-interface subnet-id=<идентификатор_подсети>,security-group-ids=<идентификатор_группы_безопасности> \
        --boot-disk-placement-group-id <идентификатор_группы_размещения_дисков> \
        --boot-disk-placement-group-partition <номер_раздела> \
        --secondary-disk-placement disk-name=<имя_диска>,disk-placement-group-id=<идентификатор_группы_размещения_дисков>,disk-placement-group-partition=<номер_раздела>
      ```

      Где:

      * `--boot-disk-placement-group-id` — идентификатор группы размещения дисков.
      * `--boot-disk-placement-group-partition` — номер раздела в группе размещения дисков со стратегией [размещения разделами](../../concepts/disk-placement-group.md#partition).
      * `--secondary-disk-placement` — политика размещения для дополнительных дисков. Параметры:

        * `disk-name` — имя диска.
        * `disk-placement-group-id` — идентификатор группы размещения дисков, в которую необходимо поместить диск.
        * `disk-placement-group-partition` — номер раздела в группе размещения дисков.

      Подробнее о команде `yc compute instance relocate` см. в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/relocate.md).

  Обратите внимание, что при подключении [сетевых интерфейсов](../../concepts/network.md) ВМ к новым подсетям изменится адресация. Если для сетевых интерфейсов ВМ требуется указать внутренние IP-адреса, используйте свойство `ipv4-address=<внутренний_IP-адрес>`, если публичные IP-адреса — свойство `nat-address=<публичный_IP-адрес>` параметра `network-interface`. В остальном установка параметров сетевых интерфейсов при переносе ВМ в другую зону доступности аналогична установке таких параметров при создании ВМ.

{% endlist %}

{% note info %}

Если на диски ВМ активно ведется запись, их перенос может завершиться ошибкой. В таком случае остановите запись на диски или выключите виртуальную машину и повторно запустите перенос.

{% endnote %}

### Примеры {#examples}

#### Перенос ВМ в другую зону {#jump-from-a-to-d}

В этом примере ВМ `my-vm-1` переносится из зоны доступности `{{ region-id }}-b` в зону доступности `{{ region-id }}-d`.

```bash
yc compute instance relocate epdi9vnr8i6n******** \
  --destination-zone-id {{ region-id }}-d \
  --network-interface subnet-id=fl8in4sila9i********,security-group-ids=enpagmu40nj5********
```

Результат:

```text
done (1m28s)
id: epdi9vnr8i6n********
folder_id: b1g0ijbfaqsn********
created_at: "2025-11-04T18:44:29Z"
name: my-vm-1
zone_id: {{ region-id }}-d
platform_id: standard-v3
resources:
  memory: "2147483648"
  cores: "2"
  core_fraction: "50"
status: RUNNING
metadata_options:
  gce_http_endpoint: ENABLED
  aws_v1_http_endpoint: ENABLED
  gce_http_token: ENABLED
  aws_v1_http_token: DISABLED
boot_disk:
  mode: READ_WRITE
  device_name: epdkl5gn20gv********
  auto_delete: true
  disk_id: epdkl5gn20gv********
network_interfaces:
  - index: "0"
    mac_address: d0:0d:12:4f:ef:b4
    subnet_id: fl8in4sila9i********
    primary_v4_address:
      address: 10.130.0.8
    security_group_ids:
      - enpagmu40nj5********
serial_port_settings:
  ssh_authorization: OS_LOGIN
gpu_settings: {}
fqdn: my-vm-1.{{ region-id }}.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}
hardware_generation:
  legacy_features:
    pci_topology: PCI_TOPOLOGY_V1
application: {}
```

#### Перенос ВМ с дисками в группе размещения {#jump-with-disk-placement-group}

В этом примере ВМ `my-vm-1` с двумя дисками в группе размещения переносится из зоны доступности `{{ region-id }}-b` в зону доступности `{{ region-id }}-d`.

```bash
yc compute instance relocate epd6qtn128k1******** \
  --destination-zone-id {{ region-id }}-d \
  --network-interface \
    subnet-id=fl8glc5v0lqj********,security-group-ids=enp1gjh3q042******** \
  --boot-disk-placement-group-id fv4pfmor782v******** \
  --boot-disk-placement-group-partition 1 \
  --secondary-disk-placement \
    disk-name=disk-two,fv4pfmor782v********,disk-placement-group-partition=2
```

Результат:

```text
done (9m0s)
id: epd6qtn128k1********
folder_id: b1gmit33ngp3********
created_at: "2023-12-07T19:30:20Z"
name: my-vm-1
zone_id: {{ region-id }}-d
platform_id: standard-v3
resources:
  memory: "2147483648"
  cores: "2"
  core_fraction: "100"
status: RUNNING
metadata_options:
  gce_http_endpoint: ENABLED
  aws_v1_http_endpoint: ENABLED
  gce_http_token: ENABLED
  aws_v1_http_token: DISABLED
boot_disk:
  mode: READ_WRITE
  device_name: epdeqrm6g38j********
  auto_delete: true
  disk_id: epdeqrm6g38j********
secondary_disks:
  - mode: READ_WRITE
    device_name: epdi54snn7t6********
    disk_id: epdi54snn7t6********
network_interfaces:
  - index: "0"
    mac_address: d0:0d:6d:76:e1:12
    subnet_id: fl8glc5v0lqj********
    primary_v4_address:
      address: 10.130.0.12
    security_group_ids:
      - enp1gjh3q042********
gpu_settings: {}
fqdn: my-vm-1.{{ region-id }}.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}
```
