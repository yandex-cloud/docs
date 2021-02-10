# Configure application health check on the VM

To make the application more available and make sure that it responds to requests, you can set up the application health check on the instance. {{ ig-name }} will check and automatically recover the instance if it fails the check. Don't confuse this with the [health check](../../../load-balancer/concepts/health-check.md) in the network load balancer. [Read more](../../concepts/instance-groups/autohealing.md) about automatic recovery and types of checks.

This section describes how to set up application health check for an existing group.

{% list tabs %}

- Management console

  1. Open the folder page in the management console.

  1. Select **{{ compute-full-name }}**.

  1. On the **Virtual machines** page, go to the **Instance groups** tab.

  1. Select the group to update.

  1. In the **Health checks** section, enable the **Activate** option to the right.

  1. Select the protocol for the health checks: **HTTP** or **TCP**.

  1. Set up the health checks:

      - The port in the range 1-32767 to receive the check requests from {{ ig-name }}.

      - Path (for HTTP) — The URL path for the HTTP check requests sent from {{ ig-name }}.

        {% note alert %}

        Only HTTP/1.1 and lower are supported.

        {% endnote %}

      - The response timeout in seconds.

        If you [connected your instance group to a network load balancer](create-with-balancer.md), we recommend setting a _smaller_ value here than in the load balancer.

      - Check interval in seconds — This is the interval for {{ ig-name }} to wait between health checks.

      - Performance threshold — The number of successful health checks required for the managed instance to be considered healthy.

        If you have connected your instance group to a network load balancer, we recommend that you set a _smaller_ value here than in the load balancer.

      - Failure threshold — The number of failed health checks for the managed instance to be considered unhealthy.

        If you have connected your instance group to a network load balancer, we recommend that you set a _higher_ value here than in the load balancer.

  1. Click **Save changes**.

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. View a description of the update group command in the CLI:

     ```
     $ {{ yc-compute-ig }} update --help
     ```

  1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Select the group `ID` or `NAME` (for example, `first-instance-group`).

  1. [Get information](get-info.md) about the instance group.

  1. Create a YAML file with any name (for example, `group.yaml`) and, based on the information received, describe:
      - [The template](../../concepts/instance-groups/instance-template.md) of the instance.
      - [The policies](../../concepts/instance-groups/policies/index.md).
      - The service account ID.
      - The network load balancer specifications (if necessary).

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
      | ----- | ----- |
      | `health_check_specs` | Health check specs. |
      | `http_options` | Settings for HTTP health checks. Only HTTP/1.1 and lower are supported.<br>If you want to use TCP, then in the `tcp_options` property specify the port number only. |
      | `port` | The port in the range 1-32767 to receive the check requests from {{ ig-name }}. |
      | `path` | The URL path for the HTTP health check requests sent from {{ ig-name }}. |
      | `interval` | Check interval in seconds — This is the interval for {{ ig-name }} to wait between health checks. |
      | `timeout` | Response waiting time in seconds.<br>If you [connected your instance group to a network load balancer](create-with-balancer.md), we recommend setting a _larger_ value here than in the load balancer. |
      | `unhealthy_threshold` | Unhealthy threshold — The number of failed health checks after which the instance is considered inoperable.<br>If you have connected your instance group to a network load balancer, we recommend that you set a _higher_ value here than in the load balancer. |
      | `healthy_threshold` | Healthy threshold — The number of successful health checks after which the instance is considered operable.<br>If you have connected your instance group to a network load balancer, we recommend that you set a _smaller_ value here than in the load balancer. |

  1. Update the instance group in the default folder:

      ```
      $ {{ yc-compute-ig }} update --name first-group --file group.yaml
      ```

     {{ ig-name }} starts the operation to update the instance group.

{% endlist %}

