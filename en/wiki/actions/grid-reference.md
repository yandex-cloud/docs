# Dynamic tables

Using the `grid` block, you can embed a [dynamic table](../create-grid.md) in your page and set up its format.

### Using the block {#tab-call}

```
{{grid page="tableURL"}}
```


### Block parameters {#tab-params}

| Parameter | Description |
--- | ---
| `page` | Required parameter. Contains the address of the table you want to embed. |
| `width` | Table width as a percentage of page width:<br>`{{grid page="tableURL" width="60%"}}` |
| `readonly` | If specified, the table is embedded in <q>read-only mode</q>. |
| `num` | If specified, row numbers are not displayed. |
| `sort` | If specified, the sorting settings of the source table are ignored. |
| `filter` | Use it to set [filters for displaying table rows](#row-filter). |
| `columns` | Use it to [set columns to display on the page](#col-filter). |

## Setting filters for displaying rows {#row-filter}

Use the `filter` parameter to set which rows should be displayed in the embedded table. Example:

```
{{grid page="tableURL" filter="[id1]=value1, [id2]=value2"}}
```

This filter will only display the rows for which the following conditions are satisfied at the same time:

- Column with the ID `[id1]` contains `value1`.

- Column with the ID `[id2]` contains `value2`.

To look up column ID:

* Click ![](../../_assets/wiki/svg/actions-icon.svg) in the header of the desired column.

* Select ![](../../_assets/wiki/table-settings-footer.png) **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_sidebar.grid-settings-label }}**.

To output all rows that meet at least one of the specified conditions, use the `OR` operator.

{% cut "Setting values to compare" %}

Depending on the column data type, values to be compared are specified in different ways:

| Data type | Example | Description |
--- | --- | ---
| {{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.text }} | `'bicycle'` | Text in single quotes. |
| {{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.number }} | `-7` | Number without quotes. |
| {{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.checkbox }} | `true` | Different write formats are supported.<br><br>For logical 0: `no, off, false, unchecked`.<br><br>For logical 1: `yes, on, true, checked, done`. |
| {{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.date }} | `2012-12-12` | Date in `YEAR-MONTH-DAY` format. |
| {{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.list }} | `'bicycle'` | Text in single quotes. |
| {{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.multiple_list }} | `'bicycle'` | Text in single quotes. |
| {{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.employee }} | `login@` | Employee's username without quotes. |
| Issue in {{ tracker-name }} | `KEY-1234` | Issue key in {{ tracker-name }} without quotes. |

{% endcut %}

{% cut "Supported comparison operators" %}

| Operation | Writes | Example |
--- | --- | ---
| Equal to | `=`, `is` | `[13] is 'bicycle'` |
| Not equal to | `!=`, `is not` | `[13] is not 'bicycle'` |
| Comparison | `<`, `>`, `<=`, `>=` | `[13] > 50 ` |
| Contains a substring | `~` | `[13] ~ 'bi'` |
| Contains no substring | `!~` | `[13] !~ 'bi'` |
| In the interval from ... to ... (handles numbers and dates) | `between ... and ...` | `[13] between 100 and 1000` |
| Equal to any of ... | `in (...)` | `[13] in ('bicycle', 'motorcycle', 'helicopter')` |
| Not equal to any of ... | `not in (...)` | `[13] not in ('submarine', 'spaceship')` |

{% endcut %}

## Choosing columns to display {#col-filter}

You can only display the specified columns of a dynamic table on a page. To do this:

1. Get the table embed code and insert it into the text of the page.

1. Add the `columns` parameter to the code to display only the columns you need:

```
{{grid page="tableURL" columns="id1, id2, id3"}}
```
This dynamic block contains only columns with the IDs: `id1, id2, id3`.

To look up column ID:

* Click ![](../../_assets/wiki/svg/actions-icon.svg) in the header of the desired column.

* Select ![](../../_assets/wiki/table-settings-footer.png) **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_sidebar.grid-settings-label }}**.