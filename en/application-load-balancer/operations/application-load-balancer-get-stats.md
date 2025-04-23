# Viewing L7 load balancer statistics

{{ alb-name }} automatically sends load balancer performance metrics to the [{{ monitoring-full-name }}](../../monitoring/) service.

For a full list of metrics, see [this reference](../metrics.md).

## View the load balancer summary {#summary}

{{ alb-name }} provides the load balancer summary without a resource breakdown.

To view the statistics:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your load balancer.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Click the name of the load balancer you need.
  1. Navigate to the **{{ ui-key.yacloud.common.monitoring }}** tab.
  1. Select the dashboard: **{{ ui-key.yacloud.alb.label_tab-http-stats }}** or **{{ ui-key.yacloud.alb.label_tab-capacity-stats }}**.
  1. Select the statistics time interval: 1 hour, 3 hours, 1 day, 1 week, or 1 month.

{% endlist %}

## Viewing statistics by resources {#resources}

{{ monitoring-name }} provides load balancer runtime statistics broken down by resources, e.g., HTTP routers, virtual hosts, routes, etc.

To view the statistics:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your load balancer.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Click the name of the load balancer you need.
  1. Navigate to the **{{ ui-key.yacloud.common.monitoring }}** tab.
  1. Select the dashboard: **{{ ui-key.yacloud.alb.label_tab-http-stats }}** or **{{ ui-key.yacloud.alb.label_tab-capacity-stats }}**.
  1. Click **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}**.
  1. Select the resources whose statistics you want to see:

     * **HTTP Router**: [HTTP router](../concepts/http-router.md).
     * **Virtual Host**: HTTP router virtual host.
     * **Route**: Virtual host route.
     * **Backend Group**: [Group of backends](../concepts/backend-group.md).
     * **Backend**: Backend.
     * **Zone**: Availability zone hosting the load balancer nodes. To learn more, see [{#T}](../concepts/application-load-balancer.md#lb-location).

     If you select `*` in this field, the dashboard will display aggregate statistics for all relevant resources, e.g., HTTP routers.

  1. Select the statistics time interval.
  1. To refresh the dashboard, click ![](../../_assets/console-icons/arrows-rotate-right.svg). You can also set the auto refresh rate next to this button.

{% endlist %}
