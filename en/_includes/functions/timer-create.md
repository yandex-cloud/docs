Create a [timer](../../functions/concepts/trigger/timer.md) — a trigger that calls a {{ sf-name }} [function](../../functions/concepts/function.md) or {{ serverless-containers-name }} [container](../../serverless-containers/concepts/container.md) on a schedule.

## Before you begin {#before-you-begin}

To create a trigger, you need:

* A function or a container the trigger will launch.

   * If you don't have a function:

      * [Create a function](../../functions/operations/function/function-create.md).
      * [Create a function version](../../functions/operations/function/version-manage.md#func-version-create).

   * If you don't have a container:

      * [Create a container](../../serverless-containers/operations/create.md).
      * [Create a container revision](../../serverless-containers/operations/manage-revision.md#create).

* (optional) A [Dead Letter Queue](../../functions/concepts/dlq.md) where messages that could not be processed by a function or a container will be redirected. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service accounts](../../iam/concepts/users/service-accounts.md) with rights to invoke a function or a container and (optionally) write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.

   1. Open **{{ sf-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **Timer**.
      * Choose what the trigger will launch — a function or a container.

   1. Under **Timer settings**, specify the function/container invocation schedule in a [cron expression](../../functions/concepts/trigger/timer.md#cron-expression).

   1. If the trigger launches:

      * A function, select one under **Function settings** and specify:

         * [Tag of the function version](../../functions/concepts/function.md#tag);
         * A [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the function.

      * A container, select one under **Container settings** and specify:

         * A [container revision](../../serverless-containers/concepts/container.md#revision);
         * A [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the container.

   1. (optional) Under **Repeat request settings**:

      * In the **Interval** field, specify the time after which the function or the container will be invoked again if the current attempt fails. Values can be from 10 to 60 seconds. The default is 10 seconds.
      * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Values can be from 1 to 5. The default is 1.

   1. (optional) Under **Dead Letter Queue settings**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To create a trigger that launches a function, run the command:

   ```
   yc serverless trigger create timer \
     --name <timer name> \
     --cron-expression '<cron expression>' \
     --invoke-function-id <function ID> \
     --invoke-function-service-account-id <service account ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead Letter Queue ID> \
     --dlq-service-account-id <service account ID>
   ```

   Where:

   * `--name`: Timer name.
   * `--cron-expression`: Function invocation schedule in [cron expression](../../functions/concepts/trigger/timer.md#cron-expression).
   * `--invoke-function-id`: Function ID.
   * `--invoke-function-service-account-id`: Service account with rights to invoke the function.
   * `--retry-attempts`: The time after which the function will be invoked again if the current attempt fails. Optional. Values can be from 10 to 60 seconds. The default is 10 seconds.
   * `--retry-interval`: The number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../message-queue/concepts/dlq.md). Optional. Values can be from 1 to 5. The default is 1.
   * `--dlq-queue-id`: [Dead Letter Queue](../../functions/concepts/dlq.md) ID. Optional.
   * `--dlq-service-account-id`: Service account with rights to write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional.

   Result:

   ```
   id: a1sfe084v4se4morbu2i
   folder_id: b1g88tflru0ek1omtsu0
   created_at: "2019-12-04T08:45:31.131391Z"
   name: timer
   rule:
     timer:
       cron_expression: 5 12 * * ? *
       invoke_function_with_retry:
         function_id: d4eofc7n0m03lmudse8l
         function_tag: $latest
         service_account_id: aje3932acd0c5ur7dagp
         retry_settings:
           retry_attempts: "1"
           interval: 10s
         dead_letter_queue:
           queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmknnpj1ll45e:dlq
           service-account-id: aje3932acd0c5ur7dagp
   status: ACTIVE
   ```

- API

   You can create a timer using the [create](../../functions/triggers/api-ref/Trigger/create.md).

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a trigger that launches a function:

   1. In the configuration file, describe the trigger parameters:

      * `name`: Timer name. Name format:

         {% include [name-format](../../_includes/name-format.md) %}

      * `description`: Trigger description.
      * `timer`: Trigger settings:
         * `cron_expression`: Function invocation schedule in [cron expression](../../functions/concepts/trigger/timer.md#cron-expression) format.
      * `function`: Settings for the function, which will be activated by the trigger:
         * `id`: Function ID.

      Example configuration file structure:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "<timer name>"
        description = "<trigger description>"
        timer {
          cron_expression = "* * * * ? *"
        }
        function {
          id = "<function ID>"
        }
      }
      ```

      For more information about the resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/function_trigger).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contain errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

         ```
         yc serverless trigger get <trigger ID>
         ```

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}
