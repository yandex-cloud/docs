# Creating dynamic tables

_Dynamic tables_ are tables where users can specify which data types to display, sort by value, and set required cells. You can use the table directly or [embed it in a page](add-grid.md).

There are several ways to create tables:

- [From any {{ wiki-name }} page](#create-page) by manually setting the address of the new table.

- [In a specific cluster](#create-subpage) by creating a subpage.

- [In the page editing window](#add-table-in-page) by clicking the button on the top panel.

## Setting the table address manually {#create-page}

To create a new table:

1. In the {{ wiki-name }} upper panel, Click **Create**.

1. Select **Table**.

1. Set the title and address the same way as when [creating a regular page](create-page.md).

1. Click **Create**.

1. Fill in the table:

    {% cut "Create columns" %}

    1. Click **+** in the upper-right corner of the table.

    1. Configure the column settings:

        - Enter the column heading in the top field.

        - Choose a data type to display in the column from the drop-down list.

        - Specify the column width in pixels or as a percentage of the table width.

        - If you want cells to require a value, choose the **Required** option.

        - For columns with the **Checkbox** data type, enable the **Mark as done** option. If the option is enabled, all rows selected with the checkbox will turn gray.

    1. Click **Add**.

    {% endcut %}

    {% cut "Create rows" %}

    To create a new row, select **Add row** at the bottom of the table.

    {% endcut %}

    {% cut "Fill in the cells" %}

    Select a cell and enter your text. Use [Markdown](basic-markup.md) to format the text. To switch to a new row inside the cell, click **Shift** + **Enter**.

    {% endcut %}

1. To save the changes, click **Done**.

## Creating cluster subpages {#create-subpage}

You can create a table in a specific cluster:

1. Go to the cluster.

1. In the upper-right corner of the page, click **Actions** and select **Create a subpage**.

1. Select **Table**.

1. Enter your page title.

    The **Address** field is filled in automatically. You can edit the address if necessary. The `!` symbol at the beginning of the line means that the address is specified relative to the current cluster.

1. Click **Create**.

## Adding a table in the page editing window {#add-table-in-page}

To create a table and place it in the text of a Wiki page:

1. In the panel at the top of the page, click ![](../_assets/wiki/add-dynamic-grid.png). The [table code](actions/grid-reference.md) appears in the text:

   `{{grid page="/users/username/pagename/grid-2021-01-24t163048" width="100%"}}`.

   The created table becomes a subsection of the current page.

1. Click **Save**.

1. [Fill in the table](edit-grid.md).

#### See also

- [Inserting a simple table](add-grid.md#simple-table)

- [{#T}](edit-grid.md)

- [{#T}](create-page.md)

- [{#T}](create-note.md)

- [{#T}](delete-page.md)

