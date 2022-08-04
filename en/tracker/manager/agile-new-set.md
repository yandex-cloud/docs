# Configuring boards

{% if audience == "draft"%}
To edit a board, change its design or column layout, go to the board page, find the left-hand panel, click ![](../../_assets/tracker/svg/boards.svg)&nbsp;**Issue boards**, and select your board.

{% note info %}

You can view the **Issue boards** section in the [beta version of the new interface {{ tracker-full-name }}](../user/personal.md#sec_beta).

{% endnote %}
{% endif %}

## Setting up columns {#cols}

Issue cards are arranged into columns based on their status. Set up board columns to view specific statuses and move issues between them.

### Adding a column {#add-cols}

To add a column to an issue board:

1. Click **Add column** on the board page.

1. Add the parameters for the new column:

    * Set one or more statuses in **Column statuses**. To do this, start typing a status name and select a value from the list that appears.

    * Enter your column name.

1. Click **Add**.

1. To view the list of statuses left unused on the board, click ![](../../_assets/tracker/svg/unused-status.svg) next to the rightmost column. Add the desired statuses to the board: on the status card, click ![](../../_assets/tracker/svg/actions.svg), then **Create column** or **Add to column**.

   {% note info %}

   If your board has issues whose statuses are not linked to columns, they will not be displayed on the board.

   {% endnote %}

1. To add a text note to display under the column name, hover over the column and click ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-note.svg) **Add note**.

### Editing columns {#edit-cols}

You can change column parameters and their position on the board.

* To change a column's name or statuses, hover over the column and click ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-edit.svg) **Edit**.

* To change a column's position on the board, drag it to the desired spot.

* To edit the text note displayed under the column name, hover over the column and click ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-note.svg) **Edit note**.

### Deleting columns {#delete-cols}

To remove a column from the board, hover over the column and click ![](../../_assets/tracker/svg/actions.svg) → ![](../../_assets/tracker/svg/icon-remove.svg) **Remove**.

If the removed column had any issues associated with it, they are moved to the **Unused statuses** section. To view these issues, click ![](../../_assets/tracker/svg/unused-status.svg) next to the rightmost column and then click the status name.

## Configuring cards {#cards}

You can customize the appearance of issue cards so that only relevant parameters are displayed on the board. You can also use this feature to quickly find issues with specific tags and components.

By default, the issue card only displays values for the key, name, assignee, and some others fields. To configure field display for issue cards, do the following:

1. In the upper-right corner of the board page, click ![](../../_assets/tracker/svg/icon-card.svg) **Select card fields**.

1. Select the issue fields to display on the card. You can add new fields or remove any configured fields, except for the issue name (the **Issue** field).

1. Click **Apply**.

1. To color-code specific tags and components, do the following:

   1. Configure your card so that it shows the **Tags** or **Components** field.

   2. Click the name of a tag or component on the issue card and select a color.

   The selected tag or component will be highlighted with the color on all cards.

## Deleting a board {#delete-board}

You can delete boards that you don't need. This will leave all its issues intact in {{ tracker-name }}. If you delete a project board, all its associated issues will be stored in the [project issue list](project-list.md).

1. Open the board.

1. In the upper-right corner, click ![](../../_assets/horizontal-ellipsis.svg) and select **Delete board**.

{% if audience == "draft" %}

1. On the left-hand panel, click ![](../../_assets/tracker/svg/boards.svg)&nbsp;**Issue boards** and select **All boards created by me**.

1. Hover over the board and click ![](../../_assets/tracker/icon-delete.png) **Delete**.
{% endif %}

1. Confirm the deletion.

