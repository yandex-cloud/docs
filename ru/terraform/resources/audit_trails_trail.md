---
subcategory: Audit Trails
page_title: 'Yandex: yandex_audit_trails_trail'
description: Manages a trail resource.
sourcePath: ru/terraform/tf-ref/yandex-cloud/resources/audit_trails_trail.md
---

# yandex_audit_trails_trail (Resource)

Allows management of [trail](https://yandex.cloud/docs/audit-trails/concepts/trail).

## Migration from deprecated filter field

In order to migrate from using `filter` to the `filtering_policy`, you will have to:
* Remove the `filter.event_filters.categories` blocks. With the introduction of `included_events`/`excluded_events` you can configure filtering per each event type.
* Replace the `filter.event_filters.path_filter` with the appropriate `resource_scope` blocks. You have to account that `resource_scope` does not support specifying relations between resources, so your configuration will simplify to only the actual resources, that will be monitored.

* Replace the `filter.path_filter` block with the `filtering_policy.management_events_filter`. New API states management events filtration in a more clear way. The resources, that were specified, must migrate into the `filtering_policy.management_events_filter.resource_scope`.

## Example usage

```terraform
//
// Create a new basic Audit Trails Trail
//
resource "yandex_audit_trails_trail" "basic-trail" {
  name        = "basic-trail"
  folder_id   = "home-folder"
  description = "Some trail description"

  labels = {
    key = "value"
  }

  service_account_id = "trail-service-account"

  logging_destination {
    log_group_id = "some-log-group"
  }

  filtering_policy {
    management_events_filter {
      resource_scope {
        resource_id   = "home-folder"
        resource_type = "resource-manager.folder"
      }
    }
    data_events_filter {
      service = "storage"
      resource_scope {
        resource_id   = "home-folder"
        resource_type = "resource-manager.folder"
      }
    }
    data_events_filter {
      service = "dns"
      resource_scope {
        resource_id   = "vpc-net-id-1"
        resource_type = "vpc.network"
      }
      resource_scope {
        resource_id   = "vpc-net-id-2"
        resource_type = "vpc.network"
      }
      dns_filter {
        include_nonrecursive_queries = true
      }
    }
  }
}
```

```terraform
//
// Create Trail for delivering events to YDS and gathering such events:
// * Management events from the 'some-organization' organization.
// * DNS data events with only recursive queries from the 'some-organization' organization.
// * Object Storage data events from the 'some-organization' organization.
//
resource "yandex_audit_trails_trail" "basic_trail" {
  name        = "a-trail"
  folder_id   = "home-folder"
  description = "Some trail description"

  labels = {
    key = "value"
  }

  service_account_id = "trail-service-account"

  data_stream_destination {
    database_id = "some-database"
    stream_name = "some-stream"
  }

  filtering_policy {
    management_events_filter {
      resource_scope {
        resource_id   = "some-organization"
        resource_type = "organization-manager.organization"
      }
    }
    data_events_filter {
      service = "storage"
      resource_scope {
        resource_id   = "some-organization"
        resource_type = "organization-manager.organization"
      }
    }
    data_events_filter {
      service = "dns"
      resource_scope {
        resource_id   = "some-organization"
        resource_type = "organization-manager.organization"
      }
      dns_filter {
        include_nonrecursive_queries = true
      }
    }
  }
}
```

```terraform
//
// Migration from deprecated filter field
//

// Before replacing "filter.event_filters.path_filter" to the "resource_scope" block.
event_filters {
  path_filter {
    some_filter {
      resource_id   = "home-folder"
      resource_type = "resource-manager.folder"
      any_filters {
        resource_id   = "vpc-net-id-1"
        resource_type = "vpc.network"
      }
      any_filters {
        resource_id   = "vpc-net-id-2"
        resource_type = "vpc.network"
      }
    }
  }
}

// After replacing "filter.event_filters.path_filter" to the "resource_scope" block.
data_events_filter {
  service = "dns"
  resource_scope {
    resource_id   = "vpc-net-id-1"
    resource_type = "vpc.network"
  }
  resource_scope {
    resource_id   = "vpc-net-id-2"
    resource_type = "vpc.network"
  }
}
```

```terraform
//
// Migration from deprecated filter field
//

// Before replacing "filter.path_filter block to the "filtering_policy.management_events_filter" block.
filter {
  path_filter {
    any_filter {
      resource_id   = "home-folder"
      resource_type = "resource-manager.folder"
    }
  }
}

// After replacing "filter.path_filter block to the "filtering_policy.management_events_filter" block.
filtering_policy {
  management_events_filter {
    resource_scope {
      resource_id   = "home-folder"
      resource_type = "resource-manager.folder"
    }
  }
}
```

<!-- schema generated by tfplugindocs -->
## Schema

### Required

- `folder_id` (String) The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `name` (String) The resource name.
- `service_account_id` (String) [Service account](https://yandex.cloud/docs/iam/concepts/users/service-accounts) which linked to the resource.

### Optional

- `data_stream_destination` (Block List, Max: 1) Structure describing destination data stream of the trail. Mutually exclusive with `logging_destination` and `storage_destination`. (see [below for nested schema](#nestedblock--data_stream_destination))
- `description` (String) The resource description.
- `filter` (Block List, Max: 1, Deprecated) Structure is deprecated. Use `filtering_policy` instead. (see [below for nested schema](#nestedblock--filter))
- `filtering_policy` (Block List, Max: 1) Structure describing event filtering process for the trail. Mutually exclusive with `filter`. At least one of the `management_events_filter` or `data_events_filter` fields will be filled. (see [below for nested schema](#nestedblock--filtering_policy))
- `labels` (Map of String) A set of key/value label pairs which assigned to resource.
- `logging_destination` (Block List, Max: 1) Structure describing destination log group of the trail. Mutually exclusive with `storage_destination` and `data_stream_destination`. (see [below for nested schema](#nestedblock--logging_destination))
- `storage_destination` (Block List, Max: 1) Structure describing destination bucket of the trail. Mutually exclusive with `logging_destination` and `data_stream_destination`. (see [below for nested schema](#nestedblock--storage_destination))
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))

### Read-Only

- `id` (String) The ID of this resource.
- `status` (String) Status of this trail.
- `trail_id` (String) ID of the trail resource.

<a id="nestedblock--data_stream_destination"></a>
### Nested Schema for `data_stream_destination`

Required:

- `database_id` (String) ID of the [YDB](https://yandex.cloud/docs/ydb/concepts/resources) hosting the destination data stream.
- `stream_name` (String) Name of the [YDS stream](https://yandex.cloud/docs/data-streams/concepts/glossary#stream-concepts) belonging to the specified YDB.


<a id="nestedblock--filter"></a>
### Nested Schema for `filter`

Optional:

- `event_filters` (Block List) Deprecated. (see [below for nested schema](#nestedblock--filter--event_filters))
- `path_filter` (Block List, Max: 1) Deprecated. (see [below for nested schema](#nestedblock--filter--path_filter))

<a id="nestedblock--filter--event_filters"></a>
### Nested Schema for `filter.event_filters`

Required:

- `categories` (Block List, Min: 1) Deprecated. (see [below for nested schema](#nestedblock--filter--event_filters--categories))
- `path_filter` (Block List, Min: 1, Max: 1) Deprecated. (see [below for nested schema](#nestedblock--filter--event_filters--path_filter))
- `service` (String) Deprecated.

<a id="nestedblock--filter--event_filters--categories"></a>
### Nested Schema for `filter.event_filters.categories`

Required:

- `plane` (String) Deprecated.
- `type` (String) Deprecated.


<a id="nestedblock--filter--event_filters--path_filter"></a>
### Nested Schema for `filter.event_filters.path_filter`

Optional:

- `any_filter` (Block List, Max: 1) Deprecated. (see [below for nested schema](#nestedblock--filter--event_filters--path_filter--any_filter))
- `some_filter` (Block List, Max: 1) Deprecated. (see [below for nested schema](#nestedblock--filter--event_filters--path_filter--some_filter))

<a id="nestedblock--filter--event_filters--path_filter--any_filter"></a>
### Nested Schema for `filter.event_filters.path_filter.any_filter`

Required:

- `resource_id` (String) Resource ID.
- `resource_type` (String) Resource type.


<a id="nestedblock--filter--event_filters--path_filter--some_filter"></a>
### Nested Schema for `filter.event_filters.path_filter.some_filter`

Required:

- `any_filters` (Block List, Min: 1) Deprecated. (see [below for nested schema](#nestedblock--filter--event_filters--path_filter--some_filter--any_filters))
- `resource_id` (String) Deprecated.
- `resource_type` (String) Deprecated.

<a id="nestedblock--filter--event_filters--path_filter--some_filter--any_filters"></a>
### Nested Schema for `filter.event_filters.path_filter.some_filter.any_filters`

Required:

- `resource_id` (String) Resource ID.
- `resource_type` (String) Resource type.





<a id="nestedblock--filter--path_filter"></a>
### Nested Schema for `filter.path_filter`

Optional:

- `any_filter` (Block List, Max: 1) Deprecated. (see [below for nested schema](#nestedblock--filter--path_filter--any_filter))
- `some_filter` (Block List, Max: 1) Deprecated. (see [below for nested schema](#nestedblock--filter--path_filter--some_filter))

<a id="nestedblock--filter--path_filter--any_filter"></a>
### Nested Schema for `filter.path_filter.any_filter`

Required:

- `resource_id` (String) Resource ID.
- `resource_type` (String) Resource type.


<a id="nestedblock--filter--path_filter--some_filter"></a>
### Nested Schema for `filter.path_filter.some_filter`

Required:

- `any_filters` (Block List, Min: 1) Deprecated. (see [below for nested schema](#nestedblock--filter--path_filter--some_filter--any_filters))
- `resource_id` (String) Deprecated.
- `resource_type` (String) Deprecated.

<a id="nestedblock--filter--path_filter--some_filter--any_filters"></a>
### Nested Schema for `filter.path_filter.some_filter.any_filters`

Required:

- `resource_id` (String) Resource ID.
- `resource_type` (String) Resource type.





<a id="nestedblock--filtering_policy"></a>
### Nested Schema for `filtering_policy`

Optional:

- `data_events_filter` (Block List) Structure describing filtering process for the service-specific data events. (see [below for nested schema](#nestedblock--filtering_policy--data_events_filter))
- `management_events_filter` (Block List, Max: 1) Structure describing filtering process for management events. (see [below for nested schema](#nestedblock--filtering_policy--management_events_filter))

<a id="nestedblock--filtering_policy--data_events_filter"></a>
### Nested Schema for `filtering_policy.data_events_filter`

Required:

- `resource_scope` (Block List, Min: 1) Structure describing that events will be gathered from the specified resource. (see [below for nested schema](#nestedblock--filtering_policy--data_events_filter--resource_scope))
- `service` (String) ID of the service which events will be gathered.

Optional:

- `dns_filter` (Block List, Max: 1) Specific filter for DNS service. (see [below for nested schema](#nestedblock--filtering_policy--data_events_filter--dns_filter))
- `excluded_events` (List of String) A list of events that won't be gathered by the trail from this service. New events will be automatically gathered when this option is specified. Mutually exclusive with `included_events`.
- `included_events` (List of String) A list of events that will be gathered by the trail from this service. New events won't be gathered by default when this option is specified. Mutually exclusive with `excluded_events`.

<a id="nestedblock--filtering_policy--data_events_filter--resource_scope"></a>
### Nested Schema for `filtering_policy.data_events_filter.resource_scope`

Required:

- `resource_id` (String) Resource ID.
- `resource_type` (String) Resource type.


<a id="nestedblock--filtering_policy--data_events_filter--dns_filter"></a>
### Nested Schema for `filtering_policy.data_events_filter.dns_filter`

Required:

- `include_nonrecursive_queries` (Boolean) All types of queries will be delivered.



<a id="nestedblock--filtering_policy--management_events_filter"></a>
### Nested Schema for `filtering_policy.management_events_filter`

Required:

- `resource_scope` (Block List, Min: 1) Structure describing that events will be gathered from the specified resource. (see [below for nested schema](#nestedblock--filtering_policy--management_events_filter--resource_scope))

<a id="nestedblock--filtering_policy--management_events_filter--resource_scope"></a>
### Nested Schema for `filtering_policy.management_events_filter.resource_scope`

Required:

- `resource_id` (String) Resource ID.
- `resource_type` (String) Resource type.




<a id="nestedblock--logging_destination"></a>
### Nested Schema for `logging_destination`

Required:

- `log_group_id` (String) ID of the destination [Cloud Logging Group](https://yandex.cloud/docs/logging/concepts/log-group).


<a id="nestedblock--storage_destination"></a>
### Nested Schema for `storage_destination`

Required:

- `bucket_name` (String) Name of the [destination bucket](https://yandex.cloud/docs/storage/concepts/bucket).

Optional:

- `object_prefix` (String) Additional prefix of the uploaded objects. If not specified, objects will be uploaded with prefix equal to `trail_id`.


<a id="nestedblock--timeouts"></a>
### Nested Schema for `timeouts`

Optional:

- `default` (String) A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting the resource ID you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or [YC CLI](https://yandex.cloud/docs/cli/quickstart).

```bash
# terraform import yandex_audit_trails_trail.<resource Name> <resource Id>
terraform import yandex_audit_trails_trail.basic-trail cnpqe**********sh835
```
