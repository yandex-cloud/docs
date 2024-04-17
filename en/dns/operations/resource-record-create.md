---
title: "How to create a resource record in {{ dns-full-name }}"
description: "Follow this guide to create a resource record."
---

# Creating a resource record

A [TXT record](../concepts/resource-record.md#txt) may not exceed 1,024 characters in length.

To create a [resource record](../concepts/resource-record.md) in a DNS zone:

{% list tabs group=instructions %}

- Management console {#console}

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

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Run this command:

   ```bash
   yc dns zone add-records --name <DNS_zone_name> \
     --record "<domain_name> <TTL> <record_type> <value>"
   ```

   **Example**

   Creating a TXT record with a DKIM signature:

   > ```bash
   > yc dns zone add-records test-zone \
   >   --record "test-record TXT v=DKIM1;k=rsa;p=MIIBIjAN...gkH2v1NTgQdTKfPmDK...YdRiwIDAQAB"
   > ```

   If your TXT record contains multiple values, enclose each one in double quotes (`""`):

   > ```bash
   > yc dns zone add-records test-zone \
   >   --record "test-record TXT v=DKIM1;k=rsa;p=MIIBIjAN""gkH2v1NTgQdTKfPmDK""YdRiwIDAQAB"
   > ```

- {{ TF }} {#tf}

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

      resource "yandex_dns_recordset" "rs_dkim" {
        zone_id = yandex_dns_zone.zone1.id
        name    = "dkim"
        type    = "TXT"
        ttl     = 200
        data    = ["v=DKIM1;k=rsa;t=s;p=MIIBIjAN...gkH2v1NTgQdTKfPmDK...YdRiwIDAQAB"]
      }
      ```

      Where:

      1. `yandex_dns_zone` parameters:

         * `zone`: Domain zone. The zone name must end with a dot. You cannot create public top-level domain (TLD) zones. This is a required parameter.
         * `folder_id`: ID of the folder to create a zone in. If not specified, the default folder is used. This is an optional parameter.
         * `name`: Zone name. It must be unique within the folder. This is an optional parameter.
         * `description`: Zone description. This is an optional parameter.
         * `labels`: Set of DNS zone labels. This is an optional parameter.
         * `public`: Zone visibility, public or private. This is an optional parameter.
         * `private_networks`: For a public zone, specify the {{ vpc-name }} resources that this zone is visible to. This is an optional parameter.

      1. `yandex_dns_recordset` parameters:

         * `zone_id`: ID of the zone where the record set will be located. This is a required parameter.
         * `name`: Domain name. This is a required parameter.
         * `type`: DNS record type. This is a required parameter.
         * `ttl`: Record time to live (TTL) in seconds before updating the record value. This is an optional parameter.
         * `data`: Record value. This is an optional parameter.

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc dns zone list-records <zone_name>
      ```

- API {#api}

   To create a resource record in a DNS zone, use the [updateRecordSets](../api-ref/DnsZone/updateRecordSets.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateRecordSets](../api-ref/grpc/dns_zone_service.md#UpdateRecordSets) gRPC API call.

{% endlist %}

When creating AAAA resource records, the service automatically normalizes IPv6 addresses by replacing the gaps between `:` with zeros. For example: `2001:db8::` → `2001:db8:0:0:0:0:0:0`.
