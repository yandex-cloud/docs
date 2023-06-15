# Your own domain

To publish a website, you can use your own domain, such as `example.com`.

To support your own domain:

1. [Create](../buckets/create.md) a bucket. Give it the same name as your domain, such as `example.com`.

1. {% include [setup-bucket.md](../../../_includes/storage/setup-bucket.md) %}

1. On the DNS server, create a public [DNS zone](../../../dns/concepts/dns-zone.md) and a [resource record](../../../dns/concepts/resource-record.md) to link your domain name to the bucket:

   {% list tabs %}

   - {{ dns-full-name }}

      1. In the [management console]({{ link-console-main }}), go to the bucket you want to use your own domain for.
      1. Go to ![website](../../../_assets/storage/website.svg) **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
      1. In **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**, under **{{ ui-key.yacloud.storage.bucket.website.title_connected-domains }}**, click **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}**.
      1. In the window that opens, click **{{ ui-key.yacloud.dns.button_zone-create }}** and select a domain zone that corresponds to the bucket name, such as `example.com`. Click **{{ ui-key.yacloud.common.create }}**.
      1. Open **{{ ui-key.yacloud.dns.label_additional-settings }}**.
      1. In the **{{ ui-key.yacloud.dns.label_form-ttl }}** field, specify the resource record time to live or select a value from the list.
      1. Click **{{ ui-key.yacloud.common.create }}**.
      1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

      To get access to public zone domain names, delegate the domain. To do this, in your domain registrar's account, specify the server addresses: `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}`.

      It may take some time to delegate the domain and update the resource records.

      You can also create a DNS zone and a resource record using {{ dns-name }} tools. For more information, see the [step-by-step guide for {{ dns-name }}](../../../dns/operations/).

      {% cut "Example of DNS zone and resource record parameters" %}

      DNS zone parameters:
      * Zone: `example.com`.
      * Type: `Public`.

      Resource record parameters:

      | Name | Type | TTL | Value |
      |--------------|-------|-----|-------------------------------|
      | example.com. | ANAME | 600 | example.com.{{ s3-web-host }} |

      [ANAME](../../../dns/concepts/resource-record.md#aname) records allow second-level domains to be used for hosting. Unlike [CNAME](../../../dns/concepts/resource-record.md#cname) records, they do not restrict the use of other record types in the same zone.

      {% endcut %}

   - Third-party DNS server

      Example of DNS zone parameters:
      * Zone: `example.com`.
      * Type: `Public`.

      [CNAME](../../../dns/concepts/resource-record.md#cname) resource record example:

      ```text
      example.com CNAME example.com.{{ s3-web-host }}
      ```

      To use a CNAME resource record, make sure your domain name belongs to at least a third-level domain. This has to do with how CNAME records are processed on DNS hosting. For more information, see section 2.4 of [RFC 1912](https://www.ietf.org/rfc/rfc1912.txt).

      Updating the resource records may take some time.

   {% endlist %}


1. To make your website available over HTTPS:

   1. {% include [create-cert.md](../../../_includes/storage/create-cert.md) %}
   1. {% include [add-cert.md](../../../_includes/storage/add-cert.md) %}

   {% include [redirect-https](../../../_includes/storage/redirect-https.md) %}


{% include [objects-access.md](../../../_includes/storage/objects-access.md) %}
