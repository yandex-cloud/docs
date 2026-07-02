[Документация Yandex Cloud](../../index.md) > [Yandex Virtual Private Cloud](../index.md) > [Пошаговые инструкции](index.md) > IP-адрес > Перенести адрес между каталогами

# Переместить публичный IP-адрес в другой каталог

[Публичный адрес](../concepts/address.md) можно переносить между каталогами в пределах одного [облака](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, где находится адрес.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/map-pin.svg) **Публичные IP-адреса**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке адреса, который требуется переместить, и выберите **Переместить**.
  1. В открывшемся окне выберите каталог назначения.
  1. Нажмите **Переместить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для перемещения адреса:

      ```bash
      yc vpc address move --help
      ```

  1. Узнайте имя или идентификатор адреса, который требуется переместить:

      ```bash
      yc vpc address list
      ```
      Результат:
      ```text
      +----------------------+------+---------------+----------+-------+
      |          ID          | NAME |    ADDRESS    | RESERVED | USED  |
      +----------------------+------+---------------+----------+-------+
      | e2l50m7qo8gp******** |      | 84.252.137.20 | true     | false |
      | e9b0qnmuh2cb******** |      | 51.250.65.244 | true     | false |
      | e9br252il3ce******** |      | 51.250.68.195 | false    | true  |
      +----------------------+------+---------------+----------+-------+
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

  1. Переместите адрес, указав имя или идентификатор адреса и каталога назначения:

     ```bash
     yc vpc address move <имя_или_идентификатор_адреса> \
       --destination-folder-name <имя_каталога_назначения> \
       --destination-folder-id <идентификатор_каталога_назначения>
     ```
     Используйте либо параметр `--destination-folder-name`, либо `--destination-folder-id`.

     Если адрес находится не в текущем каталоге (каталоге по умолчанию), укажите исходный каталог с помощью опции `--folder-name` или `--folder-id`.

     Результат:

     ```text
      id: e9br252il3ce********
      folder_id: b1chgf288nvg********
      created_at: "2022-10-10T05:38:43Z"
      external_ipv4_address:
        address: 51.250.68.195
        zone_id: ru-central1-a
        requirements: {}
      used: true
      type: EXTERNAL
      ip_version: IPV4
     ```

     Подробнее о команде `yc vpc address move` в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/address/move.md).

- API {#api}

  Чтобы переместить [публичный адрес](../concepts/address.md#public-addresses) в другой каталог, воспользуйтесь методом REST API [move](../api-ref/Address/move.md) для ресурса [Address](../api-ref/Address/index.md) или вызовом gRPC API [AddressService/Move](../api-ref/grpc/Address/move.md) и передайте в запросе:

    * Идентификатор адреса, который нужно перенести, в параметре `addressId`.

      Чтобы узнать идентификатор адреса, воспользуйтесь методом REST API [list](../api-ref/Address/list.md) для ресурса [Address](../api-ref/Address/index.md) или вызовом gRPC API [AddressService/List](../api-ref/grpc/Address/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

    * Идентификатор каталога, в который будет перенесен адрес, в параметре `destinationFolderId`.

      О том, как узнать идентификатор каталога, читайте в разделе [Получение идентификатора каталога](../../resource-manager/operations/folder/get-id.md).

{% endlist %}

## Примеры {#examples}

### Адрес в текущем каталоге {#from-default-folder}

Переместите адрес из текущего каталога, указав имя адреса и имя каталога назначения:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc vpc address move site-1 \
    --destination-folder-name my-folder-1
  ```

{% endlist %}

### Адрес в другом каталоге {#from-another-folder}

Переместите адрес, который находится в другом каталоге. Укажите идентификатор адреса, а также идентификаторы исходного и целевого каталога:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc vpc address move e9br252il3ce******** \
    --folder-id b1chgf288nvg******** \
    --destination-folder-id b1cs8ie21pk1********
  ```

{% endlist %}

#### Полезные ссылки {#see-also}

* [Перенести публичный IP-адрес от одной ВМ на другую](../../compute/operations/vm-control/vm-transferring-public-ip.md)