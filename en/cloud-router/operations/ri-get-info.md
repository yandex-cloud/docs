---
title: How to get information about a routing instance
---

# Getting information about a routing instance

{% note info %}

You need the [cloud-router.viewer](../security/index.md#cloudrouter-viewer) role for this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command to get routing instance information:

      ```bash
      yc cloudrouter routing-instance get --help
      ```

  1. Get a list of `Routing Instance` objects (RIs) for the specified folder:

      ```bash
      yc cloudrouter routing-instance list --folder-id b1gqf2hjizv2jw****** 
      ```

      Result:

      ```text
      +----------------------+--------------------+--------+-----------------------+
      |          ID          |        NAME        | STATUS | PRIVATE CONNECTION ID |
      +----------------------+--------------------+--------+-----------------------+
      | cf3jqdc4gjpxig****** | routing-instance   | ACTIVE | euuiog88zphgsq******, |
      |                      |                    |        | euucr7p47329kq******  |
      +----------------------+--------------------+--------+-----------------------+
      ```

  1. Get information about the RI by specifying its ID you obtained in the previous step:

      ```bash
      # yc cloudrouter routing-instance get <RI_ID>
      yc cloudrouter routing-instance get cf3jqdc4gjpxig******
      ```

      Result:



      Where:
      * `id`: ID of the routing instance.
      * `name`: RI name.
      * `description`: RI description.
      * `folder_id`: ID of the cloud folder the RI was created in.
      * `region_id`: ID of the region the RI was created in.
      * `vpc_info`: Information about virtual networks and their IP prefixes with the prefixes grouped by [availability zone](../../overview/concepts/geo-scope.md). A routing instance may have one or more connected [virtual networks](../../vpc/concepts/network.md).
      * `cic_private_connection_info`: Information about [private connections](../../interconnect/concepts/priv-con.md) to this RI.
      * `status`: RI state. It may take the following values: 
        * `ACTIVE`: RI is active.
        * `CREATING`: RI is being created.
        * `UPDATING`: RI is being updated.
        * `DELETING`: RI is being deleted.

{% endlist %}
