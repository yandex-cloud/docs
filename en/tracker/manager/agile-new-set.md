# Setting up a board

{% if audience == "draft"%}
To edit a board, change its layout and column positioning, go to the board page: in the left panel, click ![](../../_assets/tracker/svg/boards.svg)&nbsp;**Boards**, then select the board.

{% note info %}

The **Boards** section is available in the [beta version of the new {{ tracker-full-name }} interface](../user/personal.md#sec_beta).

{% endnote %}
{% endif %}

## Configuring columns {#cols}

Issue cards are distributed across columns according to their statuses. Set up the board's columns to see relevant statuses and move issues between them.

### Adding a column {#add-cols}

To add a column on the issue board:

1. On the board page, click **Add column**.

1. Enter the parameters of the new column:

   * In the **Column statuses** field, enter one or more statuses. For this, start entering the status name, then select its value from the list.

   * Enter a name for the column.

1. Click **Add**.

1. To view a list of statuses that aren't used on the board, click ![](../../_assets/tracker/svg/unused-status.svg) next to the rightmost column. Add relevant statuses to the board: in the status card, click ![](../../_assets/tracker/svg/actions.svg), then click **Create column** or **Add to column**.

   {% note info %}

   If the board includes the issues with statuses not linked to any columns, such issues won't be shown on the board.

   {% endnote %}

1. To add a note with the text to be shown under the name of the column, hover over the column, then click ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-note.svg) **Add note**.

### Editing a column {#edit-cols}

You can change the column's parameters and its position on the board.

* To change the column name or statuses, hover over the column and click ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-edit.svg) **Edit**.

* To reposition the column on the board, drag it around the board.

* To edit the note with the text shown under the column name, hover over the column, then click ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-note.svg) **Edit note**.

### Deleting a column {#delete-cols}

To delete a column from the board, hover over the column, then click ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-remove.svg) **Delete**.

If the deleted column contained issues, they will be moved to **Unused statuses**. To view such issues, next to the rightmost column, click ![](../../_assets/tracker/svg/unused-status.svg), then click the status name.

## Configuring cards {#cards}

Customize the layout of issue cards to see only relevant parameters on the board or quickly find issues with specific tags and components.

By default, the issue card displays the values of such fields as the key, name, assignee, and some others. To set up the fields to be displayed on the issue card:

1. In the upper-right corner of the board page, click ![](../../_assets/tracker/svg/icon-card.svg) **Select fields to display on the card**.

1. Select the issue fields to be shown on the card. You can add or remove any field, except for the issue name (the **Issue** field) that can't be removed.

1. Click **Apply**.

1. To highlight certain tags or issue components with colors:

   1. Set up the card to show the fields **Tags** or **Components**.

   2. On the issue card, click the name of the tag or component and select its color.

   Such a tag or component will be highlighted by color on all cards.

## Deleting a board {#delete-board}

You can delete boards that you don't need. All the issues present on the board will be saved to {{ tracker-name }}. If you delete a project board, its issues will be saved to the [project's issue list](project-list.md).

1. Open the board.

1. In the upper-right corner, click ![](../../_assets/horizontal-ellipsis.svg) and select **Delete board**.

{% if audience == "draft" %}
1. In the left panel, click ![](../../_assets/tracker/svg/boards.svg)&nbsp;**Boards**, then select **Full list of boards created by me**.

1. Hover over the board, then click ![](../../_assets/tracker/icon-delete.png) **Delete**.
{% endif %}

1. Confirm the deletion.
