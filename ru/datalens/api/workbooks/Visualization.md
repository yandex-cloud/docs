# Visualization

Поле-дискриминатор: `kind`


Визуализация данных.


## ColumnDiagram

`kind`:`column`


 Поле | Тип | Описание
------|-----|----------
`x` | **list** * |
`x[]` | **ChartField**  |
`x[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
`y` | **list** * |
`y[]` | **ChartField**  |
`y[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
`sort` | **list**  |
`sort[]` | **ChartSort**  |
`sort[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
`sort[]`.`direction` | **enum/str[`ASC` / `DESC`]** * |
`colors` | **list**  |
`colors[]` | **ChartField**  |
`colors[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
## FlatTable

`kind`:`flat_table`


 Поле | Тип | Описание
------|-----|----------
`columns` | **list** * |
`columns[]` | **ChartField**  |
`columns[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
`sort` | **list**  |
`sort[]` | **ChartSort**  |
`sort[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
`sort[]`.`direction` | **enum/str[`ASC` / `DESC`]** * |
## Indicator

`kind`:`indicator`


 Поле | Тип | Описание
------|-----|----------
`field` | **ChartField** * |
`field`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
## LinearDiagram

`kind`:`linear_diagram`


 Поле | Тип | Описание
------|-----|----------
`x` | **ChartField** * |
`x`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
`y` | **list** * |
`y[]` | **ChartField**  |
`y[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
`y2` | **list** * |
`y2[]` | **ChartField**  |
`y2[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
`sort` | **list**  |
`sort[]` | **ChartSort**  |
`sort[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
`sort[]`.`direction` | **enum/str[`ASC` / `DESC`]** * |
`colors` | **list**  |
`colors[]` | **ChartField**  |
`colors[]`.`source` | [ChartFieldSource](ChartFieldSource.md) * |
