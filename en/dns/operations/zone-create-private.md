---
title: "How to create a private DNS zone in {{ dns-full-name }}"
description: "Follow this guide to create a private DNS zone."
---

# Creating a private DNS zone

To create a private [DNS zone](../concepts/dns-zone.md):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you need to create a DNS zone.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
   1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
   1. Specify the zone settings:
      1. **{{ ui-key.yacloud.dns.label_zone }}**: Domain zone. The zone name must end with a dot. You cannot create public top-level domain (TLD) zones. To create a domain zone with non-Latin characters, use [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) encoding.
      1. **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.dns.label_private }}`.
      1. Specify the networks whose resources will be included in the zone being created.
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

   1. Create a new private DNS zone in the default folder:

      ```
      yc dns zone create --name test-zone \
      --zone staging. \
      --private-visibility network-ids=<network_IDs_for_the_zone>
      ```

      Where `--private-visibility` refers to the IDs of the networks whose resources will be included in the zone.

      Result:

      ```
      id: aet29qhara5j********
      folder_id: aoerb349v3h4********
      created_at: "2021-02-21T09:21:03.935Z"
      name: test-zone
      zone: staging.
      private_visibility:
        network_ids:
        - c645mh47vsc********
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
         * `private_networks`: For a private zone, specify the {{ vpc-name }} resources that have access to domain names within this zone. This is an optional parameter.


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
        name        = "my-private-zone"
        description = "Test private zone"

        labels = {
          label1 = "test-private"
        }

        public           = false
        private_networks = [yandex_vpc_network.foo.id]
      }

      resource "yandex_dns_recordset" "rs1" {
        zone_id = yandex_dns_zone.zone1.id
        name    = "srv.example.com."
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

   To create a private DNS zone, use the [create](../api-ref/DnsZone/create.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/Create](../api-ref/grpc/dns_zone_service.md#Create) gRPC API call.

{% endlist %}
