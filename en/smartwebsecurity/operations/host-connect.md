---
title: "Connecting a security profile to a virtual host"
description: "Follow this guide to connect a security profile to a virtual host."
---

# Connecting a security profile to a virtual host

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), choose the folder where you want to connect a [security profile](../concepts/profiles.md) to an [{{ alb-full-name }}](../../application-load-balancer/) [virtual host](../../application-load-balancer/concepts/http-router.md#virtual-host).
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. Select the profile to connect to the host.
   1. Click ![plug](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
   1. In the window that opens, select:
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}**](../../application-load-balancer/concepts/application-load-balancer.md).
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}**](../../application-load-balancer/concepts/http-router.md).
      * **{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}**. You can connect the security profile to multiple virtual hosts at once.

         To connect the profile to another L7 load balancer, click **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_add-balancer }}**.
   1. Click **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**. If the selected hosts are already connected to another security profile, confirm the connection.

      In the **{{ ui-key.yacloud.smart-web-security.overview.title_connected-to-the-hosts }}** tab, you will see the connected virtual hosts.

{% endlist %}

{% include [auto-scaling-tip](../../_includes/smartwebsecurity/auto-scaling-tip.md) %}

### See also {#see-also}

* [{#T}](host-delete.md)
