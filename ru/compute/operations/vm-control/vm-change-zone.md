---
title: "Как перенести виртуальную машину в другую зону доступности"
description: "Следуя данной инструкции, вы сможете перенести виртуальную машину в другую зону доступности."
---

# Перенести виртуальную машину в другую зону доступности

При создании виртуальной машины можно выбрать, в какой из [зон доступности](../../../overview/concepts/geo-scope.md) {{ yandex-cloud }} она будет размещена. 

Перенести существующую ВМ в другую зону доступности можно с помощью [команды CLI](../../../cli/cli-ref/managed-services/compute/instance/relocate.md) или путем создания копии ВМ в нужной зоне доступности с помощью [снимков дисков](../../concepts/snapshot.md).


{% include [relocate-note](../../../_includes/compute/relocate-note.md) %}


{% note warning %}

В зоне `{{ region-id }}-d` не поддерживаются ВМ на [платформе](../../concepts/vm-platforms.md) Intel Broadwell. Чтобы перенести ВМ с такой платформы в зону `{{ region-id }}-d`, вы можете:

* Сделать снимок диска и создать из него новую ВМ в зоне `{{ region-id }}-d` на другой платформе.
* Остановить ВМ, изменить платформу и переместить ВМ командой `relocate`.

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

## Перенести ВМ с помощью CLI {#relocate-cli}

При переносе в другую зону доступности с помощью CLI у ВМ сохранятся идентификатор и метаданные. Вместе с ВМ в новую зону доступности будут перенесены и все подключенные к ней диски.

{% note info %}

Продолжительность операции переноса в другую зону доступности зависит от размера дисков виртуальной машины. Перенос диска размером 100 ГБ занимает приблизительно 10 минут.

В некоторых случаях при переносе в зону доступности `{{ region-id }}-d` процесс может занять больше времени.

{% endnote %}

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Получите список всех подсетей в каталоге по умолчанию:

    ```bash
    yc vpc subnet list
    ```

    Результат:

    ```bash
    +----------------------+-----------------------+----------------------+----------------+---------------+------------------+
    |          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE       |
    +----------------------+-----------------------+----------------------+----------------+---------------+------------------+
    | bucqps2lt75g******** | default-{{ region-id }}-a | c64pv6m0aqq6******** |                | {{ region-id }}-a | [192.168.0.0/24] |
    | bltign9kcffv******** | default-{{ region-id }}-b | c64pv6m0aqq6******** |                | {{ region-id }}-b | [192.168.1.0/24] |
    | fo2e120dga7n******** | default-{{ region-id }}-c | c64pv6m0aqq6******** |                | {{ region-id }}-c | [192.168.2.0/24] |
    +----------------------+-----------------------+----------------------+----------------+---------------+------------------+
    ```

1. Получите список всех групп безопасности в каталоге по умолчанию:

    ```bash
    yc vpc sg list
    ```

    Результат:

    ```bash
    +----------------------+---------------------------------+--------------------------------+----------------------+
    |          ID          |              NAME               |          DESCRIPTION           |      NETWORK-ID      |
    +----------------------+---------------------------------+--------------------------------+----------------------+
    | c646ev94tb6k******** | my-sg-group                     |                                | c64pv6m0aqq6******** |
    | c64r84tbt32j******** | default-sg-c64pv6m0aqq6******** | Default security group for     | c64pv6m0aqq6******** |
    |                      |                                 | network                        |                      |
    +----------------------+---------------------------------+--------------------------------+----------------------+
    ```

1. Получите список всех виртуальных машин в каталоге по умолчанию:

    ```bash
    yc compute instance list
    ```

    Результат:

    ```bash
    +----------------------+---------+---------------+---------+---------------+-------------+
    |          ID          |  NAME   |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP |
    +----------------------+---------+---------------+---------+---------------+-------------+
    | a7lh48f5jvlk******** | my-vm-1 | {{ region-id }}-a | RUNNING |               | 192.168.0.7 |
    | epdsj30mndgj******** | my-vm-2 | {{ region-id }}-b | RUNNING |               | 192.168.1.7 |
    +----------------------+---------+---------------+---------+---------------+-------------+
    ```

1. Посмотрите описание команды CLI для переноса виртуальной машины в другую зону доступности:

    ```bash
    yc compute instance relocate --help
    ```

