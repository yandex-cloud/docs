{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана группа рабочих столов.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vdi.button_empty-create-desktop-group }}**.
  1. Введите имя и описание группы рабочих столов.
  1. Выберите **{{ ui-key.yacloud.vdi.section_type }}**:

      * **{{ ui-key.yacloud.vdi.value_type-personal }}** — рабочие столы назначаются пользователям при их первом подключении и остаются зарезервированными за ними.
      * **{{ ui-key.yacloud.vdi.value_type-session }}** — рабочие столы автоматически назначаются пользователям при каждом новом подключении и освобождаются при отключении (будет доступно позднее).
  1. В блоке **{{ ui-key.yacloud.vdi.section_desktop }}** задайте:
     1. **{{ ui-key.yacloud.vdi.field_max-desktops-amount }}** — максимальное количество рабочих столов в группе.
     1. **{{ ui-key.yacloud.vdi.field_min-ready-desktops }}** — количество рабочих столов, которые будут всегда загружены для быстрого подключения пользователей.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     * Чтобы выбрать одну из стандартных конфигураций рабочих столов, на вкладке **{{ ui-key.yacloud.component.compute.resources.label_tab-standard }}** нажмите:
        * **Базовая** — 2 vCPU, 4 ГБ RAM. Подойдет для работы с офисными приложениями, несложными документами, веб-браузером.
        * **Стандартная** — 4 vCPU, 8 ГБ RAM. Подойдет для большинства офисных задач, поддерживает многозадачность и приложения средней ресурсоемкости.
        * **Продвинутая** — 8 vCPU, 16 ГБ RAM. Подойдет для разработчиков, дизайнеров и пользователей, которые работают с ресурсоемкими приложениями. Например, с мультимедиа-редакторами.
        * **Профессиональная** — 8 vCPU, 32 ГБ RAM. Подойдет для инженеров, работающих с CAD-программами, специалистов по анализу больших данных. Конфигурация предоставляет максимальные вычислительные мощности и объем памяти для сложных и высоконагруженных приложений. 
     * Чтобы задать свою конфигурацию рабочих столов, на вкладке **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** укажите:
       * Количество ядер vCPU.
       * [Гарантированную долю](../../compute/concepts/performance-levels.md) vCPU.
       * Объем RAM.
  1. Выберите предустановленный или пользовательский [образ](../../cloud-desktop/concepts/images.md) операционной системы.
  1. В блоке **{{ ui-key.yacloud.vdi.section_disks }}**:
      * Выберите [типы](../../compute/concepts/disk.md#disks-types) загрузочного и рабочего [дисков](../../cloud-desktop/concepts/disks.md).
      * Укажите размеры загрузочного и рабочего дисков.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите [облачную сеть](../../vpc/concepts/network.md#network) и [подсети](../../vpc/concepts/network.md#subnet), в которых будут размещаться рабочие столы.
   
      {% note info %}

      Для доступа рабочих столов в интернет [настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) в соответствующей подсети.

      {% endnote %}
    
  1. В блоке **Пользователи рабочих столов** нажмите **Добавить пользователей** и укажите:
     * [Группы пользователей](../../iam/concepts/access-control/public-group.md).
     * [Отдельные пользователи](../../iam/concepts/users/accounts.md).
     * Почтовый адрес любого пользователя — ему будет отправлено приглашение в вашу организацию и назначена роль для доступа к рабочим столам.

      Изменить список пользователей можно в любое время после создания группы рабочих столов.

      {% note warning %}

      Пользователи из списка будут видеть рабочие столы этой группы на своей [витрине](../../cloud-desktop/concepts/showcase.md). Чтобы у пользователей была возможность подключаться к рабочим столам, им надо [назначить роль](../../iam/operations/roles/grant.md) `vdi.viewer`.

      {% endnote %}
  
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
