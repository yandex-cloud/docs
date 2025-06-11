---
title: How to get DNS zone information in {{ dns-full-name }}
---

# Getting information about a DNS zone

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing your [DNS zone](../concepts/dns-zone.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud.dns.label_zones-list }}**.
  1. Select the DNS zone you need.
  1. Navigate to the **{{ ui-key.yacloud.common.overview }}** tab.
  1. You will see DNS zone details on the **{{ ui-key.yacloud.common.overview }}** page.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a [DNS zone](../concepts/dns-zone.md) ID or name, [retrieve](zone-list.md) a list of zones in the folder.

  1. See the description of the CLI command for getting DNS zone information:

      ```bash
      yc dns zone get --help
      ```

  1. To get DNS zone details, run the following command with its name or ID specified:

      ```bash
      yc dns zone get <DNS_zone_name>
      ```

      Result:

      ```text
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

  To get [DNS zone](../concepts/dns-zone.md) information using {{ TF }}:
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
     * `output "zone"`: Output variable with the DNS zone type information:
       * `value`: Return value.

     You can replace `public` with another variable to get the information you need. For more information about the `yandex_dns_zone` data source variables, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/dns_zone).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create the required resources and display their output variables. To check the results, run this command:

     ```bash
     terraform output
     ```

     Result:

     ```text
     public = false
     ```

- API {#api}

  To get [DNS zone](../concepts/dns-zone.md) details, use the [get](../api-ref/DnsZone/get.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/Get](../api-ref/grpc/DnsZone/get.md) gRPC API call.

{% endlist %}
