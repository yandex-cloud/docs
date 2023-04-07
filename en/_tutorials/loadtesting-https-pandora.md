# Using Pandora to run a step-load HTTPS test

You can use {{ load-testing-full-name }} to run incremental HTTPS load tests of the service with the [Pandora](../load-testing/concepts/load-generator.md#pandora) load generator.

To perform load testing:
1. [Prepare your cloud](#before-begin).
1. [Prepare a test target](#target-prepare).
1. [Prepare the infrastructure](#infrastructure-prepare).
1. [Create an agent](#create-agent).
1. [Prepare a file with test data](#test-file).
1. [Run a test](#run-test).

If you no longer need these resources, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](./_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

If the agent is hosted on {{ yandex-cloud }}, a fee is charged for computing resources (see [{{ compute-full-name }} pricing](../compute/pricing.md)).

At the [Preview](../overview/concepts/launch-stages.md) stage, {{ load-testing-name }} can be used free of charge.

## Prepare a test target {#target-prepare}

In this example, we'll test a service with the `172.17.0.10` internal IP address in the same subnet as the agent.

Make sure the service is accessed over HTTPS using the default port: `443`.

You can also use {{ load-testing-name }} for loading testing of a service that is public or located in a subnet and security group other than those of the agent.

For a public service, allow incoming HTTPS traffic to port `443`.

For a service whose subnet and security group differ from the agent's ones, [create](#security-group-setup) a rule for incoming HTTPS traffic to port `443` in the security group where the test target is located.

## Prepare the infrastructure {#infrastructure-prepare}

### Create a service account {#sa-create}

{% include [sa-create](../_includes/load-testing/sa-create.md) %}

### Configure a network {#network-setup}

[Create and configure a NAT gateway](../vpc/operations/create-nat-gateway.md) in the subnet where your test target is and the agent will be hosted. This ensures the agent has access to {{ load-testing-name }}.

### Configure security groups {#security-group-setup}

1. Set up the test agent's security group:

   {% include [security-groups-agent](../_includes/load-testing/security-groups-agent.md) %}
1. Set up the test target's security group:

   {% include [security-groups-target](../_includes/load-testing/security-groups-target.md) %}

## Create a test agent {#create-agent}

{% include [create-agent](../_includes/load-testing/create-agent.md) %}

## Prepare a file with test data {#test-file}

1. Generate payloads in [URI](../load-testing/concepts/payloads/uri.md) format:

   ```
   [Host: 172.17.0.10]
   [Connection: Close]
   / index
   /test?param1=1&param2=2 get_test
   ```

   Please note that the `Connection: Close` header means each connection is terminated after making a request. This mode is heavier on the application and load generator. If you don't need to close connections, set `Keep-Alive`.

   There are also two requests tagged `index` and `get_test`. The load generator will repeat them within a given load profile.

1. Save the payloads to a file named `data.uri`.

## Run a test {#run-test}

1. In the [management console]({{ link-console-main }}), select **{{ load-testing-name }}**.
1. On the left-hand panel, select ![image](../_assets/load-testing/test.svg) **Tests**. Click **Create test**.
1. Select a setup method: **Form** or **Config**.
1. Depending on the selected method, specify the test parameters:

   {% list tabs %}

   - Form

      1. In the **Agent** parameter, select `agent-008`.
      1. Under **Test data**, upload the `data.uri` file to the **File with test data** field.
      1. Under **Load generator settings**:
         * In the **Load generator** field, select **PANDORA**.
         * In the **Target address** field, specify the address of the service to test: `172.17.0.10`.
         * In the **Target port** field, set `443` (default HTTPS port). Allow using a secure connection.
         * In the **Testing threads** field, specify `5000`.

            This means that the load generator can simultaneously process 5000 operations: create 5000 connections or wait for 5000 responses from the service at the same time.

            {% note tip %}

            For most tests, 1000–10000 threads are enough.

            Using a larger number of threads requires more resources of the VM the agent is running on. {{ compute-name }} also has a limit of 50000 of concurrent connections to a VM.

            [Learn more about working with threads](../load-testing/concepts/testing-stream.md).

            {% endnote %}

         * Expand the **Load schedule** menu:
            * In the **Load type** field, select `RPS`.
            * In the **Load profile** menu, click ![image](../_assets/plus-sign.svg) **Load profile** and enter the following description:

               ```
               {duration: 120s, type: step, from: 1000, to: 5000, step: 1000}
               ```

               This is an instruction for the generator to increase the load from 1000 to 5000 requests per second for 120 seconds in increments of 1000 requests.

               [Learn more about load profiles](../load-testing/concepts/load-profile.md).
         * In the **Request type** field, select `URI`.
         * In the **Autostop** menu, click ![image](../_assets/plus-sign.svg) **Autostop** and enter the following description:
            1. Autostop type: `QUANTILE`. Autostop criteria: `75,100ms,10s`.

               The criterion stops the test if the 75th percentile exceeds 100 milliseconds for 10 seconds (for 10 seconds, the processing time of 25% of queries exceeds 100 milliseconds).

            1. Autostop type: `INSTANCES`. Autostop criteria: `90%,60s`.

               This criterion will stop the test if over 90% of the testing threads are busy for 60 seconds.

            As load increases, the system being tested will start to degrade at some point. Subsequent load increases will result in either an increased response time or an increased error rate.

            To avoid significantly increasing the test time, make sure to set **Autostop** as a termination criterion for these tests.

            [Learn more about autostop](../load-testing/concepts/auto-stop.md).
      1. Under **Test information**, specify the name, description, and number of the test version. This will make the report easier to read.

   - Config

      1. In the **Agent** parameter, select `agent-008`.
      1. Under **Test data**, upload the `data.uri` file to the **File with test data** field.
      1. In the configuration input field, specify the testing thread settings in `yaml` format:

         ```yaml
         pandora:
           enabled: true
           package: yandextank.plugins.Pandora
           config_content:
             pools:
               - id: HTTP
                 gun:
                   type: http               # protocol
                   target: 172.17.0.10:443  # address of testing objective
                   ssl: true
                 ammo:
                   type: uri
                   file: ammo_131b131b-131b-131b-131b-131b13
                 result:
                   type: phout
                   destination: ./phout.log
                 rps:
                   - duration: 120s         # test time
                     type: step             # load type
                     from: 1000
                     to: 5000
                     step: 1000
                 startup:
                   type: once
                   times: 5000              # number of threads
             log:
               level: error
             monitoring:
               expvar:
                 enabled: true
                 port: 1234
         autostop:                          # autostop
           enabled: true
           package: yandextank.plugins.Autostop
           autostop:
             - quantile(75,100ms,10s)       # stop test if 75th percentile exceeds 100 milliseconds for 10 seconds (for 10 seconds, processing time of 25% of queries exceeds 100 milliseconds).
             - instances(90%,60s)           # stop test if 90% of testing threads are being used for 60 seconds.
         core: {}
         uploader:
           enabled: true
           package: yandextank.plugins.DateUploader
           job_name: '[example][pandora][step]'
           job_dsc: 'example'
           ver: '0.5.5'
           api_address: loadtesting.{{ api-host }}:443
         ```

         As load increases, the system being tested will start to degrade at some point. Subsequent load increases will result in either an increased response time or an increased error rate.

         To avoid significantly increasing the test time, make sure to set **Autostop** as a termination criterion for these tests.

         [Learn more about autostop](../load-testing/concepts/auto-stop.md).

         {% note tip %}

         View a [sample configuration file](../load-testing/concepts/testing-stream.md#config_example). You can also find sample configuration files in existing tests.

         {% endnote %}

   {% endlist %}

1. Click **Create**. Once the configuration is verified, the agent starts loading the tested service.
1. To see the testing progress, select the created test and go to the **Report** tab.

## How to delete created resources {#clear-out}

To stop paying for the resources created, just [delete the agent](../compute/operations/vm-control/vm-delete.md).