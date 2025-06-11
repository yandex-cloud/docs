# Configuring application health checks on a VM instance

By configuring app health checks on a VM instance, you can improve application availability and ensure its responsiveness. {{ ig-name }} will run a check and automatically recover the instance if it fails it. Do not confuse this with a network load balancer [health check](../../../network-load-balancer/concepts/health-check.md). Learn more about automatic recovery and types of checks [here](../../concepts/instance-groups/autohealing.md).

This section describes how to configure an application health check for an existing group.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), open the folder containing the instance group you need.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Select the group to update.
  1. In the top-right corner of the page, click **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_health-check }}**, enable **{{ ui-key.yacloud.compute.groups.create.field_enable-health-check }}**.
  1. Configure health check settings:
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}**: `{{ ui-key.yacloud.common.label_http }}` or `{{ ui-key.yacloud.common.label_tcp }}`.
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** (for HTTP): URL path {{ ig-name }} will use to send HTTP check requests.
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}**: Port in the range of 1 to 32767 {{ ig-name }} will use to send check requests on.

       {% note alert %}

       Only HTTP/1.1 and lower are supported.

       {% endnote %}
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-timeout }}**: Response timeout in seconds.
       If you [connected your group to a network load balancer](create-with-balancer.md), we recommend setting this parameter to a _higher_ value than the one for the load balancer.
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-interval }}**: Interval between app health checks run by {{ ig-name }}, in seconds.
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}**: Number of successful health checks required to consider a VM instance healthy.
        If you connected your group to a network load balancer, we recommend setting this parameter to a _lower_ value than the one for the load balancer.
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}**: Number of failed health checks required to consider a VM instance unhealthy.
       If you connected your group to a network load balancer, we recommend setting this parameter to a _higher_ value than the one for the load balancer.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating an instance group:

     ```
     {{ yc-compute-ig }} update --help
     ```

  1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}
  1. Select `ID` or `NAME` of the group you need, e.g., `first-instance-group`.
  1. [Get information](get-info.md) about the instance group.
  1. Create a YAML file with any name, e.g., `group.yaml`, and define the following based on the info you get:

      * Instance [template](../../concepts/instance-groups/instance-template.md).
      * [Policies](../../concepts/instance-groups/policies/index.md).
      * Service account ID.
      * Network load balancer specification, if required.

  1. Add a health check specification to the file, e.g, for HTTP checks:

     ```yaml
     ...
     health_checks_spec:
       health_check_specs:
         - http_options:
             port: 80
             path: /
           interval: 30s
           timeout: 10s
           unhealthy_threshold: 5
           healthy_threshold: 3
     ...
     ```

      Where:

      Key | Value
      ----- | -----
      `health_check_specs` | Health check specification
      `http_options` | Settings for HTTP health checks. Only HTTP/1.1 and lower are supported.<br>If you want to use TCP, specify only the port number in the `tcp_options` property.
      `port` | Port in the range of 1 to 32767 {{ ig-name }} will use to send check requests on.
      `path` | URL path {{ ig-name }} will use to send HTTP check requests.
      `interval` | Interval between app health checks run by {{ ig-name }}, in seconds.
      `timeout` | Response timeout in seconds.<br>If you [connected your group to a network load balancer](create-with-balancer.md), we recommend setting this parameter to a _higher_ value than the one for the load balancer.
      `unhealthy_threshold` | Number of failed health checks required to consider a VM instance unhealthy.<br>If you connected your group to a network load balancer, we recommend setting this parameter to a _higher_ value than the one for the load balancer.
      `healthy_threshold` | Number of successful health checks required to consider a VM instance healthy.<br>If you connected your group to a network load balancer, we recommend setting this parameter to a _lower_ value than the one for the load balancer.

  1. Update the instance group in the default folder:

      ```
      {{ yc-compute-ig }} update --name first-group --file group.yaml
      ```

     {{ ig-name }} will initiate instance group updating.

{% endlist %}