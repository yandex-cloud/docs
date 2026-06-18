# Получить информацию о таблице маршрутизации

{% list tabs %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [таблица маршрутизации](../concepts/routing.md).
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **Таблицы маршрутизации**.
  1. Выберите нужную таблицу маршрутизации.
  1. На странице **Обзор** отобразится подробная информация о таблице маршрутизации.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../cli/index.md) для получения информации о [таблице маршрутизации](../concepts/routing.md):

     ```bash
     yc vpc route-table get --help
     ```

  1. Получите информацию о таблице маршрутизации, указав ее имя или идентификатор:

     ```bash
     yc vpc route-table get <имя_таблицы_маршрутизации>
     ```

     Результат:

     ```text
     id: enpmgov0n4ah********
     folder_id: b1go3el0d8fs********
     created_at: "2023-09-20T13:56:58Z"
     name: my-routing
     network_id: enpols3n07b8********
     static_routes:
       - destination_prefix: 0.0.0.0/0
         gateway_id: enpkq1ujbgrs********
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [таблице маршрутизации](../concepts/routing.md) с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

     ```hcl
     data "yandex_vpc_route_table" "my-rt" {
       route_table_id = "<идентификатор_таблицы_маршрутизации>"
     }

     output "route-table" {
       value = data.yandex_vpc_route_table.my-rt.static_route
     }
     ```

     Где:
     * `data "yandex_vpc_route_table"` — описание таблицы маршрутизации в качестве источника данных:
       * `route_table_id` — идентификатор таблицы маршрутизации.
     * `output "route-table"` — выходная переменная, которая содержит информацию о статических маршрутах таблицы маршрутизации:
       * `value` — возвращаемое значение.

     Вместо `static_route` вы можете выбрать любой другой параметр для получения информации. Подробнее о параметрах источника данных `yandex_vpc_route_table` в [документации провайдера](../../terraform/data-sources/vpc_route_table.md).

  1. Создайте ресурсы:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Terraform создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     route-table = toset([
       {
         "destination_prefix" = "0.0.0.0/0"
         "gateway_id" = "enpkq1ujbgrs********"
         "next_hop_address" = ""
       },
     ])
     ```

- API {#api}

  Чтобы получить подробную информацию о [таблице маршрутизации](../concepts/routing.md), воспользуйтесь методом REST API [get](../api-ref/RouteTable/get.md) для ресурса [RouteTable](../api-ref/RouteTable/index.md), или вызовом gRPC API [RouteTableService/Get](../api-ref/grpc/RouteTable/get.md).

{% endlist %}