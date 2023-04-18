# Creating a resource

To create a [resource](../../concepts/resource.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a resource.

   1. Select **{{ cdn-name }}**.

   1. If you don't have any CDN resources, click **Activate provider**. A connection is established automatically.

   1. Click **Create resource**.

   1. Under **Content**, select **Content query** `From one origin` or `From origin group`:

      * When requesting content `From one origin`, select an **Origin type**: `Server`, `Bucket`, or `L7 load balancer`. Specify an origin. For more information about types, see [{#T}](../../concepts/origins.md).

      * When requesting content from an `Origin group`, select an [origin group](../../concepts/origins.md#groups) or create a new one:
         * Click **Create new**.
         * Enter a **Group name**.
         * Configure **Origins**:
            * Specify the **Origin type**: `Server`, `Bucket`, or `L7 load balancer`. For more information about types, see [{#T}](../../concepts/origins.md).
            * Specify an origin.
            * Select the **Priority**: `Active` or `Backup`. For more information about priorities, see [{#T}](../../concepts/origins.md#groups).
         * Add other origins if needed.
         * Click **Create**. In the **Origin group** field, you will see the name of the created group.

      For more information, see [{#T}](../../concepts/origins.md).

   1. Under **Domain names for content distribution**, enter the **Domain name**. You can add multiple **Domain names**. Names containing characters other than ASCII (for example, Cyrillic) and [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) are supported. The first name is considered the primary domain name.

      {% note warning %}

      After you create a resource, you can't change the primary domain name.

      {% endnote %}

      In the settings of your DNS hosting, create CNAME records for the specified domain names using the value displayed at the bottom of the **Domain names for content distribution** section. For more information, see [{#T}](../../concepts/resource.md#hostnames).

   1. In the **Advanced** section:

      1. Select **Origin request protocol**.
      1. Select a client redirect method: `Don't use`, `HTTP to HTTPS`, or `HTTPS to HTTP`.
      1. Enable or disable **End-user access to content**.
      1. If you selected the `HTTP` protocol, under **Certificate type**, select `Don't use`. Otherwise, select `Let's Encrypt®` or `Your certificate`. For more information, see [{#T}](../../concepts/clients-to-servers-tls.md).
      1. Select a **Host header** value: `Primary domain name`, `Forward`, or select `Custom` and input the **Header value**. For more information, see [{#T}](../../concepts/servers-to-origins-host.md).

   1. Click **Create**.

- CLI

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. If it's your first time creating a resource, start by connecting to the provider:

      ```bash
      yc cdn provider activate --type gcore
      ```

   1. View a description of the CLI create resource command:

      ```bash
      yc cdn resource create --help
      ```

   1. Get a list of origin groups in the folder:

      ```bash
      yc cdn origin-group list --format yaml
      ```

      Result:

      ```bash
      - id: "90209"
        folder_id: somefolder7p3l5eobbd
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

   1. Create a resource:

      ```bash
      yc cdn resource create <resource domain name> \
        --origin-group-id <origin group ID> \
        --origin-protocol <protocol for origins>
      ```

      * Instead of the `--origin-group-id`, you can specify the origin domain name using the `--origin-custom-source` flag.
      * Possible `--origin-protocol` values are `HTTP`, `HTTPS`, and `MATCH` (same as the client's).

      For more information about the `yc cdn resource create` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/resource/create.md).

- {{ TF }}

   Make sure the CDN provider is activated before you start using CDN resources. You can activate it in the [management console]({{ link-console-main }}) or using the [YC CLI](../../../cli/quickstart.md) command:

   ```
   yc cdn provider activate --folder-id <folder ID> --type gcore
   ```

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of the CDN resource to create:

      
      ```hcl
      terraform {
        required_providers {
          yandex = {
            source  = "yandex-cloud/yandex"
            version = "0.69.0"
          }
        }
      }

      provider "yandex" {
        token     = "<OAuth>"
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "<availability zone>"
      }

      resource "yandex_cdn_resource" "my_resource" {
          cname               = "cdn1.yandex-example.ru"
          active              = false
          origin_protocol     = "https"
          secondary_hostnames = ["cdn-example-1.yandex.ru", "cdn-example-2.yandex.ru"]
          origin_group_id     = yandex_cdn_origin_group.my_group.id
      }
      ```



      Where:

      * `cname`: Primary domain name used for content distribution. This parameter is required.
      * `active`: Flag that indicates if content is available to end users. `True`: Content from the CDN is available to clients. Optional parameter, the default value is `true`.
      * `origin_protocol`: Origin protocol. Optional parameter, the default value is `http`.
      * `secondary_hostnames`: Additional domain names. This is an optional parameter.
      * `origin_group_id`: ID of the [origin group](../../concepts/origins.md). This parameter is required. Use the ID from the description of the origin group in the `yandex_cdn_origin_group` resource.

      For more information about `yandex_cdn_resource` parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/cdn_resource).

   1. In the command line, go to the directory with the {{ TF }} configuration file.

   1. Check the configuration using this command:
      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check the changes to the CDN resource in the [management console]({{ link-console-main }}) or using the [CLI](../../../cli/quickstart.md):

      ```
      yc cdn resource list
      ```

- API

   Use the [create](../../api-ref/Resource/create.md) REST API method for the [Resource](../../api-ref/Resource/index.md) resource or the [ResourceService/Create](../../api-ref/grpc/resource_service.md#Create) gRPC API call.

{% endlist %}

{% include [after-creation-tip](../../../_includes/cdn/after-creation-tip.md) %}

## Examples {#examples}

{% list tabs %}

- CLI

   Create a resource with HTTP:

   ```bash
   yc cdn resource create testexample.com \
     --origin-group-id 90209 \
     --origin-protocol HTTP
   ```

   Result:

   ```bash
   id: someidkfjqjfl325fw

   ...

   cname: testexample.com
   active: true

   ...

   origin_group_id: "90209"
   origin_group_name: test-group-1
   origin_protocol: HTTP
   ssl_certificate:
   type: DONT_USE
   status: READY
   ```

{% endlist %}
