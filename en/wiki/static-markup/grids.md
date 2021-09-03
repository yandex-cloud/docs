# Table

Static tables do not have any dynamic elements and are marked up manually.

## Markdown table {#tab-md}

- Add an empty line before inserting the table.

- To format your table, use the following markup:

    ```
    | Header 1 | Header 2 | Header 3 |
    | --- | --- | --- |
    | cell 11 | cell 12 | cell 13 |
    | cell 21 | cell 22 | cell 23 |
    ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/table-with-border.png)

    {% endcut %}

{% note info %}

In table cells, you can use [text styling elements](formatting.md).

{% endnote %}

## Table in CSV format {#table_csv}

You can display CSV data as a table by using markup:

```
%%(csv delimiter=; head=1)
Header 1;Header 2;Header 3
cell11;cell12;cell13
cell21;cell22;cell23
%%
```

{% cut "See the result" %}

![](../../_assets/wiki/csv-table.png)

{% endcut %}

Markup parameters:

- `delimiter`: Field separator used in CSV tables.

- `head`: If set to 1, the first row of the table becomes a heading.

{% note info %}

CSV tables don't support any other text markup.

{% endnote %}

