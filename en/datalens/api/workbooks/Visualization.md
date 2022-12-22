# Visualization

Discriminator field: `kind`


Visualizing data.


## ColumnDiagram

`kind`:`column`


| Field | Type | Description |
------|-----|----------
| `x` | **list** * |
| `x[]` | **ChartField** |
| `x[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
| `y` | **list** * |
| `y[]` | **ChartField** |
| `y[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
| `sort` | **list** |
| `sort[]` | **ChartSort** |
| `sort[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
| `sort[]`.`direction` | **enum/str[`ASC` / `DESC`]** * |
| `colors` | **list** |
| `colors[]` | **ChartField** |
| `colors[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
## FlatTable

`kind`:`flat_table`


| Field | Type | Description |
------|-----|----------
| `columns` | **list** * |
| `columns[]` | **ChartField** |
| `columns[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
| `sort` | **list** |
| `sort[]` | **ChartSort** |
| `sort[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
| `sort[]`.`direction` | **enum/str[`ASC` / `DESC`]** * |
## Indicator

`kind`:`indicator`


| Field | Type | Description |
------|-----|----------
| `field` | **ChartField** * |
| `field`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
## LinearDiagram

`kind`:`linear_diagram`


| Field | Type | Description |
------|-----|----------
| `x` | **ChartField** * |
| `x`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
| `y` | **list** * |
| `y[]` | **ChartField** |
| `y[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
| `y2` | **list** * |
| `y2[]` | **ChartField** |
| `y2[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
| `sort` | **list** |
| `sort[]` | **ChartSort** |
| `sort[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
| `sort[]`.`direction` | **enum/str[`ASC` / `DESC`]** * |
| `colors` | **list** |
| `colors[]` | **ChartField** |
| `colors[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
