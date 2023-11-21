# Using Phantom to run a fixed-load HTTPS test

{{ load-testing-name }} can be used for testing a fixed-load service over HTTPS using the [Phantom](../../load-testing/concepts/load-generator.md#phantom) [load generator](../../load-testing/concepts/load-generator.md).

To perform load testing:
1. [Prepare your cloud](#before-begin)
1. [Prepare a test target](#target-prepare)
1. [Prepare your infrastructure](#infrastructure-prepare)
1. [Create an agent](#create-agent)
1. [Prepare a file with test data](#test-file)
1. [Run a test](#run-test)

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

If the [agent](../../load-testing/concepts/agent.md) is hosted on {{ yandex-cloud }}, a fee is charged for computing resources (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

At the [Preview](../../overview/concepts/launch-stages.md) stage, {{ load-testing-name }} can be used free of charge.

## Prepare a test target {#target-prepare}

In this example, we will test a service with the `172.17.0.10` [internal IP address](../../vpc/concepts/address.md#internal-addresses) in the same [subnet](../../vpc/concepts/network.md#subnet) as the agent.

Make sure the service is accessed over HTTPS using the default port: `443`.

You can also use {{ load-testing-name }} for load testing of a service that is public or located in a subnet and [security group](../../vpc/concepts/security-groups.md) other than those of the agent.

For a public service, allow incoming HTTPS traffic to port `443`.

For a service whose subnet and security group differ from the agent's ones, [create](#security-group-setup) a rule for incoming HTTPS traffic to port `443` in the security group where the test target is located.

## Prepare the infrastructure {#infrastructure-prepare}

### Create a service account {#sa-create}

{% include [sa-create](../../_includes/load-testing/sa-create.md) %}

### Configure a network {#network-setup}

[Create and configure a NAT gateway](../../vpc/operations/create-nat-gateway.md) in the subnet where your test target is and the agent will be hosted. This ensures the agent has access to {{ load-testing-name }}.

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

   Please note that the `Connection: Close` header means each connection is terminated after making a request. This mode is heavier on the application and load generator. If you do not need to close connections, set `Keep-Alive`.

   There are also two requests tagged `index` and `get_test`. The load generator will repeat them within a given [load profile](../../load-testing/concepts/load-profile.md).
1. Save the payloads to a file named `data.uri`.

## Run a test {#run-test}

1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. In the left-hand panel, select ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**. Click **{{ ui-key.yacloud.load-testing.button_create-test }}**.
1. In the **{{ ui-key.yacloud.load-testing.label_agents-list }}** parameter, select `agent-008`.
1. Under **Attached files**, click **Select files** and select the `data.uri` file you saved earlier.
1. Under **{{ ui-key.yacloud.load-testing.label_test-settings }}**, select a configuration method: `{{ ui-key.yacloud.load-testing.label_settings-type-form }}` or `{{ ui-key.yacloud.load-testing.label_settings-type-config }}`.
1. Depending on the selected method, specify the test parameters:

   {% list tabs %}

   - Form

      1. In the **{{ ui-key.yacloud.load-testing.field_load-generator }}** field, select `PHANTOM`.
      1. In the **{{ ui-key.yacloud.load-testing.field_target-address }}** field, specify the IP address of the service to test: `172.17.0.10`.
      1. In the **{{ ui-key.yacloud.load-testing.field_target-port }}** field, set `443` (default HTTPS port). Allow using a secure connection.
      1. In the **Testing threads** field, specify `5000`.

         This means that the load generator can simultaneously process 5,000 operations: create 5,000 connections or wait for 5,000 responses from the service at the same time.

         {% note tip %}

         For most tests, 1,000 to 10,000 [threads](../../load-testing/concepts/testing-stream.md) are enough.

         Using a larger number of threads requires more resources of the [VM](../../compute/concepts/vm.md) the agent is running on. {{ compute-name }} also has a limit of 50,000 of concurrent connections to a VM.

         {% endnote %}

      1. In the **Load type** menu, select `RPS`.
      1. Add a **Load profile**:
         * **Profile**: `Const`
         * **{{ ui-key.yacloud.load-testing.label_rps }}**: `2000`
         * **Duration**: `10m`

         This instructs the load generator to maintain a load of 2,000 requests per second for 10 minutes.
      1. In the **Request type** field, select `URI`.
      1. In the **{{ ui-key.yacloud.load-testing.test-data-section }}** field, select **Attached file**.
      1. In the **Autostop** menu, click ![image](../../_assets/plus-sign.svg) **Autostop** and enter the following description:
         * **Autostop type**: `INSTANCES`
         * **Limit**: `90%`
         * **Window duration**: `60s`

         This means a test will be stopped if 90% of testing threads are used for 60 seconds, which indicates a testing issue. [Learn more about autostop](../../load-testing/concepts/auto-stop.md).
      1. Under **{{ ui-key.yacloud.load-testing.meta-section }}**, specify the name, description, and number of the test version. This will make the report easier to read.

   - Configuration file

      1. In the configuration input field, specify the testing thread settings in `yaml` format:

         ```yaml
         phantom:
           enabled: true
           package: yandextank.plugins.Phantom
           address: 172.17.0.10:443 # Test target IP.
           ammo_type: uri
           load_profile:
             load_type: rps
             schedule: const(2000,5m) # # Load schedule: 2,000 requests per second for 5 minutes.
           ssl: true
           instances: 5000 # Number of threads.
           ammofile: data.uri
         core: {}
         autostop: # Autostop.
           enabled: true
           package: yandextank.plugins.Autostop
           autostop:
             - instances(90%,60s) # Stop the test if over 90% of testing threads are used
                                 # for 60 seconds, which indicates
                                 # a testing issue.
         uploader:
           enabled: true
           package: yandextank.plugins.DataUploader
           job_name: '[example][phantom][const]'
           job_dsc: 'example'
           ver: '0.5.5'
           api_address: loadtesting.{{ api-host }}:443
         ```

         [Learn more about autostop](../../load-testing/concepts/auto-stop.md).

         {% note tip %}

         View a [sample configuration file](../../load-testing/concepts/testing-stream.md#config_example). You can also find sample configuration files in existing tests.

         {% endnote %}

   {% endlist %}

1. Click **{{ ui-key.yacloud.common.create }}**.

Afterwards, the configuration will be verified, and the agent will start loading the service being tested.

To see the testing progress, select the created test and go to the **{{ ui-key.yacloud.load-testing.label_test-report }}** tab.

## How to delete the resources you created {#clear-out}

To stop paying for the resources created, just [delete the agent](../../compute/operations/vm-control/vm-delete.md).
