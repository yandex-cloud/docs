---
title: How to cancel a server lease in {{ baremetal-full-name }}
description: Follow this guide to cancel a server lease in {{ baremetal-full-name }}.
---

# Canceling a server lease

After you cancel a lease, the server will continue to run until the end of the paid period and then will be deleted.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the server belongs to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the row with the server you need, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.baremetal.action_stop-prolongation-server }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.baremetal.action_stop-prolongation-server-dialog }}**.

{% endlist %}
