---
title: Getting started with {{ er-full-name }}
description: Follow this guide to create a bus and transmit data through it.
keywords:
  - eventrouter
  - event router
  - bus
  - connector
  - rule
---

# Getting started with {{ er-name }}

{% include [event-router-preview-note](../../_includes/serverless-integrations/event-router-preview-note.md) %}

In this tutorial, you will use an {{ er-name }} [bus](../concepts/eventrouter/bus.md) to forward a message from a [{{ message-queue-name }}](../../message-queue/) to a [workflow](../concepts/workflows/workflow.md) in {{ sw-name }}.

If it matches the filter defined in the rule inside the bus, a message entering the queue will be forwarded to the workflow. The workflow will start automatically. Before being forwarded, the message will be converted according to the template defined in the same rule as the filter.

## Getting started {#before-you-begin}

To get started in {{ yandex-cloud }}:
1. Log in to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the on-screen instructions.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and its [status](../../billing/concepts/billing-account-statuses.md) is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../../resource-manager/operations/folder/create.md).

## Create a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the appropriate folder.
    1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
    1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
    1. Enter a name for the [service account](../../iam/concepts/users/service-accounts.md): `sa-for-eventrouter`.
    1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `serverless.workflows.executor`, [ymq.reader](../../iam/roles-reference.md#ymq-reader), and [ymq.writer](../../iam/roles-reference.md#ymq-writer) roles.
    1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**. 

{% endlist %}

## Create a queue {#create-queue}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
    1. Click **{{ ui-key.yacloud.ymq.queues.button_create }}**.
    1. Enter a name for the queue: `sample-queue`.
    1. Select the `{{ ui-key.yacloud.ymq.queue.form.type_switch_standard }}` type. Do not change other settings.
    1. Click **{{ ui-key.yacloud.common.create }}**.
    1. Open the queue you created.
    1. In the **{{ ui-key.yacloud.common.overview }}** tab, under **{{ ui-key.yacloud.ymq.queue.overview.section_base }}**, copy the queue URL as you will need it later.

{% endlist %}

## Create a workflow {#create-workflow}

{% include [workflows-preview-note](../../_includes/serverless-integrations/workflows-preview-note.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}** from the list of services.
    1. In the left-hand panel, select ![GraphNode](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
    1. In the top-right corner, click **{{ ui-key.yacloud.serverless-workflows.button_create-workflow }}**.
    1. In the **{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_text-editor }}** field, add the specification as follows:
        ```
        yawl: "0.1"
        start: noopstep
        steps:
          noopstep:
            noOp:
              output: |-
                \(.)
        ```
    1. Expand the **{{ ui-key.yacloud.serverless-workflows.label_additional-parameters }}** section.
    1. In the **{{ ui-key.yacloud.common.name }}** field, enter the workflow name: `sample-workflow`.
    1. In the **{{ ui-key.yacloud.serverless-workflows.label_service-account }}** field, select the `sa-for-eventrouter` service account.
    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Create a bus {#create-bus}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}** from the list of services.
    1. In the left-hand panel, select ![ObjectAlignCenterVertical](../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
    1. In the top-right corner, click **{{ ui-key.yacloud.serverless-event-router.button_create-bus }}**.
    1. Enter the bus name: `sample-bus`.
    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Create a connector {#create-connector}

{% list tabs group=instructions %}

- Management console {#console}

    1. Select the `sample-bus` bus.
    1. Navigate to the **{{ ui-key.yacloud.serverless-event-router.label_connectors }}** tab.
    1. In the top-right corner, click **{{ ui-key.yacloud.serverless-event-router.button_create-connector }}**.
    1. In the **{{ ui-key.yacloud.serverless-event-router.label_connector-source }}** field, select `{{ message-queue-full-name }}`.
    1. Specify `sample-queue` in the **Message queue** field.
    1. In the **Service account** field, specify `sa-for-eventrouter`.
    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Create a rule {#create-rule}

{% list tabs group=instructions %}

- Management console {#console}

    1. Select the `sample-bus` bus.
    1. Navigate to the **{{ ui-key.yacloud.serverless-event-router.label_rules }}** tab.
    1. In the top-right corner, click **{{ ui-key.yacloud.serverless-event-router.button_create-rule }}**.
    1. Expand the **{{ ui-key.yacloud.serverless-event-router.label_filter }}** section and specify the following _jq_ expression to filter messages:
        ```
        .httpMethod == "GET" and (.headers.Host | test("^d5dm"))
        ```
    1. Under **{{ ui-key.yacloud.serverless-event-router.label_targets}}**, click **{{ ui-key.yacloud.common.add }}**.
    1. In the **{{ ui-key.yacloud.serverless-event-router.label_target-type }}** field, select `{{ sw-full-name }}`.
    1. In the **Workflow** field, specify `sample-workflow`.
    1. In the **Service account** field, specify `sa-for-eventrouter`.
    1. Expand the **{{ ui-key.yacloud.serverless-event-router.label_target-transformer }}** section and specify the _jq_ expression to convert messages:
        ```
        {
           "message": "API gateway host is \(.headers.Host)."
        }
        ```
    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Send a message to the queue {#send-message}

Make sure the messages matching the created rule are converted and forwarded to the workflow.

{% list tabs group=instructions %}

- AWS CLI {#cli}

    1. [Install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) the AWS CLI.
    1. [Create](../../iam/operations/authentication/manage-access-keys.md#create-access-key) static access keys for the `sa-for-eventrouter` service account. Save the ID and secret key to a secure location. You will not be able to view the secret key parameters again after you close the window.
    1. Configure the AWS CLI:

       {% include [configure-aws-cli](../../_includes/message-queue/configure-aws-cli.md) %}

    1. Send the first message to `sample-queue` using the previously saved queue URL:

        ```bash
        aws sqs send-message \
          --message-body '{"httpMethod":"GET","headers":{"Host":"h6ds1lb3s0df********.k7******.apigw.yandexcloud.net"}}' \
          --endpoint {{ ymq-endpoint }} \
          --queue-url <queue_URL>
        ```

         Result:
         
        ```json
        {
            "MD5OfMessageBody": "c37859ba35a9958be041467c********",
            "MessageId": "f845****-9260****-7527****-f4b0****",
            "SequenceNumber": "0"
        }
         ```
    1. Make sure the filter you specified in the rule stopped the message from going through the bus:

        1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}** from the list of services.
        1. In the left-hand panel, select ![GraphNode](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
        1. Navigate to the **{{ ui-key.yacloud.serverless-workflows.label_workflow-executions }}** tab. You should not see any completed runs on the page.

    1. Send the second message to `sample-queue` using the previously saved queue URL:

        ```bash
        aws sqs send-message \
          --message-body '{"httpMethod":"GET","headers":{"Host":"{{ api-host-apigw }}"}}' \
          --endpoint {{ ymq-endpoint }} \
          --queue-url <queue_URL>
        ```

        Result:
         
        ```json
        {
            "MD5OfMessageBody": "c37859ba35a9958be041467c********",
            "MessageId": "f845****-9260****-7527****-f4b0****",
            "SequenceNumber": "0"
        }
         ```
    1. Make sure the filter you specified in the rule allowed the message to go through the bus and then the message was converted according to the template and forwarded to the workflow:

        1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}** from the list of services.
        1. In the left-hand panel, select ![GraphNode](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
        1. Navigate to the **{{ ui-key.yacloud.serverless-workflows.label_workflow-executions }}** tab. You should now see a completed run on the page.
        1. Select the completed run.
        1. Make sure the **{{ ui-key.yacloud.serverless-workflows.label_input_data }}** section displays the converted message:
            ```
            {
               "message": "API gateway host is {{ api-host-apigw }}."
            }
            ```

{% endlist %}

## What's next {#what-is-next}

* [Read about the {{ er-name }} concepts](../concepts/eventrouter/bus.md).
