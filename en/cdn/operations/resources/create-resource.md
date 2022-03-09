# Creating a resource

To create a [resource](../../concepts/resource.md):

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a resource.
  1. Select **{{ cdn-name }}**.
  1. On the **CDN resources** tab, click **Create resource**.
  1. Under **Content**, enter the **Origin domain name** or select an **Origin group**.

     You can create a new origin group:
     1. Click **Create new**.
     1. Enter the **Group name**.
     1. Enter the **Origin domain name** and select **Active** or **Backup**.
     1. Add other origins if needed.
     1. Click **Create**. In the **Origin group** field, you will see the name of the created group.

     For more information, see [{#T}](../../concepts/origins.md).

  1. Under **Domain names for content distribution**, enter the **Domain name**. You can add multiple **Domain names**. The first name is considered the primary domain name.

     {% note warning %}

     After you create a resource, you can't change the primary domain name.

     {% endnote %}

     In the settings of your DNS hosting, create CNAME records for the specified domain names using the value displayed at the bottom of the **Domain names for content distribution** section. For more information, see the [{#T}](../../concepts/resource.md#hostnames).

  1. In the **Advanced** section:

      1. Select **Origin request protocol**.
      1. Enable or disable **End-user access to content**.
      1. If you have selected only the HTTP protocol, then in the **TLS certificate** field, select **Don't use**. Otherwise, select the **Let's Encrypt®** certificate. For more information, see [{#T}](../../concepts/clients-to-servers-tls.md).
      1. Select the value of the **Host header** or choose **Custom** and enter the **Header value**. For more information, see [{#T}](../../concepts/servers-to-origins-host.md).

  1. Click **Create**.

- CLI

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. If it's your first time creating a resource, start with connecting to the provider:

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
        --origin-protocol <origin protocol>
      ```

      * Instead of the `--origin-group-id`, you can specify the origin domain name using the `--origin-custom-source` flag.
      * Possible `--origin-protocol` values are `HTTP`, `HTTPS`, and `MATCH` (same as the client's).

      For more information about the `yc cdn resource create` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/resource/create.md).

- Terraform

  Make sure the CDN provider is activated before you start using CDN resources. You can activate it in the [management console]({{ link-console-main }}) or using the [YC CLI](../../../cli/quickstart.md) command:

  ```
  yc cdn provider activate --folder-id <folder ID> --type gcore
  ```

  If you don't have Terraform yet, [install it and configure the {{ yandex-cloud }} provider](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. In the configuration file, describe the parameters of a CDN resource to create:

      * `cname`: The primary domain name used for content distribution. Required parameter.
      * `active`: A flag that indicates if content is available to end users. `True`: CDN content is available to end users. Optional parameter, defaults to `True`.
      * `origin_protocol`: Origin protocol. Optional parameter, defaults to `HTTP`.
      * `secondary_hostnames`: Additional domain names. Optional.
      * `origin_group_id`: ID of the [origin group](../../concepts/origins.md). Required parameter. Use the ID from the description of the origin group in the `yandex_cdn_origin_group` resource.

      Example configuration file structure:

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

      For more information about the `yandex_cdn_resource` parameters in Terraform, see the [provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/cdn_resource).

  1. In the command line, go to the directory with the Terraform configuration file.

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

     The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, Terraform points them out.

  1. Apply the configuration changes:

     ```
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press  **Enter**.

     You can check if the CDN resource has changed in the [management console]({{ link-console-main }}) or using the [CLI](../../../cli/quickstart.md) command:

     ```
     yc cdn resource list
     ```

{% endlist %}

{% note info %}

To stop the created resource, [disable access](disable-resource.md) to the content for end users.

{% endnote %}

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