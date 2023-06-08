# Transferring test logs to {{ cloud-logging-name }}

Set up the transfer of test logs to [{{ cloud-logging-full-name }}](../../logging/). You can use logs to analyze test results and detect problems during testing.

Resources transferred to a {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md):
* `loadtesting.log.tank`: General [Yandex Tank](https://yandextank.readthedocs.io/en/latest/) launch logs.
* `loadtesting.log.phantom`: Logs from the [Phantom](../concepts/load-generator.md#phantom) load generator if it was used in the test.
* `loadtesting.log.pandora`: Logs of the [Pandora](../concepts/load-generator.md#pandora) load generator if it was used in the test.

To set up the transfer of logs to {{ cloud-logging-name }}:
1. [Create a log group](../../logging/operations/create-group.md) in the same folder where the [test agent](../concepts/agent.md) is located.
1. [Assign the `{{ roles-logging-writer }}` role](../../logging/operations/access-rights.md#add-access) for the log group to the service account used to [create the test agent](create-agent.md).
1. [Create a new test](../quickstart.md#run-test) and specify the created log group in the **{{ ui-key.yacloud.load-testing.field_logging-group }}** field.

   You can also restart the existing test.

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
      1. In the left-hand panel, select ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
      1. Select the test. In the top-right corner, click **{{ ui-key.yacloud.load-testing.restart }}**.
      1. Select the created log group in the **{{ ui-key.yacloud.load-testing.field_logging-group }}** field.
      1. Under **{{ ui-key.yacloud.load-testing.test-data-section }}**, upload the [test data](../concepts/payload.md) file.
      1. Click **{{ ui-key.yacloud.common.create }}**.

   {% endlist %}

   After the test is complete, the agent will transfer the necessary logs to the specified log group. The ID of the logs in the log group will correspond to the test ID.

{% note info %}

You can set up automatic log transfer only before starting the test. Logs of performed tests can be [transferred to the log group](../../logging/operations/write-logs.md) manually.

Test logs are stored on the test agent at `/var/lib/tankapi/tests/<date and time of test launch>`.

{% endnote %}