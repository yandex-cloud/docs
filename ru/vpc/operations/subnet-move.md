# Переместить подсеть в другой каталог

Облачные ресурсы можно переносить между каталогами в пределах одного [облака](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs %}

- Консоль управления

  Чтобы переместить [подсеть](../concepts/network.md) в другой каталог:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где находится подсеть.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. Нажмите на имя облачной сети, в которой находится подсеть.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке подсети, которую требуется переместить, и выберите **Переместить**.
  1. В выпадающем списке выберите каталог назначения.
  1. Нажмите кнопку **Переместить**.

  {% note info %}

  Подсеть можно [переместить](network-move.md) также в составе облачной сети.

  {% endnote %}

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы переместить [подсеть](../concepts/network.md) в другой каталог:

  1. Посмотрите описание команды CLI для перемещения подсети:

      ```bash
      yc vpc subnet move --help
      ```

  1. Узнайте имя или идентификатор подсети, которую требуется переместить:

      ```bash
      yc vpc subnet list
      ```
      Результат:
      ```text
      +----------------------+----------+----------------------+----------------+---------------+------------------+
      |          ID          |   NAME   |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE       |
      +----------------------+----------+----------------------+----------------+---------------+------------------+
      | e9bcd5mq43cnrsfckikh | subnet-a | encb4ubvmief09h6qg5e |                | {{ region-id }}-a | [10.1.0.0/16]    |
      | e2llon52hhss119t4g2c | subnet-b | enc39op1vq9m8tjr3udp |                | {{ region-id }}-b | [192.168.1.0/24] |
      | b0cscj0f9uq59ig7o6u0 | subnet-c | enc772aa2rgqiqq67ehu |                | {{ region-id }}-c | [10.0.0.0/16]    |
      +----------------------+----------+----------------------+----------------+---------------+------------------+
      ```

  1. Получите список доступных каталогов:

      ```bash
      yc resource-manager folder list
      ```

      Результат:
      ```text
      +----------------------+------------------------+--------+--------+
      |          ID          |          NAME          | LABELS | STATUS |
      +----------------------+------------------------+--------+--------+
      | b1cs8ie21pk10aurd2c3 | default                |        | ACTIVE |
      | b1chgf288nvg541tgu73 | my-folder-1            |        | ACTIVE |
      | b1cu6g9ielh690at5bm7 | my-folder-2            |        | ACTIVE |
      +----------------------+------------------------+--------+--------+
      ```

  1. Переместите подсеть, указав имя или идентификатор подсети и каталога назначения:

     ```bash
     yc vpc subnet move <имя_или_идентификатор_подсети> \
       --destination-folder-name <имя_каталога_назначения> \
       --destination-folder-id <идентификатор_каталога_назначения>
     ```
     Используйте либо параметр `--destination-folder-name`, либо `--destination-folder-id`.

     Если подсеть находится не в текущем каталоге (каталоге по умолчанию), укажите исходный каталог с помощью опции `--folder-name` или `--folder-id`.

     Результат:
     ```text
      id: e9bcd5mq43cnrsfckikh
      folder_id: b1chgf288nvg541tgu73
      created_at: "2022-10-08T15:03:39Z"
      name: subnet-a
      network_id: encb4ubvmief09h6qg5e
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
        - 10.1.0.0/16
      dhcp_options: {}
     ```
     Подробнее о команде `yc vpc subnet move` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/subnet/move.md).

- API

  Чтобы переместить [подсеть](../concepts/network.md#subnet) в другой каталог, воспользуйтесь методом REST API [move](../api-ref/Subnet/move.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Move](../api-ref/grpc/subnet_service.md#Move).

{% endlist %}

## Примеры {#examples}

### Подсеть в текущем каталоге {#from-default-folder}

Переместите подсеть из текущего каталога, указав имя подсети и имя каталога назначения:

{% list tabs %}

- CLI

  ```bash
  yc vpc subnet move subnet-a \
    --destination-folder-name my-folder-1
  ```

{% endlist %}

### Подсеть в другом каталоге {#from-another-folder}

Переместите подсеть, которая находится в другом каталоге. Укажите идентификатор подсети, а также идентификаторы исходного и целевого каталога:

{% list tabs %}

- CLI

  ```bash
  yc vpc subnet move enc39op1vq9m8tjr3udp \
    --folder-id b1chgf288nvg541tgu73 \
    --destination-folder-id b1cs8ie21pk10aurd2c3
  ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](network-move.md)

