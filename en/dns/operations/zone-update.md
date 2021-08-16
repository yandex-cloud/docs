# Updating a DNS zone

After creating a [DNS zone](../concepts/dns-zone.md), you can update it: rename the zone, add a description, or select other networks for it.

To update a DNS zone:

{% list tabs %}

- Management console
  1. Open the **{{ dns-name }}** section in the folder where you want to update a DNS zone.
  1. Click ![image](../../_assets/options.svg) in the row of the zone you want to update.
  1. In the menu that opens, click **Edit**.
  1. Update the zone parameters, for example, change its visibility settings or add it to other networks.
  1. Click **Save**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update a DNS zone:

  1. View a description of the CLI's update zone command:

     ```
     yc dns zone update --help
     ```

  1. Change the visibility of the zone in the networks:

     ```
     yc dns zone update <zone name or ID> \
     --private-visibility network-ids=c645mh47vscba1d64tbs,
     ```

     Command execution result:

     ```
     id: aet29qhara5jeg45tbjg
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2021-02-21T09:21:03.935Z"
     name: <new zone name>
     zone: staging.
     private_visibility:
       network_ids:
       - c645mh47vscba1d64tbs
     ```

{% endlist %}

