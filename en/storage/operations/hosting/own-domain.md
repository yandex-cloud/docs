---
title: Custom domain
description: Follow this guide to set up a custom domain for hosting.
---

# Custom domain

You can use a custom domain, e.g., `example.com`, to publish your website.

To use a custom domain:

1. [Create](../buckets/create.md) a bucket. Name it the same as your domain, e.g., `example.com`.
1. {% include [setup-bucket.md](../../../_includes/storage/setup-bucket.md) %}
1. On the DNS server, create a public [DNS zone](../../../dns/concepts/dns-zone.md) and a [resource record](../../../dns/concepts/resource-record.md) to link your domain name to the bucket.

   {% include [storage-cloud-dns-domains](../../_includes_service/storage-cloud-dns-domains.md) %}

    {% list tabs group=instructions %}

    - {{ dns-full-name }} {#dns}

      {% note warning %}

      {{ dns-name }} usage is chargeable; for more information, see [{#T}](../../../dns/pricing.md).

      {% endnote %}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to use your custom domain for.
      1. In the left-hand panel, select ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}** and go to the **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab.
      1. In **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**, under **{{ ui-key.yacloud.storage.bucket.website.title_connected-domains }}**, click **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}**.

          {% note info %}

          Under **{{ ui-key.yacloud.storage.bucket.website.title_connected-domains }}** in the **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}** section, you can only see those domains that were created directly through this interface. Records created in [{{ dns-name }}](../../../dns/quickstart.md) will not be shown.

          {% endnote %}

      1. In the window that opens, click **{{ ui-key.yacloud.dns.button_zone-create }}** and select the domain zone that matches the bucket name, e.g., `example.com.`. Click **{{ ui-key.yacloud.common.create }}**.
      1. Expand **{{ ui-key.yacloud.dns.label_additional-settings }}**.
      1. In the **{{ ui-key.yacloud.dns.label_form-ttl }}** field, specify the resource record time to live or select a value from the list.
      1. Click **{{ ui-key.yacloud.common.create }}**.
      1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.
      
      To gain access to public zone domain names, delegate the domain by specifying the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` server addresses in your domain registrar account.

      Delegating a domain and updating resource records may take a while.

      You can also use {{ dns-name }}to [create a DNS zone](../../../dns/operations/zone-create-public.md) and [resource record](../../../dns/operations/resource-record-create).
      
      {% cut "Example of DNS zone and resource record parameters" %}

      DNS zone parameters:
      * Zone: `example.com.`
      * Type: `Public`

      Resource record parameters:

      | Name          | Type   | TTL | Value                      |
      |--------------|-------|-----|-------------------------------|
      | example.com. | ANAME | 600 | example.com.{{ s3-web-host }} |

      [ANAME](../../../dns/concepts/resource-record.md#aname) records enable using second-level domains for hosting. Unlike [CNAME](../../../dns/concepts/resource-record.md#cname) records, they do not restrict the use of other record types in the same zone. 

      {% endcut %}

    - Third-party DNS server {#third-party-dns-server}

      Here is an example of DNS zone parameters:
      * Zone: `example.com.`
      * Type: `Public`
      
      An example of a [CNAME](../../../dns/concepts/resource-record.md#cname) resource record looks like this: 

      ```text
      example.com CNAME example.com.{{ s3-web-host }}
      ```

      To use a CNAME resource record, make sure your domain name belongs to at least a third-level domain. This restriction is due to the way CNAME records are handled on DNS hosting platforms. For more information, see [RFC 1912](https://www.ietf.org/rfc/rfc1912.txt), section 2.4.

      Updating resource records may take a while.

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
