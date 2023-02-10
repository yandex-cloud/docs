# ycp_monitoring_dashboard (Resource)

Monitoring dashboard

## Schema

### Required

- `name` (String) Dashboard name, used as local identifier in project_id/folder_id

### Optional

- `description` (String) Dashboard description
- `folder_id` (String) Folder ID
- `id` (String) The ID of this resource.
- `labels` (Map of String) Dashboard labels
- `parametrization` (Block List) Dashboard parametrization (see [below for nested schema](#nestedblock--parametrization))
- `project_id` (String) Project ID
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))
- `title` (String) Dashboard title
- `widgets` (Block List) Widgets (see [below for nested schema](#nestedblock--widgets))

### Read-Only

- `dashboard_id` (String) Dashboard ID

<a id="nestedblock--parametrization"></a>
### Nested Schema for `parametrization`

Optional:

- `parameters` (Block List) Dashboard parameter (see [below for nested schema](#nestedblock--parametrization--parameters))
- `selectors` (String) Predefined selectors

<a id="nestedblock--parametrization--parameters"></a>
### Nested Schema for `parametrization.parameters`

Required:

- `id` (String) Parameter identifier

Optional:

- `custom` (Block List) Custom parameter (see [below for nested schema](#nestedblock--parametrization--parameters--custom))
- `description` (String) Parameter description
- `double_parameter` (Block List) Double parameter (see [below for nested schema](#nestedblock--parametrization--parameters--double_parameter))
- `hidden` (Boolean) UI-visibility
- `integer_parameter` (Block List) Integer parameter (see [below for nested schema](#nestedblock--parametrization--parameters--integer_parameter))
- `label_values` (Block List) Label values parameter (see [below for nested schema](#nestedblock--parametrization--parameters--label_values))
- `text` (Block List) Text parameter (see [below for nested schema](#nestedblock--parametrization--parameters--text))
- `text_values` (Block List) Text parameter (see [below for nested schema](#nestedblock--parametrization--parameters--text_values))
- `title` (String) UI-visible title of the parameter

<a id="nestedblock--parametrization--parameters--custom"></a>
### Nested Schema for `parametrization.parameters.custom`

Optional:

- `default_values` (List of String) Default value
- `multiselectable` (Boolean) Specifies the multiselectable values of parameter
- `values` (List of String) Parameter values


<a id="nestedblock--parametrization--parameters--double_parameter"></a>
### Nested Schema for `parametrization.parameters.double_parameter`

Optional:

- `default_value` (Number) Default value
- `unit_format` (String) Parameter unit


<a id="nestedblock--parametrization--parameters--integer_parameter"></a>
### Nested Schema for `parametrization.parameters.integer_parameter`

Optional:

- `default_value` (Number) Default value
- `unit_format` (String) Parameter unit


<a id="nestedblock--parametrization--parameters--label_values"></a>
### Nested Schema for `parametrization.parameters.label_values`

Required:

- `label_key` (String) Required. Label key to list label values

Optional:

- `default_values` (List of String) Default value
- `folder_id` (String) Folder ID
- `multiselectable` (Boolean) Specifies the multiselectable values of parameter
- `project_id` (String) Project ID
- `selectors` (String) Required. Selectors to select metric label values


<a id="nestedblock--parametrization--parameters--text"></a>
### Nested Schema for `parametrization.parameters.text`

Optional:

- `default_value` (String) Default value


<a id="nestedblock--parametrization--parameters--text_values"></a>
### Nested Schema for `parametrization.parameters.text_values`

Optional:

- `default_values` (List of String) Default value




<a id="nestedblock--timeouts"></a>
### Nested Schema for `timeouts`

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)


<a id="nestedblock--widgets"></a>
### Nested Schema for `widgets`

Optional:

- `alert` (Block List) Alert widget (see [below for nested schema](#nestedblock--widgets--alert))
- `chart` (Block List) Chart widget (see [below for nested schema](#nestedblock--widgets--chart))
- `iframe` (Block List) Iframe widget (see [below for nested schema](#nestedblock--widgets--iframe))
- `position` (Block List) Required. Widget layout position (see [below for nested schema](#nestedblock--widgets--position))
- `text` (Block List) Text widget (see [below for nested schema](#nestedblock--widgets--text))
- `title` (Block List) Title widget (see [below for nested schema](#nestedblock--widgets--title))

<a id="nestedblock--widgets--alert"></a>
### Nested Schema for `widgets.alert`

Required:

- `alert_id` (String) Required. Alert ID

Optional:

- `annotation_keys` (List of String) Alert annotations to select
- `description` (String) Widget description in dashboard (not enabled in UI)
- `eval_status_filters` (List of String) Alerts filter
- `folder_id` (String) Folder ID
- `labels_filter` (String) Labels filter expression as selectors
- `project_id` (String) Project ID
- `title` (String) Widget title


<a id="nestedblock--widgets--chart"></a>
### Nested Schema for `widgets.chart`

Optional:

- `chart_id` (String) Chart ID
- `description` (String) Chart description in dashboard (not enabled in UI)
- `display_legend` (Boolean) Enable legend under chart
- `freeze` (String) Fixed time interval for chart
- `name_hiding_settings` (Block List) Name hiding settings (see [below for nested schema](#nestedblock--widgets--chart--name_hiding_settings))
- `queries` (Block List) Queries (see [below for nested schema](#nestedblock--widgets--chart--queries))
- `series_overrides` (Block List) (see [below for nested schema](#nestedblock--widgets--chart--series_overrides))
- `title` (String) Chart widget title
- `visualization_settings` (Block List) Visualization settings (see [below for nested schema](#nestedblock--widgets--chart--visualization_settings))

<a id="nestedblock--widgets--chart--name_hiding_settings"></a>
### Nested Schema for `widgets.chart.name_hiding_settings`

Required:

- `names` (List of String)

Optional:

- `positive` (Boolean) True if we want to show concrete series names only, false if we want to hide concrete series names


<a id="nestedblock--widgets--chart--queries"></a>
### Nested Schema for `widgets.chart.queries`

Optional:

- `downsampling` (Block List) Downsampling settings (see [below for nested schema](#nestedblock--widgets--chart--queries--downsampling))
- `target` (Block List) Downsampling settings (see [below for nested schema](#nestedblock--widgets--chart--queries--target))

<a id="nestedblock--widgets--chart--queries--downsampling"></a>
### Nested Schema for `widgets.chart.queries.target`

Optional:

- `disabled` (Boolean) Disable downsampling
- `gap_filling` (String) Parameters for filling gaps in data
- `grid_aggregation` (String) Function that is used for downsampling
- `grid_interval` (Number) Time interval (grid) for downsampling in milliseconds. Points in the specified range are aggregated into one time point
- `max_points` (Number) Maximum number of points to be returned


<a id="nestedblock--widgets--chart--queries--target"></a>
### Nested Schema for `widgets.chart.queries.target`

Optional:

- `hidden` (Boolean) Checks that target is visible or invisible
- `query` (String) Required. Query
- `text_mode` (Boolean) Text mode



<a id="nestedblock--widgets--chart--series_overrides"></a>
### Nested Schema for `widgets.chart.series_overrides`

Optional:

- `name` (String) Series name
- `settings` (Block List) Override settings (see [below for nested schema](#nestedblock--widgets--chart--series_overrides--settings))
- `target_index` (String) Target index

<a id="nestedblock--widgets--chart--series_overrides--settings"></a>
### Nested Schema for `widgets.chart.series_overrides.target_index`

Optional:

- `color` (String) Series color or empty
- `grow_down` (Boolean) Stack grow down
- `name` (String) Series name or empty
- `stack_name` (String) Stack name or empty
- `type` (String) Type
- `yaxis_position` (String) Yaxis position



<a id="nestedblock--widgets--chart--visualization_settings"></a>
### Nested Schema for `widgets.chart.visualization_settings`

Optional:

- `aggregation` (String) Aggregation
- `color_scheme_settings` (Block List) Color scheme settings (see [below for nested schema](#nestedblock--widgets--chart--visualization_settings--color_scheme_settings))
- `heatmap_settings` (Block List) Heatmap settings (see [below for nested schema](#nestedblock--widgets--chart--visualization_settings--heatmap_settings))
- `interpolate` (String) Interpolate
- `normalize` (Boolean) Normalize
- `show_labels` (Boolean) Show chart labels
- `title` (String) Inside chart title
- `type` (String) Visualization type
- `yaxis_settings` (Block List) Y axis settings (see [below for nested schema](#nestedblock--widgets--chart--visualization_settings--yaxis_settings))

<a id="nestedblock--widgets--chart--visualization_settings--color_scheme_settings"></a>
### Nested Schema for `widgets.chart.visualization_settings.yaxis_settings`

Optional:

- `automatic` (Block List) Automatic color scheme (see [below for nested schema](#nestedblock--widgets--chart--visualization_settings--yaxis_settings--automatic))
- `gradient` (Block List) Gradient color scheme (see [below for nested schema](#nestedblock--widgets--chart--visualization_settings--yaxis_settings--gradient))
- `standard` (Block List) Standard color scheme (see [below for nested schema](#nestedblock--widgets--chart--visualization_settings--yaxis_settings--standard))

<a id="nestedblock--widgets--chart--visualization_settings--yaxis_settings--automatic"></a>
### Nested Schema for `widgets.chart.visualization_settings.yaxis_settings.automatic`


<a id="nestedblock--widgets--chart--visualization_settings--yaxis_settings--gradient"></a>
### Nested Schema for `widgets.chart.visualization_settings.yaxis_settings.gradient`

Optional:

- `green_value` (String) Gradient green value
- `red_value` (String) Gradient red value
- `violet_value` (String) Gradient violet_value
- `yellow_value` (String) Gradient yellow value


<a id="nestedblock--widgets--chart--visualization_settings--yaxis_settings--standard"></a>
### Nested Schema for `widgets.chart.visualization_settings.yaxis_settings.standard`



<a id="nestedblock--widgets--chart--visualization_settings--heatmap_settings"></a>
### Nested Schema for `widgets.chart.visualization_settings.yaxis_settings`

Optional:

- `green_value` (String) Heatmap green value
- `red_value` (String) Heatmap red value
- `violet_value` (String) Heatmap violet_value
- `yellow_value` (String) Heatmap yellow value


<a id="nestedblock--widgets--chart--visualization_settings--yaxis_settings"></a>
### Nested Schema for `widgets.chart.visualization_settings.yaxis_settings`

Optional:

- `left` (Block List) Left Y axis settings (see [below for nested schema](#nestedblock--widgets--chart--visualization_settings--yaxis_settings--left))
- `right` (Block List) Right Y axis settings (see [below for nested schema](#nestedblock--widgets--chart--visualization_settings--yaxis_settings--right))

<a id="nestedblock--widgets--chart--visualization_settings--yaxis_settings--left"></a>
### Nested Schema for `widgets.chart.visualization_settings.yaxis_settings.left`

Optional:

- `max` (String) Max value in extended number format or empty
- `min` (String) Min value in extended number format or empty
- `precision` (Number) Tick value precision (null as default, 0-7 in other cases)
- `title` (String) Title or empty
- `type` (String) Type
- `unit_format` (String) Unit format


<a id="nestedblock--widgets--chart--visualization_settings--yaxis_settings--right"></a>
### Nested Schema for `widgets.chart.visualization_settings.yaxis_settings.right`

Optional:

- `max` (String) Max value in extended number format or empty
- `min` (String) Min value in extended number format or empty
- `precision` (Number) Tick value precision (null as default, 0-7 in other cases)
- `title` (String) Title or empty
- `type` (String) Type
- `unit_format` (String) Unit format





<a id="nestedblock--widgets--iframe"></a>
### Nested Schema for `widgets.iframe`

Required:

- `url` (String) Required. Iframe URL

Optional:

- `description` (String) Widget description in dashboard (not enabled in UI)
- `title` (String) Widget title


<a id="nestedblock--widgets--position"></a>
### Nested Schema for `widgets.position`

Optional:

- `h` (Number) Required. Height
- `w` (Number) Required. Weight
- `x` (Number) Required. X-axis top-left corner coordinate
- `y` (Number) Required. Y-axis top-left corner coordinate


<a id="nestedblock--widgets--text"></a>
### Nested Schema for `widgets.text`

Optional:

- `text` (String) Text


<a id="nestedblock--widgets--title"></a>
### Nested Schema for `widgets.title`

Required:

- `text` (String) Title text

Optional:

- `size` (String) Title size

## Example
```
resource "ycp_monitoring_dashboard" "alerting-dashboard" {
  name        = "alerting-dashboard"
  description = "Alerting state"
  project_id  = "project_id_here"
  title       = "Alerting"

  widgets {
    alert {
      alert_id   = ycp_monitoring_expression_alert.alerting-cluster-membership.id
      project_id = "project_id_here"
    }
    position {
      h = 10
      w = 10
      x = 1
      y = 1
    }
  }
  widgets {
    chart {
      chart_id       = "required"
      description    = "Evaluation"
      title          = "Eval/sec"
      display_legend = true
      queries {
        target {
          query = "{project='solomon', cluster='prestable', service='alerting', alertType!='total', host='cluster', sensor='evaluations.eval.started', projectId='serverbrowsermobileyandex'}"
        }
      }
    }
    position {
      h = 40
      w = 40
      x = 30
      y = 1
    }
  }
}
```
