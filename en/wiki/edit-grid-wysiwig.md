# Editing a page in the new editor

## General settings {#general-settings}

To edit a [table](pages-types.md#grid), open it and click ![](../_assets/wiki/svg/wysiwyg/grid-settings.svg) **Table settings** in the top-right corner. Select an action:

* [Set up columns](#column-transfer).
* [Use default sorting](#sort-line).
* Copy embed code.
* Upload data from a file:
   * In CSV format.
   * In TXT format.
* Download a table:
   * In XLS format.
   * In DOCX format.
   * In CSV format.
* Delete a table.

## Editing the contents of table cells {#edit-cell}

{% include [edit table cells](../_includes/edit-cells.md) %}

Each time you save your changes, a new copy of the table is added to its [edit history](history.md). Using the history, you can view all previous versions of the table, compare them, or roll back to any of them.

## Configuring parameters of table columns {#column-params}

1. In the first cell of the column, click ![](../_assets/wiki/svg/actions-icon.svg) and select ![](../_assets/wiki/svg/grid-settings.svg) **Settings**.

1. In the pop-up window, change the column parameters:

   * Enter the column **heading** in the top field.

   * The **Unique ID** field will be filled in automatically. You can edit it manually, if required.

   * In the drop-down list, select a [data type](#data-types) for the column cells. After you save the settings, you will not be able to edit the data type.

   * In the **Width** field, set the column width or leave the default `Auto` value.

   * To add a column description, click **Add description**. To view the column description, hover over the ![](../_assets/wiki/svg/column-description.svg) icon. Its text will appear in the pop-up window.

   * To make the cells mandatory, enable the **Required** option.

   * For columns with the **Checkbox** data type, enable the **Mark as done** option. This will make all rows selected with the checkbox turn gray.

1. Click **Apply** to save your changes.

To change the column width, move the side border to the left or right. The change in width will be immediately displayed to all users who are currently viewing the table.

{% note info %}

The minimum column width is 200 px.

{% endnote %}

## Moving a column inside a table {#column-transfer}

To move a column:

1. In the top-right corner, click ![](../_assets/wiki/svg/grid-settings.svg).

1. Select ![](../_assets/wiki/svg/table-settings.svg) **Configure columns** in the table settings.

1. Select the column name in the list, click ![](../_assets/wiki/svg/moving.svg), and drag it. You cannot select multiple columns to move.

## Adding and deleting columns {#edit-column}

To add a column:

1. In the top-right corner, click ![](../_assets/wiki/svg/add.svg).

1. Configure the column parameters:

   * Enter the column **heading** in the top field.

   * The **Unique ID** field will be filled in automatically. You can edit it manually, if required.

   * In the drop-down list, select a [data type](#data-types) for the column cells. After you save the settings, you will not be able to edit the data type.

   * In the **Width** field, set the column width or leave the default `Auto` value.

   * To add a column description, click **Add description**. To view the column description, hover over the ![](../_assets/wiki/svg/column-description.svg) icon. Its text will appear in the pop-up window.

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

* ![](../_assets/wiki/svg/type-task-parameters.svg) **Issue parameters**.
    Parameters displayed for the ![](../_assets/wiki/svg/type-tracker.svg) **{{ tracker-name }} issue** data type.

{% note alert %}

The data type can only be selected when creating a column.

{% endnote %}

## Adding and deleting rows {#edit-line}

* To create a new row, click ![](../_assets/wiki/svg/add.svg) **Add row** at the bottom of the table.

* To delete a row, hover over it and click ![](../_assets/wiki/svg/delete-line.svg) **Delete row**.

## Renaming a table {#rename-tab}

To rename a table, click the table name and enter a new one.

## Sorting table rows {#sort-line}

To sort table rows:

1. Click ![](../_assets/wiki/svg/actions-icon.svg) in the first cell of the column.

1. Select **Sort in descending order** or **Sort in ascending order**.

To add multiple filters:

1. In the top-right corner, click ![](../_assets/wiki/svg/wysiwyg/grid-settings.svg) **Table settings**.

1. Click **Default order**.

1. Click **Add**:

1. In the drop-down list, select a column and sorting type: **Sort in descending order** or **Sort in ascending order**.

1. Click **Save**.

1. Add other filters and click **Apply**. The **Sorting configured** button will appear in the top-right corner above the table.

To set the sorting order, click ![](../_assets/wiki/svg/moving.svg) in the filter list and drag it. You cannot select multiple filters to move.


#### See also

* [{#T}](create-grid.md)

* [{#T}](add-grid.md)

* [{#T}](import-page.md)
