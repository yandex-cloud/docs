# Insert a table

## Embedding static tables {#simple-table}

[Static tables](static-markup/grids.md) do not have dynamic elements and are configured manually using the {{ wiki-name }} markup or Markdown.

To embed the table in your text, use the following markup:

```
| Header 1 | Header 2 | Header 3 |
| --- | --- | --- |
| cell 11 | cell 12 | cell 13 |
| cell 21 | cell 22 | cell 23 |
```

{% cut "See the result" %}

![](../_assets/wiki/table-with-border.png)

{% endcut %}

## Embedding dynamic tables {#grid}

Use _dynamic tables_ to sort values, specify columns data types, and set required cells. You can use the table as-is or [embed it in a Wiki page](#section-integrate-table).

You can edit dynamic tables right on the Wiki page (unless you had the **Read only** option enabled when copying the table code). All changes are automatically applied to the main table and all its occurrences on other pages.

### Creating and inserting tables into a Wiki page {#section-add-table-button}

To create a table and insert it into the text body of a Wiki page:

1. Click the icon ![](../_assets/wiki/add-dynamic-grid.png) in the panel at the top of the Wiki page. The [table code](actions/grid-reference.md) will appear in the text:

    ```
    {{grid page="{{ wiki-pagename }}/grid-2021-01-24t163048" width="100%"}}
    ```

    The created table will become a sub-cluster of the current page.

1. Click **Save**.

1. [Fill in the table](edit-grid.md).

### Embedding an existing table {#section-integrate-table}

To embed a dynamic table in a Wiki page:

1. Open the table.

1. Click **</>** in the panel on the left.

1. Configure the embedding parameters.

1. Copy the table embed code and paste it into the Wiki page.

### Filtering rows and columns {#filter}

You can filter dynamic tables you embed so that only specific rows and columns are displayed on the Wiki page. To do this:

1. Get a table embed code and insert it into the text on the Wiki page.

1. To choose columns for display, add the `columns` parameter to your table's code. For more information on using this parameter, see [{#T}](actions/grid-reference.md#col-filter).

1. To filter rows based on the values in specific cells, add the `filter` parameter to your table code. For more information about using this parameter, see [{#T}](actions/grid-reference.md#row-filter).

### Jumping to the source table {#go-to-source}

To open the original table embedded in your Wiki page:

1. Click the icon ![](../_assets/wiki/table-settings-footer.png) at the bottom of the table.

1. Select **Parent table**.

#### See also

- [{#T}](edit-grid.md)

- [{#T}](import-page.md)

- [{#T}](static-markup/csv.md)

