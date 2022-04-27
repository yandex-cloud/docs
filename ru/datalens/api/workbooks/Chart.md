# Chart

 Поле | Тип | Описание
------|-----|----------
`datasets` | **list** * | Список датасетов, по которым строится чарт.
`datasets[]` | **str**  | Список датасетов, по которым строится чарт.
`ad_hoc_fields` | **list** * | Дополнительные поля, необходимые для построения чарта.
`ad_hoc_fields[]` | **AdHocField**  | Дополнительные поля, необходимые для построения чарта.
`ad_hoc_fields[]`.`field` | **DatasetField** * |
`ad_hoc_fields[]`.`field`.`id` | **str** * |
`ad_hoc_fields[]`.`field`.`title` | **str** * |
`ad_hoc_fields[]`.`field`.`description` | **str** * |
`ad_hoc_fields[]`.`field`.`hidden` | **bool**  |
`ad_hoc_fields[]`.`field`.`cast` | **enum/str[`string` / `integer` / `float` / `date` / `datetime` / `boolean` / `geopoint` / `geopolygon` / `uuid` / `markup` / `datetimetz` / `unsupported` / `array_str` / `array_int` / `array_float` / `tree_str`]** * |
`ad_hoc_fields[]`.`field`.`aggregation` | **enum/str[`none` / `sum` / `avg` / `min` / `max` / `count` / `countunique`]**  |
`ad_hoc_fields[]`.`field`.`calc_spec` | [CalcSpec](CalcSpec.md) * |
`ad_hoc_fields[]`.`dataset_name` | **str**  | Имя датасета, в который будет добавлено поле. Если чарт строится по одному датасету, имя можно не указывать.
`visualization` | [Visualization](Visualization.md) * |
