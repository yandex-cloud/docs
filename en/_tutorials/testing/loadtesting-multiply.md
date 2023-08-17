# Load testing using multiple agents

You can use {{ load-testing-full-name }} to test the service with multiple [testing agents](../../load-testing/concepts/agent.md).

Load testing using multiple agents is used when:
* The testing target includes several instances, and the total inbound and outgoing traffic from them doesn't exceed the [capacity of one agent](../../load-testing/concepts/agent.md#benchmark).
* The requests being sent to the testing target require large computing capacity.
* Using a testing target is much more effective than a [load generator](../../load-testing/concepts/load-generator.md).

Agents start and apply the load on the testing target synchronously. The [testing results](../../load-testing/concepts/load-test-results.md) are available as generalized and independent [reports](../../load-testing/concepts/reports.md) on each agent.

To run the load testing using multiple agents:
1. [Prepare your cloud](#before-you-begin).
1. [Prepare the infrastructure](#infrastructure-prepare).
1. [Create a test agent](#create-agents).
1. [Run a test](#run-test).
1. [View the testing results](#see-results).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

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

{% include [security-groups-note-services](../../_includes/vpc/security-groups-note-services.md) %}

{% endnote %}

1. For the agents, [create](../../vpc/operations/security-group-create.md) a security group named `agent-sg`.
1. [Add rules](../../vpc/operations/security-group-add-rule.md):
   * Rule for outgoing HTTPS traffic to the {{ load-testing-full-name }} public API:
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `443`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `CIDR`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

      This will enable you to connect the agent to {{ load-testing-name }} so as to control the tests from the interface and get the test results.
   * A rule for outgoing HTTP traffic when generating load to the test target:
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `80`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `CIDR`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

      This enables the agents to apply the load on the testing target.
   * Rules for incoming SSH-traffic:
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `CIDR`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

      This lets you connect to the agent over SSH and control tests from the console or collect debugging information.

In this example, the load will be applied to an external service named `example.myservice.ru`. For more information about setting up security groups for testing the services running inside the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), see:
* [{#T}](../../load-testing/operations/security-groups-agent.md).
* [{#T}](../../load-testing/operations/security-groups-target.md).

## Create test agents {#create-agents}

1. If you do not have an SSH key pair yet, [create them](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
1. Create the first agent:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create your agent.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
      1. In the ![image](../../_assets/load-testing/agent.svg) **{{ ui-key.yacloud.load-testing.label_agents-list }}** tab, click **{{ ui-key.yacloud.load-testing.button_create-agent }}**.
      1. Give your agent a name, e.g., `agent-008`.
      1. Select an availability zone to place the agent in.
      1. Under **{{ ui-key.yacloud.load-testing.section_agent }}**:
         * Select the appropriate agent type. For more information, see [Agent performance](../../load-testing/concepts/agent.md#benchmark).
         * Specify the subnet to place the agent in. Make sure you created and set up a [NAT gateway](../../vpc/operations/create-nat-gateway.md) in the subnet.
         * If security groups are available to you, select a security group preset for the agent.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the agent:
         * Select the `sa-loadtest` service account.
         * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.

            {% note alert %}

            Do not use the `root` username or other names reserved by the operating system. To perform operations that require superuser permissions, use the `sudo` command.

            {% endnote %}

         * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file.
      1. Click **{{ ui-key.yacloud.common.create }}**.
      1. Wait for the VM instance to create. Make sure the agent status changes to `Ready for test`.

         {% note info %}

         The agent creation process may stop at the `Initializing connection` status unless the following conditions are met:
         * The agent has [access](../../load-testing/operations/security-groups-agent.md) to `loadtesting.{{ api-host }}:443` and is assigned a public IP address.
         * A NAT gateway is [set up](../../vpc/operations/create-nat-gateway.md) in the target subnet.
         * The service account assigned to the agent has the required [roles](../../load-testing/operations/create-agent.md#infrastructure-prepare).

         {% endnote %}

   {% endlist %}

1. Create the second agent named `agent-009`.

If you need to [connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the agents over SSH, [assign](../../compute/operations/vm-control/vm-attach-public-ip.md) to them a public IP address.

## Run a test {#run-test}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
   1. In the left-hand panel, select ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
   1. Click **{{ ui-key.yacloud.load-testing.button_create-test }}**.
   1. Under **{{ ui-key.yacloud.load-testing.label_test-config }} 1**, specify the test parameters for the first agent:

      1. **{{ ui-key.yacloud.load-testing.label_agents-list }}**: Select the `agent-008` agent.

         In this example, the agents will have different test configurations. To use the same configuration, in the **{{ ui-key.yacloud.load-testing.label_agents-list }}** field, select all the agents you need to use.
      1. Under **{{ ui-key.yacloud.load-testing.label_test-settings }}**:
         * **{{ ui-key.yacloud.load-testing.field_settings-type }}**: Select `{{ ui-key.yacloud.load-testing.label_settings-type-form }}`.
         * **{{ ui-key.yacloud.load-testing.field_load-generator }}**: Select `Pandora`.
         * **{{ ui-key.yacloud.load-testing.field_target-address }}**: Enter the address of the service to test: `example.myservice.ru`.
         * **{{ ui-key.yacloud.load-testing.field_target-port }}**: Set to `80` (default port for the HTTP protocol).
         * **Testing threads**: `1000`.

            This means that the load generator can simultaneously process 1000 operations: either create 1000 connections or wait for 1000 responses from the service at the same time. You can learn more about testing pipelines [here](../../load-testing/concepts/testing-stream.md).

            {% note warning %}

            Make sure the agent has access to `example.myservice.ru:80`.

            {% endnote %}

         * In the **Load type** menu:
            * Select the `RPS` type.
            * Add a **Load profile**:
               * **Profile 1**: Select `line`.
               * **From**: Set `1`.
               * **To**: Set `100`.
               * **Duration**: Specify `60s`.

            * Add another **Load profile**:
               * **Profile 2**: Select `const`.
               * **{{ ui-key.yacloud.load-testing.label_rps }}**: Set `100`.
               * **Duration**: Specify `300s`.

               This instructs the generator to increase the load from 1 to 100 requests per second for the first 60 seconds, and then maintain a load of 100 requests per second for 5 minutes. [Learn more about the load profile](../../load-testing/concepts/load-profile.md).
         * **Request type**: Specify `URI` as the [type](../../load-testing/concepts/payload.md).
         * In the **Set requests via form** menu:
            * In the **Requests** submenu, add the following requests:

               * `/ index`
               * `/test?param1=1&param2=2 get_test`

               The requests are marked with the `index` and `get_test` tags. The load generator will repeat them within a given load profile.
         * In the **Request headers** submenu, specify the following headers:
            * `[Host: example.myservice.ru]`
            * `[Connection: Close]`

            Please note that the `Connection: Close` header means each connection is terminated after making a request. This mode is heavier on the tested service and load generator. If you do not need to close connections, set `Keep-Alive`.
   1. Click ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.load-testing.button_duplicate-configuration }}**. The test parameters will be copied to the **{{ ui-key.yacloud.load-testing.label_test-config }} 2** section.
   1. Under **{{ ui-key.yacloud.load-testing.label_test-config }} 2**, specify the test parameters for the second agent:

      1. **{{ ui-key.yacloud.load-testing.label_agents-list }}**: Select the `agent-009` agent.
      1. Under **{{ ui-key.yacloud.load-testing.label_test-settings }}**, change the testing parameters.

         For example, in the **Autostop** menu, click ![image](../../_assets/plus-sign.svg) **Autostop** and enter the following description:
         * **Autostop type**: `INSTANCES`.
         * Set **Limit** to `90%`.
         * **Window duration**: `60s`.

         This means a test will be stopped if 90% of testing threads are used for 60 seconds, which indicates a testing issue. [Learn more about autostop](../../load-testing/concepts/auto-stop.md).
   1. Under **{{ ui-key.yacloud.load-testing.meta-section }}**, specify the name, description, and number of the test version. This will make the reports readable.
   1. Click **{{ ui-key.yacloud.common.create }}**.

   Once you are done, the configurations will be verified and the agents will start loading the application being tested. You can view the report on the **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab.

{% endlist %}

## View the testing results {#see-results}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
   1. In the left-hand panel, go to the ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab.
   1. Select the test that you created previously. Test with multiple agents have the `Multi` label.
   1. To view generalized results, go to the tab ![image](../../_assets/load-testing/results.svg) **{{ ui-key.yacloud.load-testing.label_test-report }}**.
   1. To view the test results for each agent individually:
      1. Go to ![image](../../_assets/load-testing/overview.svg) **{{ ui-key.yacloud.common.overview }}**.
      1. Select an appropriate agent under **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
      1. Go to ![image](../../_assets/load-testing/results.svg) **{{ ui-key.yacloud.load-testing.label_test-report }}**.

{% endlist %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources created, [delete](../../compute/operations/vm-control/vm-delete.md) the testing agents.
