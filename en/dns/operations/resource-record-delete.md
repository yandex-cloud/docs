# Deleting a resource record

To delete a [resource record](../concepts/resource-record.md):

{% list tabs %}

- Management console
  1. Open the **{{ dns-name }}** section in the folder with the DNS zone to delete a record from.
  1. Select the zone from the list.
  1. Select **Records** in the menu on the left.
  1. Click ![image](../../_assets/options.svg) in the row of the record you want to delete.
  1. In the menu that opens, click **Delete**.
  1. In the window that opens, click **Delete**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI delete record command:

      ```
      yc dns zone delete-records --help
      ```

  1. Get a list of all records in the zone:

      ```
      yc dns zone list-records --name <DNS zone name>
      ```

  1. Delete a record:

     ```
     yc dns zone delete-records --name <DNS zone name> \
     --record "<domain name> <TTL> <record type> <value>"
     ```

{% endlist %}

