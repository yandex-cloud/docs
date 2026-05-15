# Получение информации об источниках

Вы можете узнать информацию об отдельном [источнике](#get-origin) или о [группе источников](#get-origin-group).

## Получение информации об источнике {#get-origin}

Чтобы получить URL и другую информацию об источнике:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится источник.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Cloud CDN**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **Группы источников**.
  1. Выберите группу источников, в которой находится источник.
  1. На странице **Обзор** отобразится подробная информация об источнике.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации об источнике:

      ```bash
      yc cdn origin get --help
      ```

  1. Получите информацию об источнике, указав его идентификатор или имя:

      ```bash
      yc cdn origin get <идентификатор_источника>
      ```

      Результат:

      ```text
      id: "152152********"
      origin_group_id: "2128********"
      source: test-cdn-1.storage.yandexcloud.net
      enabled: true
      meta:
        bucket:
          name: test-cdn-1
      ```

- API {#api}

  Чтобы получить подробную информацию об источнике, воспользуйтесь методом REST API [get](../../api-ref/Origin/get.md) для ресурса [Origin](../../api-ref/Origin/index.md) или вызовом gRPC API [OriginService/Get](../../api-ref/grpc/Origin/get.md).

{% endlist %}

## Получение информации о группе источников {#get-origin-group}

Чтобы получить имя, состав группы и другую информацию о группе источников:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится группа источников.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Cloud CDN**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **Группы источников**.
  1. Выберите группу источников.
  1. На странице **Обзор** отобразится подробная информация о группе источников.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о группе источников:

      ```bash
      yc cdn origin-group get --help
      ```

  1. Получите информацию о группе источников, указав ее идентификатор или имя:

      ```bash
      yc cdn origin-group get <идентификатор_группы_источников>
      ```

      Результат:

      ```text
      id: "2149********"
      folder_id: b1ggmp8es27t********
      name: test-cdn-group
      use_next: true
      origins:
      - id: "2741********"
        origin_group_id: "2149********"
        source: test-cdn-1-2.storage.yandexcloud.net
        enabled: true
        backup: true
        meta:
          bucket:
            name: test-cdn-1-2
      - id: "2742********"
        origin_group_id: "2149********"
        source: test-cdn-1-1.storage.yandexcloud.net
        enabled: true
        meta:
          bucket:
            name: test-cdn-1-1
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_cdn_origin_group" "my_group" {
        origin_group_id = "<идентификатор_группы>"
      }

      output "my_group_origin" {
        value = "${data.yandex_cdn_origin_group.my_group.origin}"
      }
      ```

      Где:

      * `data "yandex_cdn_origin_group"` — описание группы источников в качестве источника данных:
        * `origin_group_id` — идентификатор группы источников.
      * `output "my_group_origin"` — выходная переменная, которая содержит информацию о группе источников:
        * `value` — возвращаемое значение.

      Вместо `origin` вы можете выбрать любой другой параметр для получения информации. Более подробную информацию о параметрах источника данных `yandex_cdn_origin_group` см. в [документации провайдера](../../../terraform/data-sources/cdn_origin_group.md).

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
      my_group_origin = toset([
        {
          "backup" = false
          "enabled" = true
          "origin_group_id" = 2149********
          "source" = "test-cdn-1-2"
        },
        {
          "backup" = true
          "enabled" = true
          "origin_group_id" = 2149********
          "source" = "test-cdn-1-1"
        },
      ])
      ```

- API {#api}

  Чтобы получить подробную информацию о группе источников, воспользуйтесь методом REST API [get](../../api-ref/OriginGroup/get.md) для ресурса [OriginGroup](../../api-ref/OriginGroup/index.md) или вызовом gRPC API [OriginGroupService/Get](../../api-ref/grpc/OriginGroup/get.md).

{% endlist %}