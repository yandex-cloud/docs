# Creating a dynamic table

_Dynamic tables_ are tables where users can specify data types to display, sort by values, and set required cells. You can use a table directly or [embed it in a Wiki page](add-grid.md#grid).

You can create tables in several ways:

- [From any page {{ wiki-name }}](#create-page), by setting the address of the new table manually.

- [In a specific cluster](#create-subpage), by creating a subpage.

- [In the Wiki page editing window](#add-table-in-page), by clicking the button in the top panel.

{% if audience == "external" %}

{% note info %}

The maximum number of pages per organization is 10,000.

{% endnote %}

{% endif %}

## Set the table address manually {#create-page}

To create a new table:

1. In the panel on the left, click ![](../_assets/wiki/svg/create-page.svg) **Create page**.

1. Select the **Table** type.

1. Set the title and address of the table in the same way as when [creating a regular Wiki page](create-page.md).

1. Click **Create**.

1. Fill in the table:

    {% cut "Create columns" %}

    1. Click **+** in the upper-right corner of the table.

    1. Configure the column settings:

        - Enter the column heading in the top field.

        - Choose a data type to display in the column from the drop-down list.

        - Specify the column's width in pixels or as a percentage of the table's width.

        - If you want the cells to be required for filling in, choose the **Required** option.

        - For columns with the **Checkbox** data type, enable the **Mark as done** option. If the option is enabled, all rows selected with the checkbox will turn gray.

    1. Select **Add**.

    {% endcut %}

    {% cut "Create rows" %}

    To create a new row, click **Add row** at the bottom of the table.

    {% endcut %}

    {% cut "Fill in the cells" %}

    Select a cell and enter your text. Use [Markdown](basic-markup.md) for formatting text. To switch to a new row inside the cell, click **Shift**+**Enter**.

    {% endcut %}

1. To save the changes, click **Complete**.

## Creating cluster subpages {#create-subpage}

You can create a table in a specific cluster:

1. In the menu ![](../_assets/wiki/svg/structure-icon.svg) **Cluster structure**, go to the desired cluster.

1. To the right of the page name, click ![](../_assets/wiki/svg/button-add-subpage.svg) **Create subpage**.

1. Select the **Table** type.

1. Enter your page title.

    The **Address** field is filled in automatically. To edit it, click **Change page address** and enter a new address.

1. Click **Create**.

## Adding a table in the Wiki page editing window {#add-table-in-page}

To create a table and place it in the text of a Wiki page:

1. In the panel at the top of the Wiki page, click ![](../_assets/wiki/add-dynamic-grid.png). The [table code](actions/grid-reference.md) appears in the text:
`{{grid page="{{ wiki-pagename }}/grid-2021-01-24t163048" width="100%"}}`.
The created table becomes a subsection of the current page.

1. Click **Save**.

1. [Fill in the table](edit-grid.md).

#### See also

- [How to insert a simple table](add-grid.md#simple-table)

- [{#T}](edit-grid.md)

- [{#T}](create-page.md)

- [{#T}](delete-page.md)

