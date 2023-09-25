# Connecting a security profile to a virtual host

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), choose the folder where you want to connect a [security profile](../concepts/profiles.md) to a [{{ alb-full-name }}](../../application-load-balancer/) [virtual host](../../application-load-balancer/concepts/http-router.md#virtual-host).
   1. In the list of services, select **{{ sws-name }}**.
   1. Next to the profile you want to connect to the host, click ![options](../../_assets/options.svg) and select ![pencil](../../_assets/pencil.svg) **Edit profile data**.

      {% include [host-connect](../../_includes/smartwebsecurity/host-connect.md) %}

   1. Click **Save**.

{% endlist %}

{% include [auto-scaling-tip](../../_includes/smartwebsecurity/auto-scaling-tip.md) %}
