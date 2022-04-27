# DashElement

Поле-дискриминатор: `kind`


Элемент дашборда: виджет, селектор и т. д.


## DashTitle

`kind`:`title`


 Поле | Тип | Описание
------|-----|----------
`text` | **str** * |
## DashText

`kind`:`text`


 Поле | Тип | Описание
------|-----|----------
`text` | **str** * |
## DashWidgetContainer

`kind`:`widget_container`


 Поле | Тип | Описание
------|-----|----------
`hide_title` | **bool** * |
`tabs` | **list** * |
`tabs[]` | **WidgetTab**  |
`tabs[]`.`id` | **str** * |
`tabs[]`.`chart_name` | **str** * |
`tabs[]`.`title` | **str**  |
`default_widget_id` | **str**  |
## DashControlDate

`kind`:`control_date`


 Поле | Тип | Описание
------|-----|----------
`show_title` | **bool** * |
`title` | **str** * |
`source` | [ControlValueSource](ControlValueSource.md) * |
`default_value` | **SingleStringValue** * |
`default_value`.`value` | **str** * |
## DashControlDateRange

`kind`:`control_date_range`


 Поле | Тип | Описание
------|-----|----------
`show_title` | **bool** * |
`title` | **str** * |
`source` | [ControlValueSource](ControlValueSource.md) * |
`default_value` | [Value](Value.md) * |
## DashControlExternal

`kind`:`control_external`


 Поле | Тип | Описание
------|-----|----------
`show_title` | **bool** * |
`title` | **str** * |
## DashControlMultiSelect

`kind`:`control_multiselect`


 Поле | Тип | Описание
------|-----|----------
`show_title` | **bool** * |
`title` | **str** * |
`source` | [ControlValueSource](ControlValueSource.md) * |
`default_value` | **MultiStringValue** * |
`default_value`.`values` | **list** * |
`default_value`.`values[]` | **str**  |
## DashControlSelect

`kind`:`control_select`


 Поле | Тип | Описание
------|-----|----------
`show_title` | **bool** * |
`title` | **str** * |
`source` | [ControlValueSource](ControlValueSource.md) * |
`default_value` | **SingleStringValue** * |
`default_value`.`value` | **str** * |
