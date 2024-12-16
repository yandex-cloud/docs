---
title: Getting started with {{ sw-full-name }}
description: Follow this guide to create and run a workflow.
keywords:
  - workflows
  - workflow
  - WF
  - workflow
  - YaWL specification
  - parallel
  - bus
  - connector
  - rule
---

# Getting started with {{ sw-name }}

{% include [workflows-preview-note](../../_includes/serverless-integrations/workflows-preview-note.md) %}

Using this tutorial, you will create and run a [workflow](../concepts/workflows/workflow.md). During the execution of the workflow, the [{{ sf-full-name }}](../../functions/) functions will be called.

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
    1. Enter a name for the [service account](../../iam/concepts/users/service-accounts.md): `sa-for-function`.
    1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `{{ roles-functions-invoker }}` [role](../../iam/concepts/access-control/roles.md).
    1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**. 

{% endlist %}

## Create a function to filter data {#create-filter-function}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Create a function:
        1. In the top-right corner, click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
        1. Enter the function name: `filter-function`.
        1. Click **{{ ui-key.yacloud.common.create }}**.
    1. Create a function version:
        1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** window that opens, select `Node.js 18`.
        1. Disable the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option.
        1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
        1. Create a file named `index.js` and add the following code into it:
            ```js
            module.exports.handler = async function (data, context) {
                return {
                    id: data.id,
                    name: data.name,
                    email: data.email,
                };
            };
            ```
        1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify the following in the field:
            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`
            * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `sa-for-function`.
        1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Create a function to return email addresses {#create-return-function}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Create a function:
        1. In the top-right corner, click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
        1. Enter the function name: `return-function`.
        1. Click **{{ ui-key.yacloud.common.create }}**.
    1. Create a function version:
        1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** window that opens, select `Node.js 18`.
        1. Disable the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option.
        1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
        1. Create a file named `index.js` and add the following code into it:
            ```js
            module.exports.handler = async function (data, context) {
                return {
                    result: "OK",
                    emails: data.loaded_users.map(p => p.email)
                };
            };
            ```
        1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify the following in the field:
            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`
            * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `sa-for-function`.
        1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Create a workflow {#create-workflow}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select **{{ si-name }}**.
    1. Go to the **{{ sw-name }}** tab.
    1. In the top-right corner, click **Create workflow**.
    1. Enter a name for the workflow.
    1. In the **Service Account** field, enter the `sa-for-function` service account.
    1. In the **YAML specification** field, add the specification shown below. Specify the following in the `functionId` field:
        * In the `process_user_transform_info` step, the `filter-function` ID.
        * In the `upload_users` step, the `return-function` ID.

        ```yaml
        yawl: "0.1"
        start: get_users
        defaultRetryPolicy:
          maxDelay: 10s
          retryCount: 2
          errorList:
            - STEP_QUOTA_EXCEEDED
        steps:
          get_users:
            httpCall:
              url: 'https://jsonplaceholder.typicode.com/\(.resource_type)'
              method: GET
              headers: {}
              query: {}
              output: '\({loaded_users: .})'
              next: process_users
          process_users:
            foreach:
              input: \(.loaded_users)
              output: '\({loaded_users: .})'
              next: upload_users
              do:
                start: process_user_get_info
                steps:
                  process_user_get_info:
                    httpCall:
                      url: https://jsonplaceholder.typicode.com/users/\(.id)
                      method: GET
                      headers: {}
                      query: {}
                      next: process_user_transform_info
                      output: '\({user: .})'
                      retryPolicy:
                        retryCount: 2
                        errorList:
                          - HTTP_CALL_500
                  process_user_transform_info:
                    functionCall:
                      functionId: <function_ID>
          upload_users:
            functionCall:
              functionId: "<function_ID>"
              input: '\({loaded_users, resource_type})'
        ```
    1. Click **Create**.

{% endlist %}

## Run the workflow {#execute-workflow}

{% list tabs group=instructions %}

- Management console {#console}

    1. Select a workflow.
    1. In the top-right corner, click **Run**.
    1. Enter input data in JSON format:
        ```json
        {
          "resource_type": "users"
        }
        ```
    1. When the workflow status changes from `Running` to `Completed`, the following JSON object will appear in the **Output data** section:
        ```json
        {
          "result": "OK",
          "emails": [
            "Sincere@april.biz",
            "Shanna@melissa.tv",
            "Nathan@yesenia.net",
            "Julianne.OConner@kory.org",
            "Lucio_Hettinger@annie.ca",
            "Karley_Dach@jasper.info",
            "Telly.Hoeger@billy.biz",
            "Sherwood@rosamond.me",
            "Chaim_McDermott@dana.io",
            "Rey.Padberg@karina.biz"
          ]
        }
        ```

{% endlist %}

## What's next {#what-is-next}

* [Check out another example of a workflow specification](../concepts/workflows/yawl.md#spec-example)
* [Learn about the {{ sw-name }} concepts](../concepts/workflows/workflow.md)
