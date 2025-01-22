---
title: How to use tables and tables of contents in {{ wiki-full-name }}
description: In this tutorial, you will learn how to use tables and tables of contents in {{ wiki-name }}.
---

# Tables and tables of contents

{% include [old-editor-warning](../../_includes/wiki/wysiwyg-old-editor.md) %}

## Static table {#tables-wysiwyg}

{% list tabs %}

- New editor

   To add a table, click ![](../../_assets/wiki/svg/wysiwyg/table.svg) on the toolbar and fill in table cells. You can format text in the table cells.

   To edit a table, select a cell and use the dynamic buttons.

- Old editor

   [Simple tables](../static-markup/grids.md) are static tables that are created manually using {{ wiki-name }} markup elements or Markdown formatting.

   To place a table in the text, use the markup:

   ```
   | Heading 1 | Heading 2 | Heading 3 |
   | --- | --- | --- |
   | cell 11 | cell 12 | cell 13 |
   | cell 21 | cell 22 | cell 23 |
   ```

   {% cut "See the result" %}

   ![](../../_assets/wiki/table-with-border.png)

   {% endcut %}

{% endlist %}

## Dynamic table {#grid}

{% list tabs %}

- New editor

   To add a dynamic table to your page, on the task panel, click ![](../../_assets/wiki/svg/wysiwyg/grid.svg) → ![](../../_assets/wiki/svg/wysiwyg/grid.svg) **Dynamic table**.

   To learn about working with dynamic tables, see [Dynamic tables](../edit-grid-wysiwyg.md).

- Old editor

   [Dynamic tables](../pages-types.md#grid) are tables where you can specify column data type, sort values, or make cells required for filling in. You can use a table directly or [embed it in a page](#section-integrate-table).


   ### How to create and place a table on a page created in the old editor {#section-add-table-button}

   To create a table and embed it in the text of a page:

   1. In the panel at the top of the page, click ![](../../_assets/wiki/add-dynamic-grid.png). The [table code](../actions/grid-reference.md) will appear in the text:

      ```
      {{grid page="{{ wiki-pagename }}/grid-2021-01-24t163048" width="100%"}}
      ```

      The created table will become a subcluster of the current page.

   1. Click **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-settings.save }}**.

   1. [Fill in the table](../edit-grid-wysiwyg.md).

   ### Embedding an existing table {#section-integrate-table}

   To embed a dynamic table in a page:

   1. Open the table you need and click ![](../../_assets/wiki/svg/new-settings.svg) **Table settings** in the top-right corner.

   1. Select **</> Copy embed code**.

   1. Configure the parameters for inserting the table.

   1. Copy the table code and paste it into the page text.

   ### Filtering rows and columns {#filter}

   You can filter dynamic tables you embed in a page created in the old editor so that only specific rows and columns are displayed. To do this:

   1. Get the table embed code and insert it into the text of the page.

   1. To choose columns for display, add the `columns` parameter to your table's code. For more information about using this parameter, see [{#T}](../actions/grid-reference.md#col-filter).

   1. To filter table rows based on values set in specific cells, add the `filters` parameter to your table code. For more information about using this parameter, see [{#T}](../actions/grid-reference.md#row-filter).

   ### Jumping to the parent table {#go-to-source}

   To open the original table embedded in the page:

   
   1. Click ![](../../_assets/wiki/table-settings-footer.png) at the bottom of the table.


   1. Select **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-options.parent_table }}**.

{% endlist %}

## Page table of contents {#toc}

{% list tabs %}

- New editor

   To add to your page a table of contents for the current or any other {{ wiki-name }} page created using the old or new editor:

   1. Press `/` and select ![](../../_assets/wiki/svg/wysiwyg/toc.svg) **Page table of contents** in the pop-up window.
   1. Specify the address of the page to add a table of contents to. For example, `homepage/hello-page`. If you do not specify any address, the table of contents will be created for the current page.
   1. In the **From** and **To** fields, specify the maximum and minimum heading levels to include in the table of contents. You can keep the `—` value. In this case:
   - The **From** field will get the h1 value.
   - The **To** field will get the h8 value.
   1. Click **Save**.

   To change the previously created page table of contents, in edit mode, click ![](../../_assets/wiki/svg/actions-icon.svg) → **Edit** in its top-right corner.

