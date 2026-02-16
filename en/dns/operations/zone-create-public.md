---
title: How to create a public zone in {{ dns-full-name }}
description: In this tutorial, you will learn how to create a public DNS zone.
---

# Creating a public DNS zone

To create a public [DNS zone](../concepts/dns-zone.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create your DNS zone.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
  1. Specify zone settings:
     1. **{{ ui-key.yacloud.dns.label_zone }}**: Domain zone name. Note that it must end with a trailing dot. You cannot create top-level domain (TLD) zones. To create a domain name with non-Latin characters, use [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) encoding.
     1. **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.dns.label_public }}`.
     1. **{{ ui-key.yacloud.common.name }}** of the zone.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a new DNS zone:

  1. See the description of the CLI command for creating a DNS zone:

     ```bash
     yc dns zone create --help
     ```

  1. Create a new public DNS zone in the default folder:

     ```bash
     yc dns zone create --name <zone_name> \
       --zone <domain_zone>. \
       --public-visibility=true
     ```
     Where:

     * `--name`: Zone name. Note that the zone name must be unique within a folder. This is an optional parameter.
     * `--zone`: Domain zone name. Note that it must end with a trailing dot. You cannot create top-level domain (TLD) zones. To create a domain name with non-Latin characters, use [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) encoding. This is a required setting.
     * `--public-visibility`: Enable this flag to create a public zone.

     Result:

     ```text
     id: aet2q4fn8i8i********
     folder_id: aoerb349v3h4********
     created_at: "2021-03-03T19:07:08.685Z"
     name: production-zone
     zone: www.example.com.
     public_visibility: {}
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the resources you want to create:

     ```hcl
     resource "yandex_dns_zone" "zone1" {
       name        = "<zone_name>"
       description = "<zone_description>"

       labels = {
         label1 = "<zone_label>"
       }

       zone    = "<domain_zone>."
       public  = true
     }
     ```

     Where:

     * `name`: Zone name. Note that the zone name must be unique within a folder. This is an optional parameter.
     * `description`: Zone description. This is an optional parameter.
     * `labels`: DNS zone labels. This is an optional parameter.
     * `zone`: Domain zone name. Note that it must end with a trailing dot. You cannot create top-level domain (TLD) zones. To create a domain name with non-Latin characters, use [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) encoding. This is a required setting.
     * `public`: Zone visibility, public or private. This is an optional parameter.

     For more information about the `yandex_dns_zone` resource properties, see the [provider documentation]({{ tf-provider-resources-link }}/dns_zone).

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all required resources. You can check the new resources in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc dns zone get <zone_name>
     ```

- API {#api}

  To create a public DNS zone, use the [create](../api-ref/DnsZone/create.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/Create](../api-ref/grpc/DnsZone/create.md) gRPC API call.

{% endlist %}

To use domain names in the public DNS zone, you need to delegate it to authoritative name servers. Specify `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` server addresses in your registrar's account settings.