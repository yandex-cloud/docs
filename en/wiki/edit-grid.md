# Editing dynamic tables

To edit a table, open it and click **Edit** in the lower-right corner.

## Edit cell contents {#edit-cell}

Select a cell and enter text. Use the [Markdown markup](basic-markup.md) for text formatting. To move to a new line within a cell, use the [keyboard shortcut](#shortcuts) **Shift** + **Enter**.

To save your changes, click **Finish**. Each time you save changes, a new copy of the table is created in the [edit history](history.md). In edit history, your can view all previous versions of a table, compare changes, and restore any of the versions.

## Configuring parameters of table columns {#column-params}

1. Click the **≡** icon in the first cell of the column.

1. Change the column parameters in the window that pops up:

    * Enter the column heading in the top field.

    * Specify the column's width in pixels or as a percentage of the table's width.

    * To mark cells as mandatory to fill in, choose the **Required** option.

    * Enable **Mark as done** for columns with the **Checkbox** data type. If the option is enabled, all checked rows will turn gray.

1. Click **Apply** to save your changes.

## Adding and removing columns {#edit-column}

To add a column:

1. Click **+** in the upper-right corner of the table.

1. Configure the column settings:

    * Enter the column heading in the top field.

    * In the drop-down list, choose an applicable [data type](#data-types) for the column. You can't change the data type after saving.

    * Specify the column's width in pixels or as a percentage of the table's width.

    * To mark cells as mandatory to fill in, choose the **Required** option.

    * Enable **Mark as done** for columns with the **Checkbox** data type. If the option is enabled, all checked rows will turn gray.

1. Click **Add**.

To remove a column:

1. Click the **≡** icon in the first cell of the column.

1. Click **Delete column**.

### Data types {#data-types}

Specify data type for the column:

* **Text**. Any text formatted using [Markdown markup](basic-markup.md).

* **Number**.

* **Checkbox**. You can mark items in a checkbox field. To mark the entire row, enable **Mark as finished**. If the option is enabled, all checked rows will turn gray.

* **Date**.

* **List**. You can select an item from a list of suggestions.

* **Multi-select list**. You can select multiple items from a list of suggestions.

* **Employee**. An employee's first and last name{% if audience == "internal" %}, as well as a link to their Staff profile{% endif %}.

* **Multiple employees**. First and last names of the employees{% if audience == "internal" %}, as well as links to their Staff profiles{% endif %}.

* **Issue on {{ tracker-name }}**. An issue key that works as a link to {{ tracker-name }}.

{% note alert %}

You can only select data type when creating a column.

{% endnote %}

## Adding and removing rows {#edit-line}

* To add a row, select **Add row** at the bottom of the page.

* To delete a row, hover your cursor over the row and click the icon ![](../_assets/wiki/del-row.png) on the right.

## Renaming tables {#rename-tab}

1. Open the table.

1. Click ![](../_assets/wiki/table-settings-sidebar.png) in the panel on the right.

1. Set a new table name.

1. Click **Save**.

{% note info %}

You don't have to enable edit mode to rename your table.

{% endnote %}

## Sorting table rows {#sort-line}

Rows in dynamic tables can be quickly sorted by column:

1. In the column header, click ![](../_assets/wiki/sort-column.png).

1. Click the icon again to sort the rows in reverse order.

## Sorting tables by multiple columns at the same time {#sort-multi-column}

You can apply multiple sort orders as the same time. Sorting types are specified in descending order of priority.

To create a new sort order:

1. Click ![](../_assets/wiki/table-settings-sidebar.png) in the panel on the right.

1. Click **Add sort order**.

1. Choose a column and sort order.

## Filtering tables {#filter}

You can set conditions for displaying rows and columns in your table if the table is embedded into a Wiki page via the ["grid" dynamic block](actions/grid-reference.md).

To add filters to your table:

1. Get the dynamic table's code. To do this, click the icon on the left-hand panel ![](../_assets/wiki/table-link.png).

1. Copy the code and paste it onto the Wiki page.

1. Specify the filter parameters:

    * To customize row display, use the ["filter" parameter](actions/grid-reference.md#row-filter).

    * To customize column display, use the ["column" parameter](actions/grid-reference.md#col-filter).

## Keyboard shortcuts in dynamic tables {#shortcuts}

You can use keyboard shortcuts to manage data in dynamic tables.

| **Action** | **Windows, Linux** | **MacOS** |
| --- | --- | --- |
| Add a row | **Ctrl** + **Enter** | **⌘** + **Enter** |
| Save a row | **Enter** | **Enter** |
| Exit edit mode | **Esc** | **Esc** |
| Move between columns | **Tab** | **Tab** |
| Move back between columns | **Shift** + **Tab** | **Shift** + **Tab** |
| Move between cells | **Ctrl** + **→** **←** **↑** **↓** | **⌘** + **→** **←** **↑** **↓** |
| Move to the start of the row | **Home** (double-click) | — |
| Move to the end of the row | **End** (double-click) | — |
| Move to the start of the cell | **↑** | **↑** |
| Move to the end of the cell | **↓** | **↓** |
| Create a new line within a cell | **Shift** + **Enter**. | **Shift** + **Enter**. |
| Check a **Checkbox** cell | **Space** | **Space** |

#### See also

* [{#T}](create-grid.md)

* [{#T}](add-grid.md)

* [{#T}](import-page.md)

