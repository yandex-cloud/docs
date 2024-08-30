# Viewing L7 load balancer statistics

{{ alb-name }} automatically sends load balancer performance metrics to the [{{ monitoring-full-name }}](../../monitoring/) service.

For a full list of metrics, see the [reference](../metrics.md).

## View general statistics {#summary}

{{ alb-name }} has general load balancer statistics available without itemization by associated resources.

To view the statistics:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the load balancer was created.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. Click the name of the load balancer you need.
   1. Go to the **{{ ui-key.yacloud.common.monitoring }}** tab.
   1. Select the dashboard: **{{ ui-key.yacloud.alb.label_tab-http-stats }}** or **{{ ui-key.yacloud.alb.label_tab-capacity-stats }}**.
   1. Select the time period for the statistics: one hour, three hours, one day, one week, or one month.

{% endlist %}

## Viewing statistics itemized by resources {#resources}

{{ monitoring-name }} provides load balancer runtime statistics itemized by associated load balancer resources, such as HTTP routers, virtual hosts, routes, and so on.

To view the statistics:

{% list tabs group=instructions %}

- Management console {#console}

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

      If you select `*` in the field, the dashboard will display aggregate statistics for all resources of the relevant type, such as all HTTP routers.

   1. Select the time period to view the statistics for.
   1. To refresh a dashboard, click ![](../../_assets/console-icons/arrows-rotate-right.svg). Next to the button, you can also set the statistics auto refresh rate.

{% endlist %}
