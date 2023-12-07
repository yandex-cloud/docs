# Configuring a board

To go to the board page, click ![](../../_assets/tracker/svg/boards.svg)&nbsp;**{{ ui-key.startrek.ui_components_NavigationBar.boards }}** in the left-hand panel and select the board.

## Create an issue {#create-task}

You can create a new issue directly on the board. You only need to specify its name and queue first: the other fields can be filled out later.

1. Open the board page.

1. In the leftmost column, click ![](../../_assets/tracker/svg/add-task.svg) and select **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardEmptyScreen.empty-screen--new-issue }}**.

1. Enter a name for the issue.

1. Select the queue where the issue will be created in the drop-down list.

1. Click **Create** or press **Enter**.

## Adding issues to a board {#add-task}

The issues added to the board are shown in their status columns. If you cannot find the added issues on the board, make sure that you [linked their statuses to columns](agile-new-columns.md). To view a list of statuses that are not used on the board, click ![](../../_assets/tracker/svg/unused-status.svg) next to the rightmost column.

{% note warning %}

You can add no more than 2000 issues per board.

{% endnote %}

### From the board page {#from-board}

1. Open the board page.

1. In the leftmost column, click ![](../../_assets/tracker/svg/add-task.svg) and select **Existing issue**.

1. Start typing the issue's key or name, then pick the option you need from the list.

### From the issue page {#from-ticket}

1. Open the issue page.

1. Click the **{{ ui-key.startrek-backend.fields.issue.boards }}** field in the right-hand panel. If you do not see the **{{ ui-key.startrek-backend.fields.issue.boards }}** field, add it by clicking **{{ ui-key.startrek.ui_components_IssueSidebar.add-sidebar-field }}**.

1. Start typing the board name and pick the option you need from the list that appears.

### Adding multiple issues {#from-bulk}

1. Select the issues you need using [filters](../user/create-filter.md).

1. Select the issues that you want to add to the board.

1. In the left-hand panel, click ![](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.add-to-board }}**.

1. Start typing the board name and pick the option you need from the list that appears.

1. Wait for the issues to be processed.

## Issue auto-import {#autoadd}

To automatically add issues, such as all issues with a certain assignee, to a board, use issue auto-import:

1. On the board, click **{{ ui-key.startrek.ui_components_PageAgileBoard_PageAgileBoardHeader.settings }}** → **{{ ui-key.startrek.ui_components_agile_settings_AgileSettingsLayout.issue-updates }}**.
1. Under **{{ ui-key.startrek.ui_components_agile_settings_BoardIssueUpdatesSettings.import-title }}**, click **+ {{ ui-key.startrek.ui_components_issues-import_IssuesImportFilters.add-parameters }}**. Select a parameter from the list and set its value. For example, to add all issues where you are the assignee to the board, select the **Assignee** parameter and set it to **Me**. To add more parameters, repeat the step.

The page will show the number of issues added to the board. During the first export, the issues that meet the preset condition will be added, except for issues that:

- Cannot be edited by the user setting up auto-import.
- Are already added to the issue board.
- Meet the automatic removal conditions.
- Were previously added to the board automatically but then removed manually.

At further updates, the board will be added all the issues that meet the parameters set in the auto-import settings, ignoring the above exceptions.

## Automatic issue removal {#autodelete}

There is a limit on the number of issues per board: a maximum of 2,000. To make sure your board does not get overloaded, you can set up automatic issue removal, e.g., to remove any closed issues or issues that were closed several months ago.

1. On the board, click **{{ ui-key.startrek.ui_components_PageAgileBoard_PageAgileBoardHeader.settings }}** → **{{ ui-key.startrek.ui_components_agile_settings_AgileSettingsLayout.issue-updates }}**.
1. Under **{{ ui-key.startrek.ui_components_agile_settings_BoardIssueUpdatesSettings.removal-title }}**, add all appropriate statuses and specify how long an issue should be in a certain status.

Once the condition is met, the issue will be removed from the board.

## Adding notes to a board {#add-note}

You can add your notes or comments to the board's columns to explain them to other users. Such notes are not protected from editing: any user can change them.

To add a note to a column:

1. Open the board page.

1. At the top of the column, click ![](../../_assets/tracker/svg/actions.svg), then select ![](../../_assets/tracker/svg/icon-note.svg)&nbsp;**Add note**.

1. Enter the text of your note. Use buttons on the panel to format the text if needed.

1. Save your changes.

You can only add one note per column. It will be shown to all users at the top of the column.

## Adding boards to Favorites {#favourites}

To always have quick access to the board, add it to favorites. To do this, go to the board's page, then, on the top panel of the page, click ![](../../_assets/tracker/svg/favourites.svg) to the right of the board name.

To find your favorite boards, select ![](../../_assets/tracker/svg/boards.svg)&nbsp;**{{ ui-key.startrek.ui_components_NavigationBar.boards }}** in the left-hand panel and filter the boards by the **Favorites** value.

## Show the sprint issues {#sprint-tasks}

1. Open your board.

1. Click **All issues on board**.

1. Select the sprint whose issues you want to display.

## Deleting a board {#delete-board}

Board owners can delete boards that they no longer need. All the issues present on the board will be saved to {{ tracker-name }}. If you delete a project board, its issues will be saved to the [project's issue list](project-list.md).

1. Open the board.

1. In the top-right corner, click ![](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardActionsMenu.delete-board-menu-item }}**.

1. Confirm the deletion.
