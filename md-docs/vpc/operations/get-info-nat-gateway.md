# Получить информацию о NAT-шлюзе

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [NAT-шлюз](../concepts/gateways.md).
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/arrows-opposite-to-dots.svg) **Шлюзы**.
  1. Выберите нужный NAT-шлюз.
  1. На странице **Обзор** отобразится подробная информация о NAT-шлюзе.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../cli/index.md) для получения информации о [NAT-шлюзе](../concepts/gateways.md):

     ```bash
     yc vpc gateway get --help
     ```

  1. Получите информацию о NAT-шлюзе, указав его имя или идентификатор:

     ```bash
     yc vpc gateway get <имя_или_идентификатор_NAT-шлюза>
     ```

     Результат:

     ```text
     id: enpkq1v2e7p0********
     folder_id: b1go79qlt1tp********
     created_at: "2024-04-23T16:34:53Z"
     name: test-gateway
     shared_egress_gateway: {}
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [NAT-шлюзе](../concepts/gateways.md) с помощью Terraform:
  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

     ```hcl
     data "yandex_vpc_gateway" "default" {
       gateway_id = "<идентификатор_NAT-шлюза>"
     }

     output "gateway" {
       value = data.yandex_vpc_gateway.default.created_at
     }
     ```

     Где:
     * `data "yandex_vpc_gateway"` — описание NAT-шлюза в качестве источника данных:
       * `gateway_id` — идентификатор NAT-шлюза.
     * `output "gateway"` — выходная переменная, которая содержит информацию о времени создания NAT-шлюза:
       * `value` — возвращаемое значение.

     Вместо `created_at` вы можете выбрать любой другой параметр для получения информации. Подробнее о параметрах источника данных `yandex_vpc_gateway` в [документации провайдера](../../terraform/data-sources/vpc_gateway.md).
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
     gateway = "2024-04-23T16:34:53Z"
     ```

- API {#api}

  Чтобы получить подробную информацию о [NAT-шлюзе](../concepts/gateways.md), воспользуйтесь методом REST API [get](../api-ref/Gateway/get.md) для ресурса [Gateway](../api-ref/Gateway/index.md), или вызовом gRPC API [GatewayService/Get](../api-ref/grpc/Gateway/get.md) и передайте в запросе идентификатор нужного NAT-шлюзa в параметре `gatewayId`.

   Чтобы узнать идентификатор NAT-шлюза, воспользуйтесь методом REST API [list](../api-ref/Gateway/list.md) для ресурса [Gateway](../api-ref/Gateway/index.md) или вызовом gRPC API [GatewayService/List](../api-ref/grpc/Gateway/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

   О том, как узнать идентификатор каталога, читайте в разделе [Получение идентификатора каталога](../../resource-manager/operations/folder/get-id.md).

{% endlist %}