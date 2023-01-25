# Editing the basic settings of a resource

To edit the basic settings of a [resource](../../concepts/resource.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

   1. Select **{{ cdn-name }}**.

   1. Click the name of the desired resource.

   1. In the top right-hand corner, click ![image](../../../_assets/pencil.svg) **Edit**.

   1. Edit the resource settings.

      {% note warning %}

      You can't change the primary [domain name used for content distribution](../../concepts/resource.md#hostnames).

      {% endnote %}

   1. Click **Save**.

- CLI

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI update resource command:

      ```bash
      yc cdn resource update --help
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

   1. Edit the resource settings:

      ```bash
      yc cdn resource update <resource ID> \
        <flag> <new value>
      ```

      For more information about the `yc cdn resource update` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/resource/update.md).

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To update the parameters of a CDN resource created using {{ TF }}:

   1. Open the {{ TF }} configuration file and edit the fragment with the resource description.

      {% cut "An example of describing a CDN resource in the {{ TF }} configuration" %}

      ```hcl
      resource "yandex_cdn_resource" "my_resource" {
          cname               = "cdn1.yandex-example.ru"
          active              = false
          origin_protocol     = "https"
          secondary_hostnames = ["cdn-example-1.yandex.ru", "cdn-example-2.yandex.ru"]
          origin_group_id     = "<origin group ID>"
          ...
          options {
            edge_cache_settings = "345600"
            ignore_cookie       = true
            ...
          }
      }
      ```

      {% endcut %}

      For more information about `yandex_cdn_resource` parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/cdn_resource).

   1. In the command line, go to the directory with the {{ TF }} configuration file.

   1. Check the configuration using the command:
      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check the changes to the CDN resource in the [management console]({{ link-console-main }}) or using the [CLI](../../../cli/quickstart.md):

      ```
      yc cdn resource list
      ```

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}

## Examples {#examples}

{% list tabs %}

- CLI

   Change the protocol for origins from HTTP to HTTPS and select a Let's Encrypt® certificate:

   ```bash
   yc cdn resource update someidkfjqjfl325fw \
     --origin-protocol HTTPS \
     --lets-encrypt-gcore-ssl-cert
   ```

   Result:

   ```bash
   id: someidkfjqjfl325fw

   ...

   cname: testexample.com
   active: true

   ...

   origin_group_id: "89783"
   origin_group_name: My origins group
   origin_protocol: HTTPS
   ssl_certificate:
   type: LETS_ENCRYPT_GCORE
   status: CREATING
   ```

{% endlist %}