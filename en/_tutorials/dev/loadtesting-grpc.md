# Load testing a gRPC service


You can use {{ load-testing-name }} for service load testing via [gRPC](https://grpc.io/docs/) with the [Pandora](../../load-testing/concepts/load-generator.md) [load generator](../../load-testing/concepts/load-generator.md#pandora).

To perform load testing:
1. [Get your cloud ready](#before-begin).
1. [Prepare a test target](#target-prepare).
1. [Prepare your infrastructure](#infrastructure-prepare).
1. [Create an agent](#create-agent).
1. [Test gRPC Server Reflection](#reflection-check).
1. [Prepare a file with test data](#test-file).
1. [Run a test](#run-test).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

If the [agent](../../load-testing/concepts/agent.md) is hosted on {{ yandex-cloud }}, you pay for computing resources (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

At the [Preview](../../overview/concepts/launch-stages.md) stage, {{ load-testing-name }} is free of charge.

## Prepare a test target {#target-prepare}

In this example, we will be using a gRPC service with the `172.17.0.10` [internal IP address](../../vpc/concepts/address.md#internal-addresses) in the same [subnet](../../vpc/concepts/network.md#subnet) as where the agent will reside.

To learn how to integrate the gRPC framework for different programming languages, see the [documentation](https://grpc.io/docs/languages/).
1. Configure support for gRPC Server Reflection. To learn how to configure gRPC Server Reflection for different programming languages, see the [documentation](https://grpc.github.io/grpc/core/md_doc_server-reflection.html).

   With gRPC Server Reflection, the load generator polls the server at the start of a test to collect information about services and their methods and uses this data to generate correct gRPC requests during the test.
1. Install a port for access to the gRPC service: `8080`.

You can also use {{ load-testing-name }} for load testing of a service that is public or located in a subnet and [security group](../../vpc/concepts/security-groups.md) other than those of the agent.

For a public service, allow incoming HTTPS traffic on port `8080`.

For a service whose subnet and security group is different from the agent's ones, [create](#security-group-setup) a rule for incoming HTTPS traffic on port `8080` in the security group where the test target is located.

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

## Test gRPC Server Reflection {#reflection-check}

1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the agent via SSH.
1. Run the following command to test gRPC Server Reflection on the gRPC service:

   {% list tabs group=connection %}

   - Connecting via TLS {#with-tls}

     ```bash
     grpcurl 172.17.0.10:8080 list
     ```

   - Connecting without TLS {#without-tls}

     ```bash
     grpcurl --plaintext 172.17.0.10:8080 list
     ```

   {% endlist %}

   Result:

   ```text
   api.Adder
   grpc.reflection.v1alpha.ServerReflection
   ```

## Prepare a file with test data {#test-file}

1. Generate payloads in [HTTP_JSON](../../load-testing/concepts/payloads/http-json.md) format:

   ```JSON
   {"tag": "/Add", "call": "api.Adder.Add", "payload": {"x": 21, "y": 12}}
   {"tag": "/Add", "call": "api.Adder.Add", "payload": {"x": 21, "y": 12}}
   {"tag": "/Add2", "call": "api.Adder.Add", "payload": {"x": 210, "y": 120}}
   ```

   Where:
   * `tag`: Request tag to display in reports.
   * `call`: Method being called.
   * `payload`: Dictionary with call parameters to provide to the test target.

   In our example, two thirds of requests will be tagged as `/Add` and one third, as `/Add2`.
1. Save the payloads to a file named `data.json`.

## Run a test {#run-test}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. In the left-hand panel, select ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
  1. Click **{{ ui-key.yacloud.load-testing.button_create-test }}**.
  1. On the test creation page:
     1. In the **{{ ui-key.yacloud.load-testing.label_agents-list }}** field, select `agent-008` you [previously created](#create-agent).
     1. Under **Attached files**, click **Select files** and select the `data.json` file you saved before.
     1. Under **{{ ui-key.yacloud.load-testing.label_test-settings }}**:
        * In the **{{ ui-key.yacloud.load-testing.field_settings-type }}** field, select **{{ ui-key.yacloud.load-testing.label_settings-type-config }}**.
        * In the configuration input field, specify the testing thread settings in `yaml` format:

          ```yaml
          pandora:
            enabled: true
            pandora_cmd: /usr/local/bin/pandora
            package: yandextank.plugins.Pandora
            config_content:
              pools:
                - id: GRPC
                  gun:
                    type: grpc # Protocol.
                    target: 172.17.0.10:8080 # Address of the test target.
                    tls: false
                  ammo:
                    type: grpc/json
                    file: data.json # The file name must be the same as the name of the attached file.
                  result:
                    type: phout
                    destination: ./phout.log
                  rps:
                    - duration: 180s # Test duration.
                      type: line # Load type.
                      from: 1
                      to: 1500
                  startup:
                    type: once
                    times: 1500 # Number of threads.
              log:
                level: debug
              monitoring:
                expvar:
                  enabled: true
                  port: 1234
          autostop:
            enabled: true
            package: yandextank.plugins.Autostop
            autostop:
               - limit (5m)
          uploader:
            api_address: loadtesting.{{ api-host }}:443
            enabled: true
            job_dsc: grpc test
            job_name: '[pandora][config][grpc]'
            package: yandextank.plugins.DataUploader
            ver: '1.1'
          core: {}
          ```

          {% note tip %}

          View a [sample configuration file](../../load-testing/concepts/testing-stream.md#config_example). You can also find sample configuration files in existing tests.

          {% endnote %}

     1. Click **{{ ui-key.yacloud.common.create }}**.

    With that done, the configuration will pass the checks, and the agent will start loading the gRPC service you are testing.

    To see the testing progress, select the new test and go to the **{{ ui-key.yacloud.load-testing.label_test-report }}** tab.

{% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the agent](../../compute/operations/vm-control/vm-delete.md).
1. [Delete the route table](../../vpc/operations/delete-route-table.md).
1. [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
