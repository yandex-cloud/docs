# Scripted HTTP load testing with Pandora

You can use {{ load-testing-name }} to run scripted load tests over HTTP with the [Pandora](../../load-testing/concepts/load-generator.md#pandora) [load generator](../../load-testing/concepts/load-generator.md).

To perform load testing:
1. [Prepare your cloud](#before-begin).
1. [Prepare a test target](#target-prepare).
1. [Prepare your infrastructure](#infrastructure-prepare).
1. [Create an agent](#create-agent).
1. [Prepare a file with test data](#test-file).
1. [Prepare a script file](#test-scenario).
1. [Run a test](#run-test).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

If the [agent](../../load-testing/concepts/agent.md) is hosted on {{ yandex-cloud }}, you pay for computing resources (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

At the [Preview](../../overview/concepts/launch-stages.md) stage, {{ load-testing-name }} is free of charge.

## Prepare a test target {#target-prepare}

In this example, we will test a service with the `172.17.0.10` [internal IP address](../../vpc/concepts/address.md#internal-addresses) in the same [subnet](../../vpc/concepts/network.md#subnet) as the agent.

Make sure the service is accessed over HTTPS using the default port: `443`.

You can also use {{ load-testing-name }} for load testing of a service that is public or located in a subnet and [security group](../../vpc/concepts/security-groups.md) other than those of the agent.

For a public service, allow incoming HTTPS traffic on port `443`.

For a service whose subnet and security group differ from the agent's ones, [create](#security-group-setup) a rule for incoming HTTPS traffic on port `443` in the security group where the test target is located.

## Prepare the infrastructure {#infrastructure-prepare}

### Create a service account {#sa-create}

{% include [sa-create](../../_includes/load-testing/sa-create.md) %}

### Configure a network {#network-setup}

[Create and configure a NAT gateway](../../vpc/operations/create-nat-gateway.md) in the subnet where your test target is and the agent will be hosted. Thus, the agent will have access to {{ load-testing-name }}.

### Configure security groups {#security-group-setup}

1. Set up the test agent's security group:

   {% include [security-groups-agent](../../_includes/load-testing/security-groups-agent.md) %}

1. Set up the test target's security group:

   {% include [security-groups-target](../../_includes/load-testing/security-groups-target.md) %}

## Create a test agent {#create-agent}

{% include [create-agent](../../_includes/load-testing/create-agent.md) %}

## Prepare a file with test data {#test-file}

1. Generate payloads in a `users.csv` file:

   ```csv
   user_id,name,pass
   1,John,123
   2,Jack,456
   3,Jim,789
   4,Joe,0asdf
   5,Jane,12dasdf
   6,Jill,asdf
   7,Joy,zxcv
   8,Joy,zxcv
   9,Joy,zxcv
   10,Joy,zxcv
   ```

## Prepare a script file {#test-scenario}

In your test script, specify a sequence of HTTP requests to run during testing. A single file may include multiple scripts. The following file formats are supported:
* hcl
* yaml
* json

1. Prepare your script in the `payload.hcl` file:

   ```hcl
   variable_source "variables" "variables" {
      variables = {
         auth_path = /auth
         order_path = /order
      }
   }


   variable_source "users" "file/csv" {
      file              = "users.csv"
      fields            = ["user_id", "name", "pass"]
      ignore_first_line = true
      delimiter         = ","
   }

   request "auth_req" {
      method  = "POST"
      uri     = "{{.source.variables.auth_path}}"
      headers = {
         Content-Type = "application/json"
         Useragent    = "Yandex"
      }
      body = <<EOF
   {"user_id":  {{.request.auth_req.preprocessor.user_id}}}
   EOF
      tag  = "auth"

      preprocessor {
         mapping = {
            user_id = "source.users[next].user_id"
         }
      }
   }

   request "order_req" {
      method  = "POST"
      uri     = "{{.source.variables.order_path}}?sleep=100"
      headers = {
         Useragent     = "Yandex"
      }
      body = <<EOF
   {"item_id": test_item_id}
   EOF
      tag  = "order"
   }

   scenario "test_scenario" {
      min_waiting_time = 1000
      requests = [
         "auth_req",
         "sleep(100)",
         "order_req(3, 100)"
      ]
   }
   ```

   This `test_scenario` script describes the `auth_req` and `order_req` requests. You can provide arguments to a request to set the number of its runs and the delay time between them. In this example, `order_req(3, 100)` means that `order_req` will run three times with an interval of 100 milliseconds.

   The `min_waiting_time` parameter defines the minimum script execution time in milliseconds. If a script is completed faster, the remaining time will be appended to the script as a delay.

   The script features the `variables` variable source containing the `auth_path` and `order_path` variables. Their values are used to specify the request `uri`.

   Also, the script includes the `users` variable source referring to the data from the external `users.csv` file. To work with an array of users, the script employs a preprocessor with the following modifiers:
   * `next` to get the next array element.
   * `last` to get the last array element.
   * `rand` to get a random array element.

## Run a test {#run-test}

1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. In the left-hand panel, select ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**. Click **{{ ui-key.yacloud.load-testing.button_create-test }}**.
1. In the **{{ ui-key.yacloud.load-testing.label_agents-list }}** parameter, select `agent-008`.
1. Under **Attached files**, click **Select files** and select the `users.csv` and `payload.hcl` files you previously saved.
1. Under **{{ ui-key.yacloud.load-testing.label_test-settings }}**, select the **{{ ui-key.yacloud.load-testing.label_settings-type-config }}** configuration method.

1. In the configuration input field, specify the testing thread settings in `yaml` format:

   ```yaml
      uploader:
         enabled: true
         package: yandextank.plugins.DataUploader
         api_address: loadtesting.{{ api-host }}:443
      pandora:
         enabled: true
         package: yandextank.plugins.Pandora
         config_content:
            pools:
               - id: Pool name
                  gun:
                     type: http/scenario
                     target: 172.17.0.10:80
                  ammo:
                     type: http/scenario
                     file: payload.hcl
                  result:
                     type: phout
                     destination: ./phout.log
                  rps:
                     - duration: 10s
                        type: line
                        from: 1
                        to: 5
                  startup:
                     type: once
                     times: 5
            log:
               level: debug
      autostop:
         enabled: true
         package: yandextank.plugins.Autostop
         autostop:
            - limit (5m)
      core: {}
   ```

1. Click **{{ ui-key.yacloud.common.create }}**.

Afterwards, the configuration will be verified, and the agent will start loading the service being tested.

To see the testing progress, select the created test and go to the **{{ ui-key.yacloud.load-testing.label_test-report }}** tab.

## How to delete the resources you created {#clear-out}

To stop paying for the resources created, just [delete the agent](../../compute/operations/vm-control/vm-delete.md).