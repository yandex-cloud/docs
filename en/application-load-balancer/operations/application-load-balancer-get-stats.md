# Viewing L7 load balancer statistics

Load balancer [statistics](../concepts/application-load-balancer.md#stats) are automatically logged in the [{{ monitoring-full-name }}](../../monitoring/) metrics.

For a full list of metrics, see the [reference](../metrics.md).

## View general statistics {#summary}

{{ alb-name }} has general load balancer statistics available without itemization by associated resources.

To view the statistics:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the load balancer was created.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. Click the name of the load balancer you need.
   1. Go to the **{{ ui-key.yacloud.common.monitoring }}** tab.
   1. Select the dashboard: **{{ ui-key.yacloud.alb.label_tab-http-stats }}** or **{{ ui-key.yacloud.alb.label_tab-capacity-stats }}**.
   1. Select the time period to view statistics for: 1 hour, 3 hours, 1 day, 1 week, or 1 month.

{% endlist %}

## Viewing statistics itemized by resources {#resources}

{{ monitoring-name }} provides load balancer runtime statistics itemized by associated load balancer resources, such as HTTP routers, virtual hosts, routes, and so on.

To view the statistics:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the load balancer was created.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. Click the name of the load balancer you need.
   1. Go to the **{{ ui-key.yacloud.common.monitoring }}** tab.
   1. Select the dashboard: **{{ ui-key.yacloud.alb.label_tab-http-stats }}** or **{{ ui-key.yacloud.alb.label_tab-capacity-stats }}**.
   1. Click **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}**.
   1. Select the resources to view the statistics for:

      * **HTTP Router**: [HTTP router](../concepts/http-router.md).
      * **Virtual Host**: HTTP router virtual host.
      * **Route**: Virtual host route.
      * **Backend Group**: [Group of backends](../concepts/backend-group.md).
      * **Backend**: Backend.
      * **Zone**: Availability zone where the load balancer nodes are located. For more information, see [{#T}](../concepts/application-load-balancer.md#lb-location).

      If `*` is the value selected in the field, the dashboard will display aggregate statistics for all resources of the relevant type, such as all HTTP routers.

   1. Select the time period for which you wish to view statistics.
   1. If you need to configure the dashboard to autoupdate, click ![](../../_assets/monitoring/autorefresh.svg).

{% endlist %}
