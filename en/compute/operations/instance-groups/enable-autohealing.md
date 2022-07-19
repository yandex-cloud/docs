# Configuring application health check on the VM

To increase application availability and make sure that an application is responding, you can configure application health checks on a virtual machine. {{ ig-name }} will perform a check and automatically recover a virtual machine if it fails. This is not to be confused with a network load balancer [health check](../../../network-load-balancer/concepts/health-check.md). [Learn more](../../concepts/instance-groups/autohealing.md) about automatic recovery and types of checks.

This section describes how to set up application health check for an existing group.

{% list tabs %}

- Management console

   1. Open the folder page in the [management console]({{ link-console-main }}).
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **Instance groups**.
   1. Select a group and click **Edit**.
   1. Under **Health checks**, enable the **Activate** option.
   1. Select the protocol for the health checks: **HTTP** or **TCP**.
   1. Set up the health checks:

      * Path (for HTTP): The URL path for the HTTP check requests sent from {{ ig-name }}.
      * The port in the range 1-32767 to receive the check requests from {{ ig-name }}.

         {% note alert %}

         Only HTTP/1.1 and lower are supported.

         {% endnote %}
      * The response timeout in seconds.

         If you [connected your group to a network load balancer](create-with-balancer.md), we recommend setting a _higher_ value here than in the load balancer.
      * Check interval in seconds: This is the interval between the health checks done by {{ ig-name }}.
      * Performance threshold: The number of successful health checks required for the managed instance to be considered healthy.

         If you connected your group to a network load balancer, we recommend setting a _lower_ value here than in the load balancer.
      * Failure threshold: The number of failed health checks for the managed instance to be considered unhealthy.

         If you connected your group to a network load balancer, we recommend setting a _higher_ value here than in the load balancer.
   1. Click **Save**.

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a description of the update group command in the CLI:

      ```
      {{ yc-compute-ig }} update --help
      ```
   1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}
   1. Select the group `ID` or `NAME` (for example, `first-instance-group`).
   1. [Get information](get-info.md) about the instance group.
   1. Create a YAML file with any name (for example, `group.yaml`) and, based on the information received, describe:

      * An instance [template](../../concepts/instance-groups/instance-template.md).
      * [Policies](../../concepts/instance-groups/policies/index.md).
      * The service account ID.
      * A network load balancer specification (if required).

   1. Add a health check specification to the file (for example, for HTTP checks):

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

      | Key | Value |
      ----- | -----
      | `health_check_specs` | Health check specs. |
      | `http_options` | Settings for HTTP health checks. Only HTTP/1.1 and lower are supported.<br>If you want to use TCP, then in the `tcp_options` property specify the port number only. |
      | `port` | The port in the range 1-32767 to receive the check requests from {{ ig-name }}. |
      | `path` | The URL path for the HTTP health check requests sent from {{ ig-name }}. |
      | `interval` | Check interval in seconds: This is the interval between the health checks done by {{ ig-name }}. |
      | `timeout` | Response timeout in seconds.<br>If you [connected your group to a load balancer](create-with-balancer.md), we recommend setting a _higher_ value here than in the load balancer. |
      | `unhealthy_threshold` | Unhealthy threshold is the number of failed health checks after which the instance is considered non-functional.<br>If you connected your group to a network load balancer, we recommend setting a _higher_ value here than in the load balancer. |
      | `healthy_threshold` | Healthy threshold is the number of successful health checks after which an instance is considered functional.<br>If you connected your group to a load balancer, we recommend setting a _lower_ value here than in the load balancer. |

   1. Update the instance group in the default folder:

      ```
      {{ yc-compute-ig }} update --name first-group --file group.yaml
      ```

      {{ ig-name }} will launch the instance group update process.

{% endlist %}