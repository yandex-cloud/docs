---
title: How to create a resource record in {{ dns-full-name }}
description: In this tutorial, you will learn how to create a resource record.
---

# Creating a resource record

[TXT records](../concepts/resource-record.md#txt) have a maximum length of 1024 characters.

To create a [resource record](../concepts/resource-record.md) in a DNS zone:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the DNS zone where you want to create a resource record.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Select the zone from the list.
  1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
  1. Specify the resource record settings:
     1. In the **{{ ui-key.yacloud.common.name }}** field, specify the record name.
     1. Select the [record type](../concepts/resource-record.md#rr-types) from the drop-down list.
     1. In the **{{ ui-key.yacloud.dns.label_form-ttl }}** field, select the record TTL (Time to Live) value from the dropdown list or specify a custom duration in seconds.
     1. Specify a **{{ ui-key.yacloud.dns.label_records }}** for the record.
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

  1. In the configuration file, describe the resources you want to create: You can add multiple entries at once.

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

     1. `yandex_dns_zone` settings:

        * `zone`: Domain zone. Note that the zone name must end with a trailing dot. You cannot create top-level domain (TLD) zones. This is a required setting.
        * `folder_id`: ID of the folder where you want to create your zone. If no folder is specified, the system will use the default one. This is an optional setting.
        * `name`: Zone name. Note that the zone name must be unique within the folder. This is an optional setting.
        * `description`: Zone description. This is an optional setting.
        * `labels`: DNS zone labels. This is an optional setting.
        * `public`: Zone visibility, public or private. This is an optional setting.
        * `private_networks`: For a public zone, specify the {{ vpc-name }} resources that can access this zone. This is an optional setting.

     1. `yandex_dns_recordset` settings:

        * `zone_id`: ID of the zone that will contain your resource records. This is a required setting.
        * `name`: Domain name. This is a required setting.
        * `type`: DNS record type. This is a required setting.
        * `ttl`: Record TTL (Time to Live), i.e., time in seconds before the record updates. This is an optional setting.
        * `data`: Record value. This is an optional setting.

     For more information about resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-link }}/).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
  
     {{ TF }} will create all required resources. You can check the new resources in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc dns zone list-records <zone_name>
     ```

- API {#api}

  To create a resource record in a DNS zone, use the [updateRecordSets](../api-ref/DnsZone/updateRecordSets.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateRecordSets](../api-ref/grpc/DnsZone/updateRecordSets.md) gRPC API call.

{% endlist %}

When creating AAAA resource records, the service automatically normalizes IPv6 addresses by filling omitted zeros between `:`, e.g., `2001:db8::` → `2001:db8:0:0:0:0:0:0`.
