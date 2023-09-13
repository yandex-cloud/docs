# Configuring transitions

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

You can use transitions to set up rules for changing the issue statuses. Set conditions for making transitions between statuses, executing auto actions on status change, and suggest the user to change certain issue parameters on the transition screen.

## Adding a transition {#section_en2_fhb_wbb}

You can add a transition between the statuses set for your workflow:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select the initial status in the **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}** panel.

1. Click the **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.tab-title--create-action }}** tab.

1. Set up a new transition:

   | Field | Description |
   ----- | -----
   | **{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_create-action.target-status--label }}** | Specify the target status of the transition. |
   | **{{ ui-key.startrek.blocks-desktop_b-queue-issue-type__workflow-table.button-name }}** | The name of the button in the {{ tracker-name }} interface that will switch the issue to this status. The transition also has this name in the editor. |
   | **{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_create-action.name-en--label }}** | The name of the button in the English {{ tracker-name }} interface that will switch the issue to this status. |

1. Click **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

1. [Edit your transition](workflow-action-edit.md) if you want to add conditions or auto actions.

## Configuring the transition button {#section_k1g_khb_wbb}

You can change the target status of the transition and the name of the transition button:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select the transition from the right column in the **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}** panel.

1. Click the **{{ ui-key.startrek.blocks-desktop_workflow-editor--action.tab-title--general }}** tab.

1. Configure the transition parameters:

   | Field | Description |
   ----- | -----
   | **{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_create-action.target-status--label }}** | Specify the target status of the transition. |
   | **{{ ui-key.startrek.blocks-desktop_b-queue-issue-type__workflow-table.button-name }}** | The name of the button in the {{ tracker-name }} interface that will switch the issue to this status. The transition also has this name in the editor. |
   | **{{ ui-key.startrek.blocks-desktop_workflow-editor--step_tab_create-action.name-en--label }}** | The name of the button in the English {{ tracker-name }} interface that will switch the issue to this status. |

1. Click **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

## Configuring auto actions {#section_ems_23b_wbb}

You can configure automated actions to be performed by {{ tracker-name }} during status transitions. These can include editing issue fields, setting resolutions, and other actions.

To add an auto action:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select the transition from the right column in the **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}** panel.

1. Click the **{{ ui-key.startrek.blocks-desktop_workflow-editor--action.tab-title--functions }}** tab.

1. Select one or more features from the drop-down list.

1. Adjust the function settings and click **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

## Setting transition conditions {#section_jrk_hmb_wbb}

You can restrict when a transition is active. For example, the transition can be limited to a list of employees or those who have specific roles.

#### Add a condition

To add one or more conditions:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select the transition from the right column in the **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}** panel.

1. Click the **{{ ui-key.startrek.blocks-desktop_workflow-editor--action.tab-title--conditions }}** tab.

1. Specify how the conditions have to be checked:

   - **{{ ui-key.startrek.blocks-desktop_workflow-condition.type--all }}**: All conditions must be met.

   - **{{ ui-key.startrek.blocks-desktop_workflow-condition.type--any }}**: At least one condition must be met.

1. Select one or more conditions from the drop-down list.

   In addition to basic criteria, you can add a [group](#dlentry_jt4_jrb_wbb).

1. Configure the conditions and click **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

#### Adding a group of criteria {#dlentry_jt4_jrb_wbb}

You can group conditions to combine them logically.

To add a group of criteria:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select the transition from the right column in the **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}** panel.

1. Click the **{{ ui-key.startrek.blocks-desktop_workflow-editor--action.tab-title--conditions }}** tab.

1. In the **{{ ui-key.startrek.ui_components_workflow-conditions_ConditionsMenu.add-condition }}** list, select **Combine using AND/OR**.

1. Add conditions to the group and select how the conditions should be checked inside the group.

1. Click **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

## Customizing the transition screen {#section_uf2_sks_gcb}

The transition screen is a pop-up window that you can use to suggest the user to change certain issue parameters. For example on the transition screen you can ask the user to set a resolution, leave a comment, or add the time spent.

To customize the transition screen:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select the transition from the right column in the **{{ ui-key.startrek.blocks-desktop_workflow-editor.sidebar-title }}** panel.

1. Click the **{{ ui-key.startrek.blocks-desktop_workflow-editor--action.tab-title--screen }}** tab.

1. Enable the **Show screen for this transition** option.

1. Configure the screen parameters:

   | Name | Description |
   ----- | -----
   | **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.screen-title--label-ru }}** | Text in the pop-up window title. |
   | **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.screen-title--label-en }}** | Text in the pop-up window title in the English interface. |
   | **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.screen-elements-title }}** | Select the fields that users can update on the transition screen. If necessary, set the default field values.<br/><br/>To make a field mandatory, select the box to the right of the field. |
   | **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.worklogs-enable }}** | Enable the option to add the time registration form to the transition screen. |
   | **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.linking-enable }}** | Enable the option to add the form for adding links with other issues to the transition screen. |
   | **{{ ui-key.startrek.blocks-desktop_workflow-editor--action_tab_screen.comment-enable }}** | Enable the option to add a comment field to the transition screen. |

1. Click **{{ ui-key.startrek.blocks-desktop_workflow-editor--step.button--submit }}**.

## Removing a transition {#section_del_fl_1}

Make sure that after you have deleted the transition, there are no statuses you can't switch to.

1. Click ![](../../_assets/tracker/delete-agile-status.png) next to the transition name.

1. Confirm the deletion.
