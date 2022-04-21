# Create a backend group

When creating a [backend group](../concepts/backend-group.md), you can add two [types](../concepts/backend-group.md#types) of backends to it: backends with [target groups](../concepts/target-group.md) and with [{{ objstorage-name }} buckets](../../storage/concepts/bucket.md).

## Creating a backend group with a target group {#with-target-group}

Create a backend group by following the [instructions](target-group-create.md).

To create a backend group with a target group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your backend group in.
   1. In the list of services, select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/backgrs.svg) **Backend groups**.
   1. Click **Create backend group**.
   1. Enter the backend group name: `test-backend-group`.
   1. Under **Backends**, click **Add**. Specify the backend settings:
      1. Enter the backend name: `test-backend-1`.
      1. Set the weight of the backend: `1`.
      1. Select the backend type: **Target group**.
      1. In the **Target groups** list, select `test-target-group`.
      1. Set the **Port**: `80`.
   1. Expand the **Load balancing settings** field and set the parameters:
      1. **Threshold for panic mode**: `90`.
      1. **Locality aware routing**: `90`.
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
      yc alb backend-group create <backend group name>
      ```

      Result:

      ```
      id: a5dg2cv4ngne8575fb1p
      name: test-backend-group
      folder_id: aoerb349v3h4bupphtaf
      created_at: "2021-02-11T20:46:21.688940670Z"
      ```

   1. Add a backend and health check to the group:
      ```
      yc alb backend-group add-http-backend \
        --backend-group-name <name of the backend group> \
        --name <name of the backend to be added> \
        --weight <backend weight> \
        --port <backend port> \
        --target-group-id=<target group ID> \
        --panic-threshold 90 \
        --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15, \
      timeout=10s,interval=2s,host=your-host.com,path=/ping
      ```

      Where:

      * `--panic-threshold`: The threshold for panic mode.
      * `--http-healthcheck`: Parameters for checking the resource status:
         * `port`: The port.
         * `healthy-threshold`: The healthy threshold.
         * `unhealthy-threshold`: The unhealthy threshold.
         * `timeout`: The timeout.
         * `interval`: The interval.
         * `host`: The host address.
         * `path`: The path.

      Result:

      ```
      id: a5dqkr2mk3rr799f1npa
      name: test-backend-group
      folder_id: aoe197919j8elpeg1lkp
      http:
        backends:
        - name: backend1
          backend_weight: "1"
          load_balancing_config:
            panic_threshold: "90"
          port: "80"
          target_groups:
            target_group_ids:
            - a5d2iap3nue9s3anblu6
          healthchecks:
          - timeout: 10s
            interval: 2s
            healthy_threshold: "10"
            unhealthy_threshold: "15"
            healthcheck_port: "80"
            http:
              host: your-host.com
              path: /ping
      created_at: "2021-02-11T20:46:21.688940670Z"
      ```

{% endlist %}

## Create a backend group with a bucket {#with-s3-bucket}

{% include [bucket-availability-note](../_includes_service/bucket-availability-note.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your backend group in.
   1. In the list of services, select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/backgrs.svg) **Backend groups**.
   1. Click **Create backend group**.
   1. Enter the backend group name: `test-backend-group`.
   1. Under **Backends**, click **Add**. Specify the backend settings:

      1. Enter the backend name: `test-backend-1`.
      1. Set the weight of the backend: `1`.
      1. Select **Bucket** as the backend type.
      1. Select the bucket that you want to use as a backend.

   1. Click **Create**.

{% endlist %}
