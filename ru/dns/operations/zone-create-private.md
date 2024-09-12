---
title: "Как создать внутреннюю зону DNS в {{ dns-full-name }}"
description: "Следуя данной инструкции, вы сможете создать внутреннюю зону DNS." 
---

# Создать внутреннюю зону DNS

Чтобы создать внутреннюю [зону DNS](../concepts/dns-zone.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется создать зону DNS.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}**.
  1. Задайте настройки зоны:
     1. **{{ ui-key.yacloud.dns.label_zone }}** — доменная зона. Название зоны должно заканчиваться точкой. Публичные зоны верхнего уровня (TLD-зоны) создавать нельзя. Чтобы создать доменную зону с нелатинскими символами, используйте кодировку [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode).
     1. **{{ ui-key.yacloud.common.type }}** — `{{ ui-key.yacloud.dns.label_private }}`. 
     1. Укажите сети, ресурсы из которых будут входить в создаваемую зону.
     1. **{{ ui-key.yacloud.common.name }}** зоны.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать новую зону DNS:

  1. Посмотрите описание команды CLI для создания зоны:

     ```bash
     yc dns zone create --help
     ```

  1. Создайте новую внутреннюю зону DNS в каталоге по умолчанию:

     ```bash
     yc dns zone create --name <имя_зоны> \
       --zone <доменная_зона>. \
       --private-visibility=true \
       --network-ids="<идентификатор_сети_1>","<идентификатор_сети_2>"
     ```

     Где:
     
     * `--name` — имя зоны. Должно быть уникальным внутри каталога. Необязательный параметр.
     * `--zone` — доменная зона. Название зоны должно заканчиваться точкой. Публичные зоны верхнего уровня (TLD-зоны) создавать нельзя. Чтобы создать доменную зону с нелатинскими символами, используйте кодировку [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode). Обязательный параметр.
     * `--private-visibility` — флаг для создания внутренней зоны.
     * `--network-ids` — идентификаторы сетей, ресурсы из которых будут входить в зону.

     Результат:

     ```text
     id: aet29qhara5j********
     folder_id: aoerb349v3h4********
     created_at: "2021-02-21T09:21:03.935Z"
     name: test-zone
     zone: staging.
     private_visibility:
       network_ids:
       - c645mh47vsc********
       - b335fbs4fvv********
     ``` 

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_dns_zone" "zone1" {
       name        = "<имя_зоны>"
       description = "<описание_зоны>"
     
       labels = {
         label1 = "<метка_зоны>"
       }

       zone    = "<доменная_зона>."
       public           = false
       private_networks = ["<идентификатор_сети_1>","<идентификатор_сети_2"]
     }
     ```

     Где:

     * `name` — имя зоны. Должно быть уникальным внутри каталога. Необязательный параметр.
     * `description` — описание зоны. Необязательный параметр.
     * `labels` — набор меток зоны DNS. Необязательный параметр.
     * `zone` — доменная зона. Название зоны должно заканчиваться точкой. Публичные зоны верхнего уровня (TLD-зоны) создавать нельзя. Чтобы создать доменную зону с нелатинскими символами, используйте кодировку [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode). Обязательный параметр.
     * `public` — видимость зоны: публичная или внутренняя. Необязательный параметр.
     * `private_networks` — идентификаторы сетей, которым доступны доменные имена из этой зоны. Необязательный параметр.
   
     Более подробно о параметрах ресурса `yandex_dns_zone` см. в [документации провайдера]({{ tf-provider-resources-link }}/dns_zone).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc dns zone get <имя_зоны>
     ```

- API {#api}

  Чтобы создать внутреннюю зону DNS, воспользуйтесь методом REST API [create](../api-ref/DnsZone/create.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Create](../api-ref/grpc/dns_zone_service.md#Create).

{% endlist %}
