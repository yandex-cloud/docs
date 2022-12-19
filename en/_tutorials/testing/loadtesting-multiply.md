# Load testing using multiple agents

You can use {{ load-testing-full-name }} to test the service with multiple [testing agents](../../load-testing/concepts/agent.md).

Load testing using multiple agents is used when:
* The testing target includes several instances, and the total inbound and outgoing traffic from them doesn't exceed the [capacity of one agent](../../load-testing/concepts/agent.md#benchmark).
* The requests that are sent to the testing target require a lot of computing capacity.
* Using a testing target is much more effective than a [load generator](../../load-testing/concepts/load-generator.md).

Agents start and apply the load on the testing target synchronously. The [testing results](../../load-testing/concepts/load-test-results.md) are available as generalized and independent [reports](../../load-testing/concepts/reports.md) on each agent.

To run the load testing using multiple agents:
1. [Before you start](#before-you-begin).
1. [Prepare the infrastructure](#infrastructure-prepare).
1. [Create a test agent](#create-agents).
1. [Run a test](#run-test).
1. [View the testing results](#see-results).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

If the agent is hosted on {{ yandex-cloud }}, a fee is charged for computing resources (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

At the [Preview](../../overview/concepts/launch-stages.md) stage, {{ load-testing-name }} can be used free of charge.

## Prepare the infrastructure {#infrastructure-prepare}

### Create a service account {#sa-create}

1. [Create](../../iam/operations/sa/create.md) a service account named `sa-loadtest` in the folder where you are going to place agents.
1. [Assign](../../iam/operations/roles/grant.md) the service account the `loadtesting.generatorClient` [role](../../load-testing/security/#roles-list).

### Configure a network {#network-setup}

[Set up](../../vpc/operations/create-nat-gateway.md) an NAT gateway in the subnet where you are going to place your agents. This ensures the agents have access to {{ load-testing-name }}.

### Configure the security group {#security-group-setup}

{% note info %}

Security groups are at the [Preview stage](../../overview/concepts/launch-stages.md). If they aren't available on your network, all incoming and outgoing traffic is enabled for the resources, and no additional setup is required.

To enable security groups, request access to this feature from the [support team]({{ link-console-support }}/create-ticket).

{% endnote %}

1. For the agents, [create](../../vpc/operations/security-group-create.md) a security group named `agent-sg`.
1. [Add rules](../../vpc/operations/security-group-add-rule.md):
   * A rule for outgoing HTTPS traffic to the {{ load-testing-full-name }} public API:
      * Port range: `443`.
      * Protocol: `TCP`.
      * Source type: `CIDR`.
      * Destination: `0.0.0.0/0`.

      This will enable you to connect the agent to {{ load-testing-name }} so as to control the tests from the interface and get the test results.
   * A rule for outgoing HTTP traffic when generating load to the test target:
      * Port range: `80`.
      * Protocol: `TCP`.
      * Source type: `CIDR`.
      * Destination: `0.0.0.0/0`.

      This enables the agents to apply the load on the testing target.
   * Rules for incoming SSH-traffic:
      * Port range: `22`.
      * Protocol: `TCP`.
      * Source type: `CIDR`.
      * Destination: `0.0.0.0/0`.

      This lets you connect to the agent over SSH and control tests from the console or collect debugging information.

In this example, the load will be applied to an external service named `example.myservice.ru`. For more information about setting up security groups for testing the services running inside the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), see:
* [{#T}](../../load-testing/operations/security-groups-agent.md).
* [{#T}](../../load-testing/operations/security-groups-target.md).

## Create test agents {#create-agents}

1. [Generate](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a pair of SSH keys to connect to the agents over SSH.
1. Create the first agent:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create your agent.
      1. In the list of services, select **{{ load-testing-name }}**.
      1. In the panel on the left, go to the ![image](../../_assets/load-testing/agent.svg) **Agents** tab. Click **Create agent**.
      1. Name the agent, such as `agent-008`.
      1. Select an availability zone to place the agent in.
      1. Under **Agent**:
         * Select the appropriate agent type. For more information, see [Agent performance](../../load-testing/concepts/agent.md#benchmark).
         * Specify the subnet to place the agent in.
         * Specify the test agent's security group.
      1. Under **Access**, specify the information required to access the agent:
         * Select the `sa-loadtest` service account.
         * Enter the username in the **Login** field.

            {% note alert %}

            Don't use the username `root` or other names reserved by the operating system. To perform operations that require superuser permissions, use the command `sudo`.

            {% endnote %}

         * In the **SSH key** field, paste the contents of the public key file.
      1. Click **Create**.
      1. Wait for the VM instance to create. Make sure the agent status changes to `READY_FOR_TEST`.

         {% note info %}

         The agent creation process may stop at the `INITIALIZING_CONNECTION` status if the agent has no [access](../../load-testing/operations/security-groups-agent.md) to `loadtesting.{{ api-host }}:443` or the service account assigned to the agent has no required [roles](../../load-testing/operations/create-agent.md#infrastructure-prepare).

         {% endnote %}

   {% endlist %}

1. Create the second agent named `agent-009`.

If you need to [connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the agents over SSH, [assign](../../compute/operations/vm-control/vm-attach-public-ip.md) to them a public IP address.

## Run a test {#run-test}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ load-testing-name }}**.
   1. In the panel on the left, go to the ![image](../../_assets/load-testing/test.svg) **Tests** tab. Click **Create test**.
   1. Under **Configuration 1**, specify the test parameters for the first agent:
      1. **Agents**: Select the `agent-008` agent.

         In this example, we're going to use different test configurations for the agents. To use the same configuration, select, in the **Agents** field, all the agents that you need to use.
      1. Under **Test settings**:
         * **Setup method**: Select **Form**.
         * **Load generator**: Select **Pandora**.
         * **Target address**: Enter the address of the service to test: `example.myservice.ru`.
         * **Target port**: Set to `80` (default port for the HTTP protocol).
         * **Testing threads**: `1000`.

            This means that the load generator can simultaneously process 1000 operations (create 1000 connections or wait for 1000 responses from the service at the same time). [Learn more about testing pipelines](../../load-testing/concepts/testing-stream.md).
         * In the **Load schedule** menu:
            * **Load type**: Select **RPS**.
            * **Load profile**: Add two test stages:
               * `{type: line, duration: 60s, from: 1, to: 100}`
               * `{type: const, duration: 300s, ops: 100}`

               This instructs the generator to increase the load from 1 to 100 requests per second for the first 60 seconds, and then maintain a load of 100 requests per second for 5 minutes. [Learn more about the load profile](../../load-testing/concepts/load-profile.md).
         * **Request type**: Specify `URI` as the [type](../../load-testing/concepts/payload.md).
         * In the **Requests** menu, add two requests:
            * `/ index`
            * `/test?param1=1&param2=2 get_test`

            The requests are marked with the `index` and `get_test` tags. The load generator will repeat them within a given load profile.
         * In the **Request headers** menu, specify the headers:
            * `[Host: example.myservice.ru]`
            * `[Connection: Close]`

            Please note that the `Connection: Close` header means each connection is terminated after making a request. This mode is heavier on the tested service and load generator. If you don't need to close connections, set `Keep-Alive`.
   1. Click ![image](../../_assets/plus-sign.svg) **Duplicate configuration**. The testing parameters will be copied to the **Configuration 2** settings.
   1. Under **Configuration 2**, specify the test parameters for the second agent:
      1. **Agents**: Select the `agent-009` agent.
      1. Under **Test settings**, change the testing parameters.

         For example, in the **Autostop** menu, click ![image](../../_assets/plus-sign.svg) **Autostop** and enter the following description:
         * Autostop type: `INSTANCES`.
         * Autostop criteria: `90%,60s`.

         This means a test will be stopped if 90% of testing threads are used for 60 seconds, which indicates a testing issue. [Learn more about autostop](../../load-testing/concepts/auto-stop.md).
   1. Under **Test information**, specify the name, description, and number of the test version. This will make the reports readable.
   1. Click **Create**.

   The configurations will be checked, and the agents will start applying the load against the tested service.

{% endlist %}

## View the testing results {#see-results}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ load-testing-name }}**.
   1. In the panel on the left, go to the ![image](../../_assets/load-testing/test.svg) **Tests** tab.
   1. Select the test that you created previously. Test with multiple agents have the `Multi` label.
   1. To view generalized results, go to the tab ![image](../../_assets/load-testing/results.svg) **Test results**.
   1. To view the test results for each agent individually:
      1. Go to ![image](../../_assets/load-testing/overview.svg) **Overview**.
      1. Select an appropriate agent under **Tests**.
      1. Go to ![image](../../_assets/load-testing/results.svg) **Test results**.

{% endlist %}

## How to delete created resources {#clear-out}

To stop paying for the resources created, [delete](../../compute/operations/vm-control/vm-delete.md) the testing agents.