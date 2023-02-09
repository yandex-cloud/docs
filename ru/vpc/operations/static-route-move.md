# Переместить таблицу маршрутизации в другой каталог

Облачные ресурсы можно переносить между каталогами в пределах одного [облака](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs %}

- Консоль управления

  Чтобы переместить [таблицу маршрутизации](../concepts/static-routes.md) в другой каталог:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где находится таблица маршрутизации.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. На панели слева выберите ![image](../../_assets/vpc/route-tables.svg) **Таблицы маршрутизации**.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке таблицы, которую требуется переместить, и выберите **Переместить**.
  1. В выпадающем списке выберите каталог назначения.
  1. Нажмите кнопку **Переместить**.

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
      | enp8c7ia88i8lm60ah1s | table-1 |             | encb4ubvmief09h6qg5e |
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
      | b1cs8ie21pk10aurd2c3 | default                |        | ACTIVE |
      | b1chgf288nvg541tgu73 | my-folder-1            |        | ACTIVE |
      | b1cu6g9ielh690at5bm7 | my-folder-2            |        | ACTIVE |
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
     id: enp8c7ia88i8lm60ah1s
     folder_id: b1chgf288nvg541tgu73
     created_at: "2022-10-10T05:55:39Z"
     name: table-1
     network_id: encb4ubvmief09h6qg5e
     ```
     Подробнее о команде `yc vpc route-table move` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/route-table/move.md).

- API

  Чтобы переместить [таблицу маршрутизации](../concepts/static-routes.md) в другой каталог, воспользуйтесь методом REST API [move](../api-ref/RouteTable/move.md) для ресурса [RouteTable](../api-ref/RouteTable/index.md) или вызовом gRPC API [RouteTableService/Move](../api-ref/grpc/route_table_service.md#Move).

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

