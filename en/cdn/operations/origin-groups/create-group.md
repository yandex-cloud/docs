# Creating an origin group

To create an [origin group](../../concepts/origins.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create a resource group in.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
   1. In the left-hand panel, select ![image](../../../_assets/cdn/origin-groups.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}**.
   1. Click **{{ ui-key.yacloud.cdn.button_origins-group-create }}**.
   1. Enter a name for the group.
   1. Configure **{{ ui-key.yacloud.cdn.label_section-origins-list }}**:
      * Specify the **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}`, or `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`. For more information about types, see [{#T}](../../concepts/origins.md).
      * Specify an origin.
      * Select the **{{ ui-key.yacloud.cdn.field_origin-state }}**: `{{ ui-key.yacloud.cdn.value_active }}` or `{{ ui-key.yacloud.cdn.value_backup }}`. For more information about priorities, see [{#T}](../../concepts/origins.md#groups).
      * Add other origins if needed.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI origin group create command:

      ```
      yc cdn origin-group create --help
      ```

   1. Create an origin group in the default folder:

      ```
      yc cdn origin-group create --name <group name> \
        --origin source=<origin IP address or domain name>,enabled=true \
        --origin source=<origin IP address or domain name>,enabled=true,backup=true
      ```

      Where `origin`: The origin specification:
      * `source`: The origin IP address or domain name.
      * `enabled`: Flag indicating whether an origin is enabled.
      * `backup`: Flag indicating whether an origin is a backup. For more information about priorities, see [{#T}](../../concepts/origins.md#groups).

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

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Describe the properties of the `yandex_cdn_origin_group` resource in the configuration file:

      Example of the configuration file structure:

      
      ```
      provider "yandex" {
        token     = "<OAuth>"
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "<default availability zone>"
      }

      resource "yandex_cdn_origin_group" "my_group" {
        name = "<group name>"
        use_next = true
        origin {
         source = "<origin 1 IP address or domain name>"
        }
        origin {
         source = "<origin 2 IP address or domain name>"
        }
        origin {
         source = "<origin 3 IP address or domain name>"
         backup = false
        }
      }
      ```



      For more information about the resources that you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/cdn_origin_group).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

   1. Create an origin group.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

- API

   Use the [create](../../api-ref/OriginGroup/create.md) REST API method for the [OriginGroup](../../api-ref/OriginGroup/index.md) resource or the [OriginGroupService/Create](../../api-ref/grpc/origin_group_service.md#Create) gRPC API call.

{% endlist %}
