---
title: How to get information about a routing instance
---

# Getting information about a routing instance

{% note info %}

You need the [cloud-router.viewer](../security/index.md#cloudrouter-viewer) role for this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  You can view information about a routing instance using the following commands:
  * [yc cloudrouter routing-instance get](../../cli/cli-ref/cloudrouter/cli-ref/routing-instance/get.md): Allows you to get information about a routing instance using its name or ID.
  * [yc cloudrouter routing-instance get-by-cic-private-connection-id](../../cli/cli-ref/cloudrouter/cli-ref/routing-instance/get-by-cic-private-connection-id.md): Allows you to get information about a routing instance using the ID of the {{ interconnect-full-name }} [private connection](../../interconnect/concepts/priv-con.md) to the routing instance.
  * [yc cloudrouter routing-instance get-by-vpc-network-id](../../cli/cli-ref/cloudrouter/cli-ref/routing-instance/get-by-vpc-network-id.md): Allows you to get information about a routing instance using the ID of the [cloud network](../../vpc/concepts/network.md#network) the routing instance ensures connectivity with.

  **yc cloudrouter routing-instance get**

  1. See the description of the CLI command to get routing instance information:

      ```bash
      yc cloudrouter routing-instance get --help
      ```

  1. Get the list of routing instances in the specified [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc cloudrouter routing-instance list \
        --folder-id <folder_ID>
      ```

      Result:

      ```text
      +----------------------+--------------------+--------+-----------------------+
      |          ID          |        NAME        | STATUS | PRIVATE CONNECTION ID |
      +----------------------+--------------------+--------+-----------------------+
      | cf3jqdc4gjpx******** | routing-instance   | ACTIVE | euuiog88zphg********, |
      |                      |                    |        | euucr7p47329********  |
      +----------------------+--------------------+--------+-----------------------+
      ```

  1. Get information about a routing instance by providing its ID obtained in the previous step:

      ```bash
      yc cloudrouter routing-instance get cf3jqdc4gjpx********
      ```

      {% cut "Result:" %}

      {% include [ri-get-cli-output](../../_includes/cloud-router/ri-get-cli-output.md) %}

      {% endcut %}

  **yc cloudrouter routing-instance get-by-cic-private-connection-id**

  1. See the description of the CLI command to get routing instance information:

      ```bash
      yc cloudrouter routing-instance get-by-cic-private-connection-id --help
      ```
  1. Get the list of private connections in the specified folder:

      ```bash
      yc cic private-connection list \
        --folder-id <folder_ID>
      ```

      Result:

      ```text
      +----------------------+------+----------------------+
      |          ID          | NAME | TRUNK CONNECTION ID  |
      +----------------------+------+----------------------+
      | cf3r5ke20fo0******** |      | cf3dcodot14p******** |
      | cf3r3mfr4bm5******** |      | cf3dcodot14p******** |
      +----------------------+------+----------------------+
      ```
  1. Get information about a routing instance by providing the ID of the private connection made to it:

      ```bash
      yc cloudrouter routing-instance get-by-cic-private-connection-id \
        --cic-prc-id cf3r5ke20fo0********
      ```

      {% cut "Result:" %}

      {% include [ri-get-cli-output](../../_includes/cloud-router/ri-get-cli-output.md) %}

      {% endcut %}

  **yc cloudrouter routing-instance get-by-vpc-network-id**

  1. See the description of the CLI command to get routing instance information:

      ```bash
      yc cloudrouter routing-instance get-by-vpc-network-id --help
      ```
  1. Get the list of cloud networks in the specified folder:

      ```bash
      yc vpc network list \
        --folder-id <folder_ID>
      ```

      Result:

      ```
      +----------------------+-------------+
      |          ID          |    NAME     |
      +----------------------+-------------+
      | enpcfncr6uld******** | my-network1 |
      | enpcuntrql7d******** | my-network2 |
      +----------------------+-------------+
      ```
  1. Get information about a routing instance by providing the ID of the cloud network the it ensures connectivity with:

      ```bash
      yc cloudrouter routing-instance get-by-vpc-network-id \
        --vpc-id enpcfncr6uld********
      ```

      {% cut "Result:" %}

      {% include [ri-get-cli-output](../../_includes/cloud-router/ri-get-cli-output.md) %}

      {% endcut %}

{% endlist %}