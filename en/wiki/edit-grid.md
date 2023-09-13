# Editing a dynamic table in the old editor

To edit a [dynamic table](pages-types.md#grid), open it and click **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table.edit }}** in the bottom-right corner.

If another user is editing the table at the same time with you, the data will not be lost. When saving the data, you can select the most suitable option.

In view mode, updates from other users will also be displayed in the table: the header will display a notification about the number of changes with the names of their authors.

## Editing the contents of table cells {#edit-cell}

{% include [edit table cells](../_includes/edit-cells.md) %}

Each time you save your changes, a new copy of the table is added to its [edit history](history.md). Using the history, you can view all previous versions of the table, compare them, or roll back to any of them.

## Configuring parameters of table columns {#column-params}

1. In the first cell of the column, click ![](../_assets/wiki/svg/actions-icon.svg) and select ![](../_assets/wiki/svg/grid-settings.svg) **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-options.settings }}**.

1. In the pop-up window, change the column parameters:

   {% include [column parameters](../_includes/column-parameters.md) %}

1. Click **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-settings.save }}** to save your changes.

1. To change the column width, move the side border to the left or right. The change in width will be immediately displayed to all users who are currently viewing the table.

   The minimum column width is 200 px.

## Moving a column inside a table {#column-transfer}

To move a column:

1. In the top-right corner, click ![](../_assets/wiki/svg/grid-settings.svg).

1. Select ![](../_assets/wiki/svg/table-settings.svg) **Configure columns** in the table settings.

1. Select the column name in the list, click ![](../_assets/wiki/svg/moving.svg), and drag it. You cannot select multiple columns to move.

## Adding and deleting columns {#edit-column}

To add a column:

1. In the top-right corner, click **+**.

1. Configure the column parameters:

   * Enter the column **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-widget.name }}** in the top field.

   * The **Unique ID** field will be filled in automatically. You can edit it manually, if required.

   * In the drop-down list, select a [data type](#data-types) for the column cells. After you save the settings, you will not be able to edit the data type.

   * To turn cells into required, enable the **Required** option.

   * For columns with the **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.checkbox }}** data type, enable the **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.mark_made }}** option. In this case, the rows marked with checkboxes will appear gray.

1. Select **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.add }}**.

To delete a column:

1. Click ![](../_assets/wiki/svg/actions-icon.svg) in a column's first cell.

1. Click **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-options.delete }}**.

### Data types {#data-types}

Specify the data type for a table column:

* ![](../_assets/wiki/svg/type-text.svg) **Formatted text**. Any text formatted by [Markdown](basic-markup.md).

* ![](../_assets/wiki/svg/type-number.svg) **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.number }}**.

* ![](../_assets/wiki/svg/type-checkbox.svg) **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.checkbox }}**. Field with a checkbox. To mark an entire row, enable the **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.mark_made }}** option. In this case, the rows marked with checkboxes will appear gray.

* ![](../_assets/wiki/svg/type-date.svg) **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.date }}**.

* ![](../_assets/wiki/svg/type-list.svg) **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.list }}**. Field to select one value from a list of suggested options.

   To select a multiple-choice list, enable the **Allow multiple options** option.

* ![](../_assets/wiki/svg/type-employee.svg) **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.employee }}**. Employee's first and last name.

   To select multiple employees, enable the **Allow multiple users** option.

* ![](../_assets/wiki/svg/type-tracker.svg) **Issue in {{ tracker-name }}**. The key of the issue that will function as a link in {{ tracker-name }}.

* ![](../_assets/wiki/svg/type-task-parameters.svg) **Issue parameters**. Parameters displayed for the ![](../_assets/wiki/svg/type-tracker.svg) **{{ tracker-name }} issue** data type.

{% note alert %}

The data type can only be selected when creating a column.

{% endnote %}

## Adding and deleting rows {#edit-line}

* To create a new row, click ![](../_assets/wiki/svg/add.svg) **{{ ui-key.yacloud.component.table-input.popup_title }}** at the bottom of the table.

* To delete a row, hover over it and click ![](../_assets/wiki/del-row.png) **Delete row**.

## Renaming a table {#rename-tab}

To rename a table, click the table name and enter a new one.

## Sorting table rows {#sort-line}

To sort table rows:

1. Click ![](../_assets/wiki/svg/actions-icon.svg) in the first cell of the column.

1. Select **Sort in descending order** or **Sort in ascending order**.

## Filtering a table {#filter}

You can specify conditions for displaying rows or columns for tables embedded in the page using the [dynamic block `grid`](actions/grid-reference.md).

To filter a table:

1. Get the code for the dynamic table:
   1. In the top-right corner, click ![](../_assets/wiki/svg/grid-settings.svg) **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_sidebar.grid-settings-label }}**.

   1. Select ![](../_assets/wiki/svg/link.svg) **Copy embed code**.

   1. In the window that opens, select the options from among the following:
      * **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-code-form.read_only }}**.
      * **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-code-form.show_line_nums }}**.
      * **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-code-form.can_sort }}**.
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
| Move to the beginning of the row | **Home** (press twice) | N/A |
| Move to the end of the row | **End** (press twice) | N/A |
| Go to the beginning of the cell | **↑** | **↑** |
| Go to the end of the cell | **↓** | **↓** |
| Add a new row in the cell | **Shift** + **Enter** | **Shift** + **Enter** |
| Tick the checkbox in the type cell **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.checkbox }}** | **Space** | **Space** |

#### See also

* [{#T}](create-grid.md)

* [{#T}](add-grid.md)

* [{#T}](import-page.md)
