# Getting started with {{ load-testing-full-name }}

Following these instructions, you will create a test agent in your cloud, configure a simple load test, and view its outcome.

## Before you start

1. Log in to the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md).
1. If you don't have a folder, [create one](../resource-manager/operations/folder/create.md). When creating a folder, you can create a default virtual network with subnets in all availability zones.
1. Create a [service account](../iam/operations/sa/create.md) in the folder to host the agents that will generate the load. [Assign it the role](../iam/operations/roles/grant.md) `loadtesting.generatorClient`.
1. Assign all the roles required to create a VM in [Compute Cloud](../compute/security/index.md) and [{{ vpc-short-name }}](../vpc/security/index.md).
1. The agent connects to {{ load-testing-name }} using a public API. For security purposes, [create a security group](../vpc/operations/security-group-create.md). To connect to the control service, make sure the agent allows outgoing traffic to port 443. To send requests to the test target, allow access to the desired port.
1. The agent will need access to the subnet hosting the test target. For the agent to be able to connect to {{ load-testing-name }}, enable [NAT to the internet](../vpc/operations/enable-nat.md) on the subnet.

## Create an agent {#create-agent}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create your agent.
1. In the list of services, select **{{ load-testing-name }}**.
1. On the **Agents** tab, click **Create agent**.
1. Name the agent `test-agent`.
1. Specify the same availability zone where the test target is located.
1. Select the service account with the `loadtesting.generatorClient` role. You must have the [right to use it](../iam/operations/sa/set-access-bindings.md).
1. Select the appropriate agent type. For more information, see [Agent performance](concepts/agent.md#benchmark).
1. Specify the subnet where the test target is located. The subnet must have [NAT to the internet](../vpc/operations/enable-nat.md) enabled.
1. Specify the previously created security group.
1. Click **Create**.

This creates a VM in your folder that you will be able to use to load test targets in the selected subnet.

## Running a test {#run-test}

This example will test a service located at `example.myservice.com`.

We'll use Pandora as the load generator, since it's the best suited for testing cloud applications. The payload will be in a file.

1. Generate payloads in [URI](concepts/payloads/uri.md) format:

   ```
   [Host: example.myservice.ru]
   [Connection: Close]
   / index
   /test?param1=1&param2=2 get_test
   ```

   Please note that the `Connection: Close` header means each connection is terminated after making a request. This mode is heavier on the application and load generator. If you don't need to close connections, set `Keep-Alive`.

   There are also two requests tagged `index` and `get_test`. The load generator will repeat them within a given load profile.

1. Save the payloads to a file named `data.uri`.
1. Open the **Tests** tab in **{{ load-testing-name }}**. Click **Create test**. Set the test parameters:
1. **Agent**: Select `test-agent`.
1. **Data type**: Select `URI` and upload `data.uri` in the **File with test data** field.
1. **Load generator**: Select **Pandora**.
1. **Testing threads**: Leave the default value, `1000`.

   This means that the load generator can simultaneously process 1000 operations (create 1000 connections or wait for 1000 responses from the service at the same time).
1. **Target address**: Specify the address of the service to test (`example.myservice.ru`).
1. **Target port**: Set to `80` (default HTTP port).
   

   {% note warning %}

   Make sure the agent has access to example.myservice.ru:80.

   {% endnote %}

1. **Load profile**: Select the **RPS** type and add two testing stages:
   * `{type: line, duration: 60s, from: 1, to: 100}`
   * `{type: const, duration: 300s, ops: 100}`

   This instructs the generator to increase the load from 1 to 100 requests per second for the first 60 seconds, and then maintain a load of 100 requests per second for 5 minutes.

1. Under **Test information**, specify the name, description, and number of the test version. This will make the report easier to read.
1. Click **Create**.

Afterwards, the configuration will be verified, and the agent will start loading the application being tested. You can view the report on the **Tests** tab.
