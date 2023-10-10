# Setting up automatic issue creation

To manage the workflows for official employment and onboarding of new employees, create a queue where you will track procedural matters, provision of equipment and access permissions, and the progress of probation period. Set up automatic creation of an appropriate issue pool upon closing a candidate issue with the **Hired** resolution.

## Create a queue for new employees

1. [Create a queue](manager/create-queue.md) using the <q>{{ ui-key.startrek.components_QueuePresetOnboarding.preset-name--hr-preset }}</q> template.
1. Give it a name, e.g., `Employment Queue`.
1. Set up a [workflow](manager/workflows.md#section_hr) or create a [new](manager/add-workflow.md) one if needed.
1. Specify an issue type, e.g., `New employees`, for the workflow. Save the issue type key. You will need it when creating triggers.
1. Set up [queue access permissions](manager/queue-access.md) to protect employee personal data.

## Add issue types

Create separate issue types for various procedures related to employment and onboarding of new employees. For example, to grant access permissions and provide equipment, create an issue type named <q>Access permissions and equipment</q>:

1. In the top-right corner of the `Employment Queue` page, click ![](../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.
1. In the left-hand panel, select **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-types }}**.
1. Wait for the page to load and click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_types.add-issue-type }}**.
1. In the form that appears:
   * Enter a name for the new type, such as `Access permissions and equipment`, in the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_events.issue-types-config--title--type }}** field and click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_types.add-issue-type }}**. In the issue type creation form that opens, copy and save the issue key.
   * In the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_events.issue-types-config--title--workflow }}** field, select a suitable workflow, e.g., `Quick Start`.
   * In the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_events.issue-types-config--title--resolutions }}** field, select the appropriate resolutions, such as `{{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }}`.

Repeat the steps to add other issue types you need, for example, `Completion of documents`, `Probation period`, etc.
To save the new types, click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_types.save }}**.

{% note info %}

Only the issue types with a workflow and at least one resolution selected will be saved.
Make sure the issue types are unique.

{% endnote %}


## Set up a trigger in the Candidates Queue

To automate replication of issues from the `Candidates Queue` to the `Employment Queue`, create a trigger that will fire when the candidate issue status changes to Hired:

1. In the top-right corner of the `Candidates Queue` page, click ![](../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.
1. In the left-hand panel, select **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.group-title--automatization }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.title }}** and click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.button-create }}**.
1. In the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_name }}** field, enter a trigger name, such as `employ_candidate`.
1. Under **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_conditions }}**, select **{{ui-key.startrek-backend.fields.issue.fields.system }}** → **{{ ui-key.startrek-backend.fields.issue.status-key-value }}**.
1. In the **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldChangedCondition }}** field that appears, select **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldBecameEqual }}** and then, in a new field next to it, select **Hired** (the status you created in the Candidates Queue workflow).
1. Under **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_actions }}**, select **{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--webhook }}**.
1. In the form that opens, enter the request parameters. In the **{{ ui-key.startrek.blocks-desktop_trigger-action.webhook-body }}** field, set the parameters of a new sub-issue. To substitute the values from the original issue, use [variables](user/vars.md):

   #|
   || **Field** | **Content** ||
   || {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-method }} | {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-method--post }} ||
   || {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-url }} | `{{ host }}/{{ ver }}/issues` ||
   || {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-auth }} | {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-auth--oauth }} ||
   || {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-token }} | <OAuth_token> (see [How to get a token](concepts/access.md#section_about_OAuth)) ||
   || {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-token-header }} | Authorization ||
   || {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-token-type }} | OAuth ||
   || {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-content-type }} | application/json ||
   || {{ ui-key.startrek.blocks-desktop_trigger-action.webhook-body }} |
   >```
   >{
   >   "queue":"<Employment_Queue_key>",
   >   "summary":"not_var{{issue.summary.json}}",
   >   "description":"not_var{{issue.description.json}}",
   >   "type":"<New_Employees_issue_key>",
   >   "parent":"not_var{{issue.key}}"
   >}
   >```
   ||
   || Headers | Header: `X-Org-ID` or `X-Cloud-Org-ID`.
   Value: Organization ID. If you only have a {{ org-full-name }} organization, use the `X-Cloud-Org-ID` header; if only {{ ya-360 }} or both organization types, use `X-Org-ID`. You can find the ID on the [**Administration** → **Organizations**]({{ link-admin-settings }}) page. ||
   |#

   {% note info %}

   Make sure the parameters you pass in the request body using variables are set in the original issue; otherwise, the trigger will not fire.

   {% endnote %}

1. To save the trigger, click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_create }}**.


## Set up a trigger in the Employment Queue

Once the candidate issue is copied to the `Employment Queue`, you need to create a number of sub-issues related to the new employee in the same queue: `Access permissions and equipment`, `Completion of documents`, `Probation period`, etc. To automate sub-issue creation, create a trigger that will fire when the new employee's issue status changes to **In progress**. To make sure the trigger only fires for issues of the `New employees` type, specify this type in the trigger conditions.

### Create a trigger

1. In the top-right corner of the `Employment Queue` page, click ![](../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.
1. In the left-hand panel, select **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.group-title--automatization }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.title }}** and click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.button-create }}**.
1. In the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_name }}** field, enter a trigger name, e.g., `start_employment`.
1. Under **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_conditions }}**, select **{{ui-key.startrek-backend.fields.issue.fields.system }}** → **{{ ui-key.startrek-backend.fields.issue.status-key-value }}**.
1. In the **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldChangedCondition }}** field that appears, select **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldBecameEqual }}** and then, in a new field next to it, select **In progress** (the status you created in the Candidates Queue workflow).
1. Add another condition by selecting **{{ ui-key.startrek-backend.fields.issue.fields.system }}** → **{{ ui-key.startrek-backend.fields.issue.type-key-value }}** under **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_conditions }}**.
1. In the **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldChangedCondition }}** field that appears, select **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldEquals }}** and then, in a new field next to it, select **New employees**.
1. Under **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_actions }}**, select **{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--webhook }}** in the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_add-action }}** field.
1. In the form that opens, enter the request parameters as you did earlier. In the **{{ ui-key.startrek.blocks-desktop_trigger-action.webhook-body }}** field, update the issue `type`, `description` and key, such as:

```
{
    "queue":"<Employment_Queue_key>",
    "summary":"not_var{{issue.summary.json}}",
    "description":"Grant access permissions and provide equipment",
    "type":"<Access_Permissions_and_Equipment_issue_key>",
    "parent":"not_var{{issue.key}}"
}
```

### Add actions

To automatically create other sub-issues, add the appropriate actions to the trigger:

1. In the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_add-action }}** field at the bottom, select **{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--webhook }}**.
1. Fill out the form as you did earlier. In the **{{ ui-key.startrek.blocks-desktop_trigger-action.webhook-body }}** field, update the issue type description and key, such as:

```
{
   "queue":"<Employment_Queue_key>",
   "summary":"not_var{{issue.summary.json}}",
   "description":"Probation period",
   "type":"<Probation_Period_issue_type_key>",
   "parent":"not_var{{issue.key}}"
}
```
1. Repeat the steps to add actions for other issues.
1. To save the trigger, click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_create }}**.

## Test the triggers

1. On the `Candidate Queue` page, select the test issue and change the status to **Hired**.
1. Make sure a new issue has appeared on the `Employment Queue` page.
1. Open the issue and select **Accept** in the issue status field.
1. Make sure the queue now contains all the appropriate sub-issues.
