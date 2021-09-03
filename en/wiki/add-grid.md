# Inserting a table

## Inserting static tables {#simple-table}

Static tables do not have dynamic elements and are configured manually using Markdown.

To place a table on your page, use the following markup:

```
| Header 1 | Header 2 | Header 3 |
| --- | --- | --- |
| cell 11 | cell 12 | cell 13 |
| cell 21 | cell 22 | cell 23 |
```

{% cut "See the result" %}

![](../_assets/wiki/table-with-border.png)

{% endcut %}

## Inserting dynamic tables {#concept_2}

*Dynamic tables* are tables where users can specify which data types to display, sort by value, and set required cells. You can use the table directly or [embed it in the page](#section-integrate-table).

Dynamic tables can be edited right from the page as long as you don't choose the **Read only** option during embedding. All changes are automatically applied to the main table and all its occurrences on other pages.

### Creating and placing a table on a page {#section-add-table-button}

To create a table and place it in the text of a Wiki page:

1. In the panel at the top of the page, click ![](../_assets/wiki/add-dynamic-grid.png). The [table code](actions/grid-reference.md) will appear in the text:

    ```
    {{grid page="/users/username/pagename/grid-2021-01-24t163048" width="100%"}}
    ```

    The created table becomes a subsection of the current page.

1. Click **Save**.

1. [Fill in the table](edit-grid.md).

### Embedding an existing table {#section-integrate-table}

To embed a dynamic table in a page:

1. Open the table.

1. Click **</>** in the sidebar.

1. Configure the embedding parameters.

1. Copy the embed code and paste it into the page.

### Filtering rows and columns {#filter}

You can filter tables you embed so that only specific rows and columns are displayed. To do this:

1. Get an embed code and place it in the page text.

1. To choose which columns to display, add the `columns` parameter to your table's code. For more information about using this parameter, see [{#T}](actions/grid-reference.md#col-filter).

1. To filter rows based on values set in specific cells, add the `filter` parameter to your table's code. To learn more about using this parameter, see [{#T}](actions/grid-reference.md#row-filter).

### Jumping to the parent table {#go-to-source}

To open the original table you used for embedding:

1. At the bottom of the table, click ![](../_assets/wiki/table-settings-footer.png).

1. Choose **Parent table**.

#### See also

- [{#T}](edit-grid.md)

- [{#T}](import-export-grid.md)

- [{#T}](static-markup/grids.md#table_csv)

