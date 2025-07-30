---
title: How to start, stop, and restart a server in {{ baremetal-full-name }}
description: In this tutorial, you will learn how to start, stop, and restart a leased {{ baremetal-full-name }} server.
---

# How to start, stop, and restart a server

## Stopping {#stop}

To stop a server:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your server.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Find the server you need in the list, click ![image](../../../_assets/console-icons/ellipsis.svg) in its row, then select **{{ ui-key.yacloud.common.stop }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.stop }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the command to stop the server:

      ```bash
      yc baremetal server power-off --help
      ```

   1. Run this command:

      ```bash
      yc baremetal server power-off <server_name_or_ID>
      ```

{% endlist %}

## Starting {#start}

To start a stopped server:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the stopped server belongs to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Find the server you need in the list, click ![image](../../../_assets/console-icons/ellipsis.svg) in its row, then select **{{ ui-key.yacloud.common.start }}**.

- CLI {#cli}

   1. View the description of the command to start the server:

      ```bash
      yc baremetal server power-on --help
      ```

   1. Run this command:

      ```bash
      yc baremetal server power-on <server_name_or_ID>
      ```

{% endlist %}

## Restarting {#restart}

To restart a server:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your server.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Find the server you need in the list, click ![image](../../../_assets/console-icons/ellipsis.svg) in its row, then select **{{ ui-key.yacloud.baremetal.action_reboot-server }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.baremetal.action_reboot-server }}**. The server status will change to `Restarting`.

- CLI {#cli}

   1. View the description of the command to restart the server:

      ```bash
      yc baremetal server reboot --help
      ```

   1. Run this command:

      ```bash
      yc baremetal server reboot <server_name_or_ID>
      ```

{% endlist %}