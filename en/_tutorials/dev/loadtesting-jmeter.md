# JMeter load testing


You can use {{ load-testing-name }} to run fixed-load tests of a service over HTTPS using the [JMeter](../../load-testing/concepts/load-generator.md#jmeter) [load generator](../../load-testing/concepts/load-generator.md).

To run a load test:
1. [Get your cloud ready](#before-begin).
1. [Prepare a test target](#target-prepare).
1. [Set up your infrastructure](#infrastructure-prepare).
1. [Create an agent](#create-agent).
1. [Prepare a file with test data](#test-file).
1. [Run the test](#run-test).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

If the [agent](../../load-testing/concepts/agent.md) is hosted on {{ yandex-cloud }}, you pay for computing resources (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

At the [Preview](../../overview/concepts/launch-stages.md) stage, {{ load-testing-name }} is free of charge.

## Prepare a test target {#target-prepare}

In this example, we will test a service with the `172.17.0.10` [internal IP address](../../vpc/concepts/address.md#internal-addresses) in the same [subnet](../../vpc/concepts/network.md#subnet) as where the agent will reside.

Make sure the service is accessed over HTTPS using the default port: `443`.

You can also use {{ load-testing-name }} for a service that is public or located in a subnet and [security group](../../vpc/concepts/security-groups.md) other than those of the agent.

For a public service, allow incoming HTTPS traffic on port `443`.

For a service whose subnet and security group is different from the agent's ones, [create](#security-group-setup) a rule for incoming HTTPS traffic on port `443` in the security group where the test target is located.

## Set up your infrastructure {#infrastructure-prepare}

### Create a service account {#sa-create}

{% include [sa-create](../../_includes/load-testing/sa-create.md) %}

### Configure your network {#network-setup}

[Create and configure a NAT gateway](../../vpc/operations/create-nat-gateway.md) in the subnet hosting your test target and where the agent will reside. This will enable the agent to access {{ load-testing-name }}.

### Configure security groups {#security-group-setup}

1. Configure the test agent security group:

   {% include [security-groups-agent](../../_includes/load-testing/security-groups-agent.md) %}

1. Configure the test target security group:

   {% include [security-groups-target](../../_includes/load-testing/security-groups-target.md) %}

## Create a test agent {#create-agent}

{% include [create-agent](../../_includes/load-testing/create-agent.md) %}

## Prepare your load testing scenario {#test-scenario}

Create a load testing scenario in the JMeter UI and save it to a `.jmx` file. Learn more in the [JMeter documentation](https://jmeter.apache.org/usermanual/index.html).

{% cut "JMeter scenario example" %}

Create a file named `test.jmx` and paste the following code into it, specifying the actual IP address of your test target in the `HTTPSampler.domain` field:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<jmeterTestPlan version="1.2" properties="5.0" jmeter="5.6.2">
  <hashTree>
    <TestPlan guiclass="TestPlanGui" testclass="TestPlan" testname="Test Plan" enabled="true">
      <boolProp name="TestPlan.functional_mode">false</boolProp>
      <boolProp name="TestPlan.tearDown_on_shutdown">false</boolProp>
      <boolProp name="TestPlan.serialize_threadgroups">false</boolProp>
      <elementProp name="TestPlan.user_defined_variables" elementType="Arguments" guiclass="ArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
        <collectionProp name="Arguments.arguments"/>
      </elementProp>
    </TestPlan>
    <hashTree>
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="Thread Group" enabled="true">
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <stringProp name="LoopController.loops">600</stringProp>
          <boolProp name="LoopController.continue_forever">false</boolProp>
        </elementProp>
        <stringProp name="ThreadGroup.num_threads">1</stringProp>
        <stringProp name="ThreadGroup.ramp_time">1</stringProp>
        <boolProp name="ThreadGroup.delayedStart">false</boolProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
      </ThreadGroup>
      <hashTree>
        <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="HTTP Request" enabled="true">
          <boolProp name="HTTPSampler.postBodyRaw">false</boolProp>
          <elementProp name="HTTPsampler.Arguments" elementType="Arguments" guiclass="HTTPArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
            <collectionProp name="Arguments.arguments"/>
          </elementProp>
          <stringProp name="HTTPSampler.domain">172.17.0.10</stringProp>
          <stringProp name="HTTPSampler.path">/test?sleep=100</stringProp>
          <stringProp name="HTTPSampler.method">GET</stringProp>
          <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
          <boolProp name="HTTPSampler.auto_redirects">false</boolProp>
          <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
          <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>
          <boolProp name="HTTPSampler.BROWSER_COMPATIBLE_MULTIPART">false</boolProp>
          <boolProp name="HTTPSampler.image_parser">false</boolProp>
          <boolProp name="HTTPSampler.concurrentDwn">false</boolProp>
          <stringProp name="HTTPSampler.concurrentPool">6</stringProp>
          <boolProp name="HTTPSampler.md5">false</boolProp>
          <intProp name="HTTPSampler.ipSourceType">0</intProp>
        </HTTPSamplerProxy>
        <hashTree/>
        <ConstantThroughputTimer guiclass="TestBeanGUI" testclass="ConstantThroughputTimer" testname="Constant Throughput Timer" enabled="true">
          <intProp name="calcMode">1</intProp>
          <doubleProp>
            <name>throughput</name>
            <value>600.0</value>
            <savedValue>0.0</savedValue>
          </doubleProp>
        </ConstantThroughputTimer>
        <hashTree/>
      </hashTree>
    </hashTree>
  </hashTree>
</jmeterTestPlan>
```

In this example, we are creating a single thread group with one HTTP request (a `sleep` request for 100 milliseconds) and setting the IP address of the resource to test. The request rate is 600 requests per minute, and the test duration is 600 requests.

{% endcut %}

## Run the test {#run-test}

1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. In the left-hand panel, select ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**. Click **{{ ui-key.yacloud.load-testing.button_create-test }}**.
1. In the **{{ ui-key.yacloud.load-testing.label_agents-list }}** field, select `agent-008`.
1. Under **{{ ui-key.yacloud.load-testing.test-data-section }}**, click **{{ ui-key.yacloud_portal.component.file-input.button_choose-multiple }}** and select the scenario file you created [earlier](#test-scenario).
1. Under **{{ ui-key.yacloud.load-testing.label_test-settings }}**:

    1. In the **{{ ui-key.yacloud.load-testing.field_load-generator }}** field, select `JMETER`.
    1. In the **jmx scenario** field, select `Attached file`.

        If you have uploaded multiple files under **{{ ui-key.yacloud.load-testing.test-data-section }}**, select `Specify file` and in the **Attached file name or download URL** field, enter the scenario file name. If your scenario is not locally available, specify its download URL here.

1. Optionally, in the **Override jmx scenario variables** menu, you can add variables in `var=value` format. In this case, custom variables will be provided to the scenario. You can access them as `${var}`.
1. Optionally, in the **JMeter launch parameters** menu:

    1. If you are using a custom JMeter version which you manually copied to the agent, specify the JMeter executable path in the **Path to jmeter executable file** field.
    1. In the **Additional jmeter launch arguments** field, specify the additional arguments: they allow you to use Non-GUI mode launch commands. Learn more in the [JMeter documentation](https://jmeter.apache.org/usermanual/get-started.html#non_gui).

1. In the **Autostop** menu, click ![image](../../_assets/plus-sign.svg) **Autostop** and enter the following description:
    * **Autostop type 1**: `QUANTILE`
    * **Quantile**: `75`
    * **Response time limit**: `100ms`
    * **Window duration**: `10s`

    This criterion stops the test if the 75th percentile exceeds 100 milliseconds for 10 seconds (for 10 seconds, the time to process 25% of requests exceeds 100 milliseconds).
1. Under **Forced test termination time**, specify the time after which the test will autostop, unless it is stopped for other reasons. Set it to be slightly greater than the expected test duration.
1. Under **{{ ui-key.yacloud.load-testing.meta-section }}**, specify the name, description, and number of the test version. This will make the report easier to read.
1. Click **{{ ui-key.yacloud.common.create }}**.

Next, the configuration will be checked, and the agent will start loading the service.

To see the testing progress, select the new test and go to the **{{ ui-key.yacloud.load-testing.label_test-report }}** tab.

## How to delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the agent](../../compute/operations/vm-control/vm-delete.md).
1. [Delete the route table](../../vpc/operations/delete-route-table.md).
1. [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
