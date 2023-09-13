# Macros

In {{ tracker-name }}, macros are scripted algorithms that can be executed on the issue page. Use macros to automate routine actions. Macros run in one click, allowing you to change issue parameters, create typical commands.

## Creating a macro {#section_inq_5b1_x2b}

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

Each {{ tracker-name }} queue has its own set of macros. To create a new macro for the queue:

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. In the left-hand panel, select **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.group-title--automatization }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macros.title }}** and click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macros.button-create }}**.

1. Set up the parameters for the new macro:
   - **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macro-editor.label_name }}**.
   - **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macro-editor.label_body }}**: Text of a message () to be created when the macro is run. If you don't want your macro to create any messages, leave this field empty.

      You can insert [issue field values](../user/vars.md) into the message text. To do this, click **{{ ui-key.startrek.blocks-desktop_trigger-action.action_add-variable }}** and select one or more values. The **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macro-editor.label_body }}** field will show a sequence like `not_var{{issue.field_key}}`.
   - **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macro-editor.label_actions }}**: Choose issue fields a macro should change and specify their new values.

1. Tap **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macro-editor.action_create }}**.


## Editing and deleting macros {#section_swl_sdb_x2b}

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. In the left-hand panel, select **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.group-title--automatization }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macros.title }}** and hover over the macro you need.

1. To edit the macro, click ![](../../_assets/tracker/icon-edit.png).
To delete the macro, click ![](../../_assets/tracker/icon-delete.png).

## Running a macro {#section_ekq_22b_x2b}

We can use macros to change issue parameters, create comments,. Any user who has access to changing the issue can run a macro on it.

To execute the macro:

1. Open the issue page.

1. Go to the comment field.

1. Click ![](../../_assets/tracker/svg/macros.svg) **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macros.title }}** and select a macro from the drop-down list.
   You can select multiple macros at the same time. If the macros affect the same parameter, the last selected macro will be applied to the parameter.


1. To execute the macro, click **{{ ui-key.startrek.ui_components_macros_Dialog.apply-button-label }}**.


## Example of a macro {#macro_example}


Let's say a member of the first line of support wants to transfer a user request in {{ tracker-name }} to the second line of support. Let's set up a macro that will execute this action:

1. Open the queue.

1. Under **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macros.title }}**, click [**{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macros.button-create }}**](#section_inq_5b1_x2b).

1. Name the macro.

1. Write the text of a message to be added to a comment in the issue. You can add issue fields by clicking **{{ ui-key.startrek.blocks-desktop_trigger-action.action_add-variable }}**.

1. To make sure that the macro assigns the issue to a specific Line 2 support engineer, select the **{{ ui-key.startrek-backend.fields.issue.fields.system }}** → **{{ ui-key.startrek-backend.fields.issue.assignee-key-value }}** field under **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macro-editor.label_actions }}** and specify the name of the employee.

1. If you want your macro to change the issue status, go to **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macro-editor.label_actions }}**, choose **{{ ui-key.startrek-backend.fields.issue.fields.system }}** → **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.field-status }}**, and set it to **Support line 2**.


   If the list of values doesn't include a proper status, [set up the workflow](add-workflow.md).

   ![](../../_assets/tracker/macro-example-line2.png)

1. Save the macro.

To execute the created macro:

1. Open the issue page.

1. Go to the comment field.

1. Click ![](../../_assets/tracker/svg/macros.svg) **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_macros.title }}** and select a macro from the drop-down list.

1. Tap **{{ ui-key.startrek.ui_components_macros_Dialog.apply-button-label }}**. The issue will be forwarded to Tier 2 support.