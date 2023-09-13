# Working with a {{ tracker-name }} agile board

Issues are displayed on the board as cards with basic issue parameters. You [can customize](../manager/edit-agile-board.md#sec_layout) the appearance of cards on the board by choosing fields to display and setting colors that appear when selecting tags and components.

{% note warning %}

You can't restrict access to a board, but you can restrict access to issues shown on the board.

The board shows the issues only from the queues that the user has access to. To restrict access to individual issues, [add components with restricted access](../manager/queue-access.md#access-components).

{% endnote %}

## Managing issues {#manage-tasks}

Managing issues on {{ tracker-name }} boards is like working with stickers on a real board:

* Issue cards are distributed across columns according to their statuses. To change the issue status, drag it to the relevant column.
* If you want to place a card somewhere else in the column, just drag it to the location you need (only applies to boards with [Allow changing the order of issues](../manager/edit-agile-board.md#board-settings) enabled).
* To change the parameters or comment on the issue, click its key and edit the issue card on the right.

## Create an issue {#create-task}

{% note warning %}

Make sure that the queue for creating issues in is specified in the [board settings](../manager/edit-agile-board.md#board-settings). The new issue will be created in this queue.

{% endnote %}

{{ tracker-name }} boards allow you to quickly create issues. You can create an issue in the sprint right away or add it to the backlog. You only need to specify the name and type of the issue: the other fields can be filled out later.

#### Creating an issue on a board

1. Open issues boards.

1. In the bottom-right corner, click **{{ ui-key.startrek.ui_components_agile_common_AddIssueButton.add-issue-button }}**.

1. Enter the issuer name and select its type.

1. Click **{{ ui-key.startrek.blocks-desktop_agile-create-issue.create }}**.

The created issue will be placed in the queue you specified in the [settings](../manager/edit-agile-board.md#board-settings). To see the issue, update the board page.

#### Creating an issue in a sprint

1. In the top-right corner, click **{{ ui-key.startrek.blocks-desktop_b-page-agile-board.sprints }}**.

1. Select the sprint where you want to create an issue.

1. Enter the issuer name in the field under the sprint's issue list.

1. Select the issue type and click **{{ ui-key.startrek.blocks-desktop_agile-create-issue.create }}**.

The created issue will be placed in the queue you specified in the [settings](../manager/edit-agile-board.md#board-settings). To see the issue, update the board page.

#### Creating an issue in the backlog

1. In the top-right corner, click **{{ ui-key.startrek.blocks-desktop_b-page-agile-board.sprints }}**.

1. Enter the issuer name in the field under the backlog's issue list.

1. Select the issue type and click **{{ ui-key.startrek.blocks-desktop_agile-create-issue.create }}**.

The created issue will be placed in the queue you specified in the [settings](../manager/edit-agile-board.md#board-settings). To see the issue, update the board page.

## Adding issues to a board {#add-tasks}

{% note warning %}

Your board will only display issues if their issue statuses are enabled in the board settings.

{% endnote %}

You can add issues with specific settings to your board automatically using [board filters](../manager/edit-agile-board.md). To add an issue to your board manually, create a new issue on the board from scratch, or add an issue to the backlog or a sprint.

#### Adding issues to a backlog

1. Open the issue page.

1. Click the **{{ ui-key.startrek-backend.fields.issue.boards }}** field header in the right-hand panel. If you do not see the **{{ ui-key.startrek-backend.fields.issue.boards }}** field, add it by clicking **{{ ui-key.startrek.blocks-desktop_b-ticket-sidebar.action--select-fields }}**.

1. Start typing the board name in the **{{ ui-key.startrek-backend.fields.issue.boards }}** field and pick the option you need from the list that appears.

The issue will be placed on the board you've picked.

#### Adding issues to a sprint

1. Open the issue page.

1. Under **{{ ui-key.startrek-backend.fields.issue.fields.agile }}** in the right-hand panel, click the **{{ ui-key.startrek-backend.fields.issue.sprint }}** field header. If you do not see the **{{ ui-key.startrek-backend.fields.issue.sprint }}** field, add it by clicking **{{ ui-key.startrek.blocks-desktop_b-ticket-sidebar.action--select-fields }}**.

1. Start typing the sprint's name in the field and pick the option you need from the list that appears. The board field is populated automatically.

The issue will be added to the selected sprint on the board right away.

#### Adding multiple issues

To add multiple issues to the board at once, use the [bulk change](../manager/bulk-change.md) feature:

1. Select the issues you need using [filters](create-filter.md).

1. Choose the issues you want to add to the board and click **{{ ui-key.startrek.blocks-desktop_b-bulk-change.edit-fields }}**.

1. To add an issue to a backlog, start typing the backlog name in the **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.board }}** field and pick the option you need from the list that appears. If you do not see the **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.board }}** field, add it by clicking **{{ ui-key.startrek.blocks-desktop_b-ticket-sidebar.action--select-fields }}**.

1. To add an issue to a sprint, start typing the sprint name in the **{{ ui-key.startrek-backend.fields.issue.sprint }}** field and pick the option you need from the list that appears. The board field is populated automatically.

   If you do not see the **{{ ui-key.startrek-backend.fields.issue.sprint }}** field, add it by clicking **{{ ui-key.startrek.blocks-desktop_b-ticket-sidebar.action--select-fields }}**.

1. Click **{{ ui-key.startrek.ui_components_TransitionScreen.screen-next-button }}** and wait until your issues are processed.

## Remove an issue from the board {#remove-tasks}

There are several methods to remove issues from the board:

* If you added the issue manually, clear the value of the **{{ ui-key.startrek-backend.fields.issue.boards }}** field on the issue page.

* If the issue was added to the board automatically using a filter, update the filter parameters in the [board settings](../manager/edit-agile-board.md#board-settings), then clear the value of the **{{ ui-key.startrek-backend.fields.issue.boards }}** field on the issue page.

   {% note alert %}

   If the issue matches the filter parameters, it will be added to the board again.

   {% endnote %}

Removed issues will no longer show up on the board, but will remain available in {{ tracker-name }}.

## Adding notes to a board {#notes_add}

You can add your notes or comments to the board's columns to explain them to other users. Such notes aren't protected from editing: any user can change them.

To add a note to a column:

1. Open the board page.

1. Select ![](../../_assets/tracker/icon-dots.png) → **{{ ui-key.startrek.blocks-desktop_b-agile-board.add-note }}** at the top of the column.

1. Enter the text of your note. To format the text, use [YFM markup](markup.md).

1. Save your changes.


You can only add one note per column. It will be shown to all users at the top of the column.

## Filtering issues {#filter-tasks}

If there are too many issues on the board, you can always hide some of them using filters. You can apply multiple filters at the same time:

* By sprint. On the top panel, select the issues that you want to view.

* By resolution. In the top panel, expand the **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_fields.field-type--resolution }}** menu and specify the resolutions you want to display on the board.

* By status. In the top panel, expand the **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_fields.field-type--status }}** menu and specify the statuses you want to display on the board.

* The issue's key or name. Start typing the text in the field on the top panel. Only the issues whose key or name includes this text will remain on the board.

* Quick filters. By default, the board has only two quick filters: **{{ ui-key.startrek.ui_components_agile_common_QuickFiltersItem.quick-filter--assignee-me }}** and **{{ ui-key.startrek.ui_components_agile_common_QuickFiltersItem.quick-filter--author-me }}**. To add new filters, click![](../../_assets/tracker/edit-agile.png) in the filter panel.

## Fullscreen mode {#fullscreen}

You can switch the board to a full-screen mode. The full-screen mode shows the issue cards in the compact way so that more of them can fit on the board. This mode is convenient for planning or analyzing the sprint.

* To switch to fullscreen mode, open the board page and click ![](../../_assets/tracker/fullscreen-agile.png) next to the board's name.

* To set the board's update period, in full-screen mode, select one of the following values for the **{{ ui-key.startrek.blocks-desktop_b-page-agile-board.auto-refresh-text }}** field in the bottom-right corner of the page: **{{ ui-key.startrek.blocks-desktop_b-page-agile-board.auto-refresh-period }}**, **Every 3 minutes**, **Every 5 minutes**, or **{{ ui-key.startrek.blocks-desktop_b-page-agile-board.auto-refresh-off }}**.

* To exit fullscreen mode, click **{{ ui-key.startrek.blocks-desktop_b-page-agile-board.full-screen-off }}** in the bottom-right corner of the page.

## Adding boards to Favorites {#board-fav}

To always have quick access to the board, add it to favorites. Just go to a board's page and click ![](../../_assets/tracker/add-to-favorites.png) to the right of the board name. You can find your favorite boards in the **{{ ui-key.startrek.blocks-desktop_m-head.menu-agile }}** menu on the {{ tracker-name }} top panel.
