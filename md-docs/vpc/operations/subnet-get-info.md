[Документация Yandex Cloud](../../index.md) > [Yandex Virtual Private Cloud](../index.md) > [Пошаговые инструкции](index.md) > Подсеть > Получить информацию о подсети

# Получить информацию о подсети

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [подсеть](../concepts/network.md#subnet).
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **Подсети**.
  1. Выберите нужную подсеть.
  1. На странице **Обзор** отобразится подробная информация о подсети.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о [подсети](../concepts/network.md#subnet):

      ```bash
      yc vpc subnet get --help
      ```

  1. Получите информацию о подсети, указав ее имя или идентификатор:

      ```bash
      yc vpc subnet get <имя_подсети>
      ```

      Результат:

      ```text
      id: 5ubne7r188b7********
      folder_id: f01derqpemb4********
      created_at: "2023-10-25T14:59:49Z"
      name: my-network-ru-central1-a
      description: Auto-created default subnet for zone ru-central1-a in my-network
      network_id: ne7w0rkfj75j********
      zone_id: ru-central1-a
      v4_cidr_blocks:
        - 10.130.0.0/24
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [подсети](../concepts/network.md#subnet) с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

     ```hcl
     data "yandex_vpc_subnet" "my_subnet" {
       subnet_id = "<идентификатор_подсети>"
     }

     output "subnet" {
       value = data.yandex_vpc_subnet.my_subnet.zone
     }
     ```

     Где:
     * `data "yandex_vpc_subnet"` — описание подсети в качестве источника данных:
       * `subnet_id` — идентификатор подсети.
     * `output "subnet"` — выходная переменная, которая содержит название зоны доступности подсети:
       * `value` — возвращаемое значение.

     Вместо `zone` вы можете выбрать любой другой параметр для получения информации. Подробнее о параметрах источника данных `yandex_vpc_subnet` в [документации провайдера](../../terraform/data-sources/vpc_subnet.md).
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
     subnet = "ru-central1-a"
     ```

- API {#api}

  Чтобы получить подробную информацию о [подсети](../concepts/network.md#subnet), воспользуйтесь методом REST API [get](../api-ref/Subnet/get.md) для ресурса [Subnet](../api-ref/Subnet/index.md), или вызовом gRPC API [SubnetService/Get](../api-ref/grpc/Subnet/get.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Получить информацию об облачной сети](network-get-info.md)