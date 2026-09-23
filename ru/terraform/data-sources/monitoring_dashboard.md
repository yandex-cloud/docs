---
subcategory: Monitoring
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

- `dashboard_id` (String). Dashboard ID.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `parametrization` (*Read-Only*) (List Of Object). Dashboard parametrization
  - `parameters` . 
    - `custom` . 
      - `default_values` . 
      - `multiselectable` . 
      - `values` . 
    - `description` . 
    - `hidden` . 
    - `id` . 
    - `label_values` . 
      - `default_values` . 
      - `folder_id` . 
      - `label_key` . 
      - `multiselectable` . 
      - `selectors` . 
    - `text` . 
      - `default_value` . 
    - `title` . 
  - `selectors` . 
- `title` (*Read-Only*) (String). Dashboard title.
- `widgets` (*Read-Only*) (List Of Object). Widgets
  - `chart` . 
    - `chart_id` . 
    - `description` . 
    - `display_legend` . 
    - `freeze` . 
    - `name_hiding_settings` . 
      - `names` . 
      - `positive` . 
    - `queries` . 
      - `downsampling` . 
        - `disabled` . 
        - `gap_filling` . 
        - `grid_aggregation` . 
        - `grid_interval` . 
        - `max_points` . 
      - `target` . 
        - `hidden` . 
        - `query` . 
        - `text_mode` . 
    - `series_overrides` . 
      - `name` . 
      - `settings` . 
        - `color` . 
        - `grow_down` . 
        - `name` . 
        - `stack_name` . 
        - `type` . 
        - `yaxis_position` . 
      - `target_index` . 
    - `title` . 
    - `visualization_settings` . 
      - `aggregation` . 
      - `color_scheme_settings` . 
        - `automatic` . 
        - `gradient` . 
          - `green_value` . 
          - `red_value` . 
          - `violet_value` . 
          - `yellow_value` . 
        - `standard` . 
      - `heatmap_settings` . 
        - `green_value` . 
        - `red_value` . 
        - `violet_value` . 
        - `yellow_value` . 
      - `interpolate` . 
      - `normalize` . 
      - `show_labels` . 
      - `title` . 
      - `type` . 
      - `yaxis_settings` . 
        - `left` . 
          - `max` . 
          - `min` . 
          - `precision` . 
          - `title` . 
          - `type` . 
          - `unit_format` . 
        - `right` . 
          - `max` . 
          - `min` . 
          - `precision` . 
          - `title` . 
          - `type` . 
          - `unit_format` . 
  - `position` . 
    - `h` . 
    - `w` . 
    - `x` . 
    - `y` . 
  - `text` . 
    - `text` . 
  - `title` . 
    - `size` . 
    - `text` .


