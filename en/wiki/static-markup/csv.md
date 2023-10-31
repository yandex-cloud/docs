# Formatting CSV data

{% include [formatter-alert](../../_includes/wiki/formatter-alert.md) %}

To display CSV data as a table, use the markup:

```
%%(csv delimiter=; head=1)
Heading 1;Heading 2;Heading 3
cell 11;cell 12;cell 13
cell 21;cell 22;cell 23
%%
```

{% cut "See the result" %}

![](../../_assets/wiki/csv-table.png)

{% endcut %}

Markup parameters:

* `delimiter`: A field separator used in CSV tables.

* `head`: If set to 1, the first row of the table becomes a heading.

{% note info %}

You cannot use [text formatting elements](formatting.md) in CSV tables.

{% endnote %}

#### See also

* [Inserting diagrams and flowcharts](diagram.md)

* [Inserting formulas](formulas.md)