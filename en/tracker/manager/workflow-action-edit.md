# Configuring transitions

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

Use transitions to configure rules for changing the status of issues, such as conditions for transitions between statuses, macros triggered after status changes, and transition screens with fields for users to fill in.

## Adding a transition {#section_en2_fhb_wbb}

You can add transitions between statuses available in your workflow:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select the initial status in the **Statuses and transitions** panel.

1. Go to the **Add transition** tab.

1. Configure a new transition:

    | Field | Description |
    | ----- | ----- |
    | **Transition to status** | Indicate the status to transition to. |
    | **Button name** | The name of the button in the {{ tracker-name }} interface that will switch the issue to this status. The same name is used for the transition in the editor. |
    | **Button name in English** | The name of the button in the English {{ tracker-name }} interface that will switch the issue to this status. |

1. Click **Save**.

1. [Edit your transition](workflow-action-edit.md) if you want to add conditions or auto actions.

## Configuring the transition button {#section_k1g_khb_wbb}

You can change the status an issue should transition into as well as the name of the transition button:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select the transition from the right column of the **Statuses and transitions** panel.

1. Go to the **General information** tab.

1. Configure the transition:

    | Field | Description |
    | ----- | ----- |
    | **Transition to status** | Indicate the status to transition to. |
    | **Button name** | The name of the button in the {{ tracker-name }} interface that will switch the issue to this status. The same name is used for the transition in the editor. |
    | **Button name in English** | The name of the button in the English {{ tracker-name }} interface that will switch the issue to this status. |

1. Click **Save**.

## Configuring auto actions {#section_ems_23b_wbb}

You can configure automated actions to be performed by {{ tracker-name }} during status transitions. Actions that can be triggered include {% if audience == "internal" %}sending emails, {% endif %}changing issue fields, setting resolutions, and so on.

To add a macro:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select the transition from the right column of the **Statuses and transitions** panel.

1. Go to the **Functions** tab.

1. Select one or more functions from the drop-down list.

1. Adjust the function settings and click **Save**.

## Setting transition conditions {#section_jrk_hmb_wbb}

You can restrict when a transition is active. For example, a certain transition can be available to a restricted list of employees, or only to employees with specific roles.

#### Add a condition

To add criteria:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select the transition from the right column of the **Statuses and transitions** panel.

1. Go to the **Conditions** tab.

1. Specify how criteria should be met:

    - **all**: All criteria must be met.

    - **any**: At least one of the criteria must be met.

1. Select one or more criteria from the drop-down list.

    In addition to basic criteria, you can add a [group](#dlentry_jt4_jrb_wbb).

1. Configure the criteria and click **Save**.

#### Adding a group of criteria {#dlentry_jt4_jrb_wbb}

You can group criteria to logically combine them.

To add a group of criteria:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select the transition from the right column of the **Statuses and transitions** panel.

1. Go to the **Conditions** tab.

1. In the **Add condition** list, select **Combine using AND/OR**.

1. Add criteria to the group and choose how criteria within the group should be checked.

1. Click **Save**.

## Customizing the transition screen {#section_uf2_sks_gcb}

The transition screen is a pop-up window that you can use to suggest changes to issue parameters. For instance, the transition screen can ask the user to enter a resolution, leave a comment, or record the time spent.

To customize the transition screen:

1. Select the workflow and click ![](../../_assets/tracker/button-edit.png).

1. Select the transition from the right column of the **Statuses and transitions** panel.

1. Go to the **Screen** tab.

1. Enable the **Show screen for this transition** option.

1. Customize the screen settings:

   | Name | Description |
   | ----- | ----- |
   | **Screen title** | Popup title |
   | **Screen title** | Popup title in the English interface |
   | **Fields on transition screen** | Select fields that can be configured on the transition screen. If necessary, set the default field values.<br/><br/>To make a field mandatory, select the box to the right of the field. |
   | **Form for time spent** | Enable this option to have a time tracking form appear on the transition screen. |
   | **Adding links on transition screen** | Enable this option to show a form for adding related issues on the transition screen. |
   | **Form for comments** | Enable this option to include a comment field on the transition screen. |

1. Click **Save**.

## Removing a transition {#section_del_fl_1}

Make sure removing a transition will not result in inaccessible statuses.

1. Click ![](../../_assets/tracker/delete-agile-status.png) next to the transition name.

1. Confirm the deletion.

