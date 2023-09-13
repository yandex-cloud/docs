# Creating a dynamic table

_Dynamic tables_ are tables where users can specify data types in columns, sort values, and make cells mandatory. You can use a table directly or [embed it in a {{ wiki-name }} page](add-grid.md#grid).

There are multiple ways to create a table:

- [From any {{ wiki-name }} page](#create-page), by setting the address of a new table manually.

- [In a specific cluster](#create-subpage), by creating a subpage.

- [In the page editing window](#add-table-in-page), by clicking the button in the top panel.


{% note info %}

The maximum number of pages per organization is 10,000.

{% endnote %}


## Set the table address manually {#create-page}

To create a new table:

1. In the left-hand panel, click ![](../_assets/wiki/svg/create-page.svg) **Create page**.

1. Select the **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-widget.grid }}** type.

1. Specify the title and address of the table in the same way as when [creating a regular page](create-page.md).

1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-head.create }}**.

1. Fill out the table:

   {% cut "Create columns" %}

   1. In the top-right corner, click **+** **Add column**.

   1. Configure the column parameters:

      {% include [column parameters](../_includes/column-parameters.md) %}

   1. For some data types, you can select additional settings:

      * For columns with the **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.checkbox }}** data type, enable the **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.mark_made }}** option. In this case, the rows marked with checkboxes will appear gray.

      * For columns with the **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.list }}** data type, enable the **Allow multiple options** option. In this case, the list will be replaced by a multiple list.

      * For columns with the **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.employee }}** data type, enable the **Allow multiple users** option. In this case, a selection of multiple employees will be available.

   1. Select **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.add }}**.

   {% note info %}

   After creating a column, you cannot edit **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_w-grid-preview.data_type }}** and **Unique ID**.

   {% endnote %}


   {% endcut %}

   {% cut "Create rows" %}

   To create a new row, click ![](../_assets/wiki/svg/add.svg) **{{ ui-key.yacloud.component.table-input.popup_title }}** at the bottom of the table.

   {% endcut %}

   {% cut "Fill in the cells" %}

   {% include [edit table cells](../_includes/edit-cells.md) %}

   {% endcut %}

## Creating cluster subpages {#create-subpage}

You can create a table in a specific cluster:

1. Navigate to the cluster where you want to create a table.

1. There are two ways to create a table in a cluster:

   * In the ![](../_assets/wiki/svg/structure-icon.svg) **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-options.tree }}** menu, to the right of the page name, click ![](../_assets/wiki/svg/button-add-subpage.svg) **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-page-more-panel.create_page }}**.

   * In the top-right corner of the cluster page, click ![](../_assets/wiki/svg/actions-icon.svg) **Actions** and select **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-page-more-panel.create_page }}**.

1. Select the **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-widget.grid }}** type.

1. Think up a name.

1. The **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-action-delete.table_address }}** field will be populated automatically. You can change the page address manually, if required.

1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-head.create }}**.

## Adding a table in the page editing window {#add-table-in-page}

To create a table and embed it in the text of a page:

1. Navigate to the page where you want to add a new table and click **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table.edit }}**.

1. On the top panel, click ![](../_assets/wiki/add-dynamic-grid.png). The [table code](actions/grid-reference.md) will appear in the text:
   `{{grid page="{{ wiki-pagename }}/grid-2021-01-24t163048" width="100%"}}`.
   The created table becomes a subsection of the current page.

1. Save the page.

1. [Fill in the table](edit-grid.md).

#### See also

- [Inserting a simple table](add-grid.md#simple-table)

- [{#T}](edit-grid.md)

- [{#T}](create-page.md)

- [{#T}](delete-page.md)

