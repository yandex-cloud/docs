# Deleting a DNS zone

To delete a [DNS zone](../concepts/dns-zone.md):

{% list tabs %}

- Management console
  1. Open the **{{ dns-name }}** section in the folder to delete a DNS zone from.
  1. Click ![image](../../_assets/options.svg) in the row of the zone you want to delete.
  1. In the menu that opens, click **Delete**.
  1. In the window that opens, click **Delete**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI delete zone command:

      ```
      yc dns zone delete --help
      ```

  1. Get a list of all DNS zones in the default folder:

      ```
      yc dns zone list
      ```

  1. Select the `ID` or `NAME` of the zone.

  1. Delete the zone from the default folder:

      ```
      yc dns zone delete <zone name or ID>
      ```

{% endlist %}

