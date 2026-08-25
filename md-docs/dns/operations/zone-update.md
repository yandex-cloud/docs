[Документация Yandex Cloud](../../index.md) > [Yandex Cloud DNS](../index.md) > [Пошаговые инструкции](index.md) > Зоны > Изменить зону DNS

# Изменить зону DNS

После создания [зоны DNS](../concepts/dns-zone.md) ее можно изменить: переименовать или добавить описание.

Чтобы изменить зону DNS:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, где требуется изменить зону DNS.
  1. [Перейдите](https://console.yandex.cloud/link/dns) в сервис **Cloud DNS**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке зоны, которую требуется изменить.
  1. В открывшемся меню нажмите кнопку **Редактировать**.
  1. Измените параметры зоны.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить зону DNS:

  1. Посмотрите описание команды CLI для изменения зоны:

     ```bash
     yc dns zone update --help
     ```

  1. Измените видимость зоны в сетях:

     ```bash
     yc dns zone update <имя_или_идентификатор_зоны> --network-ids=<идентификаторы_сетей_для_зоны>,
     ```

     Где `--network-ids` — идентификаторы сетей для зоны.

     Результат:

     ```text
     id: aet29qhara5j********
     folder_id: aoerb349v3h4********
     created_at: "2021-02-21T09:21:03.935Z"
     name: new-zone-name
     zone: staging.
     private_visibility:
       network_ids:
       - c645mh47vsc********
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы обновить зону DNS, созданную с помощью Terraform:

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием зоны DNS.

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

  1. Примените изменения конфигурации:

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

     Проверить изменение параметров зоны DNS можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc dns zone get <имя_зоны>
     ```

- API {#api}

  Чтобы изменить зону DNS, воспользуйтесь методом REST API [update](../api-ref/DnsZone/update.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Update](../api-ref/grpc/DnsZone/update.md).

{% endlist %}