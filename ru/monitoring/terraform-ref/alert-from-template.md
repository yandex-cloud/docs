# ycp_monitoring_alert_from_template (Resource)

Monitoring alert from template

## Schema

### Required

- `alert_id` (String) Alert identifier, will be copied to id
- `name` (String) Alert name
- `project_id` (String) Project identifier
- `template_id` (String) Alert template id

### Optional

- `annotations` (Map of String) Alert annotations
- `channels` (Block List) Alert channels (see [below for nested schema](#nestedblock--channels))
- `description` (String) Alert description
- `double_parameters` (Block List) Alert double parameters (see [below for nested schema](#nestedblock--double_parameters))
- `double_thresholds` (Block List) Alert double thresholds (see [below for nested schema](#nestedblock--double_thresholds))
- `escalations` (List of String) Alert escalations
- `id` (String) The ID of this resource.
- `integer_parameters` (Block List) Alert integer parameters (see [below for nested schema](#nestedblock--integer_parameters))
- `integer_thresholds` (Block List) Alert integer thresholds (see [below for nested schema](#nestedblock--integer_thresholds))
- `label_list_parameters` (Block List) Alert label list parameters (see [below for nested schema](#nestedblock--label_list_parameters))
- `label_list_thresholds` (Block List) Alert label list thresholds (see [below for nested schema](#nestedblock--label_list_thresholds))
- `labels` (Map of String) Alert labels
- `owner_service_provider` (String) Alert owner. Service provider id
- `status` (String) Alert status. Default value is ACTIVE
- `template_version_tag` (String) Alert template version id
- `text_list_parameters` (Block List) Alert text list parameters (see [below for nested schema](#nestedblock--text_list_parameters))
- `text_list_thresholds` (Block List) Alert text list thresholds (see [below for nested schema](#nestedblock--text_list_thresholds))
- `text_parameters` (Block List) Alert text parameters (see [below for nested schema](#nestedblock--text_parameters))
- `text_thresholds` (Block List) Alert text thresholds (see [below for nested schema](#nestedblock--text_thresholds))
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))

<a id="nestedblock--channels"></a>
### Nested Schema for `channels`

Required:

- `id` (String) Channel id

Optional:

- `notify_about_statuses` (List of String) Notify statuses
- `repeat_period_duration` (String) Channel repeat duration. Example: 5h0m30s


<a id="nestedblock--double_parameters"></a>
### Nested Schema for `double_parameters`

Required:

- `name` (String) Parameter name
- `value` (Number) Parameter value


<a id="nestedblock--double_thresholds"></a>
### Nested Schema for `double_thresholds`

Required:

- `name` (String) Threshold name
- `value` (Number) Threshold value


<a id="nestedblock--integer_parameters"></a>
### Nested Schema for `integer_parameters`

Required:

- `name` (String) Parameter name
- `value` (Number) Parameter value


<a id="nestedblock--integer_thresholds"></a>
### Nested Schema for `integer_thresholds`

Required:

- `name` (String) Threshold name
- `value` (Number) Threshold value


<a id="nestedblock--label_list_parameters"></a>
### Nested Schema for `label_list_parameters`

Required:

- `name` (String) Parameter name
- `value` (List of String) Parameter value


<a id="nestedblock--label_list_thresholds"></a>
### Nested Schema for `label_list_thresholds`

Required:

- `name` (String) Threshold name
- `value` (List of String) Threshold value


<a id="nestedblock--text_list_parameters"></a>
### Nested Schema for `text_list_parameters`

Required:

- `name` (String) Parameter name
- `value` (List of String) Parameter value


<a id="nestedblock--text_list_thresholds"></a>
### Nested Schema for `text_list_thresholds`

Required:

- `name` (String) Threshold name
- `value` (List of String) Threshold value


<a id="nestedblock--text_parameters"></a>
### Nested Schema for `text_parameters`

Required:

- `name` (String) Parameter name
- `value` (String) Parameter value


<a id="nestedblock--text_thresholds"></a>
### Nested Schema for `text_thresholds`

Required:

- `name` (String) Threshold name
- `value` (String) Threshold value


<a id="nestedblock--timeouts"></a>
### Nested Schema for `timeouts`

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)

## Example
```
resource "ycp_monitoring_alert_from_template" "this" {
  description = "Alert description"
  project_id  = "alextrushkin_test"
  alert_id    = "alert1"
  name        = "My alert"
  channels {
    id                    = "channel1"
    notify_about_statuses = [
      "ALARM"
    ]
    repeat_period_duration = "20m0s"
  }
  template_id            = "alextrushkin_service_provider-tf"
  owner_service_provider = "alextrushkin_service_provider"
  integer_parameters {
    name  = "int"
    value = 700
  }
  double_parameters {
    name  = "double"
    value = 1.1
  }
  text_parameters {
    name  = "text"
    value = "value1"
  }
  text_list_parameters {
    name  = "texts"
    value = ["value2", "value3"]
  }
  label_list_parameters {
    name  = "label"
    value = ["value4", "value5"]
  }
  integer_thresholds {
    name  = "l1"
    value = 701
  }
  double_thresholds {
    name  = "l2"
    value = 1.11
  }
  status      = "ACTIVE"
  escalations = [
    "test_delete"
  ]
  annotations = {
    annotations1 = "annotationsValue1"
  }
  labels = {
    label1 = "value1"
  }
}
```
