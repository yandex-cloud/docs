---
subcategory: Monitoring
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/monitoring_dashboard.md
---

# yandex_monitoring_dashboard (DataSource)

Get information about a Yandex Monitoring dashboard.

{% note warning %}

One of `dashboard_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Monitoring Dashboard.
//
data "yandex_monitoring_dashboard" "my_dashboard" {
  dashboard_id = "some_instance_dashboard_id"
}
```

## Arguments & Attributes Reference

- `dashboard_id` (*Read-Only*) (String). Dashboard ID.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). The resource name.
- `parametrization` [Block]. Dashboard parametrization.
  - `parameters` [Block]. Dashboard parameters.
    - `custom` [Block]. Custom values parameter. Oneof: label_values, custom, text.
      - `default_values` (List Of String). Default value.
      - `multiselectable` (Bool). Specifies the multiselectable values of parameter.
      - `values` (List Of String). Parameter values.
    - `description` (String). Parameter description.
    - `hidden` (Bool). UI-visibility
    - `id` (**Required**)(String). Parameter identifier.
    - `label_values` [Block]. Label values parameter. Oneof: label_values, custom, text.
      - `default_values` (List Of String). Default value.
      - `folder_id` (String). Folder ID.
      - `label_key` (**Required**)(String). Label key to list label values.
      - `multiselectable` (Bool). Specifies the multiselectable values of parameter.
      - `selectors` (String). Selectors to select metric label values.
    - `text` [Block]. Text parameter. Oneof: label_values, custom, text.
      - `default_value` (String). Default value.
    - `title` (String). UI-visible title of the parameter.
  - `selectors` (String). Dashboard predefined parameters selector.
- `title` (String). Dashboard title.
- `widgets` [Block]. Widgets.
  - `chart` [Block]. Chart widget settings.
    - `chart_id` (String). Chart ID.
    - `description` (String). Chart description in dashboard (not enabled in UI).
    - `display_legend` (Bool). Enable legend under chart.
    - `freeze` (String). Fixed time interval for chart. Values:
- FREEZE_DURATION_HOUR: Last hour.
- FREEZE_DURATION_DAY: Last day = last 24 hours.
- FREEZE_DURATION_WEEK: Last 7 days.
- FREEZE_DURATION_MONTH: Last 31 days.

    - `name_hiding_settings` [Block]. Name hiding settings
      - `names` (List Of String). 
      - `positive` (Bool). True if we want to show concrete series names only, false if we want to hide concrete series names
    - `queries` [Block]. Queries settings.
      - `downsampling` [Block]. Downsampling settings
        - `disabled` (Bool). Disable downsampling
        - `gap_filling` (String). Parameters for filling gaps in data
        - `grid_aggregation` (String). Function that is used for downsampling
        - `grid_interval` (Number). Time interval (grid) for downsampling in milliseconds. Points in the specified range are aggregated into one time point
        - `max_points` (Number). Maximum number of points to be returned
      - `target` [Block]. Downsampling settings
        - `hidden` (Bool). Checks that target is visible or invisible
        - `query` (String). Required. Query
        - `text_mode` (Bool). Text mode
    - `series_overrides` [Block]. Time series settings.
      - `name` (String). Series name
      - `settings` [Block]. Override settings
        - `color` (String). Series color or empty
        - `grow_down` (Bool). Stack grow down
        - `name` (String). Series name or empty
        - `stack_name` (String). Stack name or empty
        - `type` (String). Type
        - `yaxis_position` (String). Yaxis position
      - `target_index` (String). Target index
    - `title` (String). Chart widget title.
    - `visualization_settings` [Block]. Visualization settings.
      - `aggregation` (String). Aggregation
      - `color_scheme_settings` [Block]. Color scheme settings
        - `automatic` [Block]. Automatic color scheme
        - `gradient` [Block]. Gradient color scheme
          - `green_value` (String). Gradient green value
          - `red_value` (String). Gradient red value
          - `violet_value` (String). Gradient violet_value
          - `yellow_value` (String). Gradient yellow value
        - `standard` [Block]. Standard color scheme
      - `heatmap_settings` [Block]. Heatmap settings
        - `green_value` (String). Heatmap green value
        - `red_value` (String). Heatmap red value
        - `violet_value` (String). Heatmap violet_value
        - `yellow_value` (String). Heatmap yellow value
      - `interpolate` (String). Interpolate
      - `normalize` (Bool). Normalize
      - `show_labels` (Bool). Show chart labels
      - `title` (String). Inside chart title
      - `type` (String). Visualization type
      - `yaxis_settings` [Block]. Y axis settings
        - `left` [Block]. Left Y axis settings
          - `max` (String). Max value in extended number format or empty
          - `min` (String). Min value in extended number format or empty
          - `precision` (Number). Tick value precision (null as default, 0-7 in other cases)
          - `title` (String). Title or empty
          - `type` (String). Type
          - `unit_format` (String). Unit format
        - `right` [Block]. Right Y axis settings
          - `max` (String). Max value in extended number format or empty
          - `min` (String). Min value in extended number format or empty
          - `precision` (Number). Tick value precision (null as default, 0-7 in other cases)
          - `title` (String). Title or empty
          - `type` (String). Type
          - `unit_format` (String). Unit format
  - `position` [Block]. Widget layout position.
    - `h` (Number). Height.
    - `w` (Number). Weight.
    - `x` (Number). X-axis top-left corner coordinate.
    - `y` (Number). Y-axis top-left corner coordinate.
  - `text` [Block]. Text widget settings.
    - `text` (String). Widget text.
  - `title` [Block]. Title widget settings.
    - `size` (String). Title size.
Title size. Values:
- TITLE_SIZE_XS: Extra small size.
- TITLE_SIZE_S: Small size.
- TITLE_SIZE_M: Middle size.
- TITLE_SIZE_L: Large size.

    - `text` (**Required**)(String). Title text.


