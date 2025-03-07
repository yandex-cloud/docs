# Getting started with {{ load-testing-full-name }}

This guide will help you create a test agent in your cloud, configure a simple load test, and view the result.

## Getting started {#before-you-begin}

1. Log in to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the on-screen instructions.
1. Go to [{{ billing-name }}]({{ link-console-billing }}) and make sure you have a [billing account](../billing/concepts/billing-account.md) linked and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../billing/quickstart/index.md).
1. If you do not have a folder yet, [create one](../resource-manager/operations/folder/create.md). While creating a folder, you can also create a default virtual network with subnets in all availability zones.
1. Create a [service account](../iam/operations/sa/create.md) in the folder to host the agents that will generate the load. [Assign](../iam/operations/roles/grant.md) the `loadtesting.generatorClient` [role](./security/#roles-list) to it.
1. The agent connects to {{ load-testing-name }} using a public API. For security purposes, [create a security group](../vpc/operations/security-group-create.md). To connect to the control service, make sure the agent allows outgoing traffic on port 443. To do this, [add the following rule](../vpc/operations/security-group-add-rule.md) for outgoing traffic to your security group:
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `443`
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `CIDR`
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

1. The agent will need access to the subnet hosting the test target. For the agent to be able to connect to {{ load-testing-name }}, set up a [NAT gateway](../vpc/operations/create-nat-gateway.md) for the subnet.
1. If you do not have an SSH key pair yet, [create one](../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

## Create an agent {#create-agent}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create the agent.
1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. In the **{{ ui-key.yacloud.load-testing.label_agents-list }}** tab, click **{{ ui-key.yacloud.load-testing.button_create-agent }}**.
1. Enter a name for the agent: `test-agent`.
1. Specify the same availability zone where the test target is located.
1. Select the appropriate agent type. For more information, see [Agent performance](concepts/agent.md#benchmark).
1. Specify the subnet where the test target is located. Make sure you [created and set up a NAT gateway](../vpc/operations/create-nat-gateway.md) in the subnet.
1. If security groups are available to you, select a preset group. 
1. Select the service account with the `loadtesting.generatorClient` role. You must have the [permission to use it](../iam/operations/sa/set-access-bindings.md).
1. Enter a username. It will be created on the VM.
1. Paste the contents of the [public key](../compute/operations/vm-connect/ssh.md#copy-key) file.
1. Click **{{ ui-key.yacloud.common.create }}**.
1. Wait for the VM to start. Make sure the agent status has changed to `Ready for test`.

This creates a VM in your folder that you will be able to use to load test targets in the selected subnet.

## Running a test {#run-test}

This example will test a service located at `example.myservice.ru`.
We will use Pandora as load generator, since it is best suited for testing cloud applications.

1. Open the ![image](../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab in **{{ load-testing-name }}**. Click **{{ ui-key.yacloud.load-testing.button_create-test }}**. Set the test parameters:
   1. **{{ ui-key.yacloud.load-testing.label_agents-list }}**: Select `test-agent` as the agent.
   1. **{{ ui-key.yacloud.load-testing.field_settings-type }}**: Select `{{ ui-key.yacloud.load-testing.label_settings-type-form }}`.
   1. **{{ ui-key.yacloud.load-testing.field_load-generator }}**: Select `Pandora` as the generator.
   1. **Target address**: Enter the address of the service to test, `example.myservice.ru`.
   1. **Target port**: `80` (default HTTP port).
   1. **Testing threads**: `1000`.
        This means that the generator can simultaneously process 1,000 operations: either create 1,000 connections or wait for 1,000 responses from the service at the same time.

        {% note warning %}

        Make sure the agent has access to `example.myservice.ru:80`.

        {% endnote %}

   1. **Load type**: Select `RPS`.
   1. Add a **Load profile**:
      * **Profile 1**: Select `line`.
      * **From**: `1`.
      * **To**: `100`.
      * **Duration**: `60s`.
   1. Add another **Load profile**:
      * **Profile 2**: Select `const`.
      * **Responses per second**: `100`.
      * **Duration**: `300s`.

      This instructs the generator to increase the load from 1 to 100 requests per second for the first 60 seconds, and then maintain a load of 100 requests per second for 5 minutes.
   1. **Request type**: `URI`.
   1. In the **Test data** field, select **{{ ui-key.yacloud.load-testing.label_settings-type-form }}**. In the menu that opens:
      * In the **Requests** submenu, add the following requests:
        * `/ index`
        * `/test?param1=1&param2=2 get_test`

        The requests are tagged as `index` and `get_test`. The load generator will repeat them in turn within the specified load profile.
      * In the **Request headers** submenu, specify the following headers:
        * `[Host: example.myservice.ru]`
        * `[Connection: Close]`

        Please note that the `Connection: Close` header means that each connection will be closed following the request. This mode is heavier on the application and load generator. If you do not want the connections closed, set `Keep-Alive`.
   1. Under **Forced test termination time**, specify the time to autostop the test unless it is stopped for other reasons. This parameter value should be slightly greater than the expected test duration.
   1. Under **{{ ui-key.yacloud.load-testing.meta-section }}**, specify the name, description, and number of the test version. This will make the report easier to read.
   1. Click **{{ ui-key.yacloud.common.create }}**.

That done, the configuration go through checks, and the agent will start test loading the application. You can view the report on the **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab.
