# Editing a dynamic table

To edit a [dynamic table](pages-types.md#grid), open it and click **Edit** in the bottom-right corner.

If another user edits the table at the same time as you, the data will not be lost. When saving the data, you can select the most suitable option.

In view mode, updates from other users will also be displayed in the table: the header will display a notification about the number of changes with the names of their authors.

## Editing the contents of table cells {#edit-cell}

{% include [edit table cells](../_includes/edit-cells.md) %}

Each time you save your changes, a new copy of the table is added to its [edit history](history.md#grid). Using the history, you can view all previous versions of the table, compare them, or roll back to any of them.

## Configuring parameters of table columns {#column-params}

1. In a column's first cell, click ![](../_assets/wiki/svg/actions-icon.svg) and select ![](../_assets/wiki/svg/grid-settings.svg) **Settings**.

1. In the pop-up window, change the column parameters:

   {% include [column parameters](../_includes/column-parameters.md) %}

1. Click **Apply** to save your changes.

1. To change the column width, move the side border to the left or right. The change in width will be immediately displayed to all users who are currently viewing the table.

   The minimum column width is 200 px.

## Moving a column inside a table {#column-transfer}

To move a column:

1. In the upper-right corner, click ![](../_assets/wiki/svg/grid-settings.svg) **Settings**.

1. Select ![](../_assets/wiki/svg/table-settings.svg) **Configure columns** in the table settings.

1. Select the column name in the list, click ![](../_assets/wiki/svg/moving.svg), and drag it. You can't select multiple columns to move.

## Adding and deleting columns {#edit-column}

To add a column:

1. In the upper-right corner, click **+**.

1. Configure the column parameters:

   * Enter the column **heading** in the top field.

   * The **Unique ID** field will be filled in automatically. If necessary, you can edit it manually.

   * In the drop-down list, select a [data type](#data-types) for the column cells. After you save the settings, you can't edit the data type.

   * To make the cells mandatory, enable the **Required** option.

   * For columns with the **Checkbox** data type, enable the **Mark as done** option. This will make all rows selected with the checkbox turn gray.

1. Select **Add**.

To delete a column:

1. Click ![](../_assets/wiki/svg/actions-icon.svg) in a column's first cell.

1. Click **Delete**.

### Data types {#data-types}

Specify the data type for a table column:

* ![](../_assets/wiki/svg/type-text.svg) **Formatted text**. Any text formatted by [Markdown](basic-markup.md).

* ![](../_assets/wiki/svg/type-number.svg) **Number**.

* ![](../_assets/wiki/svg/type-checkbox.svg) **Checkbox**. A box that can be checked or unchecked. To mark an entire row, enable the **Mark as done** option. This will make all rows selected with the checkbox turn gray.

* ![](../_assets/wiki/svg/type-date.svg) **Date**.

* ![](../_assets/wiki/svg/type-list.svg) **List**. A field where a user can select one value from a list.

   To select a multiple-choice list, enable the **Allow multiple options** option.

* ![](../_assets/wiki/svg/type-employee.svg) **Employee**. An employee's first and last name.

   To select multiple employees, enable the **Allow multiple users** option.

* ![](../_assets/wiki/svg/type-tracker.svg) **Issue in {{ tracker-name }}**. The key of the issue that will function as a link in {{ tracker-name }}.

{% note alert %}

The data type can only be selected when creating a column.

{% endnote %}

## Adding and deleting rows {#edit-line}

* To create a new row, click ![](../_assets/wiki/svg/add.svg) **Add row** at the bottom of the table.

* To delete a row, hover over it and click ![](../_assets/wiki/del-row.png) to the right of the row.

## Renaming a table {#rename-tab}

To rename a table, click the table name and enter a new one.

## Sorting table rows {#sort-line}

To sort table rows:

1. Click ![](../_assets/wiki/svg/actions-icon.svg) in a column's first cell.

1. Select **Sort in descending order** or **Sort in ascending order**.

## Filtering a table {#filter}

You can set conditions for displaying rows or columns for tables embedded using the [dynamic block `grid`](actions/grid-reference.md).

To filter a table:

1. Get the code for the dynamic table:
   1. In the upper-right corner, click ![](../_assets/wiki/svg/grid-settings.svg) **Settings**.

   1. Select ![](../_assets/wiki/svg/link.svg) **Copy embed code**.

   1. In the window that opens, select from the options:
      * **Read-only**.
      * **Show row numbers**.
      * **Sorting option**.
      * **Wysiwyg markdown**.

   1. Click **Copy code**.

1. Specify the filtering conditions:

   * To filter rows, use the [`filter` parameter](actions/grid-reference.md#row-filter).

   * To set up the way columns are displayed, use the [`column` parameter](actions/grid-reference.md#col-filter).

## Keyboard shortcuts in dynamic tables {#shortcuts}

Use keyboard shortcuts to manage data in dynamic tables.

| **Action** | **Windows, Linux** | **MacOS** |
--- | --- | --- |
| Add a row | **Ctrl** + **Enter** | **⌘** + **Enter** |
| Save a row | **Enter** | **Enter** |
| Exit editing mode | **Esc** | **Esc** |
| Navigate between columns | **Tab** | **Tab** |
| Move between columns in the opposite direction | **Shift** + **Tab** | **Shift** + **Tab** |
| Navigate between cells | **Ctrl** + **→** **←** **↑** **↓** | **⌘** + **→** **←** **↑** **↓** |
| Move to the beginning of the row | **Home** (press twice) | — |
| Move to the end of the row | **End** (press twice) | — |
| Go to the beginning of the cell | **↑** | **↑** |
| Go to the end of the cell | **↓** | **↓** |
| Add a new row in the cell | **Shift** + **Enter** | **Shift** + **Enter** |
| Select a **Checkbox** | **Space** | **Space** |

#### See also

* [{#T}](create-grid.md)

* [{#T}](add-grid.md)

* [{#T}](import-page.md)
