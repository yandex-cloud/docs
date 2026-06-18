# Получить информацию об облачной сети

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [облачная сеть](../concepts/network.md#network).
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/timestamps.svg) **Облачные сети**.
  1. Выберите нужную облачную сеть.
  1. На странице **Обзор** отобразится подробная информация о выбранной сети.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации об [облачной сети](../concepts/network.md#network):

      ```bash
      yc vpc network get --help
      ```

  1. Получите информацию о сети, указав ее имя или идентификатор:

      ```bash
      yc vpc network get <имя_сети>
      ```

      Результат:

      ```text
      id: ne7w0rkfj75j********
      folder_id: f01derqpemb4********
      created_at: "2023-10-25T14:59:46Z"
      name: my-network
      description: Auto-created network
      default_security_group_id: 5ecur17yj09k********
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию об [облачной сети](../concepts/network.md#network) с помощью Terraform:
  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

     ```hcl
     data "yandex_vpc_network" "admin" {
       network_id = "<идентификатор_сети>"
     }

     output "network" {
       value = data.yandex_vpc_network.admin.created_at
     }
     ```

     Где:
     * `data "yandex_vpc_network"` — описание облачной сети в качестве источника данных:
       * `network_id` — идентификатор облачной сети.
     * `output "network"` — выходная переменная, которая содержит информацию о временной метке создания сети:
       * `value` — возвращаемое значение.

     Вместо `created_at` вы можете выбрать любой другой параметр для получения информации. Подробнее о параметрах источника данных `yandex_vpc_network` в [документации провайдера](../../terraform/data-sources/vpc_network.md).
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
     network = "2024-04-05T06:42:00Z"
     ```

- API {#api}

  Чтобы получить подробную информацию об [облачной сети](../concepts/network.md#network), воспользуйтесь методом REST API [get](../api-ref/Network/get.md) для ресурса [Network](../api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Get](../api-ref/grpc/Network/get.md) и передайте в запросе идентификатор нужной облачной сети в параметре `networkId`.

  Чтобы узнать идентификатор облачной сети, воспользуйтесь методом REST API [list](../api-ref/Network/list.md) для ресурса [Network](../api-ref/Network/index.md) или вызовом gRPC API [NetworkService/List](../api-ref/grpc/Network/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

  О том, как узнать идентификатор каталога, читайте в разделе [Получение идентификатора каталога](../../resource-manager/operations/folder/get-id.md).


{% endlist %}

#### Полезные ссылки {#see-also}

* [Получить информацию о подсети](subnet-get-info.md)