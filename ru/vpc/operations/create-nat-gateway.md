# Настроить NAT-шлюз

{% note info %}

Функция находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы создать и настроить NAT-шлюз:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется создать шлюз.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. На панели слева выберите **Шлюзы**.
  1. Нажмите кнопку **Создать**.
  1. Задайте имя шлюза:

      {% include [name-format](../../_includes/name-format.md) %}
   
  1. (опционально) Добавьте описание шлюза.
  1. По умолчанию выбран тип шлюза **NAT-шлюз**.
  1. Нажмите кнопку **Создать**.
  1. На панели слева выберите **Таблицы маршрутизации**.
  1. Нажмите кнопку **Создать**, чтобы создать новую таблицу или выберите одну из существующих.
  1. Нажмите кнопку **Добавить маршрут**.
  1. В открывшемся окне в поле **Next hop** выберите **Шлюз**.
  1. В поле **Шлюз** выберите созданный NAT-шлюз. Префикс назначения заполнится автоматически.
  1. Нажмите кнопку **Добавить**.
  1. Нажмите кнопку **Сохранить**. 

  Затем привяжите таблицу маршрутизации к одной из подсетей, чтобы направить трафик из нее через NAT-шлюз:

  1. На панели слева выберите ![image](../../_assets/vpc/subnets.svg) **Подсети**.
  1. В строке нужной подсети нажмите кнопку ![image](../../_assets/options.svg).
  1. В открывшемся меню выберите пункт **Привязать таблицу маршрутизации**.
  1. В открывшемся окне выберите созданную таблицу в списке.
  1. Нажмите кнопку **Привязать**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для создания шлюза:

      ```
      yc vpc gateway create --help
      ```

  1. Создайте шлюз в каталоге по умолчанию:

     ```
     yc vpc gateway create --name test-gateway
     ```
  1. Получите идентификатор шлюза:

     ```
     yc vpc gateway list
     ```

     Результат выполнения команды:

     ```
     +----------------------+--------------+-------------+
     |          ID          |     NAME     | DESCRIPTION |
     +----------------------+--------------+-------------+
     | enpkq1v2e7p0cmr7e2s0 | test-gateway |             |
     +----------------------+--------------+-------------+
     ```

  1. Создайте таблицу маршрутизации со шлюзом в качестве next hop и префиксом назначения `0.0.0.0/0`:

     ```
     yc vpc route-table create --name=test-route-table --network-name=<имя сети, в которой создается таблица> --route destination=0.0.0.0/0,gateway-id=enpkq1v2e7p0cmr7e2s0
     ```

  1. Привяжите таблицу к подсети:

     ```
     yc vpc subnet update <имя подсети> --route-table-name=test-route-table

     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  Чтобы создать NAT-шлюз, указать его в качестве next hop в таблице [маршрутизации](../concepts/static-routes.md) и привязать таблицу к подсети используйте следующую конфигурацию:
  
  ```
  data "yandex_vpc_network" "net" {
    folder_id = "<идентификатор каталога>"
    name      = "<имя облачной сети>"
  }

  resource "yandex_vpc_subnet" "subnet" {
    folder_id      = "<имя каталога, в котором находится подсеть>"
    name           = "<имя подсети>"
    v4_cidr_blocks = "10.20.30.0/24"
    zone           = ru-central1-a
    network_id     = data.yandex_vpc_network.net.id
    route_table_id = yandex_vpc_route_table.rt.id
  }

  resource "yandex_vpc_gateway" "nat_gateway" {
    name = "test-gateway"
    shared_egress_gateway {}
  }

  resource "yandex_vpc_route_table" "rt" {
    name       = test-route-table
    network_id = "<идентификатор сети>"

    static_route {
      destination_prefix = "0.0.0.0/0"
      gateway_id         = yandex_vpc_gateway.nat_gateway.id
    }
  }
  ```

{% endlist %}
