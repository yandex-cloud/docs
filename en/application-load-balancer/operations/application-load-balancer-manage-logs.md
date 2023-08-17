# Setting up L7 load balancer logging

L7 load balancer [logs](../concepts/application-load-balancer.md#logging) can be sent to [{{ cloud-logging-full-name }}](../../logging/).

## Enabling logging {#enable-logs}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the load balancer is stored.
   1. Select **{{ alb-name }}**.
   1. In the list of load balancers, choose the one you need, click ![image](../../_assets/horizontal-ellipsis.svg), and select **Edit**.
   1. Under **Log settings**:

      1. Enable **Write logs**.
      1. Select the {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md) to write load balancer logs to.
      1. Click **Add discard rule** and set up its [parameters](../concepts/application-load-balancer.md#discard-logs-rules):

         * **HTTP codes**: Add HTTP status codes.
         * **HTTP code classes**: Add classes of HTTP status codes.
         * **gRPC codes**: Add gRPC codes.
         * **Share of discarded logs**: Set the percentage of logs to discard.

         You can set multiple rules.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for managing load balancer logging:

      ```bash
      yc alb load-balancer logging --help
      ```

   1. Enable logging and set parameters for writing [logs](../logs-ref.md) to {{ cloud-logging-name }}:

      ```bash
      yc alb load-balancer logging <load_balancer_name> \
        --enable
        --log-group-id <log_group_ID> \
        --discard codes=[<HTTP_code>,<HTTP_code_class>,<gRPC_code>],percent=<percentage_of_logs_to_discard>
      ```

      Where:

      * `--enable`: Parameter for enabling logging.
      * `--log-group-id`: ID of the [log group](../../logging/concepts/log-group.md) to send the load balancer logs to.
      * `--discard`: [Rule for discarding logs](../concepts/application-load-balancer.md#discard-logs-rules). Rule parameters:
         * `codes`: HTTP status codes, classes of HTTP status codes, or gRPC codes.
         * `percent`: Percentage of logs to be discarded.

         You can set multiple rules.

      Result:

      ```yaml
      done (42s)
      id: ds76g8b2op3fej1.....
      name: test-load-balancer
      folder_id: b1gu6g9ielh690a.....
      ...
      log_options:
        log_group_id: e23p9bfj2kyra3t.....
        discard_rules:
          - http_codes:
              - "200"
            http_code_intervals:
              - HTTP_2XX
            grpc_codes:
              - OK
            discard_percent: "70"
      ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Add the `log_options` section to the load balancer description in the configuration file:

      ```hcl
      log_options {
        log_group_id = "<log_group_ID>"
        discard_rule {
          http_codes          = ["200"]
          http_code_intervals = ["HTTP_2XX"]
          grpc_codes          = ["GRPC_OK"]
          discard_percent     = 75
        }
      }
      ```

      Where `log_options` are parameters for writing [logs](../logs-ref.md) to {{ cloud-logging-name }}:
      * `log_group_id`: ID of the [log group](../../logging/concepts/log-group.md) to write the load balancer logs to.
      * `discard_rule`: [Rule for discarding logs](../concepts/application-load-balancer.md#discard-logs-rules):
         * `http_codes`: HTTP status codes.
         * `http_code_intervals`: Classes of HTTP status codes.
         * `grpc_codes`: gRPC codes.
         * `discard_percent`: Percentage of logs to discard.

         You can set multiple rules.
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   This will enable logging in the specified load balancer. You can check the logging status and other load balancer settings using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

   ```bash
   yc alb load-balancer get <load_balancer_name>
   ```

- API

   To enable logging, use the [update](../api-ref/LoadBalancer/update.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Update](../api-ref/grpc/load_balancer_service.md#Update) gRPC API call.

{% endlist %}

## Updating logging parameters {#update-logs}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the load balancer is stored.
   1. Select **{{ alb-name }}**.
   1. In the list of load balancers, choose the one you need, click ![image](../../_assets/horizontal-ellipsis.svg), and select **Edit**.
   1. Under **Log settings**:

      1. Change the {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md) to write the load balancer logs to.
      1. Edit the [rules for discarding logs](../concepts/application-load-balancer.md#discard-logs-rules):

         * **HTTP codes**: Update the HTTP status codes.
         * **HTTP code classes**: Update the classes of HTTP status codes.
         * **gRPC codes**: Update the gRPC codes.
         * **Share of discarded logs**: Update the percentage of logs to discard.

         To add another rule, click **Add discard rule**.

   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for managing load balancer logging:

      ```bash
      yc alb load-balancer logging --help
      ```

   1. Update the parameters for writing [logs](../logs-ref.md) to {{ cloud-logging-name }}:

      ```bash
      yc alb load-balancer logging <load_balancer_name> \
        --log-group-id <log_group_ID> \
        --discard codes=[<HTTP_code>,<HTTP_code_class>,<gRPC_code>],percent=<percentage_of_logs_to_discard>
      ```

      Where:

      * `--log-group-id`: ID of the [log group](../../logging/concepts/log-group.md) to send the load balancer logs to.
      * `--discard`: [Rule for discarding logs](../concepts/application-load-balancer.md#discard-logs-rules). Rule parameters:
         * `codes`: HTTP status codes, classes of HTTP status codes, or gRPC codes.
         * `percent`: Percentage of logs to be discarded.

         You can set multiple rules.

      Result:

      ```yaml
      done (42s)
      id: ds76g8b2op3fej1.....
      name: test-load-balancer
      folder_id: b1gu6g9ielh690a.....
      ...
      log_options:
        log_group_id: e23p9bfj2kyra3t.....
        discard_rules:
          - http_codes:
              - "200"
            http_code_intervals:
              - HTTP_2XX
            grpc_codes:
              - OK
            discard_percent: "70"
      ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file with the load balancer description, update the logging settings in the `log_options` section:

      ```hcl
      log_options {
        log_group_id = "<log_group_ID>"
        discard_rule {
          http_codes          = ["200"]
          http_code_intervals = ["HTTP_2XX"]
          grpc_codes          = ["GRPC_OK"]
          discard_percent     = 75
        }
      }
      ```

      Where `log_options` are parameters for writing [logs](../logs-ref.md) to {{ cloud-logging-name }}:
        * `log_group_id`: ID of the [log group](../../logging/concepts/log-group.md) to write the load balancer logs to.
        * `discard_rule`: [Rule for discarding logs](../concepts/application-load-balancer.md#discard-logs-rules):
           * `http_codes`: HTTP status codes.
           * `http_code_intervals`: Classes of HTTP status codes.
           * `grpc_codes`: gRPC codes.
           * `discard_percent`: Percentage of logs to discard.

         You can set multiple rules.
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   This will update the logging parameters in the specified load balancer. You can check the load balancer settings using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

   ```bash
   yc alb load-balancer get <load_balancer_name>
   ```

- API

   To update the logging parameters, use the [update](../api-ref/LoadBalancer/update.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Update](../api-ref/grpc/load_balancer_service.md#Update) gRPC API call.

{% endlist %}

## Disabling logging {#disable-logging}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the load balancer is stored.
   1. Select **{{ alb-name }}**.
   1. In the list of load balancers, choose the one you need, click ![image](../../_assets/horizontal-ellipsis.svg), and select **Edit**.
   1. Under **Log settings**, disable **Write logs**.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for managing load balancer logging:

      ```bash
      yc alb load-balancer logging --help
      ```

   1. Disable logging:

      ```bash
      yc alb load-balancer logging <load_balancer_name> --disable
      ```

      Where `--disable` is the parameter for disabling logging.

      Result:

      ```yaml
      done (42s)
      id: ds76g8b2op3fej1.....
      name: test-load-balancer
      folder_id: b1gu6g9ielh690a.....
      ...
      log_options:
        disable: true
      ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Remove the `log_options` section from the configuration file with the load balancer description:

      ```hcl
      log_options {
      ...
      }
      ```

   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   This will disable logging in the specified load balancer. You can check the logging status and other load balancer settings using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

   ```bash
   yc alb load-balancer get <load_balancer_name>
   ```

- API

   To disable logging, use the [update](../api-ref/LoadBalancer/update.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Update](../api-ref/grpc/load_balancer_service.md#Update) gRPC API call.

{% endlist %}