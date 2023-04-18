# Creating backend group

To create a [backend group](../concepts/backend-group.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your backend group in.
   1. In the list of services, select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/backgrs.svg) **Backend groups**.
   1. Click **Create backend group**.
   1. Enter the backend group name: `test-backend-group`.
   1. Select the [backend group type](../concepts/backend-group.md#group-types):

      * `HTTP`: For HTTP or HTTPS traffic.
      * `gRPC`: For HTTP or HTTPS traffic with a [gRPC](https://{{ lang }}.wikipedia.org/wiki/GRPC) call.
      * `Stream`: For unencrypted TCP traffic or TCP traffic with TLS encryption support.

   1. (optional) Enable [session affinity](../concepts/backend-group.md#session-affinity). `HTTP` and `gRPC` backend groups support the following session affinity modes:

      * `By IP address`.
      * `By HTTP header`.
      * `By cookie`.

      For a `Stream` backend group, sessions are assigned to the client IP address.

      {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

   1. Under **Backends**, click **Add**. Specify the backend settings:

      {% include [backend-settings-console](../../_includes/application-load-balancer/backend-settings-console.md) %}

   1. Click **Create**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   {% note info %}

   You can create a gRPC backend group in the [management console]({{ link-console-main }}) or using {{ TF }}.

   {% endnote %}

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

   1. Add a backend and health check to the group. All backends within the group must have the same [type](../concepts/backend-group.md#group-types): HTTP or Stream.

      {% cut "HTTP backend" %}

      Run this command:

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

      {% endcut %}

      {% cut "Stream backend" %}

      Run this command:

      ```
      yc alb backend-group add-stream-backend \
        --backend-group-name <name of the backend group> \
        --name <name of the backend to be added> \
        --weight <backend weight> \
        --port <backend port> \
        --target-group-id=<target group ID> \
        --panic-threshold 90 \
        --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
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
      id: ds77tero4f5h46l4e2gl
      name: test-backend-group
      folder_id: b1gu6g9ielh690at5bm7
      stream:
        backends:
        - name: stream-backend
      backend_weight: "1"
          port: "80"
          target_groups:
            target_group_ids:
            - ds7eof3r2cte9u069p97
          healthchecks:
          - timeout: 10s
            interval: 2s
            healthy_threshold: "10"
            unhealthy_threshold: "15"
            healthcheck_port: "80"
            http:
              host: your-host.com
              path: /ping
      created_at: "2022-04-06T09:17:57.104324513Z"
      ```

      {% endcut %}

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see our documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the {{ TF }} configuration file, describe the parameters of the resource to create:

      ```hcl
      resource "yandex_alb_backend_group" "test-backend-group" {
        name                     = "<backend_group_name>"
        session_affinity {
          connection {
            source_ip = <true_or_false>
          }
        }

        http_backend {
          name                   = "<backend_name>"
          weight                 = 1
          port                   = 80
          target_group_ids       = ["<target_group_ID>"]
          load_balancing_config {
            panic_threshold      = 90
          }    
          healthcheck {
            timeout              = "10s"
            interval             = "2s"
            healthy_threshold    = 10
            unhealthy_threshold  = 15
            http_healthcheck {
              path               = "/"
            }
          }
        }
      }
      ```

      Where:

      * `yandex_alb_backend_group` specifies the backend group parameters:
      * `name`: Backend group name.
      * `session_affinity`: Settings for [session affinity](../../application-load-balancer/concepts/backend-group.md#session-affinity) (an optional parameter).

         {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

         * `connection`: Session affinity mode based on the IP address (`source_ip`). The `cookie` and `header` modes are also available. Only one of the modes should be specified. If the backend group has the Stream type (includes the `stream_backend` resources), you can only use the `connection` mode for session affinity.

      * `http_backend`, `grpc_backend`, and `stream_backend`: [Backend type](../concepts/backend-group.md#group-types). All backends within the group must have the same type: HTTP, gRPC, or Stream.

      Backend parameters:
      * `name`: Backend name.
      * `port`: Backend port.
      * `weight`: Backend weight.
      * `target_group_ids`: Target group ID. To get a list of available target groups, run the following [CLI](../../cli/quickstart.md) command: `yc alb target-group list`.
      * `load_balancing_config`: Load balancing settings:
         * `panic_threshold`: Threshold for panic mode.
      * `healthcheck`: Health check parameters:
         * `timeout`: The timeout.
         * `interval`: The interval.
         * `healthy_threshold`: The healthy threshold.
         * `unhealthy_threshold`: The unhealthy threshold.
         * `http_healthcheck`: Parameters for HTTP health checks:
            * `path`: The path.

      For more information about the `yandex_alb_backend_group` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-alb-backendgroup }}).
   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check that the resources are there using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```bash
      yc alb backend-group list
      ```

- API

   Use the [create](../api-ref/BackendGroup/create.md) REST API method for the [BackendGroup](../api-ref/BackendGroup/index.md) resource or the [BackendGroupService/Create](../api-ref/grpc/backend_group_service.md#Create) gRPC API call.

{% endlist %}