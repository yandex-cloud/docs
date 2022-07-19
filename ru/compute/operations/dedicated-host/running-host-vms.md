# Создание виртуальной машины на выделенном хосте

Виртуальная машина будет создана с привязкой к выбранному [выделенному хосту](../../concepts/dedicated-host.md) из группы. При остановке ВМ она будет недоступна на хосте, а при последующем перезапуске будет привязана к этому же хосту из группы.

Если у вас еще нет группы выделенных хостов, [создайте](create-host-group.md) ее.

Чтобы создать ВМ:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Узнайте идентификатор группы выделенных хостов, в которой необходимо создать ВМ:

      ```bash
      yc compute host-group list
      ```

      Результат:

      ```bash
      +----------------------+------+---------------+--------+---------------------+------+
      |          ID          | NAME |     ZONE      | STATUS |        TYPE         | SIZE |
      +----------------------+------+---------------+--------+---------------------+------+
      | abcdefg1hi23gkl16dnf |      | {{ region-id }}-a | READY  | intel-6230-c66-m454 |    2 |
      +----------------------+------+---------------+--------+---------------------+------+
      ```

  1. Узнайте идентификатор выделенного хоста в группе, на котором необходимо создать ВМ:

      ```bash
      yc compute host-group list-hosts <идентификатор группы выделенных хостов>
      ```

      Результат:

      ```bash
      +----------------------+----------------------+
      |          ID          |      SERVER ID       |
      +----------------------+----------------------+
      | fhm1ab2mhnf3cd1610f5 | fhmlabct12vp3de45728 |
      | fhmabcun12kbbvhdeug3 | fhm1a2bcsl13ide4cqp2 |
      +----------------------+----------------------+
      ```

  1. Получите список доступных подсетей:

      ```bash
      yc vpc subnet list
      ```

      Результат:

      ```bash
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      |          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE      |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      | b0c6n43f9lgh3695v2k2 | default-{{ region-id }}-c | enpe3m3fa00udao8g5lg |                | {{ region-id }}-c | [10.130.0.0/24] |
      | e2l2da8a20b33g7o73bv | default-{{ region-id }}-b | enpe3m3fa00udao8g5lg |                | {{ region-id }}-b | [10.129.0.0/24] |
      | e9bnlm18l70ao30pvfaa | default-{{ region-id }}-a | enpe3m3fa00udao8g5lg |                | {{ region-id }}-a | [10.128.0.0/24] |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      ```

  1. Выполните команду для создания ВМ:

      ```bash
      yc compute instance create \
        --host-id <идентификатор выделенного хоста> \
        --zone <зона доступности>
        --network-interface subnet-name=<имя подсети> \
      ```

      Где:

      * `host-id` — идентификатор выделенного хоста.
      * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой размещена группа выделенных хостов.      
      * `network-interface subnet-name` — имя подсети в зоне доступности.

      Чтобы указать характеристики ВМ, используйте параметры команды `yc compute instance create`, описанные в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/instance/create.md). Подробнее см. в разделах [{#T}](../../concepts/vm.md) и [{#T}](../index.md#vm-create).

      Результат:

      ```bash
      done (41s)
      id: fhm1abc23407de854r9e
      folder_id: m4n56op78mev0cljderg
      created_at: "2020-10-13T08:00:55Z"
      zone_id: {{ region-id }}-a
      ...
      placement_policy:
        host_affinity_rules:
        - key: yc.hostId
          op: IN
          values:
          - fhm1ab2mhnf3cd1610f5
      ```

- API

  1. Узнайте идентификатор группы выделенных хостов с помощью метода [list](../../api-ref/HostGroup/list.md) для ресурса `HostGroup`.
  1. Узнайте идентификаторы выделенных хостов в группе с помощью метода [listHosts](../../api-ref/HostGroup/listHosts.md) для ресурса `HostGroup`.
  1. Создайте ВМ с помощью метода [create](../../api-ref/Instance/create.md) для ресурса `Instance`.

{% endlist %}