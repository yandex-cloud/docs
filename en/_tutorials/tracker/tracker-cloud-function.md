# {{ tracker-name }} integration with {{ sf-short-name }}

This guide describes how you can integrate {{ tracker-name }} automation tools with {{ sf-short-name }} using the example of calculating the total time spent across all child sub-issues for the parent issue.

To configure the total time spent value of a parent issue to automatically update whenever this value changes in any of its child sub-issues:

1. [Register the application](#register-app).
1. [Get an application access token](#get-token).
1. [Get an organization ID to access the API](#get-tracker-id).
1. [Create a {{ sf-name }} function](#create-function).
1. [Set up a trigger](#setup-trigger).
1. [Test out automatic data updates](#test-updates).

## Getting started {#before-you-begin}

{% note info %}

To run the scenario, you will need:

* A {{ yandex-cloud }} billing account.
* A {{ tracker-name }} account belonging to an organization connected to {{ ya-360 }} with a [role](../../organization/security/index.md#service-roles) no lower than `{{ roles-organization-admin }}`.

{% endnote %}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of infrastructure support includes a fee for function invocations (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).

If you no longer need the resources you created, [delete them](#clear-out).

## Register the application {#register-app}

1. Open ` https://oauth.yandex.ru/client/new ` in your browser and log in with your {{ tracker-name }} account.
1. In the **Create app** form:
   1. In the **Service name** field, enter a name, e.g., `TimeUpdater`.
   1. Under **Platforms**, enable **Web services** and enter ` https://oauth.yandex.ru/verification_code ` in the **Redirect URI** field.
   1. Under **Data access**, in the input field, start typing `tracker`. Then, in the drop-down list, select:
      * `Read from Tracker`
      * `Write in Tracker`
1. Click **Create app**.
1. Wait for the page with the application details to load and copy your application ID from the **ClientID** field.

## Get an application access token {#get-token}

1. In the browser, go to:
   ```
   https://oauth.yandex.ru/authorize?response_type=token&client_id=<app_ID>
   ```
   Where the `client_id` parameter value is the application ID from the **ClientID** field on the application details page from the previous step.
1. Wait for the page to load and copy the token.
1. Save the token. You will need it to create a function.

## Get an organization ID to access the API {#get-tracker-id}

1. Go to [{{ tracker-name }}](https://tracker.yandex.ru/). Click **Logging in to Yandex Tracker**.
1. In the right-hand panel, click **{{ ui-key.startrek.blocks-desktop_page-admin.breadcrumbs-title }}**.
1. Under **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.access-and-payment }}**, click **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-orgs }}**.
1. Under **{{ ui-key.startrek.ui_components_page-admin_OrgPanes_DirectoryOrgPane.source-title }}**, copy and save your organization ID. You will need it to create a function.

## Create a {{ sf-name }} function {#create-function}

1. Go to the [management console]({{ link-console-main }}).
1. In the top-left corner, click ![](../../_assets/datalens/all-services.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.
1. Select **Serverless computing** → **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
1. Enter a function name, e.g., `timeupdater`.
1. Click **{{ ui-key.yacloud.serverless-functions.create.button_create }}**.
1. In the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** window that opens, select `Python / 3.9` as the runtime environment.
1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** field, click **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}**.
1. Attach a [test archive](https://github.com/yandex-cloud-examples/yc-tracker-summarize-spent/blob/main/build/tracker-summarize-spent.zip).
1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, specify `index.handler`.
1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, in the **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}** field, add:
   * `ORG`: {{ ya-360 }} organization ID.
   * `TOKEN`: Application access token.
1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
1. Wait for the page to load. Then, in the **{{ ui-key.yacloud.serverless-functions.item.overview.label_invoke-link }}** field, copy and save the function call link.
   Link example:
   ```
   	https://functions.yandexcloud.net/d4e94uav31086c******
   ```
1. Enable the **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}** option.

## Set up a trigger {#setup-trigger}

### Create a queue

1. In the left-hand panel, select ![](../../_assets/tracker/svg/queues.svg) **{{ ui-key.startrek.ui_components_TrackerSearch.queues }}** → **{{ ui-key.startrek.blocks-desktop_b-head.new-queue }}**.
1. Select a queue template, such as **{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset-title--development-preset }}**.
1. Enter a name, e.g., `Function Test`.
1. Click **{{ ui-key.startrek.blocks-desktop_queue-new-presets.create }}**.

### Create a trigger

1. In the top-right corner of the queue page, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.
1. In the left-hand panel, select **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.group-title--automatization }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.title }}** and click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.button-create }}**.
1. In the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_name }}** field, enter a trigger name, e.g., `timeupdater`.
1. Under **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_conditions }}**, select **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}**  → **Time spent**.
1. Under **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_actions }}**, select **{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--webhook }}**.
1. In the form that opens, in the **{{ ui-key.startrek.blocks-desktop_trigger-action.webhook-url }}** field, enter:
   ```
   	https://functions.yandexcloud.net/<function_ID>?id=not_var{{issue.key}}
   ```
   Where `https://functions.yandexcloud.net/<function_ID>` is the function call link you saved when creating the function.
   For example:
   ```
   	https://functions.yandexcloud.net/d4e94uav31086c******?id=not_var{{issue.key}}
   ```
1. Click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_create }}**.

## Test out automatic data updates {#test-updates}

### Create issues

1. Create a parent issue whose total time spent across all sub-issues will be calculated:
   1. On the `Function Test` queue page, click **{{ ui-key.startrek.blocks-desktop_guide.ticket--main--action_new--title }}**.
   1. In the form that opens, in the **{{ ui-key.startrek.ui_components_create-issue-popup_NewIssueForm.issue-name }}** field, enter an issue name, e.g., `Parent Task`.
   1. Click **{{ ui-key.startrek.ui_components_create-issue-popup_NewIssueForm.create }}**.
1. Create sub-issues:
   1. In the top-right corner of the `Parent Task` issue page, in the **{{ ui-key.startrek.ui_components_IssueMenu.title }}** menu, select **{{ ui-key.startrek.ui_components_IssueMenu.create-subissue }}**.
   1. In the form that opens, in the **{{ ui-key.startrek.ui_components_create-issue-popup_NewIssueForm.issue-name }}** field, enter a sub-issue name, e.g., `Subtask-1`.
   1. In the same way, create another sub-issue or multiple sub-issues named `Subtask-2`, `Subtask-3`, etc.

### Enter time spent values for the sub-issues

1. In the top-right corner of the `Subtask-1` sub-issue page, in the **{{ ui-key.startrek.ui_components_IssueMenu.title }}** menu, select **{{ ui-key.startrek.ui_components_IssueMenu.add-worklog }}**.
1. In the dialog that opens, in the **{{ ui-key.startrek.ui_components_AddWorklogDialog.duration-label }}** field, enter any time value, e.g., `1h25m`.
1. In the same way, add time spent values for the other sub-issues.

### Check if the function works correctly

1. Go to the `Parent Task` issue page.
1. In the issue properties, under **{{ ui-key.startrek-backend.fields.issue.fields.timetracking }}**, make sure that the **{{ ui-key.startrek-backend.fields.issue.spent-key-value }}** field includes the time you specified in the sub-issue.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete the {{ sf-name }} function](../../functions/operations/function/function-delete.md).
