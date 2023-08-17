# Создать публичную зону DNS

Чтобы создать публичную [зону DNS](../concepts/dns-zone.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется создать зону DNS.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}**.
  1. Задайте настройки зоны:
     1. **{{ ui-key.yacloud.dns.label_zone }}** — доменная зона. Название зоны должно заканчиваться точкой. Публичные зоны верхнего уровня (TLD-зоны) создавать нельзя. Чтобы создать доменную зону с нелатинскими символами, используйте кодировку [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode).
     1. **{{ ui-key.yacloud.common.type }}** — `{{ ui-key.yacloud.dns.label_public }}`.
     1. **{{ ui-key.yacloud.common.name }}** зоны.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать новую зону DNS:

  1. Посмотрите описание команды CLI для создания зоны:

     ```
     yc dns zone create --help
     ```

  1. Создайте новую публичную зону DNS в каталоге по умолчанию:

     ```
     yc dns zone create --name production-zone --zone www.example.com. --public-visibility
     ```

     Результат:

     ```
     id: aet2q4fn8i8icfug97p0
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2021-03-03T19:07:08.685Z"
     name: production-zone
     zone: www.example.com.
     public_visibility: {}
     ```

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     1. Параметры зоны DNS:

        * `zone` — доменная зона. Название зоны должно заканчиваться точкой. Публичные зоны верхнего уровня (TLD-зоны) создавать нельзя. Чтобы создать доменную зону с нелатинскими символами, используйте кодировку [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode). Обязательный параметр.
        * `folder_id` — идентификатор каталога, в котором будет создана зона. Если он не указан, используется каталог по умолчанию. Необязательный параметр.
        * `name` — имя зоны. Должно быть уникальное внутри каталога. Необязательный параметр.
        * `description` — описание зоны. Необязательный параметр.
        * `labels` — набор меток зоны DNS. Необязательный параметр.
        * `public` — видимость зоны: публичная или внутренняя. Необязательный параметр.

     1. Параметры записи DNS:

        * `zone_id` — идентификатор зоны, в которой будет находиться этот набор записей. Обязательный параметр.
        * `name` — доменное имя. Обязательный параметр.
        * `type` — тип DNS записи. Обязательный параметр.
        * `ttl` — время жизни записи (TTL, Time to live) в секундах до актуализации информации о значении записи. Необязательный параметр.
        * `data` — значение записи. Необязательный параметр.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_vpc_network" "foo" {}
     
     resource "yandex_dns_zone" "zone1" {
       name        = "my-public-zone"
       description = "Test public zone"
     
       labels = {
         label1 = "test-public"
       }
     
       zone    = "test.example-public2.com."
       public  = true
     }

     resource "yandex_dns_recordset" "rs1" {
       zone_id = yandex_dns_zone.zone1.id
       name    = "test.example-public.com."
       type    = "A"
       ttl     = 200
       data    = ["10.1.0.1"]
     }
     ```
   
     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, смотрите в [документации провайдера]({{ tf-provider-link }}/).


  1. Выполните проверку с помощью команды:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. Это проверочный этап: ресурсы не будут созданы. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  
       {% note alert %}
    
       Все созданные с помощью {{ TF }} ресурсы тарифицируются. Внимательно проверьте план.
    
       {% endnote %}
  
  1. Чтобы создать ресурсы выполните команду:
     ```
     terraform apply
     ```
     
  1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.
  
     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc dns zone get <имя зоны DNS>
     ```

- API

  Чтобы создать публичную зону DNS, воспользуйтесь методом REST API [create](../api-ref/DnsZone/create.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Create](../api-ref/grpc/dns_zone_service.md#Create).

{% endlist %}

Чтобы получить доступ к именам из публичной зоны, вам нужно делегировать домен. Укажите адреса серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}` в личном кабинете вашего регистратора.