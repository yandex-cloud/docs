# Переместить подсеть в другой каталог

[Подсети](../concepts/network.md) можно переносить между каталогами в пределах одного [облака](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где находится подсеть.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной подсети и выберите **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.
  1. В открывшемся окне выберите каталог назначения.
  1. Нажмите **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.

  {% note info %}

  Подсеть можно [переместить](network-move.md) также в составе облачной сети.

  {% endnote %}

- CLI {#cli}

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
      | e9bcd5mq43cn******** | subnet-a | encb4ubvmief******** |                | {{ region-id }}-a | [10.1.0.0/16]    |
      | e2llon52hhss******** | subnet-b | enc39op1vq9m******** |                | {{ region-id }}-b | [192.168.1.0/24] |
      | b0cscj0f9uq5******** | subnet-d | enc772aa2rgq******** |                | {{ region-id }}-d | [10.0.0.0/16]    |
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
      | b1cs8ie21pk1******** | default                |        | ACTIVE |
      | b1chgf288nvg******** | my-folder-1            |        | ACTIVE |
      | b1cu6g9ielh6******** | my-folder-2            |        | ACTIVE |
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
      id: e9bcd5mq43cn********
      folder_id: b1chgf288nvg********
      created_at: "2022-10-08T15:03:39Z"
      name: subnet-a
      network_id: encb4ubvmief********
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
        - 10.1.0.0/16
      dhcp_options: {}
     ```
     Подробнее о команде `yc vpc subnet move` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/subnet/move.md).

- API {#api}

  Чтобы переместить [подсеть](../concepts/network.md#subnet) в другой каталог, воспользуйтесь методом REST API [move](../api-ref/Subnet/move.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Move](../api-ref/grpc/subnet_service.md#Move) и передайте в запросе:

  * Идентификатор подсети, которую нужно перенести, в параметре `subnetId`.

    {% include [get-subnet-id](../../_includes/vpc/get-subnet-id.md) %}

  * Идентификатор каталога, в который будет перенесена подсеть, в параметре `destinationFolderId`.

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}

## Примеры {#examples}

### Подсеть в текущем каталоге {#from-default-folder}

Переместите подсеть из текущего каталога, указав имя подсети и имя каталога назначения:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc vpc subnet move subnet-a \
    --destination-folder-name my-folder-1
  ```

{% endlist %}

### Подсеть в другом каталоге {#from-another-folder}

Переместите подсеть, которая находится в другом каталоге. Укажите идентификатор подсети, а также идентификаторы исходного и целевого каталога:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc vpc subnet move enc39op1vq9m******** \
    --folder-id b1chgf288nvg******** \
    --destination-folder-id b1cs8ie21pk1********
  ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](network-move.md)

