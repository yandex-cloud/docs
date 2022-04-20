# Creating dynamic tables

Use _dynamic tables_ to sort values, specify columns data types, and set required cells. You can use the table as-is or [embed it in a Wiki page](add-grid.md#grid).

There are multiple ways to create a table:

- [In any page {{ wiki-name }}](#create-page), by setting the new table's address manually.

- [In the destination cluster](#create-subpage), by creating a subpage.

- [In the Wiki page editing window](#add-table-in-page), by clicking the button on the top panel.

## Setting the table address manually {#create-page}

To create a new table:

1. In the top {{ wiki-name }} menu, click **Create**.

1. Select **Table**.

1. Enter the table header and address in the same way as when [creating a Wiki page](create-page.md).

1. Click **Create**.

1. Fill in the table:

    {% cut "Create columns" %}

    1. Click **+** in the upper-right corner of the table.

    1. Configure the column settings:

        - Enter the column heading in the top field.

        - Choose a data type to display in the column from the drop-down list.

        - Specify the column's width in pixels or as a percentage of the table's width.

        - To mark cells as mandatory to fill in, choose the **Required** option.

        - Enable **Mark as done** for columns with the **Checkbox** data type. If the option is enabled, all checked rows will turn gray.

    1. Select **Add**.

    {% endcut %}

    {% cut "Create rows" %}

    To create a new row, select **Add row** at the bottom of the table.

    {% endcut %}

    {% cut "Fill in the cells" %}

    Select a cell and enter text. Use the [Markdown markup](basic-markup.md) for text formatting. To move to a new line within a cell, press **Shift**+**Enter**.

    {% endcut %}

1. To save your changes, click **Finish**.

## Create cluster subpages {#create-subpage}

You can create a table right from the desired cluster:

1. Go to the cluster.

1. Click **Action** in the upper-right corner and select **Create subpage**.

1. Select **Table**.

1. Enter your title.

    The **Address** field is filled in automatically. You can edit the address if necessary. The `!` symbol at the start of a row indicates that the address is relative to the current cluster.

1. Click **Create**.

## Add Wiki pages in the edit window {#add-table-in-page}

To create a table and insert it into the text body of a Wiki page:

1. Click the icon ![](../_assets/wiki/add-dynamic-grid.png) in the panel at the top of the Wiki page. The [table embed code](actions/grid-reference.md) will appear in the text: `{{grid page="{{ wiki-pagename }}/grid-2021-01-24t163048" width="100%"}}`.
The created table will become a sub-cluster of the current page.

1. Click **Save**.

1. [Fill in the table](edit-grid.md).

#### See also

- [How to embed a static table](add-grid.md#simple-table)

- [{#T}](edit-grid.md)

- [{#T}](create-page.md)

- [{#T}](create-note.md)

- [{#T}](delete-page.md)

