# Setting up automatic recovery for instances

You can set up automatic recovery for a group of instances to enhance the availability of your application and make sure it is responding. You can set up automatic recovery for instances when creating or updating a group.

You can only set up one health check for automatic recovery (don't confuse it with [health checks](../../../load-balancer/concepts/health-check.md) for {{ load-balancer-full-name }}).

{% include [warning.md](../../../_includes/instance-groups/sa.md) %}

To enable automatic recovery when updating an instance group:

{% list tabs %}

- Management console
  
  1. Open the folder page in the management console.
  
  1. Select **{{ compute-full-name }}**.
  
  1. On the **Virtual machines** page, go to the **Instance groups** tab.
  
  1. Select the group to update.
  
  1. In the **Health checks** section, enable the **Activate** option to the right.
  
  1. Select the protocol for the health checks: **HTTP** or **TCP**.
  
      Indicate the following:
  
      - A port number in the range of 1-32767.
  
      - The URL to perform checks for (if **HTTP** is chosen).
  
      - The response timeout in seconds.
  
      - The interval between health checks in seconds.
  
      - The performance threshold, which is the number of successful health checks required for the managed instance to be considered healthy.
  
      - The failure threshold, which is the number of failed health checks for the managed instance to be considered unhealthy.
  
  1. Click **Save changes**.
  
- CLI
  
  {% include [cli-install.md](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}
  
  1. View a description of the CLI's update group command:
  
     ```
     $ {{ yc-compute-ig }} update --help
     ```
  
  1. Get a list of instance groups in the default folder:
  
      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}
  
  1. Select the `ID` or `NAME` of the necessary group (for example, `first-group`).
  
  1. Get [information](get-info.md) about the instance group.
  
  1. Create a YAML file with any name (for example, `group.yaml`) and, based on the information received, describe:
  
      - [The template](../../concepts/instance-groups/instance-template.md) of the instance.
  
      - [The policies](../../concepts/instance-groups/policies.md).
  
      - The service account ID.
  
      - The load balancer specifications (if necessary).
  
  1. Add the health check specifications to the file:
  
      ```yaml
      ...
      health_checks_spec:
          health_check_specs:
          - tcp_options:
              port: 80
          interval: 10s
          timeout: 30s
          unhealthy_threshold: 5
          healthy_threshold: 3
      ...
      ```
  
      Where:
  
      | Key | Value |
      | ----- | ----- |
      | `health_check_specs` | Health check specs. |
      | `tcp_options` | TCP options. |
      | `port` | A port number in the range of 1-32767. |
      | `interval` | The interval between health checks in seconds. |
      | `timeout` | The response timeout in seconds. |
      | `unhealthy_threshold` | The failure threshold, which is the number of failed health checks for the managed instance to be considered unhealthy. |
      | `healthy_threshold` | The performance threshold, which is the number of successful health checks required for the managed instance to be considered healthy. |
  
  1. Update the instance group in the default folder:
  
      ```
      $ {{ yc-compute-ig }} update --name first-group --file group.yaml
      ```
  
     {{ ig-name }} starts the operation to update the instance group.
  
{% endlist %}
