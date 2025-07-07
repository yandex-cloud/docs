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

{% endlist %}

## Starting {#start}

Use the **{{ ui-key.yacloud.common.start }}** command to start a server.

To start a server:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your server.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Find the server you need in the list, click ![image](../../../_assets/console-icons/ellipsis.svg) in its row, then select **{{ ui-key.yacloud.common.start }}**.

{% endlist %}

## Restarting {#restart}

Use the **{{ ui-key.yacloud.baremetal.action_reboot-server }}** command to restart a server.

To restart a server:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your server.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Find the server you need in the list, click ![image](../../../_assets/console-icons/ellipsis.svg) in its row, then select **{{ ui-key.yacloud.baremetal.action_reboot-server }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.baremetal.action_reboot-server }}**. The server status will change to `Restarting`.

{% endlist %}
