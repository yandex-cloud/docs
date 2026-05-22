# Переместить NAT-шлюз в другой каталог

{% note info %}

Функция находится на [стадии Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Облачные ресурсы можно переносить между каталогами в пределах одного [облака](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы переместить [NAT-шлюз](../concepts/gateways.md) в другой каталог:

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, где находится NAT-шлюз.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/arrows-opposite-to-dots.svg) **Шлюзы**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке NAT-шлюза, который требуется переместить, и выберите **Переместить**.
  1. В выпадающем списке выберите каталог назначения.
  1. Нажмите кнопку **Переместить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы переместить [NAT-шлюз](../concepts/gateways.md) в другой каталог:

  1. Посмотрите описание команды CLI для перемещения NAT-шлюза:

      ```bash
      yc vpc gateway move --help
      ```

  1. Узнайте имя или идентификатор NAT-шлюза, который требуется переместить:

      ```bash
      yc vpc gateway list
      ```
      Результат:
      ```text
      +----------------------+----------+-------------+
      |          ID          |   NAME   | DESCRIPTION |
      +----------------------+----------+-------------+
      | enckq19qqsr5******** | router-1 |             |
      +----------------------+----------+-------------+
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

  1. Переместите NAT-шлюз, указав имя или идентификатор NAT-шлюза и каталога назначения:

     ```bash
     yc vpc gateway move <имя_или_идентификатор_шлюза> \
       --destination-folder-name <имя_каталога_назначения> \
       --destination-folder-id <идентификатор_каталога_назначения>
     ```
     Используйте либо параметр `--destination-folder-name`, либо `--destination-folder-id`.

     Если шлюз находится не в текущем каталоге (каталоге по умолчанию), укажите исходный каталог с помощью опции `--folder-name` или `--folder-id`.

     Результат:
     ```text
     id: enckq19qqsr5********
     folder_id: b1chgf288nvg********
     created_at: "2022-10-06T10:14:04Z"
     name: router-1
     shared_egress_gateway: {}
     ```
     Подробнее о команде `yc vpc address move` см. в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/gateway/move.md).

- API {#api}

  Чтобы переместить [NAT-шлюз](../concepts/gateways.md) в другой каталог, воспользуйтесь методом REST API [move](../api-ref/Gateway/move.md) для ресурса [Gateway](../api-ref/Gateway/index.md) или вызовом gRPC API [GatewayService/Move](../api-ref/grpc/Gateway/move.md) и передайте в запросе:

  * Идентификатор NAT-шлюза, который нужно перенести, в параметре `gatewayId`.

    Чтобы узнать идентификатор NAT-шлюза, воспользуйтесь методом REST API [list](../api-ref/Gateway/list.md) для ресурса [Gateway](../api-ref/Gateway/index.md) или вызовом gRPC API [GatewayService/List](../api-ref/grpc/Gateway/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

  * Идентификатор каталога, в который будет перенесен NAT-шлюз, в параметре `destinationFolderId`.

    О том, как узнать идентификатор каталога, читайте в разделе [Получение идентификатора каталога](../../resource-manager/operations/folder/get-id.md).

{% endlist %}

## Примеры {#examples}

### NAT-шлюз в другом каталоге {#from-another-folder}

Переместите NAT-шлюз, который находится в другом каталоге. Укажите идентификатор NAT-шлюза, а также идентификаторы исходного и целевого каталога:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc vpc gateway move enckq19qqsr5******** \
    --folder-id b1chgf288nvg******** \
    --destination-folder-id b1cs8ie21pk1********
  ```

{% endlist %}

#### См. также {#see-also}

* [Переместить облачную сеть в другой каталог](network-move.md)
* [Переместить подсеть в другой каталог](subnet-move.md)