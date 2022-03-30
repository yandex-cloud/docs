# Создание виртуальной машины на выделенном хосте

Виртуальная машина будет создана с привязкой к выбранному хосту из группы. При остановке ВМ она будет недоступна на хосте, а при последующем перезапуске будет привязана к этому же хосту из группы.

{% include [dedicated](../../../_includes/compute/dedicated-quota.md) %}

Чтобы создать ВМ на выделенном хосте, выполните следующие действия:

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
       --zone ru-central1-a
     ```

     Где:
     * `fixed-size` — количество выделенных хостов в группе.
     * `type` — тип выделенных хостов.
     * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md).

     Результат выполнения команды:

     ```bash
     done (5s)
     id: fhm123hj4l56abcg10qf
     folder_id: m4n56op78mev0cljderg
     created_at: "2020-10-13T07:54:08Z"
     zone_id: ru-central1-a
     status: READY
     type_id: intel-6230-c66-m454
     maintenance_policy: RESTART
     scale_policy:
       fixed_scale:
         size: "2"
     ```

  1. Посмотрите идентификаторы выделенных хостов в группе и выберите хост, на котором необходимо будет создать ВМ:

     ```bash
     yc compute host-group list-hosts fhm123hj4l56abcg10qf
     ```

     Результат выполнения команды:

     ```bash
     +----------------------+----------------------+
     |          ID          |      SERVER ID       |
     +----------------------+----------------------+
     | fhm1ab2mhnf3cd1610f5 | fhmlabct12vp3de45728 |
     | fhmabcun12kbbvhdeug3 | fhm1a2bcsl13ide4cqp2 |
     +----------------------+----------------------+
     ```

  1. Создайте виртуальную машину с привязкой к выделенному хосту.

     Более подробную информацию о создании ВМ см. в разделе [Создание виртуальной машины](../../operations/index.md#vm-create)

     ```bash
     yc compute instance create \
       --host-id fhm1ab2mhnf3cd1610f5 \
       --network-interface subnet-name=network-ru-central1-a \
       --zone ru-central1-a
     ```

     Где:
     * `host-id` — идентификатор выделенного хоста.
     * `subnet-name` — имя выбранной подсети.
     * `zone` — зона доступности, которая соответствует выбранной подсети.

     Результат выполнения команды:

     ```bash
     done (41s)
     id: fhm1abc23407de854r9e
     folder_id: m4n56op78mev0cljderg
     created_at: "2020-10-13T08:00:55Z"
     zone_id: ru-central1-a
     ...
     placement_policy:
       host_affinity_rules:
       - key: yc.hostId
         op: IN
         values:
         - fhm1ab2mhnf3cd1610f5
     ```

- API

  1. Выберите тип хоста с помощью метода [list](../../api-ref/HostType/list.md) для ресурса `HostType`.

  1. Создайте группу выделенных хостов с помощью метода [create](../../api-ref/HostGroup/create.md) для ресурса `HostGroup`.

  1. Посмотрите идентификаторы выделенных хостов в группе с помощью метода [listHosts](../../api-ref/HostGroup/listHosts.md) для ресурса `HostGroup`.

  1. Создайте виртуальную машину на выделенном хосте с помощью метода [create](../../api-ref/Instance/create.md) для ресурса `Instance`.

{% endlist %}