[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Управление диском > Получить информацию о диске

# Получить информацию о диске

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится [диск](../../concepts/disk.md).
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **Диски**.
  1. Выберите диск из списка.
  1. На странице **Обзор** отобразится подробная информация о диске.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о [диске](../../concepts/disk.md):

      ```bash
      yc compute disk get --help
      ```

  1. Получите информацию о диске, указав его идентификатор или имя:

      ```bash
      yc compute disk get <идентификатор_диска>
      ```

      Результат:

      ```text
      id: epdi2r341gcq********
      folder_id: b1go3el0d8fs********
      created_at: "2023-10-27T12:14:30Z"
      name: test-disk
      type_id: network-hdd
      zone_id: ru-central1-a
      size: "21474836480"
      block_size: "4096"
      status: READY
      disk_placement_policy: {}
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [диске](../../concepts/disk.md) с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_compute_disk" "my_disk" {
        disk_id = "epdi2r341gcq********"
      }

      output "my_disk_size" {
        value = data.yandex_compute_disk.my_disk.size
      }
      ```

      Где:

      * `data "yandex_compute_disk"` — описание [диска](../../concepts/disk.md) в качестве источника данных:
         * `disk_id` — идентификатор диска.
      * `output "my_disk_size"` — выходная переменная, которая содержит информацию о размере диска:
         * `value` — возвращаемое значение.

     Вместо `size` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_compute_disk` читайте в [документации провайдера](../../../terraform/data-sources/compute_disk.md).

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
      my_disk_size = 20
      ```

- API {#api}

  Чтобы получить информацию о [диске](../../concepts/disk.md), воспользуйтесь методом REST API [get](../../api-ref/Disk/get.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Get](../../api-ref/grpc/Disk/get.md).

{% endlist %}