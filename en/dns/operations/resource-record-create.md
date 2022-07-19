# Creating a resource record

To create a [resource record](../concepts/resource-record.md) in a DNS zone:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing the DNS zone to create a record in.
   1. Select **{{ dns-name }}**.
   1. Select the zone from the list.
   1. Click **Create record**.
   1. Set the record parameters:
      1. Domain name.
      1. [Record type](../concepts/resource-record.md#rr-types).
      1. Record TTL.
      1. Record value.
   1. Click **Create**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Run the command:

   ```bash
   yc dns zone add-records --name <DNS zone name> \
      --record "<domain name> <TTL> <record type> <value>"
   ```

   You can add multiple records at the same time.

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of resources that you want to create: You can add multiple records at the same time.

      ```hcl
      resource "yandex_vpc_network" "foo" {}

      resource "yandex_dns_zone" "zone1" {
        name        = "my-private-zone"
        description = "desc"

        labels = {
          label1 = "label-1-value"
        }

        zone             = "example.com."
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

      resource "yandex_dns_recordset" "rs2" {
        zone_id = yandex_dns_zone.zone1.id
        name    = "srv2"
        type    = "A"
        ttl     = 200
        data    = ["10.1.0.2"]
      }
      ```

      Where:

      * `yandex_dns_zone` parameters:

        * `zone`: Domain zone. The zone name must end with a dot. You can't create public top-level domain (TLD) zones. Required parameter.
        * `folder_id`: ID of the folder to create a zone in. If not specified, the default folder is used. Optional.
        * `name`: Zone name. It must be unique within the folder. Optional.
        * `description`: Zone description. Optional.
        * `labels`: A set of DNS zone labels. Optional.
        * `public`: Zone visibility (public or internal). Optional.
        * `private_networks`: For a public zone, specify the {{ vpc-name }} resources that this zone is visible to. Optional.

      * `yandex_dns_recordset` parameters:

        * `zone_id`: ID of the zone where the record set will be located. Required parameter.
        * `name`: Domain name. Required parameter.
        * `type`: DNS record type. Required parameter.
        * `ttl`: Record time to live (TTL) in seconds before updating the record value. Optional.
        * `data`: Record value. Optional.

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
      yc dns zone list-records <DNS zone name>
      ```

{% endlist %}

When creating AAAA resource records, the service automatically normalizes IPv6 addresses by replacing the gaps between `:` with zeros. For example: `2001:db8::` → `2001:db8:0:0:0:0:0:0`.
