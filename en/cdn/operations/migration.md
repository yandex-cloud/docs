---
noIndex: true
---

# Migrating CDN resources and origin groups to {{ cdn-full-name }}

Starting January 22, 2026, our {{ cdn-name }} partner, EdgeCenter, will stop providing CDN on the Yandex Cloud platform.

For this reason, you will need to migrate your CDN resources from EdgeCDN to {{ yandex-cloud }}. When switching, the [cost of using the service](../pricing.md) will remain the same. You can either do it on your own or as part of the [partial auto-migration process](#auto) we will complete by January 17, 2026.

To migrate your CDN resources and origin groups from the EdgeCDN [provider](../concepts/providers.md) to {{ cdn-full-name }}:
1. [Migrate the existing resource configuration](#copy-configuration).
1. [Edit the CNAME record](#cname).
1. [Check whether your resource works correctly](#check).

## Migrating the existing resource configuration {#copy-configuration}

<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplv65sb6shyvchwvqnu?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) housing your CDN resource managed by the EdgeCDN provider.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Click **{{ ui-key.yacloud.cdn.button_resource-create }}**.
  1. Under **{{ ui-key.yacloud.cdn.label_copy-config }}**, select your CDN resource managed by the EdgeCDN provider (the one you want to migrate to {{ cdn-full-name }}).

      {% note tip %}

      You can find the provider name under the resource domain name.

      {% endnote %}

  1. All settings will get populated automatically as per the original CDN resource configuration. You can adjust them, if required.

      {% note info %}

      When migrating from EdgeCDN to {{ cdn-full-name }}, you can keep your resource’s **{{ ui-key.yacloud.cdn.label_personal-domain }}**. The name must be unique across the resources of a single CDN provider.

      {% endnote %}

  1. Click **{{ ui-key.yacloud.common.continue }}**.
  1. If required, adjust the settings under **{{ ui-key.yacloud.cdn.label_resource-cache }}**, **{{ ui-key.yacloud.cdn.label_resource-http-headers }}**, and **{{ ui-key.yacloud.cdn.label_additional }}**, and then click **{{ ui-key.yacloud.common.continue }}**.

      Wait until this new CDN resource appears in the list as managed by {{ cdn-full-name }}.

      Apart from this new CDN resource, the system will also create a copy of your [origin group](../concepts/origins.md).

  1. If you uploaded a TLS certificate for the original CDN resource, select your new CDN resource that has {{ cdn-full-name }} as provider and make sure the **{{ ui-key.yacloud.cdn.label_certificate-type }}** section has your certificate name specified.
      
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

## Checking whether your resource works correctly {#check}

Once your CNAME record gets propagated across DNS servers, client requests will start arriving to your new CDN resource.

To check whether your resource works properly:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the CDN resource was created.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Select the CDN resource you previously created.
  1. Navigate to **{{ ui-key.yacloud.common.monitoring }}**.

{% endlist %}

## Partial auto-migration {#auto}

By January 17, 2026, we will automatically migrate your CDN resources by copying them with saved settings and transferring to {{ cdn-full-name }}.

All you will need to do is [replace](#cname) the CNAME domain record in your DNS hosting settings.

### See also {#see-also}

* [{#T}](../concepts/providers.md)
* [{#T}](./resources/copy-resource.md)
* [{#T}](./resources/get-stats.md)