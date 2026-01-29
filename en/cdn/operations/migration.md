---
noIndex: true
---

# Migrating CDN resources and origin groups to {{ cdn-full-name }}

Starting January 22, 2026, our {{ cdn-name }} partner, EdgeCenter, will stop providing CDN on the Yandex Cloud platform.

{{ yandex-cloud }} will automatically migrate CDN resources and origin groups from EdgeCDN to {{ cdn-full-name }} by January 17, 2026. After the migration, the service will [cost](../pricing.md) the same.

To start using your migrated CDN resources and origin groups:
1. [Enable access to the content](#content-access).
1. [Verify your TLS certificate](#tls).
1. [Edit the CNAME record](#cname).
1. [Check origins for protection against information attacks](#ddos).
1. [Test the resource](#check).

## Enable access to the content {#content-access}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) housing your CDN resource from the EdgeCDN provider.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. In the list of resources, find your migrated CDN resource. Make sure its provider is `{{ cdn-full-name }}` and its primary domain name is the same as in EdgeCDN. 
  1. If the **Status** column of the migrated CDN resource says `Not active`, enable access to the content:
      1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the resource and select ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
      1. Under **Content**, enable access to the content and click **Save**.

  {% note info %}

  It may take up to 15 minutes for the new CDN server settings to take effect.

  {% endnote %}

{% endlist %}

## Verify your TLS certificate {#tls}

{% list tabs group=instructions %}

- Management console {#console}

  If a TLS certificate for the original CDN resource was previously uploaded, select the new CDN resource with {{ cdn-full-name }} for provider in the [management console]({{ link-console-main }}) and make sure your certificate is named in the **{{ ui-key.yacloud.cdn.label_certificate-type }}** section.
      
  {% note warning %}

  Previously, EdgeCDN supported issuing TLS certificates automatically for CDN resources. In CDN resource settings, such certificate type is shown as **{{ ui-key.yacloud.cdn.md_value_certificate-le }}**. 

  You cannot migrate such certificates from EdgeCDN to {{ cdn-full-name }}. Instead, [issue](../../certificate-manager/operations/managed/cert-create.md) a new Let's Encrypt^®^ certificate or [upload](../../certificate-manager/operations/import/cert-create.md) a custom one through {{ certificate-manager-full-name }} and specify it when migrating your CDN resource.

  {% endnote %}

{% endlist %}

## Editing the CNAME record {#cname}

1. Learn the current CNAME record value:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. Select the CDN resource with the {{ cdn-full-name }} provider you created.
      1. Under **{{ ui-key.yacloud.cdn.label_dns-settings_title }}**, copy the CNAME value, e.g., `{{ cname-example-yc }}`.

    {% endlist %}

1. In your DNS hosting settings, change the CNAME record value from the one pointing to the EdgeCDN domain name to the one pointing to {{ cdn-full-name }}.

    <br>

    > Example of the original record for EdgeCDN:
    > 
    > ```text
    > cdn.example.com. CNAME {{ cname-example-edge }}
    > ```
    > 
    > Example of the edited record for {{ cdn-full-name }}:
    > 
    > ```text
    > cdn.example.com. CNAME {{ cname-example-yc }}
    > ```

    {% note tip %}

    If you use {{ dns-full-name }} for DNS hosting, check out [this guide](../../dns/operations/resource-record-update.md).

    {% endnote %}

The new resource will start running properly after the CNAME record you edited on your DNS hosting gets propagated across DNS servers. This may take a few hours. For details, see [this section](../../cdn/concepts/resource.md#hostnames) on domain names for content distribution.

{% include [note-dns-aname](../../_includes/cdn/note-dns-aname.md) %}

## Check origins for protection against information attacks {#ddos}

If the origin you are adding to {{ cdn-full-name }} has information security measures in place, e.g., a firewall or DDoS protection, make sure [{{ cdn-full-name }} addresses](https://tech.cdn.yandex.net/prefixes/yc.json) are whitelisted.

## Test the resource {#check}

Once your CNAME record gets propagated across DNS servers, client requests will start arriving to your new CDN resource.

To check whether your resource works properly:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the CDN resource was created.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Select the CDN resource you previously created.
  1. Navigate to the **{{ ui-key.yacloud.common.monitoring }}** tab.

{% endlist %}

### See also {#see-also}

* [{#T}](./resources/copy-resource.md)
* [{#T}](./resources/get-stats.md)