- Old editor

   [{{ wiki-name }} pages](../pages-types.md#page) created in the old editor may automatically generate a table of contents based on headings. This is done using a dynamic block named `toc`.

   ### Adding a table of contents for a page {#single-page}

   1. Make sure your page is created in the [old editor](../create-page.md).
   1. Make sure the page headings are [marked up properly](../static-markup.md#markup). To quickly view the table of contents for a page, click ![](../../_assets/wiki/ico-toc.png) in the right-hand panel.
      If there are matching headings on the page, the links in the table of contents may not work correctly.

   1. Create a table of contents using a dynamic block:

      ```text
      not_var{{toc}}
      ```

   By default, all headings of the current {{ wiki-name }} page are added to the table of contents. You can configure the additional TOC settings using the [advanced parameters](#toc-params).

   > Here is an example of a table of contents that includes first (`h1`) to third (`h3`) level headings:
   >
   > ```text
   > {{toc from="h1" to="h3"}}
   > ```

   #### Block parameters (optional) {#toc-params}

   | Parameter | Description |
   --- | ---
   | `from` | Highest level of headings to include first in the table of contents |
   | `to` | Lowest level of headings to include last in the table of contents |
   | `page` | Relative address of the table of contents source page, e.g., `userName/pageName/`; default address of the page where the `toc` block is added |

   ### Adding a table of contents for a page group {#group-pages}

   There are two ways to add a table of contents:

   1. Following [this guide](../actions/page-lists.md).

   1. Using links:

      {% list tabs %}

      - {{ wiki-name }}

         ```text
         ((<link> <page_name>))
         ```

      - Markdown

         ```text
         [<page_name>](<link>)
         ```

      {% endlist %}

{% endlist %}

## Cluster structure {#tree}

{% list tabs %}

- New editor

   To add to your page a table of contents for any cluster consisting of several {{ wiki-name }} subpages:

   1. Press `/` and select ![](../../_assets/wiki/svg/wysiwyg/tree.svg) **Cluster structure** in the pop-up window.
   1. Specify the page address for which you want to format the structure of subpages. For example, `homepage/hello-page`. If you do not specify any address, a table of contents will be created for subpages of the current page.
   1. In the **Depth** field, specify the maximum level of nesting beyond which the pages will not be listed in the table of contents.
   1. Click **Save**.

   To change the previously created cluster structure, in edit mode, click ![](../../_assets/wiki/svg/actions-icon.svg) → **Edit** in its top-right corner.

- Old editor

   You can add lists to your [page](../pages-types.md#page):

   * [{#T}](#tree)
   * [{#T}](#backlinks)
   * [{#T}](#mypages)

   ### Cluster pages {#tree}

   This block contains a list of all pages for the selected cluster.

   #### Using the block {#tree-call}

   ```
   {{tree for="адресСтраницы" nomark="0" depth="3" show_redirects="False" show_grids="True" show_files="False" show_owners="False" show_titles="True"  show_created_at="False" show_modified_at="False" sort_by="title" sort="asc"}}
   ```

   All parameters of the `not_var{{tree}}` block are optional. The example below shows the default parameter values.

   #### Block parameters (optional) {#tree-params}

   | Parameter | Description |
   --- | ---
   | `for` | Address of the page the tree is intended for |
   | `page` | Alternative name (alias) for the `for` parameter |
   | `depth` | Depth of the tree. Setting this to `0` makes the depth unlimited. |
   | `show_grids` | Displaying dynamic tables in the tree:<br>`true`: Dynamic tables are included in the tree.<br>`false`: Dynamic tables are not displayed in the tree. |
   | `show_files` | Displaying attached files in the tree:<br>`true`: Files are included in the tree.<br>`false`: Files are not displayed in the tree. |
   | `show_owners` | Displaying page authors:<br>`true`: Authors are displayed.<br>`false`: Authors are hidden. |
   | `show_titles` | Displaying page titles:<br>`true`: Page titles are displayed.<br>`false`: Page titles are hidden. |
   | `show_created_at` | Displaying page creation dates:<br>`true`: Dates are displayed.<br>`false`: Dates are hidden. |
   | `show_modified_at` | Displaying the dates of page changes:<br>`true`: Dates are displayed.<br>`false`: Dates are hidden. |
   | `sort_by` | Sort pages:<br>`title`: By title.<br>`cluster`: By cluster.<br>`created_at`: By date created.<br>`modified_at`: By date last modified. |
   | `sort` | Sorting order:<br>`asc`: Ascending.<br>`desc`: Descending. |

   ### List of pages linking to a specified page {#backlinks}

   The block contains a list of all pages that link to the specified page.

   #### Using the block {#backlink-call}

   ```
   {{backLinks for="адресСтраницы"}}
   ```

   #### Block parameters (optional) {#baclink-params}

   | Parameter | Description |
   --- | ---
   | `for` | Contains the address of the page that the list is being built for. If this parameter is omitted, the list is built for the current page. |

   ### Pages created by me {#mypages}

   The block contains a list of pages that the user authored.

   #### Using the block {#mypages-call}

   ```
   not_var{{mypages}}
   ```

   > For example, if you want to display a list of pages created by `username` and sort them by the date of their last update, set this block:
   >
   > ```
   > {{mypages bychange=1 user="username"}}
   > ```

   All parameters of the `not_var{{mypages}}` block are optional. By default, the block displays the current user's list of pages. The pages are displayed in alphabetical order.

   #### Block parameters (optional) {#mypages-params}

   | Parameter | Description |
   --- | ---
   | `user` | You can display the list of pages created by any user. To do this, specify that user's login in the `user` parameter. |
   | `bydate` | Sorting by creation date:<br>`1`: Enable.<br>`0`: Disable. |
   | `bychange` | Sorting by date of change:<br>`1`: Enable.<br>`0`: Disable. |

{% endlist %}