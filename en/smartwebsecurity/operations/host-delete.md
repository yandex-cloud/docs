# Disconnecting a security profile from a virtual host

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to disconnect a [security profile](../concepts/profiles.md) from a [{{ alb-full-name }}](../../application-load-balancer/) [virtual host](../../application-load-balancer/concepts/http-router.md#virtual-host).
   1. In the list of services, select **{{ sws-name }}**.
   1. Next to the profile you want to disconnect from the host, click ![options](../../_assets/options.svg) and select ![pencil](../../_assets/pencil.svg) **Edit profile data**.
   1. Go to the **Hosts connected to profile** tab.
   1. Next to the host from which you want to disconnect the profile, click ![options](../../_assets/options.svg) and select ![disconnect](../../_assets/smartwebsecurity/disconnect.svg) **Disconnect profile from host**.
   1. Confirm your action.
   1. Click **Save**.

{% endlist %}
