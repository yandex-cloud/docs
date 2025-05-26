---
title: How to activate a {{ cdn-full-name }} provider
description: Follow this guide to activate a {{ cdn-full-name }} provider.
---

# Activating a {{ cdn-name }} provider

You can only create a CDN resource and origin group in a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) if this folder is connected to a CDN provider. When activating a CDN provider, the folder gets a unique `cname` value you need to create CNAME [resource records](../../dns/concepts/resource-record.md#cname) for CDN resources.

To connect a folder to a CDN provider and get a `cname` value:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to connect to a CDN provider.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. If the CDN provider is not activated yet, click **{{ ui-key.yacloud.cdn.label_activate-provider-empty-container_action-text }}**. CDN will be enabled automatically.

      If you do not see the **{{ ui-key.yacloud.cdn.label_activate-provider-empty-container_action-text }}** button but you can create resources and origin groups, it means the provider is already activated.

  1. The `cname` value for creating [resource records](../../dns/concepts/resource-record.md#cname) for CDN resources is displayed in the following sections:
      * **{{ ui-key.yacloud.cdn.label_section-domain }}** when creating a CDN resource.
      * **{{ ui-key.yacloud.cdn.label_dns-settings_title }}** on the CDN resource info page.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Activate a provider:

      ```bash
      yc cdn provider activate --type gcore
      ```

  1. Get the CNAME record for the CDN resource:

      ```bash
      yc cdn resource get-provider-cname
      ```

      Result:

      ```yaml
      cname: cl-ms6*****90.edgecdn.ru
      folder_id: b1gt6g8ht345********
      ```

- API {#api}

  To activate a provider, use the [activate](../../cdn/api-ref/Provider/activate.md) REST API method for the [Provider](../../cdn/api-ref/Provider/index.md) resource or the [ProviderService/Activate](../../cdn/api-ref/grpc/Provider/activate.md) gRPC API call.

  To get the `cname` value for a folder, use the [getProviderCName](../../cdn/api-ref/Resource/getProviderCName.md) REST API method for the [Resource](../../cdn/api-ref/Resource/index.md) resource or the [ResourceService/GetProviderCName](../../cdn/api-ref/grpc/Resource/getProviderCName.md) gRPC API call.

{% endlist %}