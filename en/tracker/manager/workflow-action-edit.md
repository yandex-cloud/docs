# Transitions between statuses

You can use transitions to set up rules for changing the issue statuses. Set conditions for making transitions between statuses, executing auto actions on status change, and suggest the user to change certain issue parameters on the transition screen.

The queue owner and users granted [permission to access the queue settings](queue-access.md) can edit transitions in queue workflows.

## Transition settings {#add-action}

You can set up transitions between statuses within a workflow using the workflow visual editor. To open the workflow editor:

1. Go to the queue page.

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-workflows }}** tab and click the name of the workflow whose status transitions you want to edit.

The workflow visual editor will open. You can use it to edit existing transitions. To do this, just click the appropriate transition in the diagram to open its settings page. You can also [add new transitions](#add-action) to the diagram.

### Automation {#automatization}

You can configure automated actions to be performed by {{ tracker-name }} during status transitions. These can include sending a message, editing issue fields, setting resolutions, and other actions.

To add an auto action:

1. In the transition settings, open the **{{ ui-key.startrek.ui_components_queue-admin-tab-workflows_TransitionEdit.settings-functions }}** section and click **{{ ui-key.startrek.ui_components_workflow-functions_WorkflowFunctionMenu.menu-title }}**.

1. Select the automations you need from the list and configure them. If there is no suitable automation, set up a [trigger](../user/trigger.md).

Possible auto actions at issue status change include:
* **{{ ui-key.startrek.ui_components_workflow-functions.type-SendEmailFunction }}**: Send emails to specific employees or users performing certain issue roles (for example, to the issue reporter or assignee)
* **{{ ui-key.startrek.ui_components_workflow-functions.type-AddCommentFunction }}**: Make a comment in the issue on behalf of a certain user (employee or robot)
* **{{ ui-key.startrek.ui_components_workflow-functions.type-SetActiveSprintFunction }}**: Add an issue to an active sprint on the selected board
* **{{ ui-key.startrek.ui_components_workflow-functions.type-SetCurrentTimeFunction }}**: Write the transition time to the selected field
* **{{ ui-key.startrek.ui_components_workflow-functions.type-CalculateFieldFunction }}**: Sum up the contents of multiple fields and write the resulting value to another field
* **{{ ui-key.startrek.ui_components_workflow-functions.type-MoveUsersFunction }}**: Move or copy users from one field to another
* **{{ ui-key.startrek.ui_components_workflow-functions.type-RemoveUsersFromCcFunction }}**: Remove a user from the list of issue followers, for example, if the required information was received from them and their participation in the issue is no longer required
* **{{ ui-key.startrek.ui_components_workflow-functions.type-AddTextToFieldFunction }}**: Fill in an issue field. When setting up this type of automation, a filter by the type of field value will be helpful
* **{{ ui-key.startrek.ui_components_workflow-functions.type-RemoveFieldValueFunction }}**: Remove the contents of any issue field
* **{{ ui-key.startrek.ui_components_workflow-functions.type-UnsetResolutionFunction }}**: If the issue was completed with a certain resolution, this resolution will be canceled

### Transition conditions {#conditions}

You can limit conditions when a transition is active. For example, the transition can be limited to a list of employees or those who have specific roles.

To add transition conditions:

1. In the transition settings, open the **{{ ui-key.startrek.ui_components_queue-admin-tab-workflows_TransitionEdit.settings-conditions }}** section and click **{{ ui-key.startrek.ui_components_workflow-conditions_ConditionsMenu.add-condition }}**.

1. Select the appropriate conditions from the list and configure them. To set a group of conditions using **AND** and **OR** operators, click **{{ ui-key.startrek.ui_components_workflow-conditions_WorkflowGroupCondition.add-conditions-group }}**.

### Transition screen {#screen}

The transition screen is a pop-up window that you can use to suggest the user to change certain issue parameters. For example, on the transition screen, you can ask the user to set a resolution, leave a comment, or add the time spent.

To add the transition screen:

1. In the transition settings, open the **{{ ui-key.startrek.ui_components_queue-admin-tab-workflows_TransitionEdit.settings-screen }}** section and enable **{{ ui-key.startrek.ui_components_queue-admin-tab-workflows_TransitionEditPageScreen.enable-transition-screen }}**.

1. Customize the transition screen:
   * **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.screen-title--label-ru }}**: Text in the pop-up window title
   * **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.screen-title--label-en }}**: Text in the pop-up window title in the English interface
   * **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.screen-elements-title }}**: Select the fields that users can update on the transition screen. Set the default field values if required. To make a field required, select the box to the right of it
   * **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.worklogs-enable }}**: Enable the option to add the time registration form to the transition screen
   * **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.linking-enable }}**: Enable the option to add the form for adding links with other issues to the transition screen
   * **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.comment-enable }}**: Enable the option to add a comment field to the transition screen

## Adding a transition between statuses {#add-action}

To add a transition between statuses added to a workflow:

1. Go to the queue page.

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-workflows }}** tab and click the name of the workflow you need. The workflow visual editor will open.

1. In the top panel of the workflow visual editor, click **Add transition**. Fill in the **{{ ui-key.startrek.ui_components_queue-admin-tab-workflows_TransitionEdit.field-from-status }}** and **{{ ui-key.startrek.ui_components_queue-admin-tab-workflows_TransitionEdit.field-to-status}}** fields with the appropriate values from the lists. To add a transition for statuses that a workflow does not contain yet, [add them](./workflow-status-edit.md#add-status) first.

1. Fill out the fields below:
   * **Name**: **Initial status** name will be substituted automatically. You can edit it if needed.
   * **Name in English**: Will be generated automatically from the Russian name.

1. Configure the required [automation](#automatization), [conditions](#conditions), and [transition screen](#screen).

You can also add a transition right in the diagram by joining two statuses with an arrow. To do this, hover over a spare point in the initial status section, hold it, and drag it to a spare point of another status.

## Removing a transition {#remove-action}

Make sure that after you have deleted the transition, there are no statuses you cannot switch to.

1. Click ![](../../_assets/tracker/delete-agile-status.png) next to the transition name.

1. Confirm the deletion.
