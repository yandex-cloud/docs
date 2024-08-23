# Удалить NAT-шлюз

Если NAT-шлюз вам больше не нужен, вы можете [удалить его](#delete-nat-gateway). Перед удалением NAT-шлюза [отвяжите его](#unlink-nat-gateway) от всех таблиц маршрутизации, в которых он используется.

## Отвязать NAT-шлюз от таблицы маршрутизации {#unlink-nat-gateway}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется отвязать NAT-шлюз.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
  1. В открывшемся списке найдите таблицу маршрутизации, у которой в колонке **Статические маршруты** указан нужный NAT-шлюз.
  1. В строке с нужной таблицей нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. В открывшемся окне нажмите на значок ![image](../../_assets/console-icons/xmark.svg) в строке с названием NAT-шлюза.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы отвязать NAT-шлюз от таблицы маршрутизации:

  1. Посмотрите описание команды CLI для изменения таблицы маршрутизации:

      ```bash
      yc vpc route-table update --help
      ```

  1. Узнайте имя или идентификатор таблицы маршрутизации, к которой привязан NAT-шлюз:

      ```bash
      yc vpc route-table list
      ```
      Результат:
      ```text
      +----------------------+----------------------+-------------+----------------------+
      |          ID          |         NAME         | DESCRIPTION |      NETWORK-ID      |
      +----------------------+----------------------+-------------+----------------------+
      | enpcaaqahk3c******** | test-table           |             | enptgj64mv2r******** |
      +----------------------+----------------------+-------------+----------------------+

      ```
  1. Отвяжите NAT-шлюз:
      ```bash
      yc vpc route-table update <имя_или_идентификатор_таблицы_маршрутизации> --clear-routes
      ```
      Используйте либо параметр `--id`, либо параметр `--name`.

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  Чтобы отвязать NAT-шлюз от таблицы маршрутизации, созданной с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и найдите фрагмент с описанием таблицы маршрутизации, к которой привязан NAT-шлюз.

     {% cut "Пример описания таблицы маршрутизации в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_vpc_route_table" "routetable" {
       folder_id  = "<идентификатор_каталога_пользователя>"
       name       = "<имя_таблицы_маршрутизации>"
       network_id = "<идентификатор_сети>"
       static_route {
         destination_prefix = "0.0.0.0/0"
         gateway_id         = <идентификатор_шлюза>
       }
     }
     ...
     ```

     {% endcut %}

  1. Удалите объект `static_route`.

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.

  1. Проверьте конфигурацию командой:

     ```
     terraform validate
     ```

     Если конфигурация является корректной, появится сообщение:

     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```
     terraform plan
     ```

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc vpc route-table get <имя_или_идентификатор_таблицы_маршрутизации>
     ```
     Используйте либо параметр `--id`, либо параметр `--name`.

- API {#api}

  Чтобы отвязать NAT-шлюз от таблицы маршрутизации, нужно удалить из таблицы маршрутизации статический маршрут с этим NAT-шлюзом. Для этого воспользуйтесь методом REST API [update](../api-ref/RouteTable/update.md) для ресурса [RouteTable](../api-ref/RouteTable/index.md) или вызовом gRPC API [RouteTableService/Update](../api-ref/grpc/route_table_service.md#Update) и передайте в запросе список статических маршрутов без удаляемого маршрута в параметре:
    * `staticRoutes` для REST API;
    * `static_routes` для gRPC API.

  Если в списке содержался только один статический маршрут, передайте пустой список.

  Чтобы получить список статических маршрутов, воспользуйтесь методом REST API [get](../api-ref/RouteTable/get.md) для ресурса [RouteTable](../api-ref/RouteTable/index.md) или вызовом gRPC API [RouteTableService/Get](../api-ref/grpc/route_table_service.md#Get) и передайте в запросе идентификатор таблицы маршрутизации в параметре:
    * `routeTableId` для REST API;
    * `route_table_id` для gRPC API.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Удалить NAT-шлюз {#delete-nat-gateway}

{% note warning %}

Перед удалением NAT-шлюза [отвяжите его](#unlink-route-table) от всех таблиц маршрутизации, к которым он привязан.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить NAT-шлюз:
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется удалить NAT-шлюз.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/vpc/gateways.svg) **{{ ui-key.yacloud.vpc.switch_gateways }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке с именем нужного NAT-шлюза и выберите **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить таблицу маршрутизации:

  1. Посмотрите описание команды CLI для удаления NAT-шлюза:

      ```bash
      yc vpc gateway delete --help
      ```

  1. Узнайте имя или идентификатор NAT-шлюза, который требуется удалить:

      ```bash
      yc vpc gateway list
      ```
      Результат:
      ```text
      +----------------------+-----------+-------------+
      |          ID          |   NAME    | DESCRIPTION |
      +----------------------+-----------+-------------+
      | enpkq171u4gb******** | gateway-1 |             |
      +----------------------+-----------+-------------+
      ```
  1. Удалите NAT-шлюз:
      ```bash
      yc vpc gateway delete <имя_или_идентификатор_шлюза>
      ```
      Используйте либо параметр `--id`, либо параметр `--name`.

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  Чтобы удалить NAT-шлюз, созданный с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием нужного NAT-шлюза.

     {% cut "Пример описания NAT-шлюза в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_vpc_gateway" "natgateway" {
       folder_id      = "<идентификатор_каталога>"
       name = "<имя_шлюза>"
       shared_egress_gateway {}
     }
     ...
     ```

     {% endcut %}

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.

  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```

     Если конфигурация является корректной, появится сообщение:

     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```bash
     terraform plan
     ```

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc vpc gateway list
     ```

- API {#api}

  Чтобы удалить NAT-шлюз, воспользуйтесь методом REST API [delete](../api-ref/Gateway/delete.md) для ресурса [Gateway](../api-ref/Gateway/index.md) или вызовом gRPC API [GatewayService/Delete](../api-ref/grpc/gateway_service.md#Delete) и передайте в запросе идентификатор удаляемого NAT-шлюза в параметре:
    * `gatewayId` для REST API;
    * `gateway_id` для gRPC API.

  Чтобы узнать идентификатор NAT-шлюза, воспользуйтесь методом REST API [list](../api-ref/Gateway/list.md) для ресурса [Gateway](../api-ref/Gateway/index.md) или вызовом gRPC API [GatewayService/List](../api-ref/grpc/gateway_service.md#List) и передайте в запросе идентификатор каталога в параметре:
    * `folderId` для REST API;
    * `folder_id` для gRPC API.

{% endlist %}
