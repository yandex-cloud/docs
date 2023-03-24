# Creating a dynamic table

_Dynamic tables_ are tables where users can specify data types in columns, sort values, and make cells mandatory. You can use a table directly or [embed it in a Wiki page](add-grid.md#grid).

You can create tables in several ways:

- [From any {{ wiki-name }} page](#create-page), by setting the address of a new table manually.

- [In a specific cluster](#create-subpage), by creating a subpage.

- [In the Wiki page editing window](#add-table-in-page), by clicking the button in the top panel.



{% note info %}

The maximum number of pages per organization is 10000.

{% endnote %}


## Set the table address manually {#create-page}

To create a new table:

1. In the panel on the left, click ![](../_assets/wiki/svg/create-page.svg) **Create page**.

1. Select the **Table** type.

1. Set the title and address of the table in the same way as when [creating a regular Wiki page](create-page.md).

1. Click **Create**.

1. Fill in the table:

   {% cut "Create columns" %}

   1. In the upper-right corner, click **+** **Add column**.

   1. Configure the column parameters:

      {% include [column parameters](../_includes/column-parameters.md) %}

   1. For some data types, you can select additional settings:

      * For columns with the **Checkbox** data type, enable the **Mark as done** option. This will make all rows selected with the checkbox turn gray.

      * For columns with the **List** data type, enable the **Allow multiple options** option. In this case, the list will be replaced by a multiple list.

      * For columns with the **Employee** data type, enable the **Allow multiple users** option. In this case, a selection of multiple employees will be available.

   1. Select **Add**.

   {% note info %}

   After creating a column, you can't edit **Data type** and **Unique ID**.

   {% endnote %}


   {% endcut %}

   {% cut "Create rows" %}

   To create a new row, click ![](../_assets/wiki/svg/add.svg) **Add row** at the bottom of the table.

   {% endcut %}

   {% cut "Fill in the cells" %}

   {% include [edit table cells](../_includes/edit-cells.md) %}

   {% endcut %}

## Creating cluster subpages {#create-subpage}

You can create a table in a specific cluster:

1. Navigate to the cluster where you want to create a table.

1. There are two ways to create a table in a cluster:

   * In the ![](../_assets/wiki/svg/structure-icon.svg) **Wiki structure** menu: To the right of the page name, click ![](../_assets/wiki/svg/add.svg) **Create subpage**.

   * In the upper-right corner of the cluster page, click ![](../_assets/wiki/svg/actions-icon.svg) **Actions** and select **Create subpage**.

1. Select the **Table** type.

1. Think up a name.

1. The **Address** field will be populated automatically. If necessary, you can change the page address manually.

1. Click **Create**.

## Adding a table in the Wiki page editing window {#add-table-in-page}

To create a table and embed it in the text of a Wiki page:

1. Navigate to the page where you want to add a new table and click **Edit**.

1. On the top panel, click ![](../_assets/wiki/add-dynamic-grid.png). The [table code](actions/grid-reference.md) appears in the text:
   `{{grid page="{{ wiki-pagename }}/grid-2021-01-24t163048" width="100%"}}`.
   The created table becomes a subsection of the current page.

1. Save the page.

1. [Fill in the table](edit-grid.md).

#### See also

- [Inserting a simple table](add-grid.md#simple-table)

- [{#T}](edit-grid.md)

- [{#T}](create-page.md)

- [{#T}](delete-page.md)

