# Deleting a resource

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.
   1. Select **{{ cdn-name }}**.
   1. Click the name of the desired resource.
   1. In the upper-right corner, click ![image](../../../_assets/basket.svg) **Delete**, then, in the window that opens, click **Delete**.

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
      ...
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

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a CDN resource created with {{ TF }}:
   1. Open the {{ TF }} configuration file and delete the section with the resource description.

      {% cut "An example of describing a CDN resource in the {{ TF }} configuration" %}

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

   1. In the command line, go to the directory with the {{ TF }} configuration file.
   1. Check the configuration using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```text
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can make sure than a CDN resource has been deleted in the [management console]({{ link-console-main }}) or via the [CLI](../../../cli/quickstart.md) command below:

      ```bash
      yc cdn resource list
      ```

- API

   To delete a resource, use the [delete](../../api-ref/Resource/delete.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/Delete](../../api-ref/grpc/resource_service.md#Delete) gRPC API call.

{% endlist %}