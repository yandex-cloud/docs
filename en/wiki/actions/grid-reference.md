# Embedding dynamic tables

Using blocks, you can embed a [dynamic table](../create-grid.md) on the page and configure it.

### Using a block {#tab-call}

```
{{grid page="tableAddress"}}
```

You can edit dynamic tables right on the page where they're embedded. All changes are automatically applied to the main table and all its occurrences on other pages.

### Block parameters {#tab-params}

| Parameter | Description |
| --- | --- |
| `page` | Required parameter. Contains the address of the table you want to embed |
| `width` | The table width as a percentage of the page width:<br>`{{grid page="tableAddress" width="60%"}}` |
| `readonly` | If specified, the table is embedded in <q>read-only mode</q> |
| `num` | If specified, the table row numbers aren't displayed |
| `sort` | If specified, the sorting settings of the original table don't affect other tables |
| `filter` | Use it to set [filters for displaying table rows](#row-filter) |
| `columns` | Use it to [set columns to display on the page](#col-filter) |

## Setting filters for displaying rows {#row-filter}

Use the `filter` parameter to set which rows should be displayed in the embedded table. For example:

```
{{grid page="tableAddress" filter="[id1]=value1, [id2]=value2"}}
```

This filter will only display rows that meet all the following criteria:

- The column with the ID `[id1]` has the value `value1`.

- The column with the ID `[id2]` has the value `value2`.

To find a column's ID, switch to table editing mode (**Edit**) and click the **≡** icon in the header of the corresponding column.

{% cut "Specifying comparison values" %}

There are multiple ways to choose values to compare based on the table's data type:

| Data type | Example | Description |
| --- | --- | --- |
| Text | `'bicycle'` | Text in single quotes |
| Number | `-7` | Number without quotes |
| Checkbox | `true` | Various entry formats are supported.<br><br>Boolean \"false\" value: `no, off, false, unchecked`.<br><br>Boolean \"true\" value: `yes, on, true, checked, done` |
| Date | 2012-12-12 | Date in the YYYY-MM-DD format |
| List | `'bicycle'` | Text in single quotes |
| Multi-select list | `'bicycle'` | Text in single quotes |

{% endcut %}

{% cut "Supported comparison operations" %}

| Operation | Book | Example |
| --- | --- | --- |
| Equal to | `=`, `is` | `[13] is 'bicycle'` |
| Not equal to | `!=`, `is not` | `[13] is not 'bicycle'` |
| Comparison | `<`, `>`, `<=`, `>=` | `[13] > 50 ` |
| Contains substring | `~` | `[13] ~ 'bike'` |
| No substring | `!~` | `[13] !~ 'bike'` |
| Value from ... to ... (works with numbers and dates) | `between ... and ...` | `[13] between 100 and 1000` |
| Equal to either of ... | `in (...)` | `[13] in ('bicycle', 'motorcycle', 'helicopter')` |
| Not equal to either of ... | `not in (...)` | `[13] not in ('submarine', 'spaceship')` |

{% endcut %}

## Choosing columns to display {#col-filter}

You can choose to only display specific columns from your dynamic table. To do this:

1. Get an embed code and place it in the page text.

1. Add the `columns` parameter to your code in order to display only the specified columns:

```
{{grid page="tableAddress" columns="id1, id2, id3"}}
```

This type of dynamic block only includes columns with IDs: `id1, id2, id3`.

To find a column's ID, switch to table editing mode (**Edit**) and click the **≡** icon in the header of the corresponding column.

