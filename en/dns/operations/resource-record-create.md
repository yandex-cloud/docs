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

  Run the command:

  ```
  yc dns zone add-records --name <DNS zone name> \
  --record "<domain name> <TTL> <record type> <value>"
  ```

  You can add multiple records at the same time.

{% endlist %}

