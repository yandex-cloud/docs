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

{% note info %}

{{ er-name }} is at the [Preview](../../overview/concepts/launch-stages.md) stage. To get access, contact [support]({{ link-console-support }}) or your account manager.

{% endnote %}

In this guide, you will create a queue in [{{ message-queue-name }}](../../message-queue/) and send a message to it. This message will be transmitted to a [{{ sf-name }}](../../functions/) function via a [bus](../concepts/eventrouter/bus.md).

## Getting started {#before-you-begin}

To get started in {{ yandex-cloud }}:
1. Log in to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the instructions.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` [status](../../billing/concepts/billing-account-statuses.md). If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../../resource-manager/operations/folder/create.md).

## Create a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the appropriate folder.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
    1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
    1. Enter a name for the [service account](../../iam/concepts/users/service-accounts.md): `sa-for-eventrouter`.
    1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `{{ roles-functions-invoker }}`, `ymq.reader`, and `ymq.writer` [roles](../../iam/concepts/access-control/roles.md).
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
   1. On the **{{ ui-key.yacloud.common.overview }}** tab under **{{ ui-key.yacloud.ymq.queue.overview.section_base }}**, copy the queue URL and ARN for later use.

{% endlist %}

## Create a function {#create-filter-function}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Create a function:
        1. In the top-right corner, click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
        1. Enter the function name: `eventrouter-function`.
        1. Click **{{ ui-key.yacloud.common.create }}**.
    1. Create a function version:
        1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** window that opens, select `Node.js 18`.
        1. Disable the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option.
        1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
        1. Create a file named `index.js` and paste the following code into it:
            ```js
			module.exports.handler = async function (event, context) {
			    console.log(JSON.stringify(event))
			    return {
			        statusCode: 200,
			        body: "",
			    };
			};
            ```
        1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify the following in the field:
            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`
            * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `sa-for-eventrouter`
        1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Create a bus {#create-bus}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select **{{ si-name }}**.
    1. Go to the **{{ er-name }}** tab.
    1. In the top-right corner, click **Create bus**.
    1. Enter a name for the bus and click **Create**.

{% endlist %}

## Create a connector {#create-connector}

{% list tabs group=instructions %}

- Management console {#console}

    1. Select a bus.
    1. Go to the **Connectors** tab.
    1. In the top-right corner, click **Create connector**.
    1. Under **Source**, select `{{ message-queue-full-name }}`.
    1. Specify the queue ARN in the **Message queue** field.
    1. In the **Service account** field, specify `sa-for-eventrouter`.
    1. Click **Create**.

{% endlist %}

## Create a rule {#create-rule}

{% list tabs group=instructions %}

- Management console {#console}

    1. Select a bus.
    1. Go to the **Rules** tab.
    1. In the top-right corner, click **Create rule**.
    1. Under **Targets**, click **Add**.
    1. In the **Type** field, select `{{ sf-full-name }}`.
    1. In the **Function** field, specify `eventrouter-function`.
    1. In the **Service account** field, specify `sa-for-eventrouter`.
    1. Click **Create**.

{% endlist %}

## Send a message to the queue {#send-message}

{% list tabs group=instructions %}

- AWS CLI {#cli}

    1. [Install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) the AWS CLI.
    1. [Create](../../iam/operations/sa/create-access-key.md) static access keys for the `sa-for-eventrouter` service account. Save the ID and secret key to a secure location. You will not be able to view the secret key parameters again after you close the window.
    1. Set up the AWS CLI:

       {% include [configure-aws-cli](../../_includes/message-queue/configure-aws-cli.md) %}

    1. Send a message to `sample-queue` using the previously saved queue URL:

        ```bash
         aws sqs send-message \
           --message-body "Hello World" \
           --endpoint https://message-queue.api.cloud.yandex.net/ \
           --queue-url <queue_URL>
         ```

         Result:
         
         ```json
         {
             "MD5OfMessageBody": "67e63db14341b5a696596634********",
             "MessageId": "765ff4d2-fa4bc83-6cfcc***-*****"
         }
         ```

{% endlist %}

## Check that the function was invoked {#check}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select the `eventrouter-function` function.
    1. Go to the **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** tab. The messages you sent to the queue must appear in logs.

{% endlist %}

## What's next {#what-is-next}

* [Read about the {{ er-name }} concepts](../concepts/eventrouter/bus.md).
