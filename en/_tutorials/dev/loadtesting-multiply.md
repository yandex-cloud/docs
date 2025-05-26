# Load testing using multiple agents


You can use {{ load-testing-name }} to test your service with multiple [agents](../../load-testing/concepts/agent.md).

You can use multiple agents for load testing when:
* The test target includes multiple [instances](../../compute/concepts/vm.md), and the total incoming and outgoing traffic from them does not exceed the [capacity of one agent](../../load-testing/concepts/agent.md#benchmark).
* Requests to the test target require significant computing capacity.
* Using a test target is much more effective than a [load generator](../../load-testing/concepts/load-generator.md).

Agents launch and load the test target synchronously. [Test results](../../load-testing/concepts/load-test-results.md) are available as cumulative and independent [reports](../../load-testing/concepts/reports.md) on each agent.

To run a load test using multiple agents:
1. [Get your cloud ready](#before-you-begin).
1. [Set up your infrastructure](#infrastructure-prepare).
1. [Create a test agent](#create-agents).
1. [Run the test](#run-test).
1. [View the testing results](#see-results).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

If the agent is hosted on {{ yandex-cloud }}, you pay for computing resources (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

At the [Preview](../../overview/concepts/launch-stages.md) stage, {{ load-testing-name }} is free of charge.

## Set up your infrastructure {#infrastructure-prepare}

### Create a service account {#sa-create}

1. [Create](../../iam/operations/sa/create.md) a [service account](../../iam/concepts/users/service-accounts.md) named `sa-loadtest` in the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the agents will reside.
1. [Assign](../../iam/operations/roles/grant.md) the `loadtesting.generatorClient` [role](../../load-testing/security/index.md#roles-list) to the service account.

### Configure your network {#network-setup}

[Set up](../../vpc/operations/create-nat-gateway.md) a [NAT gateway](../../vpc/concepts/gateways.md) in the [subnet](../../vpc/concepts/network.md#subnet) to host the agents. This will allow the agents to access {{ load-testing-name }}.

### Configure the security group {#security-group-setup}

1. For the agents, [create](../../vpc/operations/security-group-create.md) a [security group](../../vpc/concepts/security-groups.md) named `agent-sg`.
1. [Add rules](../../vpc/operations/security-group-add-rule.md):
   * Rule for outgoing HTTPS traffic to the {{ load-testing-name }} public API:
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `443`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `CIDR`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

     This will allow you to connect the agent to {{ load-testing-name }} and manage the tests using the interface and get the test results.
   * Rule for outgoing HTTP traffic when generating load to the test target:
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `80`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `CIDR`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

     This enables the agents to load the test target.
   * Rules for incoming SSH traffic:
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `CIDR`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

     This will allow you to connect to the agent over SSH and manage tests from the console or collect debugging information.

In this example, an external service named `example.myservice.ru` will be loaded. For more information about setting up security groups for testing the services running inside the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), see:
* [{#T}](../../load-testing/operations/security-groups-agent.md).
* [{#T}](../../load-testing/operations/security-groups-target.md).

## Create test agents {#create-agents}

1. If you do not have an SSH key pair yet, [create one](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
1. Create the first agent:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you want to create the agent.
     1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
     1. In the ![image](../../_assets/load-testing/agent.svg) **{{ ui-key.yacloud.load-testing.label_agents-list }}** tab, click **{{ ui-key.yacloud.load-testing.button_create-agent }}**.
     1. Enter a name for the agent, e.g., `agent-008`.
     1. Select an [availability zone](../../overview/concepts/geo-scope.md) to host the agent.
     1. Under **{{ ui-key.yacloud.load-testing.section_agent }}**:
        * Select the appropriate [agent type](../../load-testing/concepts/agent.md#benchmark).
        * Specify the subnet to host the agent. Make sure you [created and set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) in the subnet.
        * If you can use security groups, select a preset agent security group.
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the agent access credentials:
        * Select the `sa-loadtest` service account.
        * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter the username.

          {% note alert %}

          Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.

          {% endnote %}

        * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file.
     1. Click **{{ ui-key.yacloud.common.create }}**.
     1. Wait until the VM instance is created. Make sure the agent status has changed to `Ready for test`.

        {% note info %}

        The agent creation process may stop at the `Initializing connection` status unless the following conditions are met:
        * The agent has a [public IP address](../../vpc/concepts/address.md) and [access](../../load-testing/operations/security-groups-agent.md) to `loadtesting.{{ api-host }}:443`.
        * A NAT gateway is [set up](../../vpc/operations/create-nat-gateway.md) in the target subnet.
        * The service account assigned to the agent has the required [roles](../../load-testing/operations/create-agent.md#infrastructure-prepare).

        {% endnote %}

   {% endlist %}

1. Follow the same steps to create the second agent named `agent-009`.

If you need to [connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the agents over SSH, [assign](../../compute/operations/vm-control/vm-attach-public-ip.md) to them a public IP address.

## Run the test {#run-test}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. In the left-hand panel, select ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
  1. Click **{{ ui-key.yacloud.load-testing.button_create-test }}**.
  1. Under **Configuration 1**, specify the test parameters for the first agent:
     1. **{{ ui-key.yacloud.load-testing.label_agents-list }}**: Select `agent-008`.

        In this example, the agents will have different test configurations. To use the same configuration, in the **{{ ui-key.yacloud.load-testing.label_agents-list }}** field, select all the agents you need to use.
     1. Under **{{ ui-key.yacloud.load-testing.label_test-settings }}**:
        * **{{ ui-key.yacloud.load-testing.field_settings-type }}**: Select `{{ ui-key.yacloud.load-testing.label_settings-type-form }}`.
        * **{{ ui-key.yacloud.load-testing.field_load-generator }}**: Select `Pandora`.
        * **Target address**: Enter the address of the service to test, `example.myservice.ru`.
        * **Target port**: Enter `80` (default port for the HTTP protocol).
        * **Testing threads**: Enter `1000`.

        This means that the load generator can simultaneously process 1,000 operations: either create 1,000 connections or wait for 1,000 responses from the service at the same time. [Learn more about testing threads](../../load-testing/concepts/testing-stream.md).

        {% note warning %}

        Make sure the agent has access to `example.myservice.ru:80`.

        {% endnote %}

        * In the **Load type** menu:
          * Select the `RPS` type.
          * Add a **Load profile**:
            * **Profile 1**: `line`
            * **From**: `1`
            * **To**: `100`
            * **Duration**: `60s`
          * Add another **Load profile**:
            * **Profile 2**: `const`
            * **Responses per second**: `100`
            * **Duration**: `300s`

          This instructs the load generator to increase the load from 1 to 100 requests per second for the first 60 seconds, and then maintain a load of 100 requests per second for 5 minutes. [Learn more about the load profile](../../load-testing/concepts/load-profile.md).
        * **Request type**: Specify `URI` as the [type](../../load-testing/concepts/payloads/uri.md).
        * In the **{{ ui-key.yacloud.load-testing.test-data-section }}** field, select **{{ ui-key.yacloud.load-testing.label_settings-type-form }}**. In the menu that opens:
          * In the **Requests** menu, add the following requests:
            * `/ index`
            * `/test?param1=1&param2=2 get_test`

          The requests are tagged `index` and `get_test`. The load generator will repeat them alternately within the specified load profile.
        * In the **Request headers** menu, specify the following headers:
          * `[Host: example.myservice.ru]`
          * `[Connection: Close]`

            Please note that the `Connection: Close` header means that each connection will be closed following the request. This mode is heavier on the tested service and load generator. If you do not want the connections closed, set `Keep-Alive`.
        * Under **Forced test termination time**, specify the time after which the test will autostop, unless it is stopped for other reasons. Set it to be slightly greater than the expected test duration.
  1. Click ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.load-testing.button_duplicate-configuration }}**. The test parameters will be copied to the **Configuration 2** settings.
  1. Under **Configuration 2**, specify the test parameters for the second agent:
     1. **{{ ui-key.yacloud.load-testing.label_agents-list }}**: Select `agent-009`.
     1. Under **{{ ui-key.yacloud.load-testing.label_test-settings }}**, change the test parameters.

        For example, in the **Autostop** menu, click ![image](../../_assets/plus-sign.svg) **Autostop** and enter the following description:
        * **Autostop type**: `INSTANCES`
        * **Limit**: `90%`
        * **Window duration**: `60s`

        This criterion will stop the test if over 90% of the testing threads are busy for 60 seconds, which indicates a testing issue.
  1. Under **{{ ui-key.yacloud.load-testing.meta-section }}**, specify the name, description, and number of the test version. This will make the reports easier to read.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  The configurations will be checked, and the agents will start loading the service. You can check the report on the **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab.

{% endlist %}

## View the testing results {#see-results}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. In the left-hand panel, go to the ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab.
  1. Select the test that you created earlier. Tests using multiple agents have the `Multi` label.
  1. To view cumulative results, go to the ![image](../../_assets/load-testing/results.svg) **{{ ui-key.yacloud.load-testing.label_test-report }}** tab.
  1. To view the test results for each agent individually:
     1. Navigate to the ![image](../../_assets/load-testing/overview.svg) **{{ ui-key.yacloud.common.overview }}** tab.
     1. Select the agent under **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
     1. Navigate to the ![image](../../_assets/load-testing/results.svg) **{{ ui-key.yacloud.load-testing.label_test-report }}** tab.

{% endlist %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete](../../compute/operations/vm-control/vm-delete.md) the testing agents.