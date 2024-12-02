# Connecting an origin group to a resource

To connect an [origin group](../../concepts/origins.md#groups) to a [resource](../../concepts/resource.md), under **{{ ui-key.yacloud.cdn.label_section-content }}**, select the appropriate **Origin group** when [creating](../resources/create-resource.md) or [updating resource settings](../resources/configure-basics.md).

## Connecting an origin group when creating a resource {#connect-while-creating}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a resource.

  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Click **{{ ui-key.yacloud.cdn.button_resource-create }}**.

  1. Under **{{ ui-key.yacloud.cdn.label_section-content }}**, select `{{ ui-key.yacloud.cdn.value_query-type-group-origin }}` in the **{{ ui-key.yacloud.cdn.label_content-query-type }}** field.

  1. Select an origin group.

  1. Specify the other resource settings. For more information, see [{#T}](../resources/create-resource.md).

  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI create resource command:

     ```
     yc cdn resource create --help
     ```
  
  1. Get a list of all origin groups in the default folder:

     ```
     yc cdn origin-group list --format yaml
     ```

     Result:

     ```
     - id: "90209"
       folder_id: b1g86q4m5vej********
       name: test-group-1
       use_next: true
       origins:
       - id: "561547"
         origin_group_id: "90209"
         source: www.example2.com
         enabled: true
         backup: true
       - id: "561546"
         origin_group_id: "90209"
         source: www.example1.com
         enabled: true
     - id: "90208"
       folder_id: b1g86q4m5vej********
       name: test-group
       use_next: true
       origins:
       - id: "561545"
         origin_group_id: "90208"
         source: www.a2.com
         enabled: true
         backup: true
       - id: "561544"
         origin_group_id: "90208"
         source: www.a1.com
         enabled: true
     ```
  
  1. Create a resource with the connected origin group:

     ```
     yc cdn resource create --cname <resource_domain_name> \
       --origin-group-id <origin_group_ID> \
       --origin-protocol https
     ```

     Where:

     * `--origin-group-id`: Origin group ID.
     * `--origin-protocol`: Protocol for origins.

     Result:

     ```
     id: bc855oumelrq********
     folder_id: b1g86q4m5vej********
     cname: res1.example.com
     created_at: "2022-01-15T15:13:42.827643Z"
     updated_at: "2022-01-15T15:13:42.827671Z"
     active: true
     options:
       edge_cache_settings:
         enabled: true
         default_value: "345600"
       cache_http_headers:
         value:
         - accept-ranges
         - cache-control
         - connection
         - content-encoding
         - content-length
         - content-type
         - date
         - etag
         - expires
         - keep-alive
         - last-modified
         - server
         - vary
       stale:
         enabled: true
         value:
         - error
         - updating
       allowed_http_methods:
         value:
         - GET
         - POST
         - HEAD
         - OPTIONS
     origin_group_id: "90208"
     origin_group_name: test-group-22
     origin_protocol: HTTPS
     ssl_certificate:
       type: DONT_USE
       status: READY
     ```

     For more information about the `yc cdn resource create` command, see the [CLI reference](../../../cli/cli-ref/cdn/cli-ref/resource/create.md).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Describe the parameters of the `yandex_cdn_resource` resource in the configuration file:

     Here is an example of the configuration file structure:


     ```
     provider "yandex" {
       token     = "<OAuth_token>"
       cloud_id  = "<cloud_ID>"
       folder_id = "<folder_ID>"
       zone      = "<default_availability_zone>"
     }

     resource "yandex_cdn_resource" "my_resource" {
       cname = "<resource_domain_name>"
       active = true
       origin_protocol = "https"
	    origin_group_id = <origin_group_ID>
     }
     ```


     
     For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/cdn_origin_group).

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Create an origin group.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  To add an origin group when creating a resource, use the [create](../../api-ref/Resource/create.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/Create](../../api-ref/grpc/Resource/create.md) gRPC API call.

{% endlist %}

## Connecting an origin group when editing resource settings {#connect-while-changing}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Click the resource name.

  1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.

  1. Select an origin group.

  1. Enter the other resource settings if needed. For more information, see [{#T}](../resources/configure-basics.md). 

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI update resource command:

     ```
     yc cdn resource update --help
     ```

  1. Get a list of all resources in the default folder:

     ```
     yc cdn resource list --format yaml
     ```

     Result:

     ```
     - id: bc82xll34xuc********
       folder_id: b1g86q4m5vej********
       cname: res1.example.com
       created_at: "2022-01-21T08:17:48.850086Z"
       updated_at: "2022-01-21T08:17:48.850125Z"
       active: true
       options:
         edge_cache_settings:
           enabled: true
           default_value: "345600"
         cache_http_headers:
           value:
           - accept-ranges
           - cache-control
           - connection
           - content-encoding
           - content-length
           - content-type
           - date
           - etag
           - expires
           - keep-alive
           - last-modified
           - server
           - vary
         stale:
           enabled: true
           value:
           - error
           - updating
         allowed_http_methods:
           value:
           - GET
           - POST
           - HEAD
           - OPTIONS
       origin_group_id: "90208"
       origin_group_name: test-group
       origin_protocol: HTTPS
       ssl_certificate:
         type: DONT_USE
         status: READY
     ```
  
  1. Get a list of all origin groups in the default folder and select `ID` of the appropriate group:

     ```
     yc cdn origin-group list --format yaml
     ```

     Result:

     ```
     - id: "90209"
       folder_id: b1g86q4m5vej********
       name: test-group-1
       use_next: true
       origins:
       - id: "561547"
         origin_group_id: "90209"
         source: www.example2.com
         enabled: true
         backup: true
       - id: "561546"
         origin_group_id: "90209"
         source: www.example1.com
         enabled: true
     - id: "90208"
       folder_id: b1g86q4m5vej********
       name: test-group
       use_next: true
       origins:
       - id: "561545"
         origin_group_id: "90208"
         source: www.a2.com
         enabled: true
         backup: true
       - id: "561544"
         origin_group_id: "90208"
         source: www.a1.com
         enabled: true
     ```

  1. Update resource settings by specifying the ID of the origin group:

     ```
     yc cdn resource update \
       --id <resource_ID> \
       --origin-group-id <origin_group_ID>
     ```

     Result:

     ```
     id: bc8krsk72icw********
     folder_id: b1g86q4m5vej********
     cname: res2.example.com
     created_at: "2022-01-15T15:29:19.103653Z"
     updated_at: "2022-01-15T15:33:22.819916Z"
     active: true
     options:
       edge_cache_settings:
         enabled: true
         default_value: "345600"
       cache_http_headers:
         value:
         - accept-ranges
         - cache-control
         - connection
         - content-encoding
         - content-length
         - content-type
         - date
         - etag
         - expires
         - keep-alive
         - last-modified
         - server
         - vary
       stale:
         enabled: true
         value:
         - error
         - updating
       allowed_http_methods:
         value:
         - GET
         - POST
         - HEAD
         - OPTIONS
     origin_group_id: "90209"
     origin_group_name: test-group-1
     origin_protocol: HTTPS
     ssl_certificate:
       type: DONT_USE
       status: READY
     ```

     For more information about the `yc cdn resource update` command, see the [CLI reference](../../../cli/cli-ref/cdn/cli-ref/resource/update.md).

- API {#api}

  To add an origin group when editing resource settings, use the [update](../../api-ref/Resource/update.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/Update](../../api-ref/grpc/Resource/update.md) gRPC API call.

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}
