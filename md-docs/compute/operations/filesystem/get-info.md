# Получить информацию о файловом хранилище

Вы можете узнать размер, зону доступности и другую информацию о файловом хранилище.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [файловое хранилище](../../concepts/filesystem.md).
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/nodes-right.svg) **Файловые хранилища**.
  1. Выберите нужное файловое хранилище.
  1. На странице **Обзор** отобразится подробная информация о файловом хранилище.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о [файловом хранилище](../../concepts/filesystem.md):

      ```bash
      yc compute filesystem get --help
      ```

  1. Получите информацию о файловом хранилище, указав его идентификатор или имя:

      ```bash
      yc compute filesystem get <идентификатор_файлового_хранилища>
      ```

      Результат:

      ```text
      id: epdt429j3unu********
      folder_id: b1go3el0d8fs********
      created_at: "2023-10-27T12:15:53Z"
      name: test-filesystem
      type_id: network-hdd
      zone_id: ru-central1-a
      size: "1073741824"
      block_size: "4096"
      status: READY
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [файловом хранилище](../../concepts/filesystem.md) с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_compute_filesystem" "my_fs" {
        filesystem_id = "<идентификатор_файлового_хранилища>"
      }

      output "filesystem" {
        value = data.yandex_compute_filesystem.my_fs.size
      }
      ```

      Где:

      * `data "yandex_compute_filesystem"` — описание файлового хранилища в качестве источника данных:
         * `resource_id` — идентификатор файлового хранилища.
      * `output "filesystem"` — выходная переменная, которая содержит информацию о размере файлового хранилища:
         * `value` — возвращаемое значение.

     Вместо `size` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_compute_filesystem` см. в [документации провайдера](../../../terraform/data-sources/compute_filesystem.md).

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
      filesystem = "5"
      ```

- API {#api}

  Чтобы получить подробную информацию о [файловом хранилище](../../concepts/filesystem.md), воспользуйтесь методом REST API [get](../../api-ref/Filesystem/get.md) для ресурса [Filesystem](../../api-ref/Filesystem/index.md), или вызовом gRPC API [FilesystemService/Get](../../api-ref/grpc/Filesystem/get.md).

{% endlist %}