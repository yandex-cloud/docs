# Получить информацию о публичном образе

Вы можете получить идентификатор или другую информацию о публичном образе.

## Получить идентификатор публичного образа {#get-id}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать виртуальную машину.
  1. Перейдите в сервис **Compute Cloud**.
  1. Справа сверху нажмите кнопку **Создать ресурс**.
  1. В открывшемся списке выберите **Виртуальная машина**.
  1. В блоке **Образ загрузочного диска** нажмите ![image](../../../_assets/console-icons/circle-info.svg) рядом с нужным [публичным образом](../../concepts/image.md#public).
  1. В блоке **Идентификаторы продукта** отобразится **image_id** — идентификатор публичного образа.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о [публичном образе](../../concepts/image.md#public) диска:

      ```bash
      yc compute image get --help
      ```

  1. Получите идентификатор публичного образа, указав название [семейства](../../concepts/image.md#family) операционных систем:

      ```bash
      yc compute image get-latest-from-family <имя_семейства> --folder-id standard-images
      ```

      Чтобы узнать название семейства образа, [получите](#get-info) список образов в каталоге.

      Результат:

      ```text
      id: fd85u0rct32prepgjlv0
      folder_id: standard-images
      created_at: "2024-03-11T10:57:40Z"
      name: ubuntu-22-04-lts-v20240311
      description: ubuntu 22.04 lts
      family: ubuntu-2204-lts
      storage_size: "7633633280"
      min_disk_size: "8589934592"
      product_ids:
        - f2ef01lju2nsansfdahf
      status: READY
      os:
        type: LINUX
      pooled: true
      ```

      Идентификатор публичного образа отобразится в строке `id`.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы получить идентификатор [публичного образа](../../concepts/image.md#public) с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_compute_image" "my_image" {
        family = "<имя_семейства>"
      }

      output "image" {
        value = data.yandex_compute_image.my_image.image_id
      }
      ```

      Где:

      * `data "yandex_compute_image"` — описание публичного образа в качестве источника данных:
        * `family` — название [семейства](../../concepts/image.md#family) операционных систем публичного образа. Чтобы узнать название семейства образа, [получите](#get-info) список образов в каталоге.
      * `output "image"` — выходная переменная, которая содержит идентификатор публичного образа:
        * `value` — возвращаемое значение.

      Более подробно о параметрах источника данных `yandex_compute_image` см. в [документации провайдера](../../../terraform/data-sources/compute_image.md).

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
      image = "fd85u0rct32prepgjlv0"
      ```

- API {#api}

  Чтобы получить идентификатор [публичного образа](../../concepts/image.md#public) диска, воспользуйтесь методом REST API [get](../../api-ref/Image/get.md) для ресурса [Image](../../api-ref/Image/index.md), или вызовом gRPC API [ImageService/Get](../../api-ref/grpc/Image/get.md).

{% endlist %}

## Получить информацию о публичном образе {#get-info}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать виртуальную машину.
  1. Перейдите в сервис **Compute Cloud**.
  1. Справа сверху нажмите кнопку **Создать ресурс**.
  1. В открывшемся списке выберите **Виртуальная машина**.
  1. В блоке **Образ загрузочного диска** нажмите ![image](../../../_assets/console-icons/circle-info.svg) рядом с нужным [публичным образом](../../concepts/image.md#public).
  1. В открывшемся окне отобразится информация о публичном образе.
  1. Если необходимо увидеть все доступные публичные образы, перейдите на вкладку **Marketplace** и нажмите **Показать все продукты Marketplace**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о [публичном образе](../../concepts/image.md#public):

      ```bash
      yc compute image get --help
      ```

  1. Получите информацию о публичном образе, указав его идентификатор:

      ```bash
      yc compute image get <идентификатор_образа>
      ```

      Чтобы узнать идентификатор образа, [получите](#get-id) список образов в каталоге.

      Результат:

      ```text
      id: fd89ls0nj4oqmlhhi568
      folder_id: standard-images
      created_at: "2024-04-29T10:58:27Z"
      name: ubuntu-2204-lts-oslogin-v20240429
      description: Ubuntu 22.04 OsLogin
      family: ubuntu-2204-lts-oslogin
      storage_size: "7511998464"
      min_disk_size: "10737418240"
      product_ids:
        - f2e48vn7nr04r2bpg4eg
      status: READY
      os:
        type: LINUX
      pooled: true
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию об [публичном образе](../../concepts/image.md#public) с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_compute_image" "my_image" {
        image_id = "<идентификатор_образа>"
      }
      output "image" {
        value = data.yandex_compute_image.my_image.family
      }
      ```

      Где:

      * `data "yandex_compute_image"` — описание публичного образа в качестве источника данных:
        * `image_id` — идентификатор публичного образа. Чтобы узнать идентификатор образа, [получите](#get-id) список образов в каталоге.
      * `output "image"` — выходная переменная, которая содержит информацию о [семействе](../../concepts/image.md#family) операционных систем:
        * `value` — возвращаемое значение.

      Вместо `family` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_compute_image` см. в [документации провайдера](../../../terraform/data-sources/compute_image.md).

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
      image = "ubuntu-2204-lts"
      ```

- API {#api}

  Чтобы получить подробную информацию об [публичном образе](../../concepts/image.md#public) диска, воспользуйтесь методом REST API [get](../../api-ref/Image/get.md) для ресурса [Image](../../api-ref/Image/index.md), или вызовом gRPC API [ImageService/Get](../../api-ref/grpc/Image/get.md).

{% endlist %}

Посмотреть информацию обо всех доступных публичных образах также можно в [Cloud Marketplace](https://yandex.cloud/ru/marketplace).