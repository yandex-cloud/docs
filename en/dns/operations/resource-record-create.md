# Creating a resource record

To create a [resource record](../concepts/resource-record.md) in a DNS zone:

{% list tabs %}

- Management console
  1. Open the **{{ dns-name }}** section in the folder where the DNS zone to create a record in is located.
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

{% endlist %}

When creating AAAA resource records, the service automatically normalizes IPv6 addresses by replacing the gaps between `:` with zeros. For example: `2001:db8::` → `2001:db8:0:0:0:0:0:0`.

