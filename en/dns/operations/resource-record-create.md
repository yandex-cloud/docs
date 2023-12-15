---
title: "How to create a resource record in {{ dns-full-name }}"
description: "Follow this guide to create a resource record."
---

# Creating a resource record

To create a [resource record](../concepts/resource-record.md) in a DNS zone:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing the DNS zone to create a record in.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
   1. Select the zone from the list.
   1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
   1. Set the record parameters:
      1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the record.
      1. Select a [record type](../concepts/resource-record.md#rr-types) from the drop-down list.
      1. In the **{{ ui-key.yacloud.dns.label_form-ttl }}** field, specify the record time to live or select a value from the list.
      1. Enter a **{{ ui-key.yacloud.dns.label_records }}** for the record.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Run the following command:

   ```bash
   yc dns zone add-records --name <DNS zone name> \
      --record "<domain name> <TTL> <record type> <value>"
   ```

   You can add multiple records at the same time.

- {{ TF }}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of resources that you want to create: You can add multiple records at the same time.

      ```hcl
      resource "yandex_vpc_network" "foo" {}

      resource "yandex_dns_zone" "zone1" {
        name        = "my-private-zone"
        description = "desc"

        labels = {
          label1 = "label-1-value"
        }

        zone             = "example.com."
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

      resource "yandex_dns_recordset" "rs2" {
        zone_id = yandex_dns_zone.zone1.id
        name    = "srv2"
        type    = "A"
        ttl     = 200
        data    = ["10.1.0.2"]
      }
      ```

      Where:

      1. `yandex_dns_zone` parameters:

         * `zone`: Domain zone. The zone name must end with a dot. You cannot create public top-level domain (TLD) zones. This is a required parameter.
         * `folder_id`: ID of the folder to create a zone in. If not specified, the default folder is used. This is an optional parameter.
         * `name`: Zone name. It must be unique within the folder. This is an optional parameter.
         * `description`: Zone description. This is an optional parameter.
         * `labels`: Set of DNS zone labels. This is an optional parameter.
         * `public`: Zone visibility (public or internal). This is an optional parameter.
         * `private_networks`: For a public zone, specify the {{ vpc-name }} resources that this zone is visible to. This is an optional parameter.

      1. `yandex_dns_recordset` parameters:

         * `zone_id`: ID of the zone where the record set will be located. This is a required parameter.
         * `name`: Domain name. This is a required parameter.
         * `type`: DNS record type. This is a required parameter.
         * `ttl`: Record time to live (TTL) in seconds before updating the record value. This is an optional parameter.
         * `data`: Record value. This is an optional parameter.

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Run a check using this command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. This is a test step. No resources are created. If the configuration contains any errors, {{ TF }} will point them out.

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
      yc dns zone list-records <DNS zone name>
      ```

- API

   To create a resource record in a DNS zone, use the [updateRecordSets](../api-ref/DnsZone/updateRecordSets.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateRecordSets](../api-ref/grpc/dns_zone_service.md#UpdateRecordSets) gRPC API call.

{% endlist %}

When creating AAAA resource records, the service automatically normalizes IPv6 addresses by replacing the gaps between `:` with zeros. For example: `2001:db8::` → `2001:db8:0:0:0:0:0:0`.

The service supports a single [TXT record](../concepts/resource-record.md#txt). The value of a resource TXT record cannot contain more than 255 characters per line and 1024 characters total. If a record contains more characters, split it into multiple values.
