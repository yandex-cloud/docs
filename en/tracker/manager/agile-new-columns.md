# Configuring board columns

Issue cards are distributed across columns according to their statuses. Set up the board's columns to see relevant statuses and move issues between them. There are two types of board columns: [by status](#status) and [custom](#user-columns).

Go to the board page, click ![](../../_assets/tracker/svg/boards.svg)&nbsp;**Boards** in the left-hand panel and select the board.

## Columns by status {#status}

To go to columns by status, click **Columns** → **Columns by statuses** in the board's top panel.

### Adding a column {#add-status-cols}

To add a column by status to the issue board:

1. On the board page, click **Add column**.

1. Enter the parameters of the new column:

   * In the **Column statuses** field, enter one or more statuses. For this, start entering the status name, then select its value from the list.

   * Enter a name for the column.

   * Set the maximum number of issues per column. If there are more issues, the column will turn yellow, but you will still be able to add issues to it, exceeding the limit.

1. Click **Add**.

1. To view a list of statuses that aren't used on the board, click ![](../../_assets/tracker/svg/unused-status.svg) next to the rightmost column. Add relevant statuses to the board: in the status card, click ![](../../_assets/tracker/svg/actions.svg), then click **Create column** or **Add to column**.

   {% note info %}

   If the board includes issues with statuses not linked to any columns, they will not appear on the board.

   {% endnote %}

1. To add a note with text to appear under the column name, hover over the column, then click ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-note.svg) **Add note**.

### Editing a column {#edit-status-cols}

You can change the column's parameters and its position on the board.

* To rename the column, change the maximum number of issues per column, or update statuses, hover over the column and click ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-edit.svg) **Edit**.

* To reposition the column on the board, drag it around the board.

* To edit the note with the text shown under the column name, hover over the column, then click ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-note.svg) **Edit note**.

### Deleting a column {#delete-status-cols}

To delete a column from the board, hover over the column, then click ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-remove.svg) **Delete**.

If the deleted column contained issues, they will be moved to **Unused statuses**. To view such issues, next to the rightmost column, click ![](../../_assets/tracker/svg/unused-status.svg), then click the status name.

## Custom columns {#user-columns}

You can create, move, and delete custom columns on boards, except the first column that contains non-assigned issues. In addition, you can create issues inside custom columns and move them both within and across the columns.

To go to custom columns, click  **Columns**→ **Custom columns** in the board's top panel.

### Adding a column {#add-user-cols}

To add a custom column to the issue board:

1. On the board page, click **Add column**.

1. Enter the parameters of the new column:

   * Name the column.

   * Set the maximum number of issues per column. If there are more issues, the column will turn yellow, but you will still be able to add issues to it, exceeding the limit.

1. Click **Add**.

1. Add issues to a column: click ![](../../_assets/tracker/svg/add-task.svg) next to it and add an existing issue or create a new one.

   {% note info %}

   If you add the **Story Points** field to the issue card, the total number of **Story Points** in the column will be shown in its heading. To add the **Story Points** field to the issue card, click ![](../../_assets/tracker/svg/actions.svg) → **Card fields** in the right-hand corner of the search, sort, and group panel on the board page and select the **Story Points** field.

   {% endnote %}

### Editing a column {#edit-user-cols}

You can change the column's parameters and its position on the board.

* To rename a column or change the maximum number of issues in it, hover over the column and click ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-edit.svg) **Edit**.

* To reposition the column on the board, drag it around the board.

* To edit the note with the text shown under the column name, hover over the column, then click ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-note.svg) **Edit note**.

### Deleting a column {#delete-user-cols}

To delete a column from the board, hover over the column, then click ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-remove.svg) **Delete**.
