# Dataset

| Field | Type | Description |
------|-----|----------
| `fields` | **list** * |
| `fields[]` | **DatasetField** |
| `fields[]`.`id` | **str** * |
| `fields[]`.`title` | **str** * |
| `fields[]`.`description` | **str** * |
| `fields[]`.`hidden` | **bool** |
| `fields[]`.`cast` | **enum/str[`string` / `integer` / `float` / `date` / `datetime` / `boolean` / `geopoint` / `geopolygon` / `uuid` / `markup` / `datetimetz` / `unsupported` / `array_str` / `array_int` / `array_float` / `tree_str`]** * |
| `fields[]`.`aggregation` | **enum/str[`none` / `sum` / `avg` / `min` / `max` / `count` / `countunique`]** |
| `fields[]`.`calc_spec` | [CalcSpec](CalcSpec.md) * |
| `avatars` | **AvatarsConfig** * | Avatars configuration (a counterpart of `FROM` in SQL). For a single data source, you can transmit the value `null`, in this case, the avatar is created automatically and the ID of the avatar is the same as the ID of the data source. |
| `avatars`.`definitions` | **list** * |
| `avatars`.`definitions[]` | **AvatarDef** |
| `avatars`.`definitions[]`.`id` | **str** * |
| `avatars`.`definitions[]`.`source_id` | **str** * |
| `avatars`.`definitions[]`.`title` | **str** * |
| `avatars`.`root` | **str** * |
| `avatars`.`joins` | **list** * |
| `avatars`.`joins[]` | **AvatarJoinCondition** |
| `sources` | **list** * |
| `sources[]` | **DataSource** |
| `sources[]`.`id` | **str** * |
| `sources[]`.`title` | **str** * |
| `sources[]`.`connection_ref` | **str** * |
| `sources[]`.`spec` | [DataSourceSpec](DataSourceSpec.md) * |
