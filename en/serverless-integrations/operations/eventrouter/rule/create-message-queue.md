---
title: How to create a rule with a {{ message-queue-full-name }} target
description: Follow this guide to create a rule with a {{ message-queue-full-name }} target.
---

# Creating a rule with a {{ message-queue-full-name }} target

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [rule](../../../concepts/eventrouter/rule.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select the [bus](../../../concepts/eventrouter/bus.md) you need.
  1. Navigate to the ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}** tab.
  1. In the top-right corner, click **{{ ui-key.yacloud.serverless-event-router.button_create-rule }}**.

  1. {% include [target-filter-console](../../../../_includes/serverless-integrations/target-filter-console.md) %}
  1. Under **{{ ui-key.yacloud.serverless-event-router.label_targets }}**, click **{{ ui-key.yacloud.common.add }}** and configure the target:

      1. Specify `{{ message-queue-full-name }}` as the target type.
      1. Select the [folder](../../../../resource-manager/concepts/resources-hierarchy.md#folder) and [queue](../../../../message-queue/concepts/queue.md) to receive the messages matching the rule.
      1. Select the [service account](../../../../iam/concepts/users/service-accounts.md) to which the `ymq.writer` [role](../../../../message-queue/security/index.md#ymq-writer) or higher is assigned for the selected queue or [create](../../../../iam/operations/sa/create.md) a new account.
      1. {% include [target-retry-console](../../../../_includes/serverless-integrations/target-retry-console.md) %}
      1. {% include [target-transformer-console](../../../../_includes/serverless-integrations/target-transformer-console.md) %}
      1. {% include [target-dlq-console](../../../../_includes/serverless-integrations/target-dlq-console.md) %}

  1. {% include [target-additional-console](../../../../_includes/serverless-integrations/target-additional-console.md) %}
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating a [rule](../../../concepts/eventrouter/rule.md):

      ```bash
      yc serverless eventrouter rule create --help
      ```

  1. Create a rule with a {{ message-queue-full-name }} target:

      ```bash
      yc serverless eventrouter rule create \
        --bus-id <bus_ID> \
        --filter '<jq_template>' \
        --ymq-target \
      queue-arn=<queue_ARN>,\
      service-account-id=<queue_service_account_ID>,\
      retry-attempts=<number_of_attempts>,\
      maximum-age=<interval>,\
      transformer=<jq_template>,\
      dlq-arn=<DLQ>,\
      dlq-service-account-id=<DLQ_service_account_ID> \
        --name <rule_name> \
        --description "<rule_description>" \
        --deletion-protection \
        --labels <label_list>
      ```

      Where:

      {% include [target-basics-cli](../../../../_includes/serverless-integrations/target-basics-cli.md) %}

      * `--ymq-target`: Parameter for configuring the `{{ message-queue-full-name }}` target and its properties:

          * `queue-arn`: ARN of the [queue](../../../../message-queue/concepts/queue.md) to receive the messages matching the rule.
          * `service-account-id`: ID of the [service account](../../../../iam/concepts/users/service-accounts.md) to which the `ymq.writer` [role](../../../../message-queue/security/index.md#ymq-writer) or higher is assigned for the selected queue.


          {% include [target-retry-cli](../../../../_includes/serverless-integrations/target-retry-cli.md) %}

          {% include [target-transformer-cli](../../../../_includes/serverless-integrations/target-transformer-cli.md) %}


          {% include [target-dlq-cli](../../../../_includes/serverless-integrations/target-dlq-cli.md) %}

      {% include [target-additional-cli](../../../../_includes/serverless-integrations/target-additional-cli.md) %}

      Result:

      ```text
      id: f66vfpjrkc35********
      bus_id: f66epjc9llqt********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-26T14:04:47.710918Z"
      name: new-rule
      description: created via cli
      labels:
        owner: admin
        version: beta
      filter:
        jq_filter: .firstName == "Ivan"
      targets:
        - ymq:
            queue_arn: yrn:yc:ymq:{{ region-id }}:b1g681qpemb4********:dlq-42
            service_account_id: ajelprpohp7r********
          transformer:
            jq_transformer: .
          retry_settings:
            retry_attempts: "3"
            maximum_age: 600s
          dead_letter_queue:
            queue_arn: yrn:yc:ymq:{{ region-id }}:b1g681qpemb4********:dlq-42
            service_account_id: ajelprpohp7r********
          status: ENABLED
      deletion_protection: true
      status: ENABLED
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To create a [rule](../../../concepts/eventrouter/rule.md) with a {{ message-queue-full-name }} target:

  1. In the configuration file, describe the resources you want to create:

      ```hcl
      resource "yandex_serverless_eventrouter_rule" "example_rule" {
        bus_id    = "<bus_ID>"
        jq_filter = "<jq_template>"

        ymq {
          queue_arn            = "<queue_ARN>"
          service_account_id   = "<service_account_ID>"
        }
      
        name        = "<rule_name>"
        description = "<rule_description>"

        labels = {
          <key_1> = "<value_1>"
          <key_2> = "<value_2>"
          ...
          <key_n> = "<value_n>"
        }
      }
      ```

      Where:

      * `bus_id`: {{ er-name }} [bus](../../../concepts/eventrouter/bus.md) ID.
      * `jq_filter`: [jq template](https://jqlang.github.io/jq/manual/) for event [filtering](../../../concepts/eventrouter/rule.md#filter).
      * `ymq`: Section to configure the `{{ message-queue-full-name }}` target and its parameters:

          * `queue_arn`: ARN of the [queue](../../../../message-queue/concepts/queue.md) to receive the messages matching the rule.
          * `service_account_id`: ID of the [service account](../../../../iam/concepts/users/service-accounts.md) to which the `ymq.writer` [role](../../../../message-queue/security/index.md#ymq-writer) or higher is assigned for the selected queue.

      {% include [target-additional-tf](../../../../_includes/serverless-integrations/target-additional-tf.md) %}

      For more information about `yandex_serverless_eventrouter_rule` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/serverless_eventrouter_rule).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources in the [management console]({{ link-console-main }}) or using this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter rule list
      ```

- API {#api}

  To create a [rule](../../../concepts/eventrouter/rule.md) with a {{ message-queue-full-name }} target, use the [Create](../../../../serverless-integrations/eventrouter/api-ref/Rule/create.md) REST API method for the [rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) resource or the [rule/Create](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/create.md) gRPC API call.

{% endlist %}

{% include [rule-created-enabled](../../../../_includes/serverless-integrations/rule-created-enabled.md) %}