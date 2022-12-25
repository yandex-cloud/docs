# DashElement

Discriminator field: `kind`


Dashboard elements: widget, selector, etc.


## DashTitle

`kind`:`title`


| Field | Type | Description |
------|-----|----------
| `text` | **str** * |
## DashText

`kind`:`text`


| Field | Type | Description |
------|-----|----------
| `text` | **str** * |
## DashWidgetContainer

`kind`:`widget_container`


| Field | Type | Description |
------|-----|----------
| `hide_title` | **bool** * |
| `tabs` | **list** * |
| `tabs[]` | **WidgetTab** |
| `tabs[]`.`id` | **str** * |
| `tabs[]`.`chart_name` | **str** * |
| `tabs[]`.`title` | **str** |
| `default_widget_id` | **str** |
## DashControlDate

`kind`:`control_date`


| Field | Type | Description |
------|-----|----------
| `show_title` | **bool** * |
| `title` | **str** * |
| `source` | [ControlValueSource](ControlValueSource.md) * |
| `default_value` | **SingleStringValue** * |
| `default_value`.`value` | **str** * |
## DashControlDateRange

`kind`:`control_date_range`


| Field | Type | Description |
------|-----|----------
| `show_title` | **bool** * |
| `title` | **str** * |
| `source` | [ControlValueSource](ControlValueSource.md) * |
| `default_value` | [Value](Value.md) * |
## DashControlExternal

`kind`:`control_external`


| Field | Type | Description |
------|-----|----------
| `show_title` | **bool** * |
| `title` | **str** * |
## DashControlMultiSelect

`kind`:`control_multiselect`


| Field | Type | Description |
------|-----|----------
| `show_title` | **bool** * |
| `title` | **str** * |
| `source` | [ControlValueSource](ControlValueSource.md) * |
| `default_value` | **MultiStringValue** * |
| `default_value`.`values` | **list** * |
| `default_value`.`values[]` | **str** |
## DashControlSelect

`kind`:`control_select`


| Field | Type | Description |
------|-----|----------
| `show_title` | **bool** * |
| `title` | **str** * |
| `source` | [ControlValueSource](ControlValueSource.md) * |
| `default_value` | **SingleStringValue** * |
| `default_value`.`value` | **str** * |
