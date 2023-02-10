# Creating an internal DNS zone

To create an internal [DNS zone](../concepts/dns-zone.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you need to create a DNS zone.
   1. Select **{{ dns-name }}**.
   1. Click **Create zone**.
   1. Specify the zone settings:
      1. **Zone**: Domain zone. The zone name must end with a dot.
      1. **Type**: Internal.
      1. Specify the networks whose resources will be included in the zone being created.
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

   1. Create a new internal DNS zone in the default folder:

      ```
      yc dns zone create --name test-zone \
      --zone staging. \
      --private-visibility network-ids=<network IDs for the zone>
      ```

      Result:

      ```
      id: aet29qhara5jeg45tbjg
      folder_id: aoerb349v3h4bupphtaf
      created_at: "2021-02-21T09:21:03.935Z"
      name: test-zone
      zone: staging.
      private_visibility:
        network_ids:
        - <network ID>
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
        * `private_networks`: For an internal zone, specify the {{ vpc-name }} resources that have access to domain names within this zone. Optional.

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
        name        = "my-private-zone"
        description = "Test private zone"

        labels = {
          label1 = "test-private"
        }

        public           = false
        private_networks = [yandex_vpc_network.foo.id]
      }

      resource "yandex_dns_recordset" "rs1" {
        zone_id = yandex_dns_zone.zone1.id
        name    = "srv.example.com."
        type    = "A"
        ttl     = 200
        data    = ["10.1.0.1"]
      }
      ```

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

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
