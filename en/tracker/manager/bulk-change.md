# Changing multiple issues

You can change the statuses and parameters of multiple issues at once. To open a list of issues, go to the queue page or filter page.

## Changing the status {#change-status}

To change the issue status:

1. Open the issue list.

1. Check the box ![](../../_assets/tracker/svg/check.svg) next to the issues you want to change.

   If you want to select all the issues on the queue or filter page at once, check the box ![](../../_assets/tracker/svg/check.svg) above the list of issues.

1. Click **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.change-status }}** under the issue list and select the status.

   Only status transitions that are included in the [workflow](workflow.md) are available for bulk change. If you select a status change that is available only to part of the issues, only this part will change their status.

1. After the operation is complete, in the bottom-right corner, you will see a notification with the number of issues with changed status.

   To see a list of issues that cannot be changed to the selected status, click **Learn more** in the notification.

## Move an issues to another queue {#change-queue}

To edit the issue queue:

1. Open the issue list.

1. Check the box ![](../../_assets/tracker/svg/check.svg) next to the issues you want to move.

   If you want to select all the issues on the queue or filter page at once, check the box ![](../../_assets/tracker/svg/check.svg) above the list of issues.

1. Click **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.move }}** under the issue list.

1. Select the queue that the issues will be moved to.

1. When the operation is complete, in the bottom-right corner, you'll see a notification with the number of issues moved to another queue.

   To see a list of issues that cannot be moved, click **More** in the notification. The issues that are in the selected queue already, cannot be moved.

Once moved to another queue, the issues are assigned new keys. Links to the issue using the old key remain valid. When following such a link, the issue automatically opens in the new queue. However, you will not be able to find the issue by the old key using a [filter](../manager/quick-filters.md) or a [query](../user/query-filter.md#query-format.md).

## Adding a link {#add-links}

To add a link to multiple issues at once:

1. Open the issue list.

1. Add ![](../../_assets/tracker/svg/check.svg) next to the issues to which you want to add a related issue.

   If you want to select all the issues on the queue or filter page at once, check the box ![](../../_assets/tracker/svg/check.svg) above the list of issues.

1. Click **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.add-link }}** under the list of issues, select the [link type](../user/links.md), and create the link:

   * To create an issue, click the **New issue** tab. Give your issue a name and press **Enter**.

   * If the issue already exists, click **Existing issue** and specify the issue's key or name, then select the issue from the list. You can find the key on the issue page, under the title (for example, `TEST-1234`).

## Adding issues to a board or project {#add-project-board}

To add issues to a board or project:

1. Open the issue list.

1. Add the ![](../../_assets/tracker/svg/check.svg) checkmark next to the issues that you want to add to your board or project.

   If you want to select all the issues on the queue or filter page at once, check the box ![](../../_assets/tracker/svg/check.svg) above the list of issues.

1. Click ![](../../_assets/horizontal-ellipsis.svg) under the issue list.

   * To add issues to the board, click **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.add-to-board }}**. Select one or more boards, then click **{{ ui-key.startrek.ui_components_bulk_BulkChangeParametersDialog.button-submit-text }}**.

   * To add the issue to a project, select **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.add-to-projects }}**. All the subissues will also be added to the project

## Changing field settings {#change-parameters}

To edit issue parameters:

1. Open the issue list.

1. Check the box ![](../../_assets/tracker/svg/check.svg) next to the issues you want to change.

   If you want to select all the issues on the queue or filter page at once, check the box ![](../../_assets/tracker/svg/check.svg) above the list of issues.

1. Click ![](../../_assets/horizontal-ellipsis.svg) under the issue list and select **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.edit-parameters }}**.

1. Select relevant parameters. If the fields you need are not in the list, use the **Edit parameter list** button to add them.

1. Set the values.

   Some fields, such as **Followers**, **{{ ui-key.startrek-backend.messages.workflow.field.maillists }}**, or **Tags**, may contain a list of values. New values are added to the end of the list by default. To overwrite a field, select **Delete values**.

1. Click **{{ ui-key.startrek.ui_components_BulkSuggestPopup.apply }}**.

## Becoming an issue participant {#change-my-tickets}

To add or remove oneself from the **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.assignee }}** or **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.followers }}** field in an issue:

1. Open the issue list.

1. Check the box ![](../../_assets/tracker/svg/check.svg) next to the issues you want to change.

   If you want to select all the issues on the queue or filter page at once, check the box ![](../../_assets/tracker/svg/check.svg) above the list of issues.

1. Click ![](../../_assets/horizontal-ellipsis.svg) under the issue list and select one of the options.

   * To become an issue participant, select **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.add-me-to-followers }}** or **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.assignee-me }}**.

   * To withdraw your participation in the issue, select **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.remove-me-from }}** and specify **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.followers }}**, **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.assignee }}**, or **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.remove-from-both-fields }}**.
