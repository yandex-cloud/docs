# Edit a backend group

## Update a group's basic parameters {#update-group}

To change the backend group parameters:

{% list tabs %}

- Management console

   {% note info %}

   You can change the [group type](../concepts/backend-group.md#group-types) only in other tools: CLI, {{ TF }}, API.

   {% endnote %}

   1. In the [management console]({{ link-console-main }}), select the folder where the backend group was created.
   1. Select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/backgrs.svg) **Backend groups**.
   1. Click on the name of the group you need.
   1. Click ![image](../../_assets/pencil.svg) **Edit**.
   1. Edit the group settings.
   1. At the bottom of the page, click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for changing the backend group basic parameters:

      ```bash
      yc alb backend-group update --help
      ```

   1. Run the command:

      ```bash
      yc alb backend-group update \
        --name <backend group name> \
        --new-name <new backend group name> \
        --description <backend group description> \
        --labels key=value[,<key>=<label value>]
      ```

      Where:
      * `--name`: Name of the backend group.
      * `--new-name`: New name of the backend group. Naming requirements:

         {% include [name-format-2](../../_includes/name-format-2.md) %}

      * `--description`: Description of the backend group. Optional.
      * `-labels key=value`: List of labels in `key=value` format. Optional.

      Result:

      ```
      id: ds77tero4f5h46l4e2gl
      name: test-backend-group
      description: update
      folder_id: b1gu6g9ielh690at5bm7
      stream:
        backends:
        - name: backend1
          backend_weight: "2"
          load_balancing_config:
            panic_threshold: "90"
          port: "80"
          target_groups:
            target_group_ids:
            - a5dvd82vl14khpjdv87d
          healthchecks:
          - timeout: 10s
            interval: 2s
            healthy_threshold: "10"
            unhealthy_threshold: "15"
            healthcheck_port: "80"
            http:
              host: your-host.com
              path: /ping
      created_at: "2021-02-14T13:37:17.846064589Z"
      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Open the {{ TF }} configuration file and edit the fragment with the backend group description:

      ```hcl
      resource "yandex_alb_backend_group" "test-backend-group" {
        name        = "<backend_group_name>"
        description = "<backend_group_description>"
        labels      = {
          new-label = "test-label"
        }
        session_affinity {
          connection {
            source_ip = <true_or_false>
          }
        }
      ...
      }
      ```

      `yandex_alb_backend_group` specifies the backend group parameters:
      * `name`: Backend group name.
      * `description`: Backend group description. Optional.
      * `labels`: List of labels in `key=value` format. Optional.
      * `session_affinity`: Settings for [session affinity](../../application-load-balancer/concepts/backend-group.md#session-affinity) (an optional parameter).

         {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

         * `connection`: Session affinity mode based on the IP address (`source_ip`). The `cookie` and `header` modes are also available. Only one of the modes should be specified. If the backend group has the Stream type (includes the `stream_backend` resources), you can only use the `connection` mode for session affinity.

      For more information about the `yandex_alb_backend_group` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-alb-backendgroup }}).
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      You can verify the changes to the backend group using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```bash
      yc alb backend-group get --name <backend_group_name>
      ```

{% endlist %}

## Add a backend to a group {#add-backend}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the backend was created.
   1. Select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/backgrs.svg) **Backend groups**.
   1. Click on the name of the group you need.
   1. Click ![image](../../_assets/plus.svg) **Add backend**.
   1. In the window that opens, set the backend settings:
      * Enter the backend name: `test-backend-1`.
      * Set the weight of the backend: `1`.
      * Select the `Target group` backend type for an `HTTP` backend group. In a `gRPC` or `Stream` backend group, only target groups and their sets can act as backends.
      * In the **Target groups** list, select `test-target-group` and set the **Port** to `80`.
   1. Expand the **Load balancing settings** field and set the parameters:
      * **Threshold for panic mode**: `90`.
      * **Locality aware routing**: `90`.
   1. Expand the **Protocol settings** field and select the `HTTP` type. By default, HTTP/1.1 is used for `HTTP` backend groups. To use HTTP/2, select the **HTTP/2** option. Backend groups of the `gRPC` type only support HTTP/2 connections.
   1. Click **Add health check** and configure the check:
      * **Timeout**: `1`.
      * **Interval**: `1`.
      * **Healthy threshold**: `3`.
      * **Unhealthy threshold**: `10`.
      * **Type**: `HTTP`.

         {% note info %}

         Health checks of the `HTTP`, `gRPC`, and `Stream` types are supported. They match the backend group types. However, the type of a health check doesn't have to be the same as the group type.

         {% endnote %}

      * **Path**: `/`.
   1. Click **Add**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Add a backend and health check to the group. All backends within the group must have the same [type](../concepts/backend-group.md#group-types): HTTP or Stream.

   {% cut "HTTP backend" %}

   Run the command:

   ```bash
   yc alb backend-group add-http-backend \
     --backend-group-name <backend group name> \
     --name <added backend name> \
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

   ```text
   id: a5dqkr2mk3rr799f1npa
   name: test-backend-group
   folder_id: aoe197919j8elpeg1lkp
   ...
           host: your-host.com
           path: /ping
   created_at: "2021-02-11T20:46:21.688940670Z"
   ```

   {% endcut %}

   {% cut "Stream backend" %}

   Run the command:

   ```bash
   yc alb backend-group add-stream-backend \
     --backend-group-name <backend group name> \
     --name <added backend name> \
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

   ```text
   id: ds77tero4f5h46l4e2gl
   name: test-backend-group
   folder_id: b1gu6g9ielh690at5bm7
   ...
           host: your-host.com
           path: /ping
   created_at: "2022-04-06T09:17:57.104324513Z"
   ```

   {% endcut %}

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Open the {{ TF }} configuration file and add a section describing a backend (`http_backend`, `grpc_backend`, or `stream_backend`) to the fragment with the backend group description:

   ```hcl
   resource "yandex_alb_backend_group" "test-backend-group" {
     name                     = "<backend group name>"

     http_backend {
       name                   = "<backend name>"
       weight                 = 1
       port                   = 80
       target_group_ids       = ["<target group ID>"]
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

   `yandex_alb_backend_group` specifies the backend group parameters:
   * `name`: Backend group name.
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
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      You can verify the changes to the backend group using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```bash
      yc alb backend-group get --name <backend group name>
      ```

{% endlist %}

## Update parameters for a backend in a group {#update-backend}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the backend was created.
   1. Select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/backgrs.svg) **Backend groups**.
   1. Click on the name of the group you need.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) next to the backend name and select **Edit**.
   1. In the window that opens, set the backend settings:
      * Enable the **Weight** option and set the backend weight to `1`.
      * Select the `Target group` backend type for an `HTTP` backend group. In a `gRPC` or `Stream` backend group, only target groups and their sets can act as backends.
      * In the **Target groups** list, select `test-target-group` and set the **Port** to `80`.
   1. Expand the **Load balancing settings** field and set the parameters:
      * **Threshold for panic mode**: `90`.
      * **Locality aware routing**: `90`.
   1. Expand the **Protocol settings** field and select the `HTTP` type. By default, HTTP/1.1 is used for `HTTP` backend groups. To use HTTP/2, select the **HTTP/2** option. Backend groups of the `gRPC` type only support HTTP/2 connections.
   1. Click **Add health check** and configure the check:
      * **Timeout**: `1`.
      * **Interval**: `1`.
      * **Healthy threshold**: `3`.
      * **Unhealthy threshold**: `10`.
      * **Type**: `HTTP`.

         {% note info %}

         Health checks of the `HTTP`, `gRPC`, and `Stream` types are supported. They match the backend group types. However, the type of a health check doesn't have to be the same as the group type.

         {% endnote %}

      * **Path**: `/`.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for updating the backend parameters:

      ```bash
      yc alb backend-group update-<backend type>-backend --help
      ```

   1. Set new parameters for the backend depending on its type:

      {% cut "HTTP backend" %}

      Run the command:

      ```bash
      yc alb backend-group update-http-backend \
        --backend-group-name <backend group name> \
        --name <backend name> \
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

      ```text
      id: a5dqkr2mk3rr799f1npa
      name: test-backend-group
      folder_id: aoe197919j8elpeg1lkp
      ...
              host: your-host.com
              path: /ping
      created_at: "2021-02-11T20:46:21.688940670Z"
      ```

      {% endcut %}

      {% cut "Stream backend" %}

      Run the command:

      ```bash
      yc alb backend-group update-stream-backend \
        --backend-group-name <backend group name> \
        --name <backend name> \
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

      ```text
      id: ds77tero4f5h46l4e2gl
      name: test-backend-group
      folder_id: b1gu6g9ielh690at5bm7
      ...
              host: your-host.com
              path: /ping
      created_at: "2022-04-06T09:17:57.104324513Z"
      ```

      {% endcut %}

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Open the {{ TF }} configuration file and update the section with the description of the backend (`http_backend`, `grpc_backend`, or `stream_backend`) in the fragment with the description of the backend group:

      ```hcl
      resource "yandex_alb_backend_group" "test-backend-group" {
        name                     = "<backend group name>"

        http_backend {
          name                   = "<backend name>"
          weight                 = 1
          port                   = 80
          target_group_ids       = ["<target group ID>"]
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

      `yandex_alb_backend_group` specifies the backend group parameters:
      * `name`: Backend group name.
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
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      You can verify the changes to the backend group using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```bash
      yc alb backend-group get --name <backend group name>
      ```

{% endlist %}

## Remove a backend from a group {#delete-backend}

To remove a backend from a group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the backend was created.
   1. Select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/backgrs.svg) **Backend groups**.
   1. Click on the name of the group you need.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) next to the backend name and select **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for removing a backend from a group:

      ```bash
      yc application-load-balancer delete-<backend type>-backend --help
      ```

   1. Depending on the type of backend, run the command to delete it:
      * HTTP backend:

         ```bash
         yc alb backend-group delete-http-backend \
           --backend-group-name=<backend group name> \
           --name=<deleted backend name>
         ```

      * Stream backend:

         ```bash
         yc alb backend-group delete-stream-backend \
           --backend-group-name=<backend group name> \
           --name=<deleted backend name>
         ```

      Result:

      ```text
      id: a5dqkr2mk3rr799f1npa
      name: test-backend-group
      folder_id: aoe197919j8elpeg1lkp
      created_at: "2021-02-11T20:46:21.688940670Z"
      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Open the {{ TF }} configuration file and delete the section with the description of the backend (`http_backend`, `grpc_backend`, or `stream_backend`) from the fragment with the description of the backend group.

      Sample backend group description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_alb_backend_group" "test-backend-group" {
        name                     = "<backend group name>"

        http_backend {
          name                   = "<backend name>"
          weight                 = 1
          port                   = 80
          target_group_ids       = ["<target group ID>"]
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

      For more information about the `yandex_alb_backend_group` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-alb-backendgroup }}).
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      You can verify the changes to the backend group using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```bash
      yc alb backend-group get --name <backend group name>
      ```

{% endlist %}