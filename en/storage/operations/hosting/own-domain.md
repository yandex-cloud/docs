---
title: Your own domain
description: Follow this guide to set up your own domain for hosting.
---

# Your own domain

You can use your own domain to publish a website, e.g., `example.com`.

To support your own domain:

1. Create a [bucket](../buckets/create.md). Name it the same as your domain, e.g., `example.com`.
1. {% include [setup-bucket.md](../../../_includes/storage/setup-bucket.md) %}
1. On the DNS server, create a public [DNS zone](../../../dns/concepts/dns-zone.md) and a [resource record](../../../dns/concepts/resource-record.md) to link your domain name to the bucket.

   {% include [storage-cloud-dns-domains](../../_includes_service/storage-cloud-dns-domains.md) %}

    {% list tabs group=instructions %}

    - {{ dns-full-name }} {#dns}

      {% note warning %}

      {{ dns-name }} usage is chargeable; for more information, see [{#T}](../../../dns/pricing.md).

      {% endnote %}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to use your own domain for.
      1. In the left-hand panel, select ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}** and go to the **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab.
      1. In **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**, under **{{ ui-key.yacloud.storage.bucket.website.title_connected-domains }}**, click **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}**.

          {% note info %}

          Under **{{ ui-key.yacloud.storage.bucket.website.title_connected-domains }}** in the **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}** section, you can see only those domains that were created through this interface. If a record was created in [{{ dns-name }}](../../../dns/quickstart.md), it will not appear there.

          {% endnote %}

      1. In the window that opens, click **{{ ui-key.yacloud.dns.button_zone-create }}** and select the domain zone of the same name with the bucket, e.g., `example.com.`. Click **{{ ui-key.yacloud.common.create }}**.
      1. Open **{{ ui-key.yacloud.dns.label_additional-settings }}**.
      1. In the **{{ ui-key.yacloud.dns.label_form-ttl }}** field, specify the resource record time to live or select a value from the list.
      1. Click **{{ ui-key.yacloud.common.create }}**.
      1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.
      
      To get access to public zone domain names, delegate the domain. To do this, specify these server addresses in your domain registrar account: `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}`.

      It may take some time to delegate the domain and update the resource records.

      You can also [create a DNS zone](../../../dns/operations/zone-create-public.md) and [resource record](../../../dns/operations/resource-record-create) using {{ dns-name }}.
      
      {% cut "Example of DNS zone and resource record parameters" %}

      DNS zone parameters:
      * Zone: `example.com.`
      * Type: `Public`

      Resource record parameters:

      | Name          | Type   | TTL | Value                      |
      |--------------|-------|-----|-------------------------------|
      | example.com. | ANAME | 600 | example.com.{{ s3-web-host }} |

      [ANAME](../../../dns/concepts/resource-record.md#aname) records allow second-level domains to be used for hosting. Unlike [CNAME](../../../dns/concepts/resource-record.md#cname) records, they do not restrict the use of other record types in the same zone. 

      {% endcut %}

    - Third-party DNS server {#third-party-dns-server}

      Example of DNS zone parameters:
      * Zone: `example.com.`
      * Type: `Public`
      
      [CNAME](../../../dns/concepts/resource-record.md#cname) resource record example: 

      ```text
      example.com CNAME example.com.{{ s3-web-host }}
      ```

      To use a CNAME resource record, make sure your domain name belongs to at least a third-level domain. This has to do with how CNAME records are processed on DNS hosting. For more information, see section 2.4 of [RFC 1912](https://www.ietf.org/rfc/rfc1912.txt).

      Updating the resource records may take some time.

    {% endlist %}


1. To make your website available over HTTPS:

    1. {% include [create-cert.md](../../../_includes/storage/create-cert.md) %}
       
       {% note info %}

       {{ certificate-manager-name }} usage is free of charge; for more information, see [{#T}](../../../certificate-manager/pricing.md).
       
       {% endnote %}
       
    1. {% include [add-cert.md](../../../_includes/storage/add-cert.md) %}

    {% include [redirect-https](../../../_includes/storage/redirect-https.md) %}

    
    {% include [tls-support-alert](../../../_includes/storage/tls-support-alert.md) %}



{% include [objects-access.md](../../../_includes/storage/objects-access.md) %}
