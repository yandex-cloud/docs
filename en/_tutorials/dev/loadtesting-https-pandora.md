# Step-load HTTPS testing with Pandora


You can use {{ load-testing-name }} to run step-load tests of a service over HTTPS using the [Pandora](../../load-testing/concepts/load-generator.md#pandora) [load generator](../../load-testing/concepts/load-generator.md).

To perform load testing:
1. [Prepare your cloud](#before-begin).
1. [Prepare a test target](#target-prepare).
1. [Prepare your infrastructure](#infrastructure-prepare).
1. [Create an agent](#create-agent).
1. [Prepare a file with test data](#test-file).
1. [Create and run a test](#run-test).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

If the [agent](../../load-testing/concepts/agent.md) is hosted on {{ yandex-cloud }}, you pay for computing resources (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

At the [Preview](../../overview/concepts/launch-stages.md) stage, {{ load-testing-name }} is free of charge.

## Prepare a test target {#target-prepare}

As a test target, [create a VM](../../compute/operations/vm-create/create-linux-vm.md) from a public Linux image.

In this example, we will test a service with [internal IP address](../../vpc/concepts/address.md#internal-addresses) `172.17.0.10` in the same [subnet](../../vpc/concepts/network.md#subnet) as the agent.

Make sure the service is accessed over HTTPS using the default port: `443`.

You can also use {{ load-testing-name }} for load testing of a service that is public or located in a subnet and [security group](../../vpc/concepts/security-groups.md) other than those of the agent.

For a public service, allow incoming HTTPS traffic on port `443`.

For a service whose subnet and security group is different from the agent's ones, [create](#security-group-setup) a rule for incoming HTTPS traffic on port `443` in the security group where the test target is located.

## Prepare the infrastructure {#infrastructure-prepare}

### Create a service account {#sa-create}

{% include [sa-create](../../_includes/load-testing/sa-create.md) %}

### Configure a network {#network-setup}

[Create and configure a NAT gateway](../../vpc/operations/create-nat-gateway.md) in the subnet where your test target is and where the agent will reside. This will enable the agent to access {{ load-testing-name }}.

### Configure security groups {#security-group-setup}

1. Set up the test agent's security group:

   {% include [security-groups-agent](../../_includes/load-testing/security-groups-agent.md) %}

1. Set up the test target's security group:

   {% include [security-groups-target](../../_includes/load-testing/security-groups-target.md) %}

## Create a test agent {#create-agent}

{% include [create-agent](../../_includes/load-testing/create-agent.md) %}

## Prepare a file with test data {#test-file}

1. Generate payloads in [URI](../../load-testing/concepts/payloads/uri.md) format:

   ```text
   [Host: 172.17.0.10]
   [Connection: Close]
   / index
   /test?param1=1&param2=2 get_test
   ```

   The `Host` parameter indicates the IP address of the test target. The `Connection: Close` parameter specifies whether to close the connection after each request. This mode is heavier on the application and load generator. If you do not need to close the connections, select `Keep-Alive`.

   There are also two requests tagged `index` and `get_test`. The load generator will repeat them within a given [load profile](../../load-testing/concepts/load-profile.md).
1. Save the payloads to a file named `data.uri`.

## Create and run a test {#run-test}

1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. In the left-hand panel, select ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**. Click **{{ ui-key.yacloud.load-testing.button_create-test }}**.
1. In the **{{ ui-key.yacloud.load-testing.label_agents-list }}** parameter, select `agent-008`.
1. Under **{{ ui-key.yacloud.load-testing.test-data-section }}**, click **Select files** and select the `data.uri` file you saved earlier.
1. Under **{{ ui-key.yacloud.load-testing.label_test-settings }}**, select a configuration method: **{{ ui-key.yacloud.load-testing.label_settings-type-form }}** or **{{ ui-key.yacloud.load-testing.label_settings-type-config }}**.
1. Depending on the selected method, specify the test parameters:

   {% list tabs %}

   - {{ ui-key.yacloud.load-testing.label_settings-type-form }}

     1. In the **{{ ui-key.yacloud.load-testing.field_load-generator }}** field, select **PANDORA**.
     1. In the **Target address** field, specify the IP address of the service you are testing: `172.17.0.10`.
     1. In the **Target port** field, specify `443` (default HTTPS port). Allow using a secure connection.
     1. In the **Testing threads** field, specify `5000`.

        This means that the load generator can simultaneously process 5,000 operations: either create 5,000 connections or wait for 5,000 responses from the service at the same time.

        {% note tip %}

        For most tests, 1,000 to 10,000 [threads](../../load-testing/concepts/testing-stream.md) are enough.

        Using more testing threads requires more resources on the part of the [VM](../../compute/concepts/vm.md) the agent is running on. {{ compute-name }} also has a limit of 50,000 of concurrent connections to a VM.

        {% endnote %}

     1. In the **Load type** menu, select `RPS`.
     1. Click ![image](../../_assets/plus-sign.svg) **Load profile** and enter the following description:
        * **Profile 1**: `step`
        * **From**: `1000`
        * **To**: `5000`
        * **Step**: `1000`
        * **Duration**: `120s`

        This is an instruction for the generator to increase the load from 1,000 to 5,000 requests per second in increments of 1,000 requests, 120 seconds each.
     1. In the **Request type** field, select `URI`.
     1. In the **{{ ui-key.yacloud.load-testing.test-data-section }}** field, select **Attached file**.
     1. In the **Autostop** menu, click ![image](../../_assets/plus-sign.svg) **Autostop** and enter the following description:
        * **Autostop type 1**: `QUANTILE`
        * **Quantile**: `75`
        * **Response time limit**: `100ms`
        * **Window duration**: `10s`

        This criterion stops the test if the 75th percentile exceeds 100 milliseconds within 10 seconds (within 10 seconds, the time to process 25% of requests exceeds 100 milliseconds).
     1. Specify one more [autostop](../../load-testing/concepts/auto-stop.md):
        * **Autostop type 2**: `INSTANCES`
        * **Limit**: `90%`
        * **Window duration**: `60s`

        This criterion will stop the test if over 90% of the testing threads are busy for 60 seconds.

        As load increases, the system being tested will start to degrade at some point. Subsequent load increases will result in either an increased response time or an increased error rate. To avoid significantly increasing the test time, make sure to set **Autostop** as a termination criterion for these tests.
     1. Under **Forced test termination time**, specify the time to autostop the test unless it is stopped for other reasons. This parameter value should be slightly greater than the expected test duration.
     1. Under **{{ ui-key.yacloud.load-testing.meta-section }}**, specify the name, description, and number of the test version. This will make the report easier to read.

   - {{ ui-key.yacloud.load-testing.label_settings-type-config }}

     1. In the configuration input field, specify the testing thread settings in `yaml` format:

        ```yaml
        pandora:
          enabled: true
          package: yandextank.plugins.Pandora
          config_content:
            pools:
              - id: HTTP
                gun:
                  type: http # Protocol.
                  target: 172.17.0.10:443 # IP address of the test target.
                  ssl: true
                ammo:
                  type: uri
                  file: data.uri
                result:
                  type: phout
                  destination: ./phout.log
                rps:
                  - duration: 120s # Test duration.
                    type: step # Load type.
                    from: 1000
                    to: 5000
                    step: 1000
                startup:
                  type: once
                  times: 5000 # Number of testing threads.
            log:
              level: error
            monitoring:
              expvar:
                enabled: true
                port: 1234
        autostop: # Autostop.
          enabled: true
          package: yandextank.plugins.Autostop
          autostop:
            - limit(5m) # Make sure to specify the time limit for the test.
            - quantile(75,100ms,10s) # Stop the test if, within 10 seconds, the 75 percentile
                                     # exceeds 100 milliseconds (within 10 seconds, the time
                                     #  to process 25% of requests exceeds 100 milliseconds).
            - instances(90%,60s)  # Stop the test if more than 90% of testing threads
                                  # get busy within 60 seconds.
        core: {}
        uploader:
          enabled: true
          package: yandextank.plugins.DataUploader
          job_name: '[example][pandora][step]'
          job_dsc: 'example'
          ver: '0.5.5'
          api_address: loadtesting.{{ api-host }}:443
        ```

     As load increases, the system being tested will start to degrade at some point. Subsequent load increases will result in either an increased response time or an increased error rate. To avoid significantly increasing the test time, make sure to set **Autostop** as a termination criterion for these tests.

     {% note tip %}

     View a [sample configuration file](../../load-testing/concepts/testing-stream.md#config_example). You can also find sample configuration files in existing tests.

     {% endnote %}

    {% endlist %}

1. Click **{{ ui-key.yacloud.common.create }}**.

With that done, the configuration will pass the checks, and the agent will start loading the service you are testing.

To see the testing progress, select the new test and go to the **{{ ui-key.yacloud.load-testing.label_test-report }}** tab.

## How to delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the agent](../../compute/operations/vm-control/vm-delete.md).
1. [Delete the route table](../../vpc/operations/delete-route-table.md).
1. [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
