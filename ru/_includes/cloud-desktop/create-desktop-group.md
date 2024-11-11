{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана группа рабочих столов.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vdi.button_empty-create-desktop-group }}**.
  1. Введите имя и описание группы рабочих столов.
  1. Выберите [образ](../../cloud-desktop/concepts/images.md) операционной системы.
  1. В блоке **{{ ui-key.yacloud.vdi.section_disks }}**:
      * Выберите [типы](../../compute/concepts/disk.md#disks-types) загрузочного и рабочего [дисков](../../cloud-desktop/concepts/disks.md).
      * Укажите размеры загрузочного и рабочего дисков.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
      * Укажите количество ядер vCPU.
      * Выберите [гарантированную долю](../../compute/concepts/performance-levels.md) vCPU.
      * Укажите объем RAM.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите [облачную сеть](../../vpc/concepts/network.md#network) и [подсети](../../vpc/concepts/network.md#subnet), в которых будут размещаться рабочие столы.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  1. Посмотрите описание команды [CLI](../../cli/index.yaml) для создания [группы рабочих столов](../../cloud-desktop/concepts/desktops-and-groups.md):

      ```bash
      yc desktops group create --help
      ```

  1. Выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc resource-manager folder list
      ```

      Результат:

      ```text
      +----------------------+------------+--------+----------+
      |          ID          |    NAME    | LABELS |  STATUS  |
      +----------------------+------------+--------+----------+
      | b1g681qpemb4******** | my-folder  |        | ACTIVE   |
      | b1ggmp8es27t******** | new-folder |        | ACTIVE   |
      +----------------------+------------+--------+----------+
      ```

  1. Выберите [образ](../../cloud-desktop/concepts/images.md) для создания загрузочного [диска](../../cloud-desktop/concepts/disks.md) рабочего стола. Идентификатор образа можно посмотреть в [консоли управления]({{ link-console-main }}).
  1. Выберите [облачную сеть](../../vpc/concepts/network.md#network) и [подсети](../../vpc/concepts/network.md#subnet):

      ```bash
      yc vpc subnet list
      ```

      Результат:

      ```text
      +----------------------+-------------+----------------------+----------------------+---------------+------------------+
      |          ID          |    NAME     |      NETWORK ID      |    ROUTE TABLE ID    |     ZONE      |      RANGE       |
      +----------------------+-------------+----------------------+----------------------+---------------+------------------+
      | e2lb1da2dd9v******** | my-subnet-b | enp0asmd9pr9******** |                      | {{ region-id }}-b | [10.129.0.0/24]  |
      | e9bhhpeo3vmk******** | my-subnet-a | enp0asmd9pr9******** |                      | {{ region-id }}-a | [10.128.0.0/24]  |
      | fl8rnqg0nb99******** | my-subnet-d | enp0asmd9pr9******** | enpajmdvphs7******** | {{ region-id }}-d | [10.131.0.0/24]  |
      +----------------------+-------------+----------------------+----------------------+---------------+------------------+
      ```

      Где:

      * `ID` — идентификатор подсети.
      * `NETWORK ID` — идентификатор облачной сети.

  1. Создайте группу рабочих столов:

      ```bash
      yc desktops group create \
        --folder-id <идентификатор_каталога> \
        --image-id <идентификатор_образа> \
        --name <имя_группы> \
        --resource-spec memory=4G,cores=2,core-fraction=100 \
        --network-interface-spec \
          network-id=<идентификатор_сети>,subnet-id=<идентификатор_подсети_1>,...,network-id=<идентификатор_сети>,subnet-id=<идентификатор_подсети_n>
      ```

      Где:

      * `--folder-id` — идентификатор каталога.
      * `--image-id` — идентификатор образа диска.
      * `--name` — имя группы рабочих столов.
      * `--resource-spec` — описание вычислительных ресурсов группы рабочих столов:

          * `memory` — объем RAM.
          * `cores` — количество vCPU.
          * `core-fraction` — [гарантированная доля](../../compute/concepts/performance-levels.md) vCPU.

      * `--network-interface-spec` — описание сетевого интерфейса группы рабочих столов:

          * `network-id` — идентификатор облачной сети.
          * `subnet-id` — идентификатор подсети.

          Вы можете указать одну или несколько подсетей, находящихся в одной облачной сети.

      Результат:

      ```text
      id: e3v80f10pc01********
      folder_id: b1g681qpemb4********
      created_at: "2024-10-09T18:58:17.357Z"
      status: ACTIVE
      name: my-desktop-group
      resources_spec:
        memory: "4294967296"
        cores: "2"
        core_fraction: "100"
      network_interface_spec:
        network_id: enp0asmd9pr9********
        subnet_ids:
          - e2lb1da2dd9v********
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../cloud-desktop/api-ref/DesktopGroup/create.md) для ресурса [DesktopGroup](../../cloud-desktop/api-ref/DesktopGroup/index.md) или вызовом gRPC API [DesktopGroupService/Create](../../cloud-desktop/api-ref/grpc/DesktopGroup/create.md).

{% endlist %}
