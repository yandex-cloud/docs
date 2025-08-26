---
title: How to create an origin group in {{ cdn-full-name }}
description: Follow this guide to create an origin group.
---

# Creating an origin group

To create an [origin group](../../concepts/origins.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to host your origin group.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}**.
  1. Click **{{ ui-key.yacloud.cdn.button_origins-group-create }}**.
  1. Enter a name for the origin group.
  1. Configure **{{ ui-key.yacloud.cdn.label_section-origins-list }}**:
     * Specify the **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}`, or `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`. For more information about types, see [{#T}](../../concepts/origins.md).
     * Specify an origin.
     * Select the **{{ ui-key.yacloud.cdn.field_origin-state }}**: `{{ ui-key.yacloud.cdn.value_active }}` or `{{ ui-key.yacloud.cdn.value_backup }}`. For more information about priorities, see [{#T}](../../concepts/origins.md#groups).
     * Add other origins if needed.
  1. Select the [CDN provider](../../concepts/providers.md). The default provider is `{{ cdn-full-name }}`.

      {% include [provider-binding](../../../_includes/cdn/provider-binding.md) %}

      A CDN resource and its origin group must be associated with the same CDN provider.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the [CLI](../../../cli/) command to create an origin group:

     ```bash
     yc cdn origin-group create --help
     ```

  1. Create an origin group in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc cdn origin-group create --name <origin_group_name> \
       --origin source=<origin_IP_address_or_domain_name>,enabled=true \
       --origin source=<origin_IP_address_or_domain_name>,enabled=true,backup=true
     ```

     Where `--origin` is the [origin](../../concepts/resource.md) specification:
     * `source`: Origin [IP address](../../../vpc/concepts/address.md) or domain name.
     * `enabled`: Flag showing whether the origin is enabled.
     * `backup`: Flag showing whether the origin as a backup one. For more information about priorities, see [{#T}](../../concepts/origins.md#groups).

     Result:

     ```text
     id: "89018"
     folder_id: b1g86q4m5vej********
     name: test-group
     use_next: true
     origins:
     - id: "559295"
       origin_group_id: "89018"
       source: www.example2.com
       enabled: true
       backup: true
     - id: "559294"
       origin_group_id: "89018"
       source: www.example1.com
       enabled: true
     ```

     For more information about the `yc cdn origin-group create` command, see the [CLI reference](../../../cli/cli-ref/cdn/cli-ref/origin-group/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Define the parameters of the `yandex_cdn_origin_group` resource in the configuration file.

     Here is an example of the configuration file structure:

     ```hcl
     resource "yandex_cdn_origin_group" "my_group" {
       name = "<origin_group_name>"
       use_next = true
       origin {
        source = "<origin_1_IP_address_or_domain_name>"
       }
       origin {
        source = "<origin_2_IP_address_or_domain_name>"
       }
       origin {
        source = "<origin_3_IP_address_or_domain_name>"
        backup = false
       }
     }
     ```

     Where:
     * `name`: Origin group name.
     * `use_next`: Indicates whether to use the next [origin](../../concepts/resource.md) on the list.
     * `origin`: Origin specification:
       * `source`: Origin [IP address](../../../vpc/concepts/address.md) or domain name.
       * `enabled`: Flag showing whether the origin is enabled.
       * `backup`: Flag showing whether the origin as a backup one. For more information about priorities, see [{#T}](../../concepts/origins.md#groups).

     For more information about the resources you can create with {{ TF }}, see [this article]({{ tf-provider-resources-link }}/cdn_origin_group).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new CDN resource using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

     ```bash
     yc cdn origin-group list
     ```

- API {#api}

  If you have not created any origin groups before, connect to the CDN provider. To do this, use the [activate](../../api-ref/Provider/activate.md) REST API method for the [Provider](../../api-ref/Provider/index.md) resource or the [ProviderService/Activate](../../api-ref/grpc/Provider/activate.md) gRPC API call.

  Use the [create](../../api-ref/OriginGroup/create.md) REST API method for the [OriginGroup](../../api-ref/OriginGroup/index.md) resource or the [OriginGroupService/Create](../../api-ref/grpc/OriginGroup/create.md) gRPC API call.

{% endlist %}