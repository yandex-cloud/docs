Создайте [облачную сеть](../../../vpc/concepts/network.md) и [подсети](../../../vpc/concepts/network.md#subnet), в которых будут развернуты ресурсы.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором будете разворачивать инфраструктуру.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите имя сети. Требования к имени:

      {% include [name-format](../../../_includes/name-format.md) %}
  
  1. Оставьте включенной опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Создайте облачную сеть в каталоге по умолчанию:

      ```
      yc vpc network create --name wordpress-network
      ```

  1. Получите список облачных сетей в каталоге:

      ```
      yc vpc network list --folder-id b1g6ci08ma55********
      ```

      Результат:

      ```
      +----------------------+-------------------+
      |          ID          |      NAME         |
      +----------------------+-------------------+
      | enpavfmgapum******** | wordpress-network |
      | enplom7a98s1******** | default           |
      +----------------------+-------------------+
      ```

  1. Выберите `NAME` или `ID` требуемой облачной сети. Создайте подсеть в зоне доступности `{{ region-id }}-a`:

      ```
      yc vpc subnet create \
        --network-id enpavfmgapum******** \
        --zone {{ region-id }}-a \
        --range 192.168.0.0/24
      ```

      Где:

      * `--network-id` — идентификатор облачной сети. При создании подсети указывается облачная сеть, в которой создаются подсеть и CIDR.
      * `--zone` — зона доступности, в которой создается подсеть.
      * `--range` — список внутренних IPv4-адресов, определенных для данной подсети. Например, `10.0.0.0/22` или `192.168.0.0/16`. Адреса должны быть уникальными внутри сети. Минимальный размер подсети — /28, а максимальный размер подсети — /16. Поддерживается только IPv4.

      Требования к названию подсети:

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Аналогичным образом создайте подсеть в зоне доступности `{{ region-id }}-d`.

- API {#api}

  Чтобы создать облачную сеть, воспользуйтесь методом REST API [create](../../../vpc/api-ref/Network/create.md) для ресурса [Network](../../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../../vpc/api-ref/grpc/Network/create.md) и передайте в запросе идентификатор каталога, в котором будет размещена сеть, в параметре `folderId`.

  {% include [get-catalog-id](../../../_includes/get-catalog-id.md) %}

  Чтобы создать подсети в зонах доступности `{{ region-id }}-a` и `{{ region-id }}-d`, воспользуйтесь методом REST API [create](../../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../../vpc/api-ref/grpc/Subnet/create.md) и передайте в запросе:

  * Идентификатор каталога, в котором будет размещена подсеть, в параметре `folderId`.
  * Идентификатор сети, в которой будет размещена подсеть, в параметре `networkId`.
  * Идентификатор зоны доступности, в которой будет размещена подсеть, в параметре `zoneId`.
  * Список внутренних IPv4-адресов, определенных для данной подсети, в массиве `v4CidrBlocks[]`. Например, `10.0.0.0/22` или `192.168.0.0/16`. Адреса должны быть уникальными внутри сети. Минимальный размер подсети — `/28`, а максимальный размер подсети — `/16`. Поддерживается только IPv4.

  {% include [get-subnet-id](../../../_includes/vpc/get-subnet-id.md) %}

{% endlist %}