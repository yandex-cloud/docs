---
title: "How to create an origin group in {{ cdn-full-name }}"
description: "Follow this guide to create an origin group."
---

# Creating an origin group

To create an [origin group](../../concepts/origins.md):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a resource group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
   1. {% include [activate-provider](../../../_includes/cdn/activate-provider.md) %}
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}**.
   1. Click **{{ ui-key.yacloud.cdn.button_origins-group-create }}**.
   1. Enter a name for the group.
   1. Configure **{{ ui-key.yacloud.cdn.label_section-origins-list }}**:

      * Specify the **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}`, or `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`. For more information about types, see [{#T}](../../concepts/origins.md).
      * Specify an origin.
      * Select the **{{ ui-key.yacloud.cdn.field_origin-state }}**: `{{ ui-key.yacloud.cdn.value_active }}` or `{{ ui-key.yacloud.cdn.value_backup }}`. For more information about priorities, see [{#T}](../../concepts/origins.md#groups).
      * Add other origins if needed.

   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI origin group create command:

      ```
      yc cdn origin-group create --help
      ```

   1. Create an origin group in the default folder:

      ```
      yc cdn origin-group create --name <group_name> \
        --origin source=<origin_IP_address_or_domain_name>,enabled=true \
        --origin source=<origin_IP_address_or_domain_name>,enabled=true,backup=true
      ```

      Where `--origin` is the origin specification:
      * `source`: Origin IP address or domain name.
      * `enabled`: Origin enabled flag.
      * `backup`: Flag marking the origin as a backup. For more information about priorities, see [{#T}](../../concepts/origins.md#groups).

      Result:

      ```
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

      For more information about the `yc cdn origin-group create` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/origin-group/create.md).

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. Describe the properties of the `yandex_cdn_origin_group` resource in the configuration file:

      Here is an example of the configuration file structure:

      ```
      resource "yandex_cdn_origin_group" "my_group" {
        name = "<group_name>"
        use_next = true
        origin {
         source = "<IP_address_or_domain_name_of_origin_1>"
        }
        origin {
         source = "<IP_address_or_domain_name_of_origin_2>"
        }
        origin {
         source = "<IP_address_or_domain_name_of_origin_3>"
         backup = false
        }
      }
      ```

      Where:

      * `name`: Origin group name.
      * `use_next`: Use the next origin on the list.
      * `origin`: Origin specification:
         * `source`: Origin IP address or domain name.
         * `enabled`: Origin enabled flag.
         * `backup`: Flag marking the origin as a backup. For more information about priorities, see [{#T}](../../concepts/origins.md#groups).

      For more information about the resources that you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/cdn_origin_group).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new CDN resource using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc cdn origin-group list
      ```

- API {#api}

   Use the [create](../../api-ref/OriginGroup/create.md) REST API method for the [OriginGroup](../../api-ref/OriginGroup/index.md) resource or the [OriginGroupService/Create](../../api-ref/grpc/origin_group_service.md#Create) gRPC API call.

{% endlist %}
