# Deleting a resource

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

   1. Select **{{ cdn-name }}**.

   1. Click the name of the desired resource.

   1. In the top right-hand corner, click ![image](../../../_assets/basket.svg), **Delete**, and confirm the deletion.

- CLI

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI resource delete command:

      ```bash
      yc cdn resource delete --help
      ```

   1. Get a list of all resources in the default folder:

      ```bash
      yc cdn resource list --format yaml
      ```

      Result:

      ```bash
      id: someidkfjqjfl325fw
      folder_id: somefolder7p3l5eobbd
      cname: testexample.com
      created_at: "2022-01-19T09:23:57.921365Z"
      updated_at: "2022-01-19T10:55:30.305141Z"
      active: true
      options:
        edge_cache_settings:
          enabled: true
          default value: "345600"
        cache_http_headers:
          enabled: true
          value:
          - content-type
          - content-length
          - connection
          - server
          - date
          - test
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
      origin_group_id: "89783"
      origin_group_name: My origins group
      origin_protocol: HTTP
      ssl_certificate:
        type: DONT_USE
        status: READY
      ```

   1. Delete the resource:

      ```bash
      yc cdn resource delete <resource ID>
      ```

      For more information about the `yc cdn resource delete` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/resource/delete.md).

   1. Make sure that the delete operation was successful. To do this, view the folder's resource list again:

      ```bash
      yc cdn resource list
      ```

- Terraform

   If you don't have Terraform, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a CDN resource created with Terraform:

   1. Open the Terraform configuration file and delete the section with the resource description.

      {% cut "An example of describing a CDN resource in the Terraform configuration" %}

      ```hcl
      resource "yandex_cdn_resource" "my_resource" {
          cname               = "cdn1.yandex-example.ru"
          active              = false
          origin_protocol     = "https"
          secondary_hostnames = ["cdn-example-1.yandex.ru", "cdn-example-2.yandex.ru"]
          origin_group_id     = yandex_cdn_origin_group.my_group.id
          ...
          options {
            edge_cache_settings = "345600"
            ignore_cookie       = true
            ...
          }
      }
      ```

      {% endcut %}

   1. In the command line, go to the directory with the Terraform configuration file.

   1. Check the configuration using the command:
      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:
      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, Terraform points them out.

   1. Apply the configuration changes:
      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can make sure than a CDN resource has been deleted in the [management console]({{ link-console-main }}) or via the [CLI](../../../cli/quickstart.md) command below:

      ```
      yc cdn resource list
      ```
{% endlist %}