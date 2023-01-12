# Dynamic tables

Using the `grid` block, you can embed a [dynamic table](../create-grid.md) in your page and set up its format.

### Using the block {#tab-call}

```
{{grid page="tableURL"}}
```

{% if audience == "draft" %}
By default, you can edit this table right on the page it's embedded in. All changes are automatically applied to the main table and any of its occurrences on other pages.
{% endif %}

### Block parameters {#tab-params}

| Parameter | Description |
--- | ---
| `page` | Required parameter. Contains the address of the table you want to embed. |
| `width` | The table's width as a percentage of the page's width:<br>`{{grid page="tableURL" width="60%"}}` |
| `readonly` | If specified, the table is embedded in <q>read-only mode</q>. |
| `num` | If specified, the row numbers are not displayed. |
| `sort` | If specified, the sorting settings of the source table are ignored. |
| `filter` | Use it to set [filters for displaying table rows](#row-filter). |
| `columns` | Use it to [set columns to display on the page](#col-filter). |

## Setting filters for displaying rows {#row-filter}

Use the `filter` parameter to set which rows should be displayed in the embedded table. For example:

```
{{grid page="tableURL" filter="[id1]=value1, [id2]=value2"}}
```

This filter only outputs the rows where the following conditions are met at the same time:

- The column with `[id1]` is set to `value1`.

- The column with `[id2]` is set to `value2`.

To find out the column ID:

* Click ![](../../_assets/wiki/svg/actions-icon.svg) in the header of the desired column.

* Select ![](../../_assets/wiki/table-settings-footer.png) **Settings**.

To output all rows that meet at least one of the specified conditions, use the `OR` operator.

{% cut "Setting values to compare" %}

Depending on the column data type, values to be compared are specified in different ways:

| Data type | Example | Description |
--- | --- | ---
| Text | `'bicycle'` | Text in single quotes. |
| Number | `-7` | Number without quotes. |
| Checkbox | `true` | Different write formats are supported.<br><br>For logical 0: `no, off, false, unchecked`.<br><br>For logical 1: `yes, on, true, checked, done`. |
| Date | `2012-12-12` | Date in `YEAR-MONTH-DAY` format. |
| List | `'bicycle'` | Text in single quotes. |
| Multiple-choice list | `'bicycle'` | Text in single quotes. |
| Employee | `login@` | Employee's username without quotes. |
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

1. Get the code for embedding a table and place it in the text of the page.

1. Add the `columns` parameter to the code to only display the specified columns:

```
{{grid page="tableURL" columns="id1, id2, id3"}}
```
This type of dynamic block only includes columns with IDs: `id1, id2, id3`.

To find out the column ID:

* Click ![](../../_assets/wiki/svg/actions-icon.svg) in the header of the desired column.

* Select ![](../../_assets/wiki/table-settings-footer.png) **Settings**.