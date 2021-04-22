# Create a backend group

To create a backend group, add a backend to it and set up a health check:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where the backend group will be created.
  1. In the list of services, select **{{ alb-name }}**.
  1. In the left menu, select **Backend groups**.
  1. Click **Create backend group**.
  1. Enter the backend group name: `test-backend-group`.
  1. Under **Backends**, click **Add**. Specify the backend settings:
      1. Enter the backend name: `test-backend-1`.
      1. Set the weight of the backend: `1`.
      1. In the **Target group** list, select `test-target-group`.
      1. Set the **Port**: `80`.
  1. Expand the **Load balancing settings** field and set the parameters:
     1. **Threshold for panic mode**: `90`.
     1. **Locality aware routing **: `90`.
  1. Expand the **Protocol settings** field and set the parameters:
        1. Select the type: `HTTP`.
  1. Click **Add health check** and configure the check:
     1. **Timeout**: `1`.
     1. **Interval**: `1`.
     1. **Healthy threshold**: `3`.
     1. **Unhealthy threshold**: `10`.
     1. **Type**: `HTTP`.
     1. **Path**: `/`.
  1. Click **Create**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to create a backend group:

     ```
     yc alb backend-group create --help
     ```

  1. Create a backend group by running the command:

     ```
     yc alb backend-group create test-backend-group
     ```

     Command execution result:

     ```
     id: a5dg2cv4ngne8575fb1p
     name: test-backend-group
     folder_id: aoerb349v3h4bupphtaf
     ```

  1. Add a backend and health check to the group:

     ```
     yc application-load-balancer backend-group add-http-backend \
     --backend-group-name test-backend-group \
     --name backend1 \
     --weight 1 \
     --port 80 \
     --target-group-id=a5d751meibht4ev264pp \
     --panic-threshold 90
     --http-health-check port=80,healthy-threshold=10,unhealthy-threshold=15,timeout=10s,interval=2s,host=your-host.com,path=/ping
     ```

     Command execution result:

     ```
     id: a5dg2cv4ngne8575fb1p
     name: test-backend-group
     folder_id: aoerb349v3h4bupphtaf
     http:
       backends:
       - name: backend1
         backend_weight: "1"
         load_balancing_config:
           panic_threshold: "90"
         port: "80"
         target_groups:
           target_group_ids:
           - a5d751meibht4ev264pp
         healthchecks:
         - timeout: 10s
           interval: 2s
           healthy_threshold: "10"
           unhealthy_threshold: "15"
           healthcheck_port: "80"
           http:
             host: your-host.com
             path: /ping
     ```

{% endlist %}

