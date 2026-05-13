# Удалить зону

Чтобы удалить [зону DNS](../concepts/dns-zone.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, где требуется удалить зону DNS.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud DNS**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке зоны, которую требуется удалить.
  1. В открывшемся меню нажмите кнопку **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления зоны:

      ```
      yc dns zone delete --help
      ```
  1. Получите список всех зон в каталоге по умолчанию:

      ```
      yc dns zone list
      ```
  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной зоны.
  1. Удалите зону из каталога по умолчанию:

      ```
      yc dns zone delete <имя_или_идентификатор_зоны>
      ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить зону DNS, созданную с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием зоны DNS.

     {% cut "Пример описания зоны DNS в конфигурации Terraform" %}

     ```hcl
     resource "yandex_vpc_network" "foo" {}
     
     resource "yandex_dns_zone" "zone1" {
       name        = "my-public-zone"
       description = "Test public zone"
     
       labels = {
         label1 = "test-public"
       }
     
       zone    = "test.example-public2.com."
     }
     ```

     {% endcut %}

  1. В командной строке перейдите в папку, где расположен конфигурационный файл Terraform.

  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить удаление зоны DNS можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc dns zone list
     ```

- API {#api}

  Чтобы удалить зону DNS, воспользуйтесь методом REST API [delete](../api-ref/DnsZone/delete.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Delete](../api-ref/grpc/DnsZone/delete.md).

{% endlist %}