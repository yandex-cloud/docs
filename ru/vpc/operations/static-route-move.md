# Переместить таблицу маршрутизации в другой каталог

Облачные ресурсы можно переносить между каталогами в пределах одного [облака](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs %}

- Консоль управления

  Чтобы переместить [таблицу маршрутизации](../concepts/static-routes.md) в другой каталог:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где находится таблица маршрутизации.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/vpc/route-tables.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке таблицы, которую требуется переместить, и выберите **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.
  1. В выпадающем списке выберите каталог назначения.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы переместить [таблицу маршрутизации](../concepts/static-routes.md) в другой каталог:

  1. Посмотрите описание команды CLI для перемещения таблицы маршрутизации:

      ```bash
      yc vpc route-table move --help
      ```

  1. Узнайте имя или идентификатор таблицы маршрутизации, которую требуется переместить:

      ```bash
      yc vpc route-table list
      ```
      Результат:
      ```text
      +----------------------+---------+-------------+----------------------+
      |          ID          |  NAME   | DESCRIPTION |      NETWORK-ID      |
      +----------------------+---------+-------------+----------------------+
      | enp8c7ia88i8******** | table-1 |             | encb4ubvmief******** |
      +----------------------+---------+-------------+----------------------+
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

  1. Переместите таблицу маршрутизации, указав имя или идентификатор таблицы и каталога назначения:

     ```bash
     yc vpc route-table move <имя_или_идентификатор_таблицы_маршрутизации> \
       --destination-folder-name <имя_каталога_назначения> \
       --destination-folder-id <идентификатор_каталога_назначения>
     ```
     Используйте либо параметр `--destination-folder-name`, либо `--destination-folder-id`.

     Если таблица находится не в текущем каталоге (каталоге по умолчанию), укажите исходный каталог с помощью опции `--folder-name` или `--folder-id`.

     Результат:
     ```text
     id: enp8c7ia88i8********
     folder_id: b1chgf288nvg********
     created_at: "2022-10-10T05:55:39Z"
     name: table-1
     network_id: encb4ubvmief********
     ```
     Подробнее о команде `yc vpc route-table move` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/route-table/move.md).

- API

  Чтобы переместить [таблицу маршрутизации](../concepts/static-routes.md) в другой каталог, воспользуйтесь методом REST API [move](../api-ref/RouteTable/move.md) для ресурса [RouteTable](../api-ref/RouteTable/index.md) или вызовом gRPC API [RouteTableService/Move](../api-ref/grpc/route_table_service.md#Move) и передайте в запросе:

  * Идентификатор таблицы маршрутизации, которую нужно перенести, в параметре `routeTableId`.

    Чтобы узнать идентификатор таблицы маршрутизации, воспользуйтесь методом REST API [list](../api-ref/RouteTable/list) для ресурса [RouteTable](../api-ref/RouteTable/index.md) или вызовом gRPC API [RouteTableService/List](../api-ref/grpc/route_table_service.md#List) и передайте в запросе идентификатор текущего каталога в параметре `folderId`.

  * Идентификатор каталога, в который будет перенесена таблица маршрутизации, в параметре `destinationFolderId`.

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}

## Примеры {#examples}

### Таблица маршрутизации в текущем каталоге {#from-default-folder}

Переместите таблицу маршрутизации из текущего каталога, указав имя таблицы и имя каталога назначения:

{% list tabs %}

- CLI

  ```bash
  yc vpc route-table move table-1 \
    --destination-folder-name my-folder-1
  ```

{% endlist %}


#### См. также {#see-also}

* [{#T}](network-move.md)
* [{#T}](subnet-move.md)

