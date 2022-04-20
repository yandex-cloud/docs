# Dynamic tables

You can use `grid` blocks to embed [dynamic tables](../create-grid.md) on your page and configure display settings for them.

### Calling the block {#tab-call}

```
{{grid page="tableURL"}}
```

You can edit dynamic tables right on the page where they're embedded. All changes are automatically applied to the main table and all its occurrences on other pages.

### Block parameters {#tab-params}

| Parameter | Description |
| --- | --- |
| `page` | Required parameter. Contains the address of the table you want to embed. |
| `width` | The table's width as a percentage of the page's width:<br>`{{grid page="tableURL" width="60%"}}` |
| `readonly` | If specified, the table is embedded in <q>read-only</q> mode. |
| `num` | If specified, the table row numbers aren't displayed. |
| `sort` | If specified, the sorting settings of the original table don't affect other tables. |
| `filter` | Use the parameter to set [filters for displaying table rows](#row-filter). |
| `columns` | Use the parameter to [set columns to be displayed on the page](#col-filter). |

## Setting filters for displaying rows {#row-filter}

Use the `filter` parameter to set the rows to be displayed in the embedded table. Example:

```
{{grid page="tableURL" filter="[id1]=value1, [id2]=value2"}}
```

This filter will only display rows that meet all the following criteria:

- The column with ID `[id1]` has `value1`.

- The column with ID `[id2]` has `value2`.

To find out a column's ID, switch to table edit mode (**Edit**) and click the **≡** icon in the corresponding column header. For example, if ID in the header is set to `Id-101`, the condition should entered as follows: `filter="[101]=value1"`.

To display rows that meet at least one of the specified criteria, use the `OR` operator.

{% cut "How to specify values for comparison" %}

There are multiple ways to choose values for comparison based on the table's data type:

| Data type | Example | Description |
| --- | --- | --- |
| Text | `'bicycle'` | Text in single quotes |
| Number | `-7` | Number without quotes. |
| Checkbox | `true` | You can use different formatting options.<br><br>For Boolean true value: `no, off, false, unchecked`.<br><br>For Boolean false value: `yes, on, true, checked, done`. |
| Date | `2012-12-12` | Date format: `YYYY-MM-DD`. |
| List | `'bicycle'` | Text in single quotes |
| Multi-select list | `'bicycle'` | Text in single quotes |
| Employee | `login@` | Employee's username without quotes. |
| Issue in {{ tracker-name }} | `KEY-1234` | Issue key in {{ tracker-name }} without quotes. |

{% endcut %}

{% cut "Supported comparison operations" %}

| Operation | Operator | Example |
| --- | --- | --- |
| Equal to | `=`, `is` | `[13] is 'bicycle'` |
| Not equal to | `!=`, `is not` | `[13] is not 'bicycle'` |
| Comparison | `<`, `>`, `<=`, `>=` | `[13] > 50 ` |
| Contains substring | `~` | `[13] ~ 'bi'` |
| No substring | `!~` | `[13] !~ 'bi'` |
| Value from ... to ... (works with numbers and dates) | `between ... and ...` | `[13] between 100 and 1000` |
| Equal to either of ... | `in (...)` | `[13] in ('bicycle', 'motorcycle', 'helicopter')` |
| Not equal to either of ... | `not in (...)` | `[13] not in ('submarine', 'spaceship')` |

{% endcut %}

## Choosing columns to display {#col-filter}

You can choose to only display specific columns from your dynamic table. To do this:

1. Get an embed code and place it in the page text.

1. Add the `columns` parameter to your code to only display specific columns:

```
{{grid page="tableURL" columns="id1, id2, id3"}}
```

This type of dynamic block only includes columns with the following IDs: `id1, id2, id3`.

To find out a column's ID, switch to table edit mode (**Edit**) and click the **≡** icon in the corresponding column header.

