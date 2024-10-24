# Agent selection

When [creating a test](../operations/create-test-bucket.md#create-test), you can either specify a test agent right away by selecting one from the list or configure selecting the first agent that becomes available. The agent selection function allows you to filter test agents by parameters you set.

## Specifying a test agent {#select}

To specify a test agent:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder for testing.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
   1. In the ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab, click **{{ ui-key.yacloud.load-testing.button_create-test }}**.
   1. In the **{{ ui-key.yacloud.load-testing.label_agents-list }}** section, click **{{ ui-key.yacloud.load-testing.label_agent-from-list-selector }}**.
   1. Select the name of the agent you need from the drop-down list.

      {% note info %}

      Within a single test, you can assign multiple agents to [work synchronously](../tutorials/loadtesting-multiply.md), which allows you to increase the load on the test target.
      To do this, either select multiple agent names from the list or use **Only** and **Except** buttons in the row with the name of one of the agents. These buttons allow you to select only this agent or all agents other than this one, respectively. 

      {% endnote %}

- CLI {#cli}

   When creating a test, specify agent IDs:

   ```bash
   export AGENT_ID1='<agent_1_ID>'
   export AGENT_ID2='<agent_2_ID>'

   yc loadtesting test create \
       --name "yc-examples-test" \
       --description "Test has been created using YC" \
       --labels source=gh,type=tutorial,kind=multi \
       --configuration id=$TEST_CONFIG_ID,agent-id=$AGENT_ID1,test-data=$TEST_PAYLOAD_FILE_IN_CONFIG \
       --configuration id=$TEST_CONFIG_ID,agent-id=$AGENT_ID2,test-data=$TEST_PAYLOAD_FILE_IN_CONFIG \
       --test-data name=$TEST_PAYLOAD_FILE_IN_CONFIG,s3bucket=$S3_PAYLOAD_BUCKET,s3file=$S3_PAYLOAD_FILENAME

   ```

{% endlist %}

## Setting up selection of the first test agent that becomes available {#filter}

To configure selecting the first test agent that becomes available:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder for testing.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
   1. In the ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab, click **{{ ui-key.yacloud.load-testing.button_create-test }}**.
   1. In the **{{ ui-key.yacloud.load-testing.label_agents-list }}** section, click **{{ ui-key.yacloud.load-testing.label_agent-by-filter-selector }}**.
   1. If any of the agents is suitable for the test, select **{{ ui-key.yacloud.load-testing.label_agent-by-filter-any-option }}**; otherwise, select **{{ ui-key.yacloud.load-testing.label_agent-by-filter-condition-option }}** and set up the agent filtering conditions:
      * (Optional) In the **{{ ui-key.yacloud.load-testing.filter_label_tags }}** section, click **{{ ui-key.yacloud.component.label-set.button_add-label }}** and specify the labels for agent selection in `key:value` format.
      * (Optional) In the **{{ ui-key.yacloud.load-testing.field_name-filter }}** field, specify a string that must be present in the names of the agents you want to start the test configuration on.
   1. In the **{{ ui-key.yacloud.load-testing.label_agents-count }}** field, specify how many agents will be used to run the test in synch: This will allow you to increase the load on the test target.

- CLI {#cli}

   Set the filtering conditions:

   ```bash
   
   export ANY_AGENT_SELECTOR=""
   export SPECIFIC_AGENT_SELECTOR="labels.key IN (value1, value2)"

   yc loadtesting test create \
      --name "yc-examples-test" \
      --description "Test has been created using YC" \
      --labels source=gh,type=tutorial \
      --configuration id=$TEST_CONFIG_ID,agent-by-filter=$ANY_AGENT_SELECTOR,test-data=$TEST_PAYLOAD_FILE_IN_CONFIG \
      --configuration id=$TEST_CONFIG_ID,agent-by-filter={$SPECIFIC_AGENT_SELECTOR},test-data=$TEST_PAYLOAD_FILE_IN_CONFIG \
      --test-data name=$TEST_PAYLOAD_FILE_IN_CONFIG,s3bucket=$S3_PAYLOAD_BUCKET,s3file=$S3_PAYLOAD_FILENAME

   ```

   In this example, the first part of the test will be performed on any suitable agent (because no filtering conditions are set in `ANY_AGENT_SELECTOR`), while the second part, on any agent with the `key` label set to `value1` or `value2`.

{% endlist %}

