# Создание виртуальной машины в группе выделенных хостов

Виртуальная машина будет создана с привязкой к одному из хостов группы. При остановке ВМ она будет недоступна на хостах группы, а при последующем перезапуске может быть привязана к другому хосту из группы.

{% include [dedicated](../../../_includes/compute/dedicated-quota.md) %}

Чтобы создать ВМ с привязкой к группе выделенных хостов, выполните следующие действия:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите список возможных типов выделенных хостов:

     ```bash
     yc compute host-type list
     ```

     Результат выполнения:

     ```bash
     +---------------------+-------+--------------+
     |         ID          | CORES |    MEMORY    |
     +---------------------+-------+--------------+
     | intel-6230-c66-m454 |    66 | 487478788096 |
     +---------------------+-------+--------------+
     ```

  1. Создайте группу выделенных хостов выбранного типа. В группе может быть один или несколько хостов.

     ```bash
     yc compute host-group create \
       --fixed-size 2 \
       --type intel-6230-c66-m454 \
       --zone {{ region-id }}-a
     ```

     Где:
     * `fixed-size` — количество выделенных хостов в группе.
     * `type` — тип выделенных хостов.
     * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md).

     Результат выполнения команды:

     ```bash
     done (6s)
     id: abcdefg1hi23gkl16dnf
     folder_id: m4n56op78mev0cljderg
     created_at: "2020-10-13T07:36:49Z"
     zone_id: {{ region-id }}-a
     status: READY
     type_id: intel-6230-c66-m454
     maintenance_policy: RESTART
     scale_policy:
       fixed_scale:
         size: "2"
     ```

  1. Посмотрите идентификатор группы выделенных хостов, к которой необходимо будет привязать ВМ:

     ```bash
     yc compute host-group list
     ```

     Результат выполнения команды:

     ```bash
     +----------------------+------+---------------+--------+---------------------+------+
     |          ID          | NAME |     ZONE      | STATUS |        TYPE         | SIZE |
     +----------------------+------+---------------+--------+---------------------+------+
     | abcdefg1hi23gkl16dnf |      | {{ region-id }}-a | READY  | intel-6230-c66-m454 |    2 |
     +----------------------+------+---------------+--------+---------------------+------+
     ```

  1. Создайте виртуальную машину с привязкой к группе выделенных хостов.

     Более подробную информацию о создании ВМ см. в разделе [Создание виртуальной машины](../../operations/index.md#vm-create).

     ```bash
     yc compute instance create \
       --host-group-id abcdefg1hi23gkl16dnf \
       --network-interface subnet-name=network-{{ region-id }}-a \
       --zone {{ region-id }}-a
     ```

     Где:
     * `host-group-id` — идентификатор группы выделенных хостов.
     * `subnet-name` — имя выбранной подсети.
     * `zone` — зона доступности, которая соответствует выбранной подсети.

     Результат выполнения команды:

     ```bash
     done (20s)
     id: fhmbdt1jj2k3ls036909
     folder_id: m4n56op78mev0cljderg
     created_at: "2020-10-13T07:41:19Z"
     zone_id: {{ region-id }}-a
     ...
     placement_policy:
       host_affinity_rules:
       - key: yc.hostGroupId
         op: IN
         values:
         - abcdefg1hi23gkl16dnf
     ```

- API

  1. Выберите тип хоста с помощью метода [list](../../api-ref/HostType/list.md) для ресурса `HostType`.

  1. Создайте группу выделенных хостов с помощью метода [create](../../api-ref/HostGroup/create.md) для ресурса `HostGroup`.

  1. Посмотрите идентификатор группы выделенных хостов с помощью метода [list](../../api-ref/HostGroup/list.md) для ресурса `HostGroup`.

  1. Создайте виртуальную машину с привязкой к группе выделенных хостов с помощью метода [create](../../api-ref/Instance/create.md) для ресурса `Instance`.

{% endlist %}