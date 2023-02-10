# ycp_monitoring_alert_group (Resource)

Monitoring service provider alerts

## Schema

### Required

- `default_channels` (Boolean) Use default channels/escalations from project
- `project_id` (String) Project identifier. Alerts stored in project
- `resource_severity` (String) Resource severity. Used to filter default channels and escalations
- `resource_type` (String) Resource type for alerts. Used to filter templates and create resource
- `service_provider_id` (String) Service provider id. Used to fetch published templates
- `templates_to_create` (String) Templates to create:
  DEFAULT - create all default published templates, delete non default/published
  ALL - create all published templates, delete non published
  SELECTED - create from templates attribute, delete others

### Optional

- `channels` (Block List) Channels for all alerts (see [below for nested schema](#nestedblock--channels))
- `double_parameters` (Block List) Alerts double parameters (see [below for nested schema](#nestedblock--double_parameters))
- `escalations` (List of String) Escalations for all alerts
- `id` (String) The ID of this resource.
- `integer_parameters` (Block List) Alerts integer parameters (see [below for nested schema](#nestedblock--integer_parameters))
- `label_list_parameters` (Block List) Alerts label list parameters (see [below for nested schema](#nestedblock--label_list_parameters))
- `templates` (Block List) Specified templates. Used to override properties of template (see [below for nested schema](#nestedblock--templates))
- `text_list_parameters` (Block List) Alerts text list parameters (see [below for nested schema](#nestedblock--text_list_parameters))
- `text_parameters` (Block List) Alerts text parameters (see [below for nested schema](#nestedblock--text_parameters))
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))

<a id="nestedblock--channels"></a>
### Nested Schema for `channels`

Optional:

- `id` (String) Channel id
- `notify_about_statuses` (List of String) Notify statuses: EVALUATION_STATUS_OK, EVALUATION_STATUS_WARN, EVALUATION_STATUS_ALARM, EVALUATION_STATUS_NO_DATA, EVALUATION_STATUS_ERROR
- `repeat_period_duration` (String) Channel repeat duration, example: 10s


<a id="nestedblock--double_parameters"></a>
### Nested Schema for `double_parameters`

Optional:

- `name` (String) Parameter name
- `value` (Number) Parameter value


<a id="nestedblock--integer_parameters"></a>
### Nested Schema for `integer_parameters`

Optional:

- `name` (String) Parameter name
- `value` (Number) Parameter value


<a id="nestedblock--label_list_parameters"></a>
### Nested Schema for `label_list_parameters`

Optional:

- `name` (String) Parameter name
- `value` (List of String) Parameter value


<a id="nestedblock--templates"></a>
### Nested Schema for `templates`

Optional:

- `channels` (Block List) Alerts channels for template (see [below for nested schema](#nestedblock--templates--channels))
- `double_thresholds` (Block List) Alert double thresholds (see [below for nested schema](#nestedblock--templates--double_thresholds))
- `escalations` (List of String) Alert escalations for template
- `id` (String) Alert template id
- `integer_thresholds` (Block List) Alert integer thresholds (see [below for nested schema](#nestedblock--templates--integer_thresholds))
- `label_list_thresholds` (Block List) Alert label list thresholds (see [below for nested schema](#nestedblock--templates--label_list_thresholds))
- `text_list_thresholds` (Block List) Alert text list thresholds (see [below for nested schema](#nestedblock--templates--text_list_thresholds))
- `text_thresholds` (Block List) Alert text thresholds (see [below for nested schema](#nestedblock--templates--text_thresholds))

Read-Only:

- `created` (Boolean) Alert from template created, indicates that template group changed. Used for state

<a id="nestedblock--templates--channels"></a>
### Nested Schema for `templates.channels`

Optional:

- `id` (String) Channel id
- `notify_about_statuses` (List of String) Notify statuses: EVALUATION_STATUS_OK, EVALUATION_STATUS_WARN, EVALUATION_STATUS_ALARM, EVALUATION_STATUS_NO_DATA, EVALUATION_STATUS_ERROR
- `repeat_period_duration` (String) Channel repeat duration, example: 10s


<a id="nestedblock--templates--double_thresholds"></a>
### Nested Schema for `templates.double_thresholds`

Optional:

- `name` (String) Threshold name
- `value` (Number) Threshold value


<a id="nestedblock--templates--integer_thresholds"></a>
### Nested Schema for `templates.integer_thresholds`

Optional:

- `name` (String) Threshold name
- `value` (Number) Threshold value


<a id="nestedblock--templates--label_list_thresholds"></a>
### Nested Schema for `templates.label_list_thresholds`

Optional:

- `name` (String) Threshold name
- `value` (List of String) Threshold value


<a id="nestedblock--templates--text_list_thresholds"></a>
### Nested Schema for `templates.text_list_thresholds`

Optional:

- `name` (String) Threshold name
- `value` (List of String) Threshold value


<a id="nestedblock--templates--text_thresholds"></a>
### Nested Schema for `templates.text_thresholds`

Optional:

- `name` (String) Threshold name
- `value` (String) Threshold value



<a id="nestedblock--text_list_parameters"></a>
### Nested Schema for `text_list_parameters`

Optional:

- `name` (String) Parameter name
- `value` (List of String) Parameter value


<a id="nestedblock--text_parameters"></a>
### Nested Schema for `text_parameters`

Optional:

- `name` (String) Parameter name
- `value` (String) Parameter value


<a id="nestedblock--timeouts"></a>
### Nested Schema for `timeouts`

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)

## Example

```
resource "ycp_monitoring_alert_group" "yt-resource" {
  project_id = "solomon_tests"
  service_provider_id = "yt"
  resource_type = "account"
  templates_to_create = "DEFAULT"
  default_channels = true
  resource_severity = "SERVICE_PROVIDER_RESOURCE_SEVERITY_NON_CRITICAL"
  text_parameters {
    name  = "account"
    value = "solomon"
  }
  text_parameters {
    name  = "cluster"
    value = "hahn"
  }
}
```

Multiple resources from parameters:
```
//Map project-> clusters + severity
variable "alert_groups" {
  type = map(object({
    clusters = set(string)
    severity = string
  }))
  default = {
    "solomon_tests" = {
      clusters = ["cluster-test1", "cluster-test2"]
      severity = "SERVICE_PROVIDER_RESOURCE_SEVERITY_CRITICAL"
    }
    "alextrushkin_test" = {
      clusters = ["cluster-test3", "cluster-test4"]
      severity = "SERVICE_PROVIDER_RESOURCE_SEVERITY_HIGHLY_CRITICAL"
    }
  }
}

// make list from map
locals {
  clusters = flatten([
  for project, value in var.alert_groups : [
  for clusterId in value.clusters : {
    cluster  = clusterId
    project  = project
    severity = value.severity
  }
  ]
  ])
}

//Create alerts for
//
//clusters = [
//  {
//    "cluster" = "cluster-test3"
//    "project" = "alextrushkin_test"
//    "severity" = "SERVICE_PROVIDER_RESOURCE_SEVERITY_HIGHLY_CRITICAL"
//  },
//  {
//    "cluster" = "cluster-test4"
//    "project" = "alextrushkin_test"
//    "severity" = "SERVICE_PROVIDER_RESOURCE_SEVERITY_HIGHLY_CRITICAL"
//  },
//  {
//    "cluster" = "cluster-test1"
//    "project" = "solomon_tests"
//    "severity" = "SERVICE_PROVIDER_RESOURCE_SEVERITY_CRITICAL"
//  },
//  {
//    "cluster" = "cluster-test2"
//    "project" = "solomon_tests"
//    "severity" = "SERVICE_PROVIDER_RESOURCE_SEVERITY_CRITICAL"
//  },
//]
resource "ycp_monitoring_alert_group" "alerts" {
  for_each = {
  for cluster in local.clusters : "${cluster.project}${cluster.cluster}" => cluster
  }
  project_id          = each.value.project
  service_provider_id = "managed-postgresql"
  resource_type       = "cluster"
  templates_to_create = "DEFAULT" // use only default templates
  default_channels    = true // use default alerts
  resource_severity   = each.value.severity
  text_parameters {
    name  = "cluster"
    value = each.value.cluster
  }
}
```

[More examples](https://a.yandex-team.ru/arcadia/solomon/misc/experiments/src/alextrushkin/terraform/alerts/)