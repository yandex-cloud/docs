# Editing a virtual host connection for a security profile

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to edit a connection of a [security profile](../concepts/profiles.md) to a [{{ alb-full-name }}](../../application-load-balancer/) [virtual host](../../application-load-balancer/concepts/http-router.md#virtual-host).
   1. In the list of services, select **{{ sws-name }}**.
   1. Next to the profile to update a connection for, click ![options](../../_assets/options.svg) and select ![pencil](../../_assets/pencil.svg) **Edit profile data**.

   1. Click ![plug](../../_assets/smartwebsecurity/plug.svg) **Connect profile to host**.
   1. In the window that opens, edit:
      * [Load balancer](../../application-load-balancer/concepts/application-load-balancer.md)
      * [HTTP router](../../application-load-balancer/concepts/http-router.md)
      * Virtual hosts. You can connect the security profile to multiple virtual hosts at once.

         To connect the profile to another L7 load balancer, click **Add load balancer**.
   1. Click **Connect**. If the selected hosts are already connected to another security profile, confirm the connection.

      On the **Profile connected to hosts** tab, you will see the connected virtual hosts.
   1. Click **Save**.

{% endlist %}
