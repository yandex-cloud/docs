---
title: "How to get information about a DNS zone in {{ dns-full-name }}"
---

# Getting information about a DNS zone

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing your [DNS zone](../concepts/dns-zone.md).
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud.dns.label_zones-list }}**.
   1. Select the DNS zone you need.
   1. Go to the **{{ ui-key.yacloud.common.overview }}** tab.
   1. The **{{ ui-key.yacloud.common.overview }}** page will display detailed information about the DNS zone.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To find out the name or unique ID of a [DNS zone](../concepts/dns-zone.md), [get](zone-list.md) a list of zones in the folder.

   1. View the description of the CLI command to get information about a DNS zone:

      ```bash
      yc dns zone get --help
      ```

   1. Get information about a DNS zone by specifying its name or ID:

      ```bash
      yc dns zone get <DNS_zone_name>
      ```

      Result:

      ```bash
      id: dns6oh57qm9n********
      folder_id: f01derqpemb4********
      created_at: "2023-11-02T08:34:58.493Z"
      name: example.com.
      zone: example-zone-name
      public_visibility: {}
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To get information about a [DNS zone](../concepts/dns-zone.md) using {{ TF }}:

   1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_dns_zone" "my_zone" {
        dns_zone_id = "<DNS_zone_ID>"
      }

      output "public" {
        value = data.yandex_dns_zone.my_zone.public
      }
      ```

      Where:
      * `data "yandex_dns_zone"`: Description of the DNS zone as a data source:
         * `dns_zone_id`: DNS zone ID.
      * `output "zone"`: Output variable that contains information about the DNS zone type:
         * `value`: Returned value.

      You can replace `public` with any other parameter to get the information you need. For more information about the `yandex_dns_zone` data source parameters, see the [provider documentation]({{ tf-provider-datasources-link }}/datasource_dns_zone).
   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```text
      public = false
      ```

- API {#api}

   To get detailed information about a [DNS zone](../concepts/dns-zone.md), use the [get](../api-ref/DnsZone/get.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/Get](../api-ref/grpc/dns_zone_service.md#Get) gRPC API call.

{% endlist %}
