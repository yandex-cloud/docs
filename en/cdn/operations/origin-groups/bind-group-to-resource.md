# Connecting an origin group to a resource

To connect an [origin group](../../concepts/origins.md#groups) to the [resource](../../concepts/resource.md), under **Content**, select **Origin group** when [creating](../resources/create-resource.md) or [updating resource settings](../resources/configure-basics.md).

## Connecting an origin group when creating a resource {#connect-while-creating}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a resource.

   1. Select the service **{{ cdn-name }}**.

   1. On the **CDN resources** tab, click **Create resource**.

   1. Under **Content**, select **Origin group**.

   1. Specify the other resource settings. For more information, see [{#T}](../resources/create-resource.md).

   1. Click **Create**.

- CLI

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
        folder_id: b1g86q4m5vej8lkljme5
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
        folder_id: b1g86q4m5vej8lkljme5
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
      yc cdn resource create --cname <resource domain name> \
        --origin-group-id <origin group ID> \
        --origin-protocol https
      ```

      Command parameters:

      * `origin-group-id`: Origin group ID.
      * `origin-protocol`: Origin protocol.

      Result:

      ```
      id: bc855oumelrqw3ceywih
      folder_id: b1g86q4m5vej8lkljme5
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

      For more information about the `yc cdn resource create` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/resource/create.md).

- Terraform

   If you don't have Terraform, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Describe the resource parameters in the `yandex_cdn_resource` configuration file.

      Example configuration file structure:

      ```
      provider "yandex" {
        token     = "<OAuth>"
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "<default availability zone>"
      }

      resource "yandex_cdn_resource" "my_resource" {
        cname = "<resource domain name>"
        active = true
        origin_protocol = "https"
         origin_group_id = <origin group ID>
      }
      ```

      For more information about the resources that you can create using Terraform, see the [provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/cdn_origin_group).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

   1. Create an origin group.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

## Connecting an origin group when editing resource settings {#connect-while-changing}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the resource is located.

   1. Select the service **{{ cdn-name }}**.

   1. On the **CDN resources** tab, click on the name of the desired resource.

   1. In the upper-right corner, click **Edit**.

   1. Under **Content**, select **Origin group**.

   1. Enter the other resource settings if needed. For more information, see [{#T}](../resources/configure-basics.md).

   1. Click **Save**.

- CLI

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
      - id: bc82xll34xuc4kymnpqq
        folder_id: b1g86q4m5vej8lkljme5
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

   1. Get a list of all origin groups in the default folder and select the `ID` of the appropriate group:

      ```
      yc cdn origin-group list --format yaml
      ```

      Result:

      ```
      - id: "90209"
        folder_id: b1g86q4m5vej8lkljme5
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
        folder_id: b1g86q4m5vej8lkljme5
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
      yc cdn resource update --id <resource ID> \
        --origin-group-id <origin group ID>
      ```

      Result:

      ```
      id: bc8krsk72icwnvyvs6c3
      folder_id: b1g86q4m5vej8lkljme5
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

      For more information about the `yc cdn resource update` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/resource/update.md).

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}