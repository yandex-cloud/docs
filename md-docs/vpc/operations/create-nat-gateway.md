# Настроить NAT-шлюз


Минимально необходимые [роли](../security/index.md#roles-list) для создания и настройки [NAT-шлюза](../concepts/gateways.md): `vpc.admin` и `vpc.gateways.user`.

Чтобы создать и настроить NAT-шлюз:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется создать шлюз.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.vpc.switch_gateways }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Задайте имя шлюза. Требования к имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.
   
  1. (Опционально) Добавьте описание шлюза.
  1. По умолчанию выбран тип шлюза `{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать новую таблицу, или выберите одну из существующих.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
  1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** выберите `{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}`.
  1. В поле **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** выберите созданный NAT-шлюз. Префикс назначения заполнится автоматически.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table.edit.button_edit }}**. 

  Затем привяжите [таблицу маршрутизации](../concepts/routing.md) к одной из подсетей, чтобы направить трафик из нее через NAT-шлюз:

  1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. В строке нужной подсети нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg).
  1. В открывшемся меню выберите пункт **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
  1. В открывшемся окне выберите созданную таблицу в списке.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  1. Посмотрите описание команды CLI для создания шлюза:

      ```bash
      yc vpc gateway create --help
      ```

  1. Создайте шлюз в каталоге по умолчанию:

     ```bash
     yc vpc gateway create \
        --name test-gateway
     ```
  1. Получите идентификатор шлюза:

     ```bash
     yc vpc gateway list
     ```

     Результат:

     ```text
     +----------------------+--------------+-------------+
     |          ID          |     NAME     | DESCRIPTION |
     +----------------------+--------------+-------------+
     | enpkq1v2e7p0******** | test-gateway |             |
     +----------------------+--------------+-------------+
     ```

  1. Создайте таблицу маршрутизации со шлюзом в качестве next hop и префиксом назначения `0.0.0.0/0`:

     ```bash
     yc vpc route-table create \
        --name=test-route-table \
        --network-name=<имя_сети> \
        --route destination=0.0.0.0/0,gateway-id=enpkq1v2e7p0********
     ```

     Где `--network-name` — имя сети, в которой создается таблица.

  1. Привяжите таблицу к подсети:

     ```bash
     yc vpc subnet update <имя_подсети> \
        --route-table-name=test-route-table
     ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.
  
  Чтобы создать NAT-шлюз, указать его в качестве next hop в таблице [маршрутизации](../concepts/routing.md) и привязать таблицу к подсети используйте следующую конфигурацию:
  
  ```hcl
  data "yandex_vpc_network" "net" {
    folder_id = "<идентификатор_каталога>"
    name      = "<имя_сети>"
  }

  resource "yandex_vpc_subnet" "subnet" {
    folder_id      = "<идентификатор_каталога>"
    name           = "<имя_подсети>"
    v4_cidr_blocks = ["10.20.30.0/24"]
    zone           = "{{ region-id }}-a"
    network_id     = data.yandex_vpc_network.net.id
    route_table_id = yandex_vpc_route_table.rt.id
  }

  resource "yandex_vpc_gateway" "nat_gateway" {
    folder_id      = "<идентификатор_каталога>"
    name = "test-gateway"
    shared_egress_gateway {}
  }

  resource "yandex_vpc_route_table" "rt" {
    folder_id      = "<идентификатор_каталога>"
    name       = "test-route-table"
    network_id = "<идентификатор_сети>"

    static_route {
      destination_prefix = "0.0.0.0/0"
      gateway_id         = yandex_vpc_gateway.nat_gateway.id
    }
  }
  ```

  Где `folder_id` — идентификатор каталога, в котором находится подсеть.

- API {#api}

  1. Создайте NAT-шлюз. Воспользуйтесь методом REST API [create](../api-ref/Gateway/create.md) для ресурса [Gateway](../api-ref/Gateway/index.md) или вызовом gRPC API [GatewayService/Create](../api-ref/grpc/Gateway/create.md) и передайте в запросе:

      * Идентификатор каталога, в котором будет размещен шлюз, в параметре `folderId`.
      * Имя шлюза в параметре `name`. Формат имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

  1. Привяжите NAT-шлюз к новой таблице маршрутизации. Для этого воспользуйтесь методом REST API [create](../api-ref/RouteTable/create.md) для ресурса [RouteTable](../api-ref/RouteTable/index.md) или вызовом gRPC API [RouteTableService/Create](../api-ref/grpc/RouteTable/create.md) и передайте в запросе:

      * Идентификатор каталога, в котором будет размещена таблица маршрутизации, в параметре `folderId`.
      * Имя таблицы маршрутизации в параметре `name`. Формат имени:

        * длина — от 3 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.
      * Идентификатор сети, в которой будет размещена таблица маршрутизации, в параметре `networkId`.
      * Значение `0.0.0.0/0` для префикса подсети назначения в параметре `staticRoutes[].destinationPrefix`.
      * Идентификатор NAT-шлюза в параметре `staticRoutes[].gatewayId`.

        Чтобы узнать идентификатор NAT-шлюза, воспользуйтесь методом REST API [list](../api-ref/Gateway/list.md) для ресурса [Gateway](../api-ref/Gateway/index.md) или вызовом gRPC API [GatewayService/List](../api-ref/grpc/Gateway/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

  1. Привяжите таблицу маршрутизации к подсети. Для этого воспользуйтесь методом REST API [update](../api-ref/Subnet/update.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Update](../api-ref/grpc/Subnet/update.md) и передайте в запросе:

      * Идентификатор подсети в параметре `subnetId`.

        Чтобы узнать идентификатор подсети, воспользуйтесь методом REST API [list](../api-ref/Subnet/list.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/List](../api-ref/grpc/Subnet/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

        О том, как узнать идентификатор каталога, читайте в разделе [Получение идентификатора каталога](../../resource-manager/operations/folder/get-id.md).

      * Идентификатор таблицы маршрутизации в параметре `routeTableId`.
      * Имя параметра `routeTableId` в параметре `updateMask`.

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
      
      {% endnote %}

{% endlist %}