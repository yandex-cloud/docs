# Creating a public DNS zone

To create a public [DNS zone](../concepts/dns-zone.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you need to create a DNS zone.
   1. Select **{{ dns-name }}**.
   1. Click **Create zone**.
   1. Specify the zone settings:
      1. **Zone**: Domain zone. The zone name must end with a dot. You can't create public top-level domain (TLD) zones.
      1. **Type**: **Public**.
      1. Zone **name**.
   1. Click **Create**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a new DNS zone:

   1. View a description of the CLI create zone command:

      ```
      yc dns zone create --help
      ```

   1. Create a new public DNS zone in the default folder:

      ```
      yc dns zone create --name production-zone --zone www.example.com. --public-visibility
      ```

      Result:

      ```
      id: aet2q4fn8i8icfug97p0
      folder_id: aoerb349v3h4bupphtaf
      created_at: "2021-03-03T19:07:08.685Z"
      name: production-zone
      zone: www.example.com.
      public_visibility: {}
      ```

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of resources that you want to create:

      * DNS zone parameters:

        * `zone`: Domain zone. The zone name must end with a dot. You can't create public top-level domain (TLD) zones. Required parameter.
        * `folder_id`: ID of the folder to create a zone in. If not specified, the default folder is used. Optional.
        * `name`: Zone name. It must be unique within the folder. Optional.
        * `description`: Zone description. Optional.
        * `labels`: A set of DNS zone labels. Optional.
        * `public`: Zone visibility (public or internal). Optional.

      * DNS record parameters:

        * `zone_id`: ID of the zone where the record set will be located. Required parameter.
        * `name`: Domain name. Required parameter.
        * `type`: DNS record type. Required parameter.
        * `ttl`: Record time to live (TTL) in seconds before updating the record value. Optional.
        * `data`: Record value. Optional.

      Example configuration file structure:

      ```hcl
      resource "yandex_vpc_network" "foo" {}

      resource "yandex_dns_zone" "zone1" {
        name        = "my-public-zone"
        description = "Test public zone"

        labels = {
          label1 = "test-public"
        }

        zone    = "test.example-public2.com."
        public  = true
      }

      resource "yandex_dns_recordset" "rs1" {
        zone_id = yandex_dns_zone.zone1.id
        name    = "test.example-public.com."
        type    = "A"
        ttl     = 200
        data    = ["10.1.0.1"]
      }
      ```

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}).


   1. Run the check using the command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. This is a test step. No resources are created. If there are errors in the configuration, {{ TF }} points them out.

      {% note alert %}

      You're charged for all resources created using {{ TF }}. Check the plan carefully.

      {% endnote %}

   1. To create resources, run the command:
      ```
      terraform apply
      ```

   1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      {{ TF }} creates all the required resources. You can check that the resources are there using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc dns zone get <DNS zone name>
      ```

{% endlist %}

To get access to public zone domain names, you need to delegate the domain. Specify the addresses of the `ns1.yandexcloud.net` and `ns2.yandexcloud.net` servers in your personal dashboard at your registrar.