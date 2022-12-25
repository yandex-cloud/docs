# Chart

| Field | Type | Description |
------|-----|----------
| `datasets` | **list** * | A list of datasets the chart is built on. |
| `datasets[]` | **str** | A list of datasets the chart is built on. |
| `ad_hoc_fields` | **list** * | Additional fields needed to build the chart. |
| `ad_hoc_fields[]` | **AdHocField** | Additional fields needed to build the chart. |
| `ad_hoc_fields[]`.`field` | **DatasetField** * |
| `ad_hoc_fields[]`.`field`.`id` | **str** * |
| `ad_hoc_fields[]`.`field`.`title` | **str** * |
| `ad_hoc_fields[]`.`field`.`description` | **str** * |
| `ad_hoc_fields[]`.`field`.`hidden` | **bool** |
| `ad_hoc_fields[]`.`field`.`cast` | **enum/str[`string` / `integer` / `float` / `date` / `datetime` / `boolean` / `geopoint` / `geopolygon` / `uuid` / `markup` / `datetimetz` / `unsupported` / `array_str` / `array_int` / `array_float` / `tree_str`]** * |
| `ad_hoc_fields[]`.`field`.`aggregation` | **enum/str[`none` / `sum` / `avg` / `min` / `max` / `count` / `countunique`]** |
| `ad_hoc_fields[]`.`field`.`calc_spec` | [CalcSpec](CalcSpec.md) * |
| `ad_hoc_fields[]`.`dataset_name` | **str** | The name of the dataset in which the field will be added. If you are building your chart from a single dataset, you can omit the name. |
| `visualization` | [Visualization](Visualization.md) * |
