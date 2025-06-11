---
title: How to create a rule with a {{ serverless-containers-full-name }} target
description: Follow this guide to create a rule with a {{ serverless-containers-full-name }} target.
---

# Creating a rule with a {{ serverless-containers-full-name }} target

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

      1. Specify `{{ serverless-containers-full-name }}` as the target type.
      1. Select the [container](../../../../serverless-containers/concepts/container.md) to receive the messages matching the rule and its [revision](../../../../serverless-containers/concepts/container.md#revision).
      1. Type the path to specify after the invocation link.

          For example, if the invocation link is `https://<container_ID>.containers.yandexcloud.net/` and the path is `/hello`, the container will be invoked at `https://<container_ID>.containers.yandexcloud.net/hello`.

      1. Select the [service account](../../../../iam/concepts/users/service-accounts.md) to which the `serverless-containers.containerInvoker` [role](../../../../serverless-containers/security/index.md#serverless-containers-containerinvoker) or higher is assigned for the selected container or [create](../../../../iam/operations/sa/create.md) a new account.
      1. {% include [target-retry-console](../../../../_includes/serverless-integrations/target-retry-console.md) %}
      1. {% include [target-grouping-console](../../../../_includes/serverless-integrations/target-grouping-console.md) %}
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

  1. Create a rule with a {{ serverless-containers-full-name }} target:

      ```bash
      yc serverless eventrouter rule create \
        --bus-id <bus_ID> \
        --filter '<jq_template>' \
        --container-target \
      container-id=<container_ID>,\
      container-revision-id=<container_revision_ID>,\
      path=<path>,\
      service-account-id=<container_service_account_ID>,\
      retry-attempts=<number_of_attempts>,\
      maximum-age=<interval>,\
      max-count=<max_number_of_messages>,\
      max-bytes=<max_number_of_bytes>,\
      cutoff=<timeout>,\
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

      * `--container`: Parameter used to configure the `{{ serverless-containers-full-name }}` target and its properties:

          * `container-id`: ID of the [container](../../../../serverless-containers/concepts/container.md) to receive the messages matching the rule.
          * `container-revision-id`: [Container revision](../../../../serverless-containers/concepts/container.md#revision) ID.
          * `path`: Path to specify after the invocation link.

              For example, if the invocation link is `https://<container_ID>.containers.yandexcloud.net/` and the path is `/hello`, the container will be invoked at `https://<container_ID>.containers.yandexcloud.net/hello`.

          * `service-account-id`: ID of the [service account](../../../../iam/concepts/users/service-accounts.md) to which the `serverless-containers.containerInvoker` [role](../../../../serverless-containers/security/index.md#serverless-containers-containerinvoker) or higher is assigned for the selected container.


          {% include [target-retry-cli](../../../../_includes/serverless-integrations/target-retry-cli.md) %}

          {% include [target-transformer-cli](../../../../_includes/serverless-integrations/target-transformer-cli.md) %}


          {% include [target-grouping-cli](../../../../_includes/serverless-integrations/target-grouping-cli.md) %}

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
        - container:
            container_id: bbams2eulief********
            container_revision_id: bba9af1vblvj********
            path: /hello
            service_account_id: ajelprpohp7r********
            batch_settings:
              max_count: "1"
              max_bytes: "10000"
              cutoff: 60s
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

  To create a [rule](../../../concepts/eventrouter/rule.md) with a {{ serverless-containers-full-name }} target:

  1. In the configuration file, describe the resources you want to create:

      ```hcl
      resource "yandex_serverless_eventrouter_rule" "example_rule" {
        bus_id    = "<bus_ID>"
        jq_filter = "<jq_template>"
       
        container {
          container_id          = "<container_ID>"
          container_revision_id = "<container_revision_ID>"
          path                  = "<path>"
          service_account_id    = "<service_account_ID>"
          
          batch_settings {
            max_bytes  = <max_number_of_bytes>
            max_count  = <max_number_of_messages>
            cutoff     = "<timeout>"
          }
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
      * `container`: Section to configure the `{{ serverless-containers-full-name }}` target and its parameters:

          * `container_id`: ID of the [container](../../../../serverless-containers/concepts/container.md) to receive the messages matching the rule.
          * `container_revision_id`: [Container revision](../../../../serverless-containers/concepts/container.md#revision) ID.
          * `path`: Path to specify after the invocation link.

              For example, if the invocation link is `https://<container_ID>.containers.yandexcloud.net/` and the path is `/hello`, the container will be invoked at `https://<container_ID>.containers.yandexcloud.net/hello`.

          * `service_account_id`: ID of the [service account](../../../../iam/concepts/users/service-accounts.md) to which the `serverless-containers.containerInvoker` [role](../../../../serverless-containers/security/index.md#serverless-containers-containerinvoker) or higher is assigned for the selected container.

          {% include [target-grouping-tf](../../../../_includes/serverless-integrations/target-grouping-tf.md) %}

      {% include [target-additional-tf](../../../../_includes/serverless-integrations/target-additional-tf.md) %}

      For more information about `yandex_serverless_eventrouter_rule` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/serverless_eventrouter_rule).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources in the [management console]({{ link-console-main }}) or using this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter rule list
      ```

- API {#api}

  To create a [rule](../../../concepts/eventrouter/rule.md) with a {{ serverless-containers-full-name }} target, use the [Create](../../../../serverless-integrations/eventrouter/api-ref/Rule/create.md) REST API method for the [rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) resource or the [rule/Create](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/create.md) gRPC API call.

{% endlist %}

{% include [rule-created-enabled](../../../../_includes/serverless-integrations/rule-created-enabled.md) %}