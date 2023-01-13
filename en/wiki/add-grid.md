# Inserting a table

## Inserting static tables {#simple-table}

[Simple tables](static-markup/grids.md) are static tables that are created manually using {{ wiki-name }} markup elements or Markdown formatting.

To place a table in the text, use the markup:

```
| Heading 1 | Heading 2 | Heading 3 |
| --- | --- | --- |
| cell 11 | cell 12 | cell 13 |
| cell 21 | cell 22 | cell 23 |
```

{% cut "See the result" %}

![](../_assets/wiki/table-with-border.png)

{% endcut %}

## Inserting dynamic tables {#grid}

[Dynamic tables](pages-types.md#grid) are tables where users can specify data types in columns, sort values, and make cells mandatory. You can use a table directly or [embed it in a Wiki page](#section-integrate-table).



### Creating and embedding a table in a Wiki page {#section-add-table-button}

To create a table and embed it in the text of a Wiki page:

1. In the panel at the top of the Wiki page, click ![](../_assets/wiki/add-dynamic-grid.png). The [table code](actions/grid-reference.md) appears in the text:

   ```
   {{grid page="{{ wiki-pagename }}/grid-2021-01-24t163048" width="100%"}}
   ```

   The created table becomes a subsection of the current page.

1. Click **Save**.

1. [Fill in the table](edit-grid.md).

### Embedding an existing table {#section-integrate-table}

To embed a dynamic table in a Wiki page:

1. Open the desired table and click **Edit**.

1. Click **</>** in the sidebar.

1. Configure the parameters for inserting the table.

1. Copy the table code and paste it into the Wiki page text.

### Filtering rows and columns {#filter}

You can filter tables you embed in a Wiki page so that only specific rows and columns are displayed. To do this:

1. Get the code for embedding a table and place it in the text of the Wiki page.

1. To choose columns for display, add the `columns` parameter to your table's code. For more information about using this parameter, see [{#T}](actions/grid-reference.md#col-filter).

1. To filter rows based on values set in specific cells, add the `filter` parameter to your table's code. For more information about using this parameter, see [{#T}](actions/grid-reference.md#row-filter).

### Jumping to the parent table {#go-to-source}

To open the original table embedded in the Wiki page:

1. Click ![](../_assets/wiki/table-settings-footer.png) at the bottom of the table.

1. Choose **Parent table**.

#### See also

- [{#T}](edit-grid.md)

- [{#T}](import-page.md)

- [{#T}](static-markup/csv.md)