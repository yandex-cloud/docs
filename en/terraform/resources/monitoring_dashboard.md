---
subcategory: Monitoring
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/monitoring_dashboard.md
---

# yandex_monitoring_dashboard (Resource)

Get information about a Yandex Monitoring dashboard.

## Example usage

```terraform
//
// Create a new Monitoring Dashboard.
//
resource "yandex_monitoring_dashboard" "my-dashboard" {
  name        = "local-id-resource"
  description = "Description"
  title       = "My title"
  labels = {
    a = "b"
  }
  parametrization {
    selectors = "a=b"
    parameters {
      description = "param1 description"
      title       = "title"
      hidden      = false
      id          = "param1"
      custom {
        default_values  = ["1", "2"]
        values          = ["1", "2", "3"]
        multiselectable = true
      }
    }
    parameters {
      hidden = true
      id     = "param2"
      label_values {
        default_values  = ["1", "2"]
        multiselectable = true
        label_key       = "key"
        selectors       = "a=b"
      }
    }
    parameters {
      hidden = true
      id     = "param3"
      text {
        default_value = "abc"
      }
    }
  }
  widgets {
    text {
      text = "text here"
    }
    position {
      h = 1
      w = 1
      x = 4
      y = 4
    }
  }
  widgets {
    chart {
      description    = "chart description"
      title          = "title for chart"
      chart_id       = "chart1id"
      display_legend = true
      freeze         = "FREEZE_DURATION_HOUR"
      name_hiding_settings {
        names    = ["a", "b"]
        positive = true
      }
      queries {
        downsampling {
          disabled         = false
          gap_filling      = "GAP_FILLING_NULL"
          grid_aggregation = "GRID_AGGREGATION_COUNT"
          max_points       = 100
        }
        target {
          hidden    = true
          text_mode = true
          query     = "{service=monitoring}"
        }
      }
      series_overrides {
        name = "name"
        settings {
          color          = "colorValue"
          grow_down      = true
          name           = "series_overrides name"
          type           = "SERIES_VISUALIZATION_TYPE_LINE"
          yaxis_position = "YAXIS_POSITION_LEFT"
          stack_name     = "stack name"
        }
      }
      visualization_settings {
        aggregation = "SERIES_AGGREGATION_AVG"
        interpolate = "INTERPOLATE_LEFT"
        type        = "VISUALIZATION_TYPE_POINTS"
        normalize   = true
        show_labels = true
        title       = "visualization_settings title"
        color_scheme_settings {
          gradient {
            green_value  = "11"
            red_value    = "22"
            violet_value = "33"
            yellow_value = "44"
          }
        }
        heatmap_settings {
          green_value  = "1"
          red_value    = "2"
          violet_value = "3"
          yellow_value = "4"
        }
        yaxis_settings {
          left {
            max         = "111"
            min         = "11"
            title       = "yaxis_settings left title"
            precision   = 3
            type        = "YAXIS_TYPE_LOGARITHMIC"
            unit_format = "UNIT_CELSIUS"
          }
          right {
            max         = "22"
            min         = "2"
            title       = "yaxis_settings right title"
            precision   = 2
            type        = "YAXIS_TYPE_LOGARITHMIC"
            unit_format = "UNIT_NONE"
          }
        }
      }
    }
    position {
      h = 100
      w = 100
      x = 6
      y = 6
    }
  }
  widgets {
    title {
      text = "title here"
      size = "TITLE_SIZE_XS"
    }
    position {
      h = 1
      w = 1
      x = 1
      y = 1
    }
  }
}
```

## Arguments & Attributes Reference

- `dashboard_id` (*Read-Only*) (String). Dashboard ID.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). The resource name.
- `title` (String). Dashboard title.
- `parametrization` [Block]. Dashboard parametrization.
  - `selectors` (String). Dashboard predefined parameters selector.
  - `parameters` [Block]. Dashboard parameters.
    - `description` (String). Parameter description.
    - `hidden` (Bool). UI-visibility
    - `id` (**Required**)(String). Parameter identifier.
    - `title` (String). UI-visible title of the parameter.
    - `custom` [Block]. Custom values parameter. Oneof: label_values, custom, text.
      - `default_values` (List Of String). Default value.
      - `multiselectable` (Bool). Specifies the multiselectable values of parameter.
      - `values` (List Of String). Parameter values.
    - `label_values` [Block]. Label values parameter. Oneof: label_values, custom, text.
      - `default_values` (List Of String). Default value.
      - `folder_id` (String). Folder ID.
      - `label_key` (**Required**)(String). Label key to list label values.
      - `multiselectable` (Bool). Specifies the multiselectable values of parameter.
      - `selectors` (String). Selectors to select metric label values.
    - `text` [Block]. Text parameter. Oneof: label_values, custom, text.
      - `default_value` (String). Default value.
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

    - `title` (String). Chart widget title.
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
      - `target_index` (String). Target index
      - `settings` [Block]. Override settings
        - `color` (String). Series color or empty
        - `grow_down` (Bool). Stack grow down
        - `name` (String). Series name or empty
        - `stack_name` (String). Stack name or empty
        - `type` (String). Type
        - `yaxis_position` (String). Yaxis position
    - `visualization_settings` [Block]. Visualization settings.
      - `aggregation` (String). Aggregation
      - `interpolate` (String). Interpolate
      - `normalize` (Bool). Normalize
      - `show_labels` (Bool). Show chart labels
      - `title` (String). Inside chart title
      - `type` (String). Visualization type
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

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_monitoring.<resource Name> <resource Id>
terraform import yandex_monitoring_dashboard.my-dashboard ...
```
