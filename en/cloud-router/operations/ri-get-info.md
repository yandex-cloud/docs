---
title: How to get information about a virtual router
description: In this tutorial, you will get information about a virtual router in {{ cr-name }}.
---

# Getting information about a virtual router

{% note info %}

You need the [cloud-router.viewer](../security/index.md#cloudrouter-viewer) role for this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [virtual router](../concepts/routing-instance.md).
  1. [Navigate]({{ link-console-main }}/link/cloud-router) to **{{ ui-key.yacloud.ui.constants.label_cloud-router_kBGNL }}**.
  1. Select the virtual router.
  1. The **{{ ui-key.yacloud.common.overview }}** tab will display information about the virtual router, along with its routed networks and prefixes.

- CLI {#cli}

  You can view information about a virtual router using the following commands:
  * [yc cloudrouter routing-instance get](../../cli/cli-ref/cloudrouter/cli-ref/routing-instance/get.md): Get information about a virtual router by its name or ID.
  * [yc cloudrouter routing-instance get-by-cic-private-connection-id](../../cli/cli-ref/cloudrouter/cli-ref/routing-instance/get-by-cic-private-connection-id.md): Get information about a virtual router using the ID of the {{ interconnect-full-name }} [private connection](../../interconnect/concepts/priv-con.md) to the virtual router.
  * [yc cloudrouter routing-instance get-by-vpc-network-id](../../cli/cli-ref/cloudrouter/cli-ref/routing-instance/get-by-vpc-network-id.md): Get information about a virtual router using the ID of the [cloud network](../../vpc/concepts/network.md#network) the virtual router ensures connectivity with.

  **yc cloudrouter routing-instance get**

  1. See the description of the CLI command for getting virtual router info:

      ```bash
      yc cloudrouter routing-instance get --help
      ```

  1. Get a list of virtual routers in a given [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

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

  1. Get information about a virtual router by providing its ID obtained in the previous step:

      ```bash
      yc cloudrouter routing-instance get cf3jqdc4gjpx********
      ```

      {% cut "Result:" %}

      {% include [ri-get-cli-output](../../_includes/cloud-router/ri-get-cli-output.md) %}

      {% endcut %}

  **yc cloudrouter routing-instance get-by-cic-private-connection-id**

  1. See the description of the CLI command for getting virtual router info:

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
  1. Get information about a virtual router by providing the ID of the private connection made to it:

      ```bash
      yc cloudrouter routing-instance get-by-cic-private-connection-id \
        --cic-prc-id cf3r5ke20fo0********
      ```

      {% cut "Result:" %}

      {% include [ri-get-cli-output](../../_includes/cloud-router/ri-get-cli-output.md) %}

      {% endcut %}

  **yc cloudrouter routing-instance get-by-vpc-network-id**

  1. See the description of the CLI command for getting virtual router info:

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
  1. Get information about a virtual router by specifying the ID of the cloud network to which it provides network connectivity:

      ```bash
      yc cloudrouter routing-instance get-by-vpc-network-id \
        --vpc-id enpcfncr6uld********
      ```

      {% cut "Result:" %}

      {% include [ri-get-cli-output](../../_includes/cloud-router/ri-get-cli-output.md) %}

      {% endcut %}

{% endlist %}