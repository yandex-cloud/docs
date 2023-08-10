# Изменить зону DNS

После создания [зону DNS](../concepts/dns-zone.md) можно изменить: переименовать или добавить описание.

Чтобы изменить зону DNS:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется изменить зону DNS.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке зоны, которую требуется изменить.
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры зоны.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить зону DNS:

  1. Посмотрите описание команды CLI для изменения зоны:

     ```
     yc dns zone update --help
     ```

  1. Измените видимость зоны в сетях:

     ```
     yc dns zone update <имя или идентификатор зоны> --network-ids=c645mh47vscba1d64tbs,
     ```

     Результат:

     ```
     id: aet29qhara5jeg45tbjg
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2021-02-21T09:21:03.935Z"
     name: <новое имя зоны>
     zone: staging.
     private_visibility:
       network_ids:
       - c645mh47vscba1d64tbs
     ```

- {{ TF }}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы обновить зону DNS, созданную с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием зоны DNS.

     {% cut "Пример описания зоны DNS в конфигурации {{ TF }}" %}
     
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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение параметров зоны DNS можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc dns zone get <имя зоны DNS>
     ```

- API

  Чтобы изменить зону DNS, воспользуйтесь методом REST API [update](../api-ref/DnsZone/update.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Update](../api-ref/grpc/dns_zone_service.md#Update).

{% endlist %}
