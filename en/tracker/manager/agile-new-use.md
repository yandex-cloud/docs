# Working with an agile board in {{ tracker-name }}

You can add issues to your board from any of your queues. Issues are displayed on the board as cards with general issue parameters on them. A card's appearance can be [customized](agile-new-set.md).



## Managing issues {#manage}

Managing issues on Tracker boards is similar to using stickers on a real board:

* Issue cards are arranged into columns based on their status. To change the issue status, just drag it to the corresponding column.

  {% note info %}

  You won't be able to move a card to the column if the queue [workflow](./workflow.md) doesn't support the new status.

  {% endnote %}

* To change a card's position in the column, click ![](../../_assets/tracker/svg/actions.svg) in the card's upper-right corner and select **Move to top** or **Move to bottom**.

* To remove an issue from the board, click ![](../../_assets/tracker/svg/actions.svg) in the card's upper-right corner and select **Remove from board**.

  {% note info %}

  If you remove an issue from the project board, it will also be removed from the [project's issue list](project-list.md).

  {% endnote %}

* If you want to change issue parameters or leave a comment, click the issue card and make your changes on the right-hand panel.

## Filtering issues {#filter}

If there are too many issues on the board, you can always hide some of them using filters. You can select one of the saved filters or create a new one. You can also apply multiple filters simultaneously.

To create a filter on the board:

1. In the upper-right corner, click ![](../../_assets/tracker/svg/filter.svg)&nbsp;**Filters**. The filter settings panel will appear above the columns.

1. Click ![](../../_assets/tracker/svg/add-filter.svg). Select a parameter and set its value to filter issues.

   Your filter can contain multiple parameters if needed.

1. To remove a filter, click ![](../../_assets/tracker/svg/clear-filter.svg)&nbsp;**Reset**.

1. To save a filter, click ![](../../_assets/tracker/svg/save-filter.svg)&nbsp;**Save**:

   1. Enter a name for your filter.

   1. Select who will see the filter pinned at the top of the board for quick access: only you or all users. Pinned filters are displayed as buttons at the top of the board.

   1. Click **Save**.

   Saved filters can be accessed by all users.

1. You can pin your saved filters to the top of the board for quick access:

   1. On the filter panel, click ![](../../_assets/tracker/svg/settings.svg) (or you can click ![](../../_assets/horizontal-ellipsis.svg) in the upper-right corner) and select **Manage filters**.

   1. Select filters to display on the board and click **Apply**.

1. To edit or delete a saved filter, click ![](../../_assets/horizontal-ellipsis.svg) in the upper-right corner and select **Manage filters**. Then click ![](../../_assets/tracker/svg/settings.svg) next to the filter name.

## Issue grouping {#group}

To group issues displayed on the board by a certain parameter, click ![](../../_assets/tracker/svg/group.svg)&nbsp;**No grouping** at the top of the board and select a grouping parameter from the list. All issues that have the same value for the parameter will be grouped together.

## Create an issue {#create-task}

You can create new issues right on the issue board. To do this, you just need to specify its name or queue. You can fill in the other fields later.

1. Open the board page.

1. In the leftmost column, click ![](../../_assets/tracker/svg/add-task.svg) and select **New issue**.

1. Enter the issue name.

1. In the drow-down list, choose the queue for your issue.

1. Press **Enter**.

## Adding issues to boards {#add-task}

The issues you add to the board are displayed in columns that correspond to issue statuses. If the issues you've added are not displayed on the board, make sure you [linked their statuses to the columns](agile-new-set.md#cols). To view the list of statuses that are not used on the board, click ![](../../_assets/tracker/svg/unused-status.svg) next to the rightmost column.

{% note warning %}

You can add up to 2000 issues to a board.

{% endnote %}

### From the board page {#from-board}

1. Open the board page.

1. In the leftmost column, click ![](../../_assets/tracker/svg/add-task.svg) and select **Existing issue**.

1. Start typing the issue's name or key and pick the option you need from the list of suggestions.

### From the issue page {#from-ticket}

1. Open the issue page.

1. Click the **Boards** field on the right-hand panel. If the **Boards** field is not displayed, you can add it by clicking **Edit parameters list**.

1. Start typing your board's name and pick the option you need from the list of suggestions.

### Adding multiple issues {#from-bulk}

1. Find the issues you need using [filters](../user/create-filter.md).

1. Select the issues you wish to add to the board.

1. On the bottom panel, click ![](../../_assets/horizontal-ellipsis.svg) and select **Add to board**.

1. Start typing your board's name and pick the option you need from the list of suggestions.

1. Wait for the issues to be processed.



### Adding issues to project boards {#project}

When managing projects in the [beta version of the new interface {{ tracker-full-name }}](project-new.md), project issues are automatically displayed on the project's board.

* As you add an issue to the project board, it's also automatically added to the project itself.

* If you remove an issue from the issue board, it will be removed from the project as well.

## Adding notes to a board {#add-note}

You can attach your own notes and comments to the columns on the board to make navigation easier for other users. Such notes can be freely edited by all users.

To attach a note to a column, do the following:

1. Open the board page.

1. At the top of the column, click ![](../../_assets/tracker/svg/actions.svg) and select ![](../../_assets/tracker/svg/icon-note.svg)&nbsp;**Add a note**.

1. Enter the text for your note. If needed, you can format the note text using the buttons on the panel.

1. Save the changes.

You can only attach one note to each individual column. It will show up at the top of the column, visible to all users.

## Adding boards to Favorites {#favourites}

You can add boards to Favorites for quicker access. To do this, find the top panel on the issue page and click ![](../../_assets/tracker/svg/favourites.svg) to the right of the board name.



