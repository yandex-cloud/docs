---
title: How to cancel a server lease in {{ baremetal-full-name }}
description: In this tutorial, you will learn how to cancel a server lease in {{ baremetal-full-name }}.
---

# Canceling a server lease

After canceling the lease, the server will remain active until the paid period ends, after which it will be automatically deleted.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your server.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Find the server you need in the list, click ![image](../../../_assets/console-icons/ellipsis.svg) in its row, then select **{{ ui-key.yacloud.baremetal.action_stop-prolongation-server }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.baremetal.action_stop-prolongation-server-dialog }}**.

{% endlist %}
