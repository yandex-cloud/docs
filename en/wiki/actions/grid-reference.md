# Dynamic tables

Using the `grid` block, you can embed a [dynamic table](../create-grid.md) in your page and set up its format.

### Using a block {#tab-call}

```
{{grid page="tableURL"}}
```



### Block parameters {#tab-params}

| Parameter | Description |
| --- | --- |
| `page` | Required parameter. Contains the address of the table you want to embed. |
| `width` | The table's width as a percentage of the page's width:<br>`{{grid page="tableURL" width="60%"}}` |
| `readonly` | If specified, the table is embedded in <q>read-only mode</q>. |
| `num` | If specified, the row numbers are not displayed. |
| `sort` | If specified, the sorting settings of the source table are not taken into account. |
| `filter` | Use it to set [filters for displaying table rows](#row-filter). |
| `columns` | Use it to [set columns to display on the page](#col-filter). |

## Setting filters for displaying rows {#row-filter}

Use the `filter` parameter to set which rows should be displayed in the embedded table. For example:

```
{{grid page="tableURL" filter="[id1]=value1, [id2]=value2"}}
```

This filter will only output the rows where the conditions are met at the same time:

- The column with the ID `[id1]` has the value `value1`.

- The column with the ID `[id2]` has the value `value2`.

To find a column's ID, switch to table editing mode (**Edit**) and click the **≡** icon in the header of the corresponding column. For example, if you used `Id-101` for the header, the condition should look like: `filter="[101]=value1"`.

To output all rows that meet at least one of the specified conditions, use the `OR` operator.

{% cut "How to specify values for comparison" %}

Depending on the column's data type, the values for comparison are specified differently:

| Data type | Example | Description |
| --- | --- | --- |
| Text | `'bicycle'` | Text in single quotes. |
| Number | `-7` | Number without quotes. |
| Checkbox | `true` | Various formats are supported.<br><br>Boolean \"false\" value: `no, off, false, unchecked`.<br><br>Boolean \"true\" value: `yes, on, true, checked, done`. |
| Date | `2012-12-12` | Date in the format `YYYY-MM-DD` |
| List | `'bicycle'` | Text in single quotes. |
| Multiple list | `'bicycle'` | Text in single quotes. |
| Employee | `login@` | The employee's username without quotes. |
| An issue in {{ tracker-name }} | `KEY-1234` | The key of the issue without quotes. {{ tracker-name }} |

{% endcut %}

{% cut "Supported comparison operations" %}

| Operation | Book | Example |
| --- | --- | --- |
| Equals | `=`, `is` | `[13] is 'bicycle'` |
| Not equal to | `!=`, `is not` | `[13] is not 'bicycle'` |
| Comparison | `<`, `>`, `<=`, `>=` | `[13] > 50 ` |
| Contains a substring | `~` | `[13] ~ 'bike'` |
| Does not contain a substring | `!~` | `[13] !~ 'bike'` |
| In the range from ... to ... (works with numbers and dates) | `between ... and ...` | `[13] between 100 and 1000` |
| Is equal to one of ... | `in (...)` | `[13] in ('bicycle', 'motorcycle', 'helicopter')` |
| Is not equal to any of the ... | `not in (...)` | `[13] not in ('submarine', 'spaceship')` |

{% endcut %}

## Choosing columns to display {#col-filter}

You can display only the specified columns of a dynamic table on the page. To do this:

1. Get the code for embedding a table and place it in the text of the page.

1. Add the `columns` parameter to your code in order to display only the specified columns:

```
{{grid page="tableURL" columns="id1, id2, id3"}}
```

This type of dynamic block only includes columns with IDs: `id1, id2, id3`.

To find a column's ID, switch to table editing mode (**Edit**) and click the **≡** icon in the header of the corresponding column.

