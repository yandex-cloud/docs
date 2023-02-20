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

1. Click **Add issue** in the lower-right corner.

1. Enter the issuer name and select its type.

1. Click **Create**.

The created issue will be placed in the queue you specified in the [settings](../manager/edit-agile-board.md#section_ft1_3l3_3z). To see the issue, update the board page.

#### Creating an issue in a sprint

1. Click **Sprints** in the upper-right corner.

1. Select the sprint where you want to create an issue.

1. Enter the issuer name in the field under the sprint's issue list.

1. Select the issue type and click **Create**.

The created issue will be placed in the queue you specified in the [settings](../manager/edit-agile-board.md#board-settings). To see the issue, update the board page.

#### Creating an issue in the backlog

1. Click **Sprints** in the upper-right corner.

1. Enter the issuer name in the field under the backlog's issue list.

1. Select the issue type and click **Create**.

The created issue will be placed in the queue you specified in the [settings](../manager/edit-agile-board.md#board-settings). To see the issue, update the board page.

## Adding issues to a board {#add-tasks}

{% note warning %}

Your board will only display issues if their issue statuses are enabled in the board settings.

{% endnote %}

You can add issues with specific settings to your board automatically using [board filters](../manager/edit-agile-board.md). To add an issue to your board manually, create a new issue on the board from scratch, or add an issue to the backlog or a sprint.

#### Adding issues to a backlog

1. Open the issue page.

1. Click the title of the **Boards** field in the right-hand panel. If there's no **Boards** field, add it by clicking **Choose fields**.

1. Start typing the board's name in the **Boards** field and pick the option you need from the list that appears.

The issue will be placed on the board you've picked.

#### Adding issues to a sprint

1. Open the issue page.

1. Click the title of the **Sprint** field in the **Agile** panel on the right. If there's no **Sprint** field, add it by clicking **Choose fields**.

1. Start typing the sprint's name in the field and pick the option you need from the list that appears. The board field is populated automatically.

The issue will be added to the selected sprint on the board right away.

#### Adding multiple issues

To add multiple issues to the board at once, use the [bulk change](../manager/bulk-change.md) feature:

1. Select the issues you need using [filters](create-filter.md).

1. Choose the issues you want to add to the board and click **Edit fields**.

1. To add an issue to a backlog, start typing the backlog's name in the **Board** field and pick the option you need from the list that appears. If there's no **Board** field, add it by clicking **Choose fields**.

1. To add an issue to a sprint, start typing the sprint's name in the **Sprint** field and pick the option you need from the list that appears. The board field is populated automatically.

   If there's no **Sprint** field, add it by clicking **Choose fields**.

1. Click **Continue** and wait until your issues are processed.

## Remove an issue from the board {#remove-tasks}

There are several methods to remove issues from the board:

* If you added the issue manually, clear the value of the **Boards** field on the issue page.

* If the issue was added to the board automatically using a filter, update the filter parameters in the [board settings](../manager/edit-agile-board.md#board-settings), then clear the value of the **Boards** field on the issue page.

   {% note alert %}

   If the issue matches the filter parameters, it will be added to the board again.

   {% endnote %}

Removed issues will no longer show up on the board, but will remain available in {{ tracker-name }}.

## Adding notes to a board {#notes_add}

You can add your notes or comments to the board's columns to explain them to other users. Such notes aren't protected from editing: any user can change them.

To add a note to a column:

1. Open the board page.

1. Select ![](../../_assets/tracker/icon-dots.png) → **Add note** at the top of the column.

1. Enter the text of your note. To format the text, use [YFM markup](markup.md).

1. Save the changes.


You can only add one note per column. It will be shown to all users at the top of the column.

## Filtering issues {#filter-tasks}

If there are too many issues on the board, you can always hide some of them using filters. You can apply multiple filters at the same time:

* By sprint. On the top panel, select the issues that you want to view.

* By resolution. On the top panel, expand the **Resolution** menu and specify the resolutions you want to display on the board.

* By status. On the top panel, expand the **Status** menu and specify the statuses you want to display on the board.

* The issue's key or name. Start typing the text in the field on the top panel. Only the issues whose key or name includes this text will remain on the board.

* Quick filters. There are only two quick filters on the board by default: **Assigned to me** and **Reported by me**. To add new filters, click![](../../_assets/tracker/edit-agile.png) in the filter panel.

## Fullscreen mode {#fullscreen}

You can switch the board to a full-screen mode. The full-screen mode shows the issue cards in the compact way so that more of them can fit on the board. This mode is convenient for planning or analyzing the sprint.

* To switch to fullscreen mode, open the board page and click ![](../../_assets/tracker/fullscreen-agile.png) next to the board's name.

* To set the board's update period, in the full-screen mode, in the bottom-right corner of the page, in the **Auto-update** field, select the value: **Every minute**, **Every 3 minutes**, **Every 5 minutes**, or **Disabled**.

* To exit fullscreen mode, click **Exit fullscreen mode** in the bottom right corner of the page.

## Adding boards to Favorites {#board-fav}

To always have quick access to the board, add it to favorites. Just go to a board's page and click ![](../../_assets/tracker/add-to-favorites.png) to the right of the board name. Your favorite boards are displayed in the **Boards** menu on the top panel in {{ tracker-name }}.
