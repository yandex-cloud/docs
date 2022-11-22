# gRPC service load testing

You can use {{ load-testing-full-name }} for service load testing via [gRPC](https://grpc.io/docs/) using the [Pandora](../load-testing/concepts/load-generator.md#pandora) load generator.

To perform load testing:

1. [Before you start](#before-begin).
1. [Prepare the test target](#target-prepare).
1. [Prepare the infrastructure](#infrastructure-prepare).
1. [Create an agent](#create-agent).
1. [Test gRPC Server Reflection](#reflection-check).
1. [Prepare a file with test data](#test-file).
1. [Run the test](#run-test).

If you no longer need the created resources, [delete them](#clear-out).

## Before you start {#before-begin}

{% include [before-you-begin](./_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

If the agent is hosted on the {{ yandex-cloud }} platform, a fee is charged for computing resources (see [{{ compute-full-name }} pricing](../compute/pricing.md)).

During the [Preview stage](../overview/concepts/launch-stages), {{ load-testing-name }} can be used free of charge.

{% endif %}

## Prepare the test target {#target-prepare}

In the given example, we'll use the gRPC service with the internal IP `172.17.0.10` in the same subnet as the agent.

For instructions on how to integrate the gRPC framework for different programming languages, see the [documentation](https://grpc.io/docs/languages/).

1. Configure support for gRPC Server Reflection. For instructions on how to configure gRPC Server Reflection for different programming languages, see the [documentation](https://grpc.github.io/grpc/core/md_doc_server-reflection.html).

    With gRPC Server Reflection, the load generator polls the server at the start of a test to collect information about services and their methods and uses this data to generate correct gRPC requests during the test.

1. Set the port to access the gRPC service to `8080`.

You can also use {{ load-testing-name }} for load testing of a public service or a service hosted in a different subnet and security group than those of the agent.

For a public service, allow incoming HTTPS traffic to port `8080`.

For a service hosted in a subnet and security group other than those of the agent, [create](#security-group-setup) a rule for incoming HTTPS traffic to port `8080` in the security group with the test target.

## Prepare the infrastructure {#infrastructure-prepare}

### Create a service account {#sa-create}

{% include [sa-create](../_includes/load-testing/sa-create.md) %}

### Configure a network {#network-setup}

[Enable](../vpc/operations/enable-nat.md) NAT to the internet in the subnet where the test target is located and the agent will be placed. This ensures that the agent has access to {{ load-testing-name }}.

### Configure security groups {#security-group-setup}

1. Set up the security group of your test agent:

    {% include [security-groups-agent](../_includes/load-testing/security-groups-agent.md) %}

1. Set up the security group of the test target:

    {% include [security-groups-target](../_includes/load-testing/security-groups-target.md) %}

## Create a test agent {#create-agent}

{% include [create-agent](../_includes/load-testing/create-agent.md) %}

## Test gRPC Server Reflection {#reflection-check}

1. [Connect](../compute/operations/vm-connect/ssh.md#vm-connect) to the agent over SSH.

1. Run the command to test gRPC Server Reflection on the gRPC service:

    {% list tabs %}

    - TLS connection

      ```bash
      grpcurl 172.17.0.10:8080 list
      ```

    - Standard connection

      ```bash
      grpcurl --plaintext 172.17.0.10:8080 list
      ```

    {% endlist %}

    Result:

    ```bash
    api.Adder
    grpc.reflection.v1alpha.ServerReflection
    ```

## Prepare a file with test data {#test-file}

1. Generate payloads in [HTTP_JSON](../load-testing/concepts/payloads/http-json.md) format:

    ```JSON
    {"tag": "/Add", "call": "api.Adder.Add", "payload": {"x": 21, "y": 12}}
    {"tag": "/Add", "call": "api.Adder.Add", "payload": {"x": 21, "y": 12}}
    {"tag": "/Add2", "call": "api.Adder.Add", "payload": {"x": 210, "y": 120}}
    ```

    Where:

    * `tag`: The request tag to display in reports.
    * `call`: The method being called.
    * `payload`: A dictionary with call parameters passed to the test target.

    In the given example, two-thirds of requests will be tagged as `/Add` and one third as `/Add2`.

1. Save the payloads to a file named `data.json`.

## Run the test {#run-test}

{% list tabs %}

- Management console

  1. Select **{{ load-testing-name }}** in [management console]({{ link-console-main }}).

  1. In the left-hand panel, select ![image](../_assets/load-testing/test.svg) **Tests**. Click **Create test**.

  1. Set the test parameters:
      * **Configuration method**: Select **Config**.
      * **Agent**: Select the [previously created](#create-agent) `agent-008`.

  1. Upload the `data.json` file in the **File with test data** field.

  1. In the configuration input field, enter the testing thread settings in `yaml` format:

      ```yaml
      pandora:
        enabled: true
        pandora_cmd: /usr/local/bin/pandora
        package: yandextank.plugins.Pandora
        config_content:
          pools:
              - id: GRPC
              gun:
                type: grpc                # protocol
                target: 172.17.0.10:8080  # test target IP address
                tls: false
              ammo:
                type: grpc/json
                file: ammo_123
              result:
                type: phout
                destination: ./phout.log
              rps:
                 - duration: 180s         # test duration
                  type: line              # load type
                  from: 1
                  to: 1500
              startup:
                 - type: once
                  times: 1500             # number of threads
          log:
            level: debug
          monitoring:
            expvar:
              enabled: true
              port: 1234
      uploader:
        api_address: loadtesting.{{ api-host }}:443
        enabled: true
        job_dsc: grpc test
        job_name: '[pandora][config][grpc]'
        package: yandextank.plugins.DataUploader
        ver: '1.1'
      ```

      {% note tip %}

      Below is a [sample configuration file](../load-testing/concepts/testing-stream.md#config_example). You can also find sample configuration files in existing tests.

      {% endnote %}

  1. Click **Create**. Afterwards, the configuration will be verified, and the agent will start loading the gRPC service being tested.

  1. To monitor the results of testing, select the created test and go to the **Report** tab.

{% endlist %}

## How to delete created resources {#clear-out}

To stop paying for the created resources, just [delete the agent](../compute/operations/vm-control/vm-delete.md).

