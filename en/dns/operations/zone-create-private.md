---
title: How to create a private DNS zone in {{ dns-full-name }}
description: In this tutorial, you will learn how to create a private DNS zone.
---

# Creating a private DNS zone

To create a private [DNS zone](../concepts/dns-zone.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create your DNS zone.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
  1. Specify zone settings:
     1. **{{ ui-key.yacloud.dns.label_zone }}**: Domain zone name. Note that it must end with a trailing dot. You cannot create top-level domain (TLD) zones. To create a domain zone with non-Latin characters, use [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) encoding.
     1. **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.dns.label_private }}`.
     1. Specify the networks whose resources will belong to your new zone.
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

  1. Create a new private DNS zone in the default folder:

     ```bash
     yc dns zone create --name <zone_name> \
       --zone <domain_zone>. \
       --private-visibility=true \
       --network-ids="<network_1_ID>","<network_2_ID>"
     ```

     Where:

     * `--name`: Zone name. Note that the zone name must be unique within a folder. This is an optional parameter.
     * `--zone`: Domain zone name. Note that it must end with a trailing dot. You cannot create top-level domain (TLD) zones. To create a domain zone with non-Latin characters, use [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) encoding. This is a required setting.
     * `--private-visibility`: Enable this flag to create a private zone.
     * `--network-ids`: IDs of the networks whose resources will belong to the new zone.

     Result:

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

  1. In the configuration file, describe the resources you want to create:

     ```hcl
     resource "yandex_dns_zone" "zone1" {
       name        = "<zone_name>"
       description = "<zone_description>"

       labels = {
         label1 = "<zone_label>"
       }

       zone    = "<domain_zone>."
       public           = false
       private_networks = ["<network_1_ID>","<network_2_ID"]
     }
     ```

     Where:

     * `name`: Zone name. Note that the zone name must be unique within a folder. This is an optional parameter.
     * `description`: Zone description. This is an optional parameter.
     * `labels`: DNS zone labels. This is an optional parameter.
     * `zone`: Domain zone name. Note that it must end with a trailing dot. You cannot create top-level domain (TLD) zones. To create a domain zone with non-Latin characters, use [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) encoding. This is a required setting.
     * `public`: Zone visibility, public or private. This is an optional parameter.
     * `private_networks`: IDs of the networks that will have access to the new zone’s DNS records. This is an optional parameter.
   
     For more information about the `yandex_dns_zone` resource properties, see the [provider documentation]({{ tf-provider-resources-link }}/dns_zone).

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all required resources. You can check the new resources in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc dns zone get <zone_name>
     ```

- API {#api}

  To create a private DNS zone, use the [create](../api-ref/DnsZone/create.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/Create](../api-ref/grpc/DnsZone/create.md) gRPC API call.

{% endlist %}
