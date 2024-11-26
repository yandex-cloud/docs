---
title: How to stop, start, or restart a server in {{ baremetal-full-name }}
description: Follow this guide to manage (stop, start, or restart) a leased {{ baremetal-full-name }} server.
---

# How to stop, start, or restart a server

## Stop {#stop}

To stop a server:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the server belongs to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the row with the server you need, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.stop }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.stop }}**.

{% endlist %}

## Start {#start}

The **{{ ui-key.yacloud.common.start }}** command starts a stopped server.

To start a server:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the stopped server belongs to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the row with the server you need, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.start }}**.

{% endlist %}

## Restart {#restart}

The **{{ ui-key.yacloud.baremetal.action_reboot-server }}** command reboots a server.

To restart a server:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the server belongs to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the row with the server you need, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.baremetal.action_reboot-server }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.baremetal.action_reboot-server }}**. The server status will change to `Restarting`.

{% endlist %}
