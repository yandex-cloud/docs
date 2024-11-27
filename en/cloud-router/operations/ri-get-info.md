---
title: How to get information about a routing instance
---

# Getting information about a routing instance

{% include [cr-api-access](../../_includes/cloud-router/cr-api-access.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to get routing instance information:

      ```bash
      yc cloudrouter routing-instance get --help
      ```

  1. Get a list of `Routing Instance` objects (RIs) for the specified folder:

      ```bash
      yc cloudrouter routing-instance list --folder-id b1gqf2hjizv2jwj4dnga 
      ```

      Result:

      ```text
      +----------------------+--------------------+--------+-----------------------+
      |          ID          |        NAME        | STATUS | PRIVATE CONNECTION ID |
      +----------------------+--------------------+--------+-----------------------+
      | cf3jqdc4gjpxigewc2rv | routing-instance   | ACTIVE | euuiog88zphgsq3c15pq, |
      |                      |                    |        | euucr7p47329kqxrp4kh  |
      +----------------------+--------------------+--------+-----------------------+
      ```

  1. Get information about the RI by specifying its ID you obtained in the previous step:

      ```bash
      # yc cloudrouter routing-instance get <RI_ID>
      yc cloudrouter routing-instance get cf3jqdc4gjpxig******
      ```

      Result:

      ```yml
      id: cf3jqdc4gjpxig******
      name: routing-instance
      description: '-'
      folder_id: b1gqf2hjizv2jw******
      region_id: ru-central1
      vpc_info:
        - vpc_network_id: enp0qpdijf4h2p******
          az_infos:
            - manual_info:
                az_id: ru-central1-a
                prefixes:
                  - 10.128.11.0/24
                  - 10.128.12.0/24
                  - 10.128.13.0/24
            - manual_info:
                az_id: ru-central1-b
                prefixes:
                  - 10.129.21.0/24
                  - 10.129.22.0/24
                  - 10.129.23.0/24
            - manual_info:
                az_id: ru-central1-d
                prefixes:
                  - 10.130.31.0/24
                  - 10.130.32.0/24
                  - 10.130.33.0/24
        - vpc_network_id: enp3vifnkc6l4******
          az_infos:
            - manual_info:
                az_id: ru-central1-a
                prefixes:
                  - 172.16.1.0/24
                  - 172.16.2.0/24
                  - 172.16.3.0/24
            - manual_info:
                az_id: ru-central1-b
                prefixes:
                  - 172.16.11.0/24
                  - 172.16.12.0/24
                  - 172.16.13.0/24
            - manual_info:
                az_id: ru-central1-d
                prefixes:
                  - 172.16.21.0/24
                  - 172.16.22.0/24
                  - 172.16.23.0/24
      cic_private_connection_info:
        - cic_private_connection_id: euuiog88zphgsq******
        - cic_private_connection_id: euucr7p47329kq******
      status: ACTIVE
      ```

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
        * `UPDATING`: RI is being deleted.

{% endlist %}
