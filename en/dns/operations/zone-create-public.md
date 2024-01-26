---
title: "How to create a public zone in {{ dns-full-name }}"
description: "Follow this guide to create a public DNS zone."
---

# Creating a public DNS zone

To create a public [DNS zone](../concepts/dns-zone.md):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you need to create a DNS zone.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
   1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
   1. Specify the zone settings:
      1. **{{ ui-key.yacloud.dns.label_zone }}**: Domain zone. The zone name must end with a dot. You cannot create public top-level domain (TLD) zones. To create a domain zone with non-Latin characters, use [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) encoding.
      1. **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.dns.label_public }}`.
      1. **{{ ui-key.yacloud.common.name }}** of the zone.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a new DNS zone:

   1. View a description of the CLI create zone command:

      ```
      yc dns zone create --help
      ```

   1. Create a new public DNS zone in the default folder:

      ```
      yc dns zone create --name production-zone --zone www.example.com. --public-visibility
      ```

      Result:

      ```
      id: aet2q4fn8i8i********
      folder_id: aoerb349v3h4********
      created_at: "2021-03-03T19:07:08.685Z"
      name: production-zone
      zone: www.example.com.
      public_visibility: {}
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

      1. DNS zone parameters:

         * `zone`: Domain zone. The zone name must end with a dot. You cannot create public top-level domain (TLD) zones. To create a domain zone with non-Latin characters, use [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) encoding. This is a required parameter.
         * `folder_id`: ID of the folder to create a zone in. If not specified, the default folder is used. This is an optional parameter.
         * `name`: Zone name. It must be unique within the folder. This is an optional parameter.
         * `description`: Zone description. This is an optional parameter.
         * `labels`: Set of DNS zone labels. This is an optional parameter.
         * `public`: Zone visibility, public or private. This is an optional parameter.

      1. DNS record parameters:

         * `zone_id`: ID of the zone where the record set will be located. This is a required parameter.
         * `name`: Domain name. This is a required parameter.
         * `type`: DNS record type. This is a required parameter.
         * `ttl`: Record time to live (TTL) in seconds before updating the record value. This is an optional parameter.
         * `data`: Record value. This is an optional parameter.

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_vpc_network" "foo" {}

      resource "yandex_dns_zone" "zone1" {
        name        = "my-public-zone"
        description = "Test public zone"

        labels = {
          label1 = "test-public"
        }

        zone   = "test.example-public2.com."
        public = true
      }

      resource "yandex_dns_recordset" "rs1" {
        zone_id = yandex_dns_zone.zone1.id
        name    = "test.example-public.com."
        type    = "A"
        ttl     = 200
        data    = ["10.1.0.1"]
      }
      ```

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).


   1. Run a check using this command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. This is a test step; no resources will be created. If the configuration contains any errors, {{ TF }} will point them out.

      {% note alert %}

      You will be charged for all the resources created with {{ TF }}. Check the pricing plan carefully.

      {% endnote %}

   1. To create resources, run the command:
      ```
      terraform apply
      ```

   1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```
      yc dns zone get <zone_name>
      ```

- API {#api}

   To create a public DNS zone, use the [create](../api-ref/DnsZone/create.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/Create](../api-ref/grpc/dns_zone_service.md#Create) gRPC API call.

{% endlist %}

To get access to public zone domain names, you need to delegate the domain. Specify the addresses of `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` servers in your personal dashboard at your registrar.