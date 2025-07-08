---
noIndex: true
---

# CDN providers

{{ cdn-full-name }} supports the following content delivery network providers:
* [EdgeCDN](https://edgecenter.ru/cdn) based on the external infrastructure of our partner, EdgeCenter. It is used by default.
* [{{ cdn-full-name }}](#yc-cdn) based on Yandex own technology. 

Both providers offer the same capabilities and support the same interfaces for resource and CDN origin management: the [management console]({{ link-console-main }}), [CLI](../cli-ref/index.md), [{{ TF }}](../tf-ref.md), and [API](../api-ref/authentication.md).

However, the metrics providers send to [{{ monitoring-full-name }}](../../monitoring/) are different:
* [EdgeCDN provider metrics](../metrics.md)
* [{{ cdn-full-name }} provider metrics](../metrics-yc.md)

This means the dashboards in {{ monitoring-name }} will also differ accordingly. For more information, see [{#T}](../operations/resources/get-stats.md).

## {{ cdn-full-name }} provider {#yc-cdn} 

{% note info %}

Until August 1, 2025, the {{ cdn-full-name }} provider is at the [Preview stage](../../overview/concepts/launch-stages.md) and free of charge. You can get access upon request.

{% endnote %}

With {{ cdn-full-name }}, you can leverage the advanced Yandex infrastructure for delivering content.

### Connecting to the {{ cdn-full-name }} provider {#connect-to-yc-cdn}

1. If you previously activated the EdgeCDN provider in your folder, [create](../../resource-manager/operations/folder/create.md) a new folder.

    {% note info %}

    You can use only one provider per folder. When you activate a provider, the folder will get a unique `cname` value to create CNAME [resource records](../../dns/concepts/resource-record.md#cname) for CDN resources.

    {% endnote %}

1. Connect to the provider:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder to connect to a CDN provider.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
      1. Click **{{ ui-key.yacloud.cdn.label_activate-provider-empty-container_action-text }}**.
      1. Select **{{ cdn-full-name }}** from the drop-down list.

          If there is no **{{ ui-key.yacloud.cdn.label_activate-provider-empty-container_action-text }}** button and you can create resources as well as origin groups, the provider has already been activated.

    - CLI {#cli}

      {% include [include](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
      Run this command:

      ```bash
      yc cdn provider activate --type ourcdn
      ```

    - API {#api}

      To activate the provider, use the [activate](../../cdn/api-ref/Provider/activate.md) REST API method for the [Provider](../../cdn/api-ref/Provider/index.md) resource or the [ProviderService/Activate](../../cdn/api-ref/grpc/Provider/activate.md) gRPC API call.

      In the body of your request, provide the following:

      ```json
      {
        "folderId": "<folder_ID>",
        "providerType": "ourcdn"
      }
      ```

    {% endlist %}

#### See also {#see-also}

* [{#T}](../quickstart.md)
* [{#T}](./index.md)