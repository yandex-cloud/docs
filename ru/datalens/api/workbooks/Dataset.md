# Dataset

 Поле | Тип | Описание
------|-----|----------
`fields` | **list** * |
`fields[]` | **DatasetField**  |
`fields[]`.`id` | **str** * |
`fields[]`.`title` | **str** * |
`fields[]`.`description` | **str** * |
`fields[]`.`hidden` | **bool**  |
`fields[]`.`cast` | **enum/str[`string` / `integer` / `float` / `date` / `datetime` / `boolean` / `geopoint` / `geopolygon` / `uuid` / `markup` / `datetimetz` / `unsupported` / `array_str` / `array_int` / `array_float` / `tree_str`]** * |
`fields[]`.`aggregation` | **enum/str[`none` / `sum` / `avg` / `min` / `max` / `count` / `countunique`]**  |
`fields[]`.`calc_spec` | [CalcSpec](CalcSpec.md) * |
`avatars` | **AvatarsConfig** * | Конфигурация аватаров (аналог секции `FROM` в SQL). Для одного источника данных можно передавать значение `null`, тогда аватар создастся автоматически и ID автара будет равен ID источника данных.
`avatars`.`definitions` | **list** * |
`avatars`.`definitions[]` | **AvatarDef**  |
`avatars`.`definitions[]`.`id` | **str** * |
`avatars`.`definitions[]`.`source_id` | **str** * |
`avatars`.`definitions[]`.`title` | **str** * |
`avatars`.`root` | **str** * |
`avatars`.`joins` | **list** * |
`avatars`.`joins[]` | **AvatarJoinCondition**  |
`sources` | **list** * |
`sources[]` | **DataSource**  |
`sources[]`.`id` | **str** * |
`sources[]`.`title` | **str** * |
`sources[]`.`connection_ref` | **str** * |
`sources[]`.`spec` | [DataSourceSpec](DataSourceSpec.md) * |
