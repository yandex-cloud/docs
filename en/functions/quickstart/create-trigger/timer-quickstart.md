# Creating a timer that invokes a function

Create a [timer](../../concepts/trigger/timer.md) that invokes a {{ sf-name }} [function](../../concepts/function.md) every minute.

## Getting started {#before-you-begin}

1. [Create a function](../../operations/index.md#create-function) to be triggered by timer. For example, you can create any function from [this list](../../quickstart/create-function/index.md).
1. [Create a service account](../../../iam/operations/sa/create.md) that will be used to invoke the function and assign it the `{{ roles-functions-invoker }}` role.

## Create a timer {#timer-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a timer.

   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

   1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

      * Enter the trigger name: `timer`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_timer }}**, enter `* * ? * * *` or select `{{ ui-key.yacloud.common.button_cron-1min }}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select your function and specify:

      * [**{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}**](../../concepts/function.md#tag): `$latest`
      * [**{{ ui-key.yacloud.serverless-functions.triggers.form.field_service-account }}**](../../../iam/concepts/users/service-accounts.md) you created earlier

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create a timer that invokes a function every minute, run this command:

   ```bash
   yc serverless trigger create timer \
     --name timer \
     --cron-expression '* * ? * * *' \
     --invoke-function-id <function_ID> \
     --invoke-function-service-account-id <service_account_ID>
   ```

   Where:

   * `--name`: Timer name.
   * `--cron-expression`: Function invocation schedule specified as a [cron expression](../../concepts/trigger/timer.md#cron-expression).
   * `--invoke-function-id`: Function ID.
   * `--invoke-function-service-account-id`: Service account ID.

   Result:

   ```text
   id: a1s2aanidtep********
   folder_id: b1gtmgn9gbvm********
   created_at: "2023-03-03T12:18:15.707328472Z"
   name: timer
   rule:
     timer:
       cron_expression: '* * ? * * *'
       invoke_function_with_retry:
         function_id: d4eaic3se926********
         function_tag: $latest
         service_account_id: ajek1us5r79c********
   status: ACTIVE
   ```

- API {#api}

   You can create a timer using the [create](../../triggers/api-ref/Trigger/create.md) API method.

{% endlist %}

## Check the result {#check-result}

To make sure the timer is running properly, view the function logs. They should show that the function is invoked every minute.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.

   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

   1. Click a function to view its runtime log.

   1. In the window that opens, go to **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** and specify the period for which you want to view logs. The default period is 1 hour.

- CLI {#cli}

   To view the function logs, run this command:

   ```bash
   yc serverless function logs <function_ID>
   ```

   Result:

   ```text
   2023-03-03 12:44:12  INFO START RequestID: 5906fbf3-7ff5-4fe4-a0b2-b35c******** Version: d4efs25vm37e********
   2023-03-03 12:44:12  INFO END RequestID: 5906fbf3-7ff5-4fe4-a0b2-b35c********
   2023-03-03 12:44:12  INFO REPORT RequestID: 5906fbf3-7ff5-4fe4-a0b2-b35c******** Duration: 8.951 ms Billed Duration: 100 ms Memory Size: 128 MB Max Memory Used: 48 MB Queuing Duration: 0.066 ms Function Init Duration: 5.892 ms
   2023-03-03 12:45:12  INFO START RequestID: e806a5c4-e06a-4a6f-b468-386d******** Version: d4efs25vm37e********
   2023-03-03 12:45:12  INFO END RequestID: e806a5c4-e06a-4a6f-b468-386d********
   2023-03-03 12:45:12  INFO REPORT RequestID: e806a5c4-e06a-4a6f-b468-386d******** Duration: 10.266 ms Billed Duration: 100 ms Memory Size: 128 MB Max Memory Used: 48 MB Queuing Duration: 0.054 ms Function Init Duration: 7.023 ms
   ```

{% endlist %}

## What's next {#what-is-next}

* [Check out the concepts](../../concepts/trigger/index.md).
* [Learn how to create other triggers](../../operations/index.md#trigger-create).
