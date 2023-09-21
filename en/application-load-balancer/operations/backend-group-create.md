# Creating backend group

To create a [backend group](../concepts/backend-group.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your backend group in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. In the left-hand panel, select ![image](../../_assets/backgrs.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
   1. Click **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
   1. Enter a name for the backend group.
   1. Select the [backend group type](../concepts/backend-group.md#group-types):

      * `{{ ui-key.yacloud.alb.label_proto-http }}`: For HTTP or HTTPS traffic.
      * `{{ ui-key.yacloud.alb.label_proto-grpc }}`: For HTTP or HTTPS traffic with a [gRPC](https://{{ lang }}.wikipedia.org/wiki/GRPC) call.
      * `{{ ui-key.yacloud.alb.label_proto-stream }}`: For unencrypted TCP traffic or TCP traffic with TLS encryption support.

   1. (Optional) Enable [session affinity](../concepts/backend-group.md#session-affinity). `{{ ui-key.yacloud.alb.label_proto-http-plain }}` and `{{ ui-key.yacloud.alb.label_proto-grpc }}` backend groups support the following session affinity modes:

      * `{{ ui-key.yacloud.alb.label_affinity-connection }}`
      * `{{ ui-key.yacloud.alb.label_affinity-header }}`
      * `{{ ui-key.yacloud.alb.label_affinity-cookie }}`

      For a `{{ ui-key.yacloud.alb.label_proto-stream }}` backend group, sessions are assigned to the client IP address.

      {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

   1. Under **{{ ui-key.yacloud.alb.label_backends }}**, click **{{ ui-key.yacloud.common.add }}**. Specify the backend settings:

      {% include [backend-settings-console](../../_includes/application-load-balancer/backend-settings-console.md) %}

   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   {% note info %}

   You can create a `gRPC` backend group in the [management console]({{ link-console-main }}) or using {{ TF }}.

   {% endnote %}

   1. View a description of the CLI command to create a backend group:
      ```
      yc alb backend-group create --help
      ```

   1. Create a backend group by running the command:
      ```
      yc alb backend-group create <backend_group_name>
      ```

      Result:

      ```
      id: a5dg2cv4ngne8575fb1p
      name: test-backend-group
      folder_id: aoerb349v3h4bupphtaf
      created_at: "2021-02-11T20:46:21.688940670Z"
      ```

   1. Add a backend and health check to the group. All backends within the group must have the same [type](../concepts/backend-group.md#group-types): `HTTP`, `gRPC`, or `Stream`.

      {% cut "HTTP backend" %}

      Run this command:

      ```bash
      yc alb backend-group add-http-backend \
        --backend-group-name <backend_group_name> \
        --name <name_of_backend_to_be_added> \
        --weight <backend_weight> \
        --port <backend_port> \
        --target-group-id=<target_group_ID> \
        --panic-threshold 90 \
        --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
      timeout=10s,interval=2s,host=<host_address>,path=<path>
      ```

      Where:

      * `--panic-threshold`: Threshold for panic mode.
      * `--http-healthcheck`: Parameters for checking the resource status:
         * `port`: Port.
         * `healthy-threshold`: Healthy threshold.
         * `unhealthy-threshold`: Unhealthy threshold.
         * `timeout`: Timeout.
         * `interval`: Interval.
         * `host`: Host address.
         * `path`: Path.

      Result:

      ```text
      id: a5dqkr2mk3rr********
      name: <backend_group_name>
      folder_id: aoe197919j8e********
      http:
        backends:
        - name: <backend_name>
          backend_weight: "1"
          load_balancing_config:
            panic_threshold: "90"
          port: "80"
          target_groups:
            target_group_ids:
            - a5d2iap3nue9********
          healthchecks:
          - timeout: 10s
            interval: 2s
            healthy_threshold: "10"
            unhealthy_threshold: "15"
            healthcheck_port: "80"
            http:
              host: <host_address>
              path: <path>
      created_at: "2021-02-11T20:46:21.688940670Z"
      ```

      {% endcut %}

      {% cut "gRPC backend" %}

      ```bash
      yc alb backend-group add-grpc-backend \
        --backend-group-name <backend_group_name> \
        --name <name_of_backend_to_be_added> \
        --weight <backend_weight> \
        --port <backend_port> \
        --target-group-id=<target_group_ID> \
        --panic-threshold 90 \
        --grpc-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
      timeout=10s,interval=2s,service-name=<gRPC_service_name>
      ```

      Where:

      * `--panic-threshold`: Threshold for panic mode.
      * `--grpc-healthcheck`: Parameters for checking the resource status:
         * `port`: Port.
         * `healthy-threshold`: Healthy threshold.
         * `unhealthy-threshold`: Unhealthy threshold.
         * `timeout`: Timeout.
         * `interval`: Interval.
         * `service-name`: Name of the gRPC service to be checked. If no service is specified, the backend's general health is checked.

      Result:

      ```text
      id: a5dqkr2mk3rr********
      name: <backend_group_name>
      folder_id: aoe197919j8e********
      grpc:
        backends:
          - name: <backend_name>
            backend_weight: "12"
            load_balancing_config:
              panic_threshold: "90"
            port: "80"
            target_groups:
              target_group_ids:
                - a5d2iap3nue9********
            healthchecks:
              - timeout: 10s
                interval: 2s
                healthy_threshold: "10"
                unhealthy_threshold: "15"
                healthcheck_port: "80"
                grpc:
                  service_name: <gRPC_service_name>
      created_at: "2023-06-17T13:04:08.567141292Z"
      ```

      {% endcut %}

      {% cut "Stream backend" %}

      Run this command:

      ```bash
      yc alb backend-group add-stream-backend \
        --backend-group-name <backend_group_name> \
        --name <name_of_backend_to_be_added> \
        --weight <backend_weight> \
        --port <backend_port> \
        --target-group-id=<target_group_ID> \
        --panic-threshold 90 \
        --stream-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
      timeout=10s,interval=2s,send-text=<data_sent_to_endpoint>,receive-text=<data_received_from_endpoint>
      ```

      Where:

      * `--panic-threshold`: Threshold for panic mode.
      * `--stream-healthcheck`: Parameters for checking the resource status:
         * `port`: Port.
         * `healthy-threshold`: Healthy threshold.
         * `unhealthy-threshold`: Unhealthy threshold.
         * `timeout`: Timeout.
         * `interval`: Interval.
         * `send-text`: Data to be sent to the endpoint for a health check.
         * `receive-text`: Data to be received from the endpoint for it to pass the health check.

      Result:

      ```text
      id: ds77tero4f5********
      name: <backend_group_name>
      folder_id: b1gu6g9ielh6********
      stream:
        backends:
        - name: <backend_name>
      backend_weight: "1"
          port: "80"
          target_groups:
            target_group_ids:
            - ds7eof3r2cte********
          healthchecks:
            - timeout: 10s
              interval: 2s
              healthy_threshold: "10"
              unhealthy_threshold: "15"
              healthcheck_port: "80"
              stream:
                send:
                  text: <data_sent_to_endpoint>
                receive:
                  text: <data_received_from_endpoint>
      created_at: "2022-04-06T09:17:57.104324513Z"
      ```

      {% endcut %}

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see our documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

         * `connection`: Session affinity mode based on the IP address (`source_ip`). The `cookie` and `header` modes are also available. Only one of the modes should be specified. If the backend group has the `Stream` type (includes the `stream_backend` resources), you can only use the `connection` mode for session affinity.

      * `http_backend`, `grpc_backend`, and `stream_backend`: [Backend type](../concepts/backend-group.md#group-types). All backends within the group must have the same type: `HTTP`, `gRPC`, or `Stream`.

      Backend parameters:
      * `name`: Backend name.
      * `port`: Backend port.
      * `weight`: Backend weight.
      * `target_group_ids`: Target group ID. To get a list of available target groups, run the following [CLI](../../cli/quickstart.md) command: `yc alb target-group list`.
      * `load_balancing_config`: Load balancing settings:
         * `panic_threshold`: Threshold for panic mode.
      * `healthcheck`: Health check parameters:
         * `timeout`: Timeout.
         * `interval`: Interval.
         * `healthy_threshold`: Healthy threshold.
         * `unhealthy_threshold`: Unhealthy threshold.
         * `http_healthcheck`: Parameters for `HTTP` health checks:
            * `path`: Path.

      For more information about the `yandex_alb_backend_group` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-alb-backendgroup }}).
   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc alb backend-group list
      ```

- API

   Use the [create](../api-ref/BackendGroup/create.md) REST API method for the [BackendGroup](../api-ref/BackendGroup/index.md) resource or the [BackendGroupService/Create](../api-ref/grpc/backend_group_service.md#Create) gRPC API call.

{% endlist %}
