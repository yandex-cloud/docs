# Editing dynamic tables

To edit a [dynamic table](pages-types.md#grid), edit it, then in the bottom-right corner, click **Edit**.

## Edit the contents of table cells {#edit-cell}

Select a cell and enter your text. Use [Markdown](basic-markup.md) for formatting text. To add a new line in a cell, press the [hotkey](#shortcuts) **Shift** + **Enter**.

To save the changes, click **Complete**. Each time you save your changes, a new copy of the table is added to its [history](history.md#grid). Using the history, you can view all previous versions of the table, compare them, or roll back to any of them.

## Configuring parameters of table columns {#column-params}

1. Click **≡** in a column's first cell.

1. In the pop-up window, change the column parameters:

    * Enter the column heading in the top field.

    * Specify the column's width in pixels or as a percentage of the table's width.

    * If you want the cells to be required for filling in, choose the **Required** option.

    * For columns with the **Checkbox** data type, enable the **Mark as done** option. If the option is enabled, all rows selected with the checkbox will turn gray.

1. Click **Apply**  to save your changes.

## Adding and removing columns {#edit-column}

To add a column:

1. Click **+** in the upper-right corner of the table.

1. Configure the column settings:

    * Enter the column heading in the top field.

    * In the drop-down list, select a [data type](#data-types) for the column cells. After you save the settings, you can't edit the data type.

    * Specify the column's width in pixels or as a percentage of the table's width.

    * If you want the cells to be required for filling in, choose the **Required** option.

    * For columns with the **Checkbox** data type, enable the **Mark as done** option. If the option is enabled, all rows selected with the checkbox will turn gray.

1. Click **Add** .

To delete a column:

1. Click **≡** in a column's first cell.

1. Click **Delete column**.

### Data types {#data-types}

Specifying the data type for a table column:

* **Text** Any text formatted by [Markdown](basic-markup.md).

* **Number**.

* **Checkbox**. A field that can be ticked on/off. To mark an entire row, enable the **Mark made** option. If the option is enabled, all rows selected with the checkbox will turn gray.

* **Date**.

* **List**. A field where a user can select one value from a list.

* **Multiple-choice list**. A field where a user can select multiple values from the list.

* **Employee**. The employee's first and last name.

* **Multiple employees.** First and last names for a list of employees.

* **Issue in {{ tracker-name }}**. The key of the issue that will function as a link in {{ tracker-name }}.

{% note alert %}

This data type can only be selected when creating a column.

{% endnote %}

## Adding and removing rows {#edit-line}

* To add a row, select **Add row** at the bottom of the page.

* To delete a line, hover the cursor over it and click ![](../_assets/wiki/del-row.png) to the right of the line.

## Renaming tables {#rename-tab}

{% note tip %}

You can rename the table without switching to editing mode. For this, click the name at the top of the page and enter a new name.

{% endnote %}

1. In the panel on the left, click ![](../_assets/wiki/table-settings-sidebar.png).

1. Enter a new table name.

1. Click **Save**.

## Sorting table rows {#sort-line}

Rows of a dynamic table can be quickly sorted by any of the columns:

1. To sort rows by values in a column, click the column header.

1. To sort the rows in reverse order, click the column header again.

## Sorting tables by multiple columns at the same time {#sort-multi-column}

You can set multiple sorting parameters at the same time. Sorting parameters are set in descending order of priority.

To create a new sorting parameter:

1. In the panel on the left, click ![](../_assets/wiki/table-settings-sidebar.png).

1. Click **Add sort**.

1. Select the column and sort order.

## Filtering a table {#filter}

You can set conditions for displaying rows or columns for tables embedded using the [dynamic block `grid`](actions/grid-reference.md).

To filter a table:

1. Get the code for the dynamic table. To do this, in the panel on the left, click ![](../_assets/wiki/table-settings-sidebar.png).

1. Copy the code and paste it to the Wiki page.

1. Specify the filtering conditions:

    * To filter rows, use the [`filter` parameter](actions/grid-reference.md#row-filter).

    * To filter columns, use the [`column` parameter](actions/grid-reference.md#col-filter).

## Keyboard shortcuts in dynamic tables {#shortcuts}

Use keyboard shortcuts to manage data in dynamic tables.

| **Action** | **Windows, Linux** | **MacOS** |
| --- | --- | --- |
| Add a row | **Ctrl** + **Enter** | **⌘** + **Enter** |
| Save a row | **Enter** | **Enter** |
| Exit editing mode | **Esc** | **Esc** |
| Move across columns | **Tab** | **Tab** |
| Reverse move across columns | **Shift** + **Tab** | **Shift** + **Tab** |
| Move across cells | **Ctrl** + **→** **←** **↑** **↓** | **⌘** + **→** **←** **↑** **↓** |
| Go to row start | **Home (press twice)** | — |
| Go to row end | **End** (press twice) | — |
| Go to the beginning of the cell | **↑** | **↑** |
| Go to the end of the cell | **↓** | **↓** |
| Add a new line in the cell | **Shift** + **Enter** | **Shift** + **Enter** |
| Select a **Checkbox** | **Space** | **Space** |

#### See also

* [{#T}](create-grid.md)

* [{#T}](add-grid.md)

* [{#T}](import-page.md)

