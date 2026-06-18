# Получить информацию о группе размещения

{% list tabs %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится [группа размещения](../../concepts/placement-groups.md).
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/copy-transparent.svg) **Группы размещений**.
  1. Выберите нужную группу.
  1. На странице **Обзор** отобразится подробная информация о группе размещения ВМ.

- CLI

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о [группе размещения](../../concepts/placement-groups.md):

      ```bash
      yc compute placement-group get --help
      ```

  1. Получите информацию о группе размещения, указав ее имя или идентификатор:

      ```bash
      yc compute placement-group get <имя_группы_размещения>
      ```

      Результат:

      ```text
      id: fd8j3mm3229m********
      folder_id: b1g86q4m5vej********
      created_at: "2023-10-19T10:36:38Z"
      name: test-group
      spread_placement_strategy: {}
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [группе размещения](../../concepts/placement-groups.md) с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_compute_placement_group" "my_group" {
        group_id = "<идентификатор_группы_размещения>"
      }

      output "placement_group" {
        value = data.yandex_compute_placement_group.my_group.created_at
      }
      ```

      Где:

      * `data "yandex_compute_placement_group"` — описание группы размещения в качестве источника данных:
        * `group_id` — идентификатор группы размещения.
      * `output "placement_group"` — выходная переменная, которая содержит информацию о времени создания группы размещения:
        * `value` — возвращаемое значение.

      Вместо `created_at` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_compute_placement_group` читайте в [документации провайдера](../../../terraform/data-sources/compute_placement_group.md).

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
      placement_group = "2024-03-18T17:27:14Z"
      ```

- API {#api}

  Чтобы получить подробную информацию о [группе размещения](../../concepts/placement-groups.md), воспользуйтесь методом REST API [get](../../api-ref/PlacementGroup/get.md) для ресурса [PlacementGroup](../../api-ref/PlacementGroup/index.md), или вызовом gRPC API [PlacementGroupService/Get](../../api-ref/grpc/PlacementGroup/get.md).

{% endlist %}