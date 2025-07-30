---
title: How to get {{ baremetal-full-name }} server information
description: 'Follow this guide to get information about the {{ baremetal-full-name }} server settings: server configuration, network settings, operating system, and other data.'
---

# Getting information about a server

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the server belongs to.
  1. In the list of services, go **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}** and, in the list of servers that opens, select the one you need.

      The page offers the following information:

      * Under **{{ ui-key.yacloud.common.overview }}**, general information about the server, including its name, ID, [status](../../concepts/servers.md#server-status), [availability zone](../../../overview/concepts/geo-scope.md), and [server pool](../../concepts/servers.md#server-pools).
      * Under **{{ ui-key.yacloud.baremetal.title_section-resources }}**, information about the server's hardware [configuration](../../concepts/server-configurations.md).
      * Under **{{ ui-key.yacloud.baremetal.title_section-server-marketplace-app }}**, information about the operating system installed on the server.
      * Under **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}**, information about the server's [public network](../../concepts/network.md#public-network), including the ID, type, and CIDR of the public subnet, default gateway address, and [MAC address](https://en.wikipedia.org/wiki/MAC_address) of the network interface in the public network.
      * Under **{{ ui-key.yacloud.baremetal.title_section-server-private-network }}**, information about the server's [private network](../../concepts/network.md#private-network), including the [private subnet](../../concepts/network.md#private-subnet), as well as the private IP and MAC address of the network interface in the private network.
      * Under **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}**, information about the terms of server lease, including lease period/duration and auto-renewal.
      * Under **{{ ui-key.yacloud.baremetal.title_section-backup }}** and **{{ ui-key.yacloud.baremetal.title_section-accesses }}**, information about the server's connection to [{{ backup-full-name }}](../../../backup/index.yaml) and public SSH key of the root user, respectively.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the command for getting information about a server:

      ```bash
      yc baremetal server get --help
      ```

   1. Get information about the server:

      ```bash
      yc baremetal server get <server_name_or_ID>
      ```

{% endlist %}

## Example {#example}

Get information about the server:

 {% list tabs group=instructions %}

 - CLI {#cli}

   ```bash
   yc baremetal server get demo-baremetal-server
   ```

   {% include [server-lease-cli-result](../../../_includes/baremetal/instruction-steps/server-lease-cli-result.md) %}

{% endlist %}