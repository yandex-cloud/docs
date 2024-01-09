# Automating routine actions in issues

Employees on a probation period perform routine actions whose tracking can be automated.

## Set up automatic assignment of the end of the probation period

To have the probation period end date set automatically, create a trigger that will fire when an issue is created:

1. In the top-right corner of the `Employment Queue` page, click ![](../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.
1. On the left-hand panel, select **Automation** → **Triggers** and click **Create trigger**.
1. In the **Name** field, enter a trigger name, e.g., `probation_setup`.
1. Under **Trigger conditions**, select **{{ ui-key.startrek-backend.fields.issue.fields.system }}** → **{{ ui-key.startrek-backend.fields.issue.type-key-value }}**.
1. In the field that appears, select **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldEquals }}** and then, in a new field next to it, select **Probation period** (the issue type created previously).
1. Add another condition: select **Event** under **Trigger conditions** and then select **{{ ui-key.startrek-backend.events.event.IssueCreated }}** in the field that appears.
1. Under **Trigger actions**, select **Calculate value** in the **Add new action** field.
1. Enter the following formula in the resulting field:
   ```
   now()+3M
   ```

## Set up automatic checklist creation

To make sure you do not miss anything important in the course of new employee onboarding, add checklist creation to trigger actions:

1. Under **Trigger actions**, select **Create checklist** in the **Add new action** field.
1. In the form that opens, click **{{ ui-key.startrek.ui_components_entity-page_checklist_Footer.new-item-button-caption }}** and enter a description of the first item, such as `Assign a supervisor`.
1. Repeat the steps to add other items to the checklist.
1. To save the trigger, click **Create**.

## Set up issue status auto updates

To switch the issue to the next status upon filling in the checklist, create a new trigger:

1. Click **Create trigger**.
1. In the **Name** field, enter a trigger name, e.g., `probation_checklist`.
1. Select **{{ ui-key.startrek-backend.messages.trigger.condition.field.checklist }}** and **{{ ui-key.startrek-backend.fields.issue.type-key-value }}** → **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldEquals }}** → **Probation period** as trigger conditions.
1. Select **{{ ui-key.startrek-backend.types.types.trigger.action.transition }}** as the trigger action and set a status, such as **In progress**.

   {% note warning %}

   The issue status will not change if there are fields that must be filled in during transition to the specified status.
   For example, the **{{ ui-key.startrek-backend.applinks.otrs.status.closed }}** status requires making a comment, so you cannot use it in this action.

   {% endnote %}

1. Save your trigger.

## Test the triggers

1. On the `Employment Queue` page, select an issue of the `New employee` type.
1. Change the issue status to **Accept**.
1. Make sure the queue now contains all the appropriate sub-issues.
1. Open the `Probation period` sub-issue and check that:
   * The **Deadline** field shows a date that is three months from now.
   * There is a section named **{{ ui-key.startrek-backend.fields.issue.checklistItems }}** with the appropriate items.
1. Select all the checklist items and refresh the page. Make sure the issue status has changed.

