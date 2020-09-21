{% list tabs %}

- Web console

    To create a trigger:

    1. Open **{{ sf-name }}** in the folder where you want to create a trigger for {{ cloud-logs-name }}.
    1. Go to the **Triggers** tab.
    1. Click **Create trigger**.
    1. Under **Basic parameters**:
        * Enter a name and description for the trigger.
        * In the **Type** field, select **Cloud Logs**.
    1. Under **Cloud Logs settings**:
        * In the **Log sources** field select log sources. Log groups will be identified automatically.
        * In the **Waiting time (sec)** field select maximum message group accumulation time.
        * In the **Message batch size** field select maximum message group size.
    1. Under **Repeat request settings**:
        * In the **Interval** field, specify 5 seconds.
        * In the **Message batch size** field, enter 5.
    1. Under **Function settings**:
        * Select the function for the trigger to call.
          {% note alert %}
          Attention! If you select the function which is in the trigger log sources, its invocation can entail the exponential growth of invokes.
          {% endnote %}
        * Specify [the function version tag](../../functions/concepts/function.md#tag).
        * Specify the service account that will be used to call the function.
    1. Click **Create trigger**.

    Trigger will be created and appear in the **Triggers** table.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Create a trigger:

    - `--name` — Trigger name.
    - `--log-groups` — [Log group](../../functions/concepts/log-group.md) unique identifiers list.
    - `--batch-size` — Maximum [message group size](../../functions/concepts/trigger/cloudlogs-trigger.md#batching).
    - `--batch-cutoff` — Maximum [message group accumulation time](../../functions/concepts/trigger/cloudlogs-trigger.md#batching).
    - `--invoke-function-id` — Unique function ID.
    - `--invoke-function-service-account-id` — Service account with rights to call the function.

    ``` 
    $ yc serverless trigger create cloud-logs \
        --name log-trigger \
        --log-groups eolhui6r************,eol7tktt************ \
        --batch-size 5 \
        --batch-cutoff 10s \
        --invoke-function-id b091v4rl************ \
        --invoke-function-service-account-id bfbm2ib6************
    ```
    Result:
    ```
    id: dd0c6gsr************
    folder_id: aoeuooa5************
    created_at: "2020-08-13T10:46:55.947Z"
    name: log-trigger
    rule:
      cloud_logs:
        log_group_id:
        - eolhui6r************
        - eol7tktt************
        batch_settings:
          size: "5"
          cutoff: 10s
        invoke_function:
          function_id: b091v4rl************
          function_tag: $latest
          service_account_id: bfbm2ib6************
          retry_settings:
            retry_attempts: "1"
            interval: 10s
    status: ACTIVE
    ```
 
{% endlist %}