1. Перенесите нужную виртуальную машину в другую зону доступности:

    ```bash
    yc compute instance relocate <идентификатор_ВМ> \
      --destination-zone-id <идентификатор_зоны_доступности> \
      --network-interface \
        subnet-id=<идентификатор_подсети>,security-group-ids=<идентификатор_группы_безопасности>
    ```

    Где:

    * `<идентификатор_ВМ>` — идентификатор ВМ, которую требуется перенести в другую зону доступности.
    * `--destination-zone-id` — идентификатор [зоны доступности](../../../overview/concepts/geo-scope.md), в которую требуется перенести ВМ.
    * `subnet-id` — идентификатор подсети, соответствующей зоне доступности, в которую требуется перенести ВМ.
    * `security-group-ids` — идентификатор [группы безопасности](../../../vpc/concepts/security-groups.md), которую требуется привязать к переносимой ВМ. К одной ВМ можно привязать одновременно несколько групп безопасности, в этом случае передайте их идентификаторы через запятую в формате `[id1,id2]`.

    Подробнее о команде `yc compute instance relocate` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/instance/relocate.md).
    
    Обратите внимание, что при переносе ВМ в новую подсеть изменится адресация. Если для ВМ требуется указать внутренний IP-адрес, используйте свойство `ipv4-address=<внутренний_IP-адрес>`, если публичный — свойство `nat-address=<публичный_IP-адрес>` параметра `network-interface`. В остальном задание параметров сетевого интерфейса переносимой ВМ аналогична созданию инстанса.

    Пример:

    ```bash
    yc compute instance relocate a7lh48f5jvlk******** \
      --destination-zone-id {{ region-id }}-b \
      --network-interface \
        subnet-id=bltign9kcffv********,security-group-ids=c646ev94tb6k********
    ```

    В этом примере ВМ `my-vm-1` переносится из зоны доступности `{{ region-id }}-a` в зону доступности `{{ region-id }}-b`.

    Результат:

    ```bash
    done (3m15s)
    id: a7lh48f5jvlk********
    folder_id: aoeg2e07onia********
    created_at: "2023-10-13T19:47:40Z"
    name: my-vm-1
    zone_id: {{ region-id }}-b
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
      device_name: a7lp7jpslu59********
      auto_delete: true
      disk_id: a7lp7jpslu59********
    network_interfaces:
      - index: "0"
        mac_address: d0:0d:11:**:**:**
        subnet_id: bltign9kcffv********
        primary_v4_address:
          address: 192.168.1.17
        security_group_ids:
          - c646ev94tb6k********
    gpu_settings: {}
    fqdn: my-vm-1.{{ region-id }}.internal
    scheduling_policy: {}
    network_settings:
      type: STANDARD
    placement_policy: {}
    ```

    Если вы переносите ВМ с [диском в группе размещения](../../concepts/disk-placement-group.md), используйте команду:

    ```bash
    yc compute instance relocate <идентификатор_ВМ> \
      --destination-zone-id <идентификатор_зоны_доступности> \
      --network-interface \
        subnet-id=<идентификатор_подсети>,security-group-ids=<идентификатор_группы_безопасности> \
      --boot-disk-placement-group-id <идентификатор_группы_размещения_дисков> \
      --boot-disk-placement-group-partition <номер_раздела> \
      --secondary-disk-placement \
        disk-name=<имя_диска>,disk-placement-group-id=<идентификатор_группы_размещения_дисков>,disk-placement-group-partition=<номер_раздела>
    ```

    Где:

    * `--boot-disk-placement-group-id` — идентификатор группы размещения дисков.
    * `--boot-disk-placement-group-partition` — номер раздела в группе размещения дисков со стратегией [размещения разделами](../../concepts/disk-placement-group.md#partition).
    * `--secondary-disk-placement` — политика размещения для дополнительных дисков. Параметры:

      * `disk-name` — имя диска.
      * `disk-placement-group-id` — идентификатор группы размещения дисков, в которую необходимо поместить диск.
      * `disk-placement-group-partition` — номер раздела в группе размещения дисков.
 
    Подробнее о команде `yc compute instance relocate` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/instance/relocate.md).
    
    {% note info %}

    Если на диски ВМ активно ведется запись, их перенос может завершиться ошибкой. В таком случае остановите запись на диски или выключите виртуальную машину и повторно запустите перенос.

    {% endnote %}

Обратите внимание, что при переносе ВМ в новую подсеть изменится адресация. Если для ВМ требуется указать внутренний IP-адрес, используйте свойство `ipv4-address=<внутренний_IP-адрес>`, если публичный — свойство `nat-address=<публичный_IP-адрес>` параметра `network-interface`. В остальном задание параметров сетевого интерфейса переносимой ВМ аналогична созданию инстанса.

### Примеры {#examples}

#### Перенос ВМ в другую зону {#jump-from-a-to-d}

В этом примере ВМ `my-vm-1` переносится из зоны доступности `{{ region-id }}-a` в зону доступности `{{ region-id }}-d`.

```bash
yc compute instance relocate a7lh48f5jvlk******** \
  --destination-zone-id {{ region-id }}-d \
  --network-interface \
    subnet-id=bltign9kcffv********,security-group-ids=c646ev94tb6k********
```

Результат:

```text
done (3m15s)
id: a7lh48f5jvlk********
folder_id: aoeg2e07onia********
created_at: "2023-10-13T19:47:40Z"
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
  device_name: a7lp7jpslu59********
  auto_delete: true
  disk_id: a7lp7jpslu59********
network_interfaces:
  - index: "0"
mac_address: d0:0d:11:**:**:**
subnet_id: bltign9kcffv********
primary_v4_address:
  address: 192.168.1.17
security_group_ids:
  - c646ev94tb6k********
gpu_settings: {}
fqdn: my-vm-1.{{ region-id }}.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}
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
