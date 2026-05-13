# Переместить подсеть в другой каталог

[Подсети](../concepts/network.md) можно переносить между каталогами в пределах одного [облака](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, где находится подсеть.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **Подсети**.
  1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной подсети и выберите **Переместить**.
  1. В открывшемся окне выберите каталог назначения.
  1. Нажмите **Переместить**.

  {% note info %}

  Подсеть можно [переместить](network-move.md) также в составе облачной сети.

  {% endnote %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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
      | e9bcd5mq43cn******** | subnet-a | encb4ubvmief******** |                | ru-central1-a | [10.1.0.0/16]    |
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
      zone_id: ru-central1-a
      v4_cidr_blocks:
        - 10.1.0.0/16
      dhcp_options: {}
     ```
     Подробнее о команде `yc vpc subnet move` см. в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/subnet/move.md).

- API {#api}

  Чтобы переместить [подсеть](../concepts/network.md#subnet) в другой каталог, воспользуйтесь методом REST API [move](../api-ref/Subnet/move.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Move](../api-ref/grpc/Subnet/move.md) и передайте в запросе:

  * Идентификатор подсети, которую нужно перенести, в параметре `subnetId`.

    Чтобы узнать идентификатор подсети, воспользуйтесь методом REST API [list](../api-ref/Subnet/list.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/List](../api-ref/grpc/Subnet/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

  * Идентификатор каталога, в который будет перенесена подсеть, в параметре `destinationFolderId`.

    О том, как узнать идентификатор каталога, читайте в разделе [Получение идентификатора каталога](../../resource-manager/operations/folder/get-id.md).

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

* [Переместить облачную сеть в другой каталог](network-move.md)