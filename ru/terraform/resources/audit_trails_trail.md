---
subcategory: Audit Trails
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
    codec       = "ZSTD"
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

## Arguments & Attributes Reference

- `description` (String). The resource description.
- `folder_id` (**Required**)(String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). The resource name.
- `service_account_id` (**Required**)(String). [Service account](https://yandex.cloud/docs/iam/concepts/users/service-accounts) which linked to the resource.
- `status` (*Read-Only*) (String). Status of this trail.
- `trail_id` (*Read-Only*) (String). ID of the trail resource.
- `data_stream_destination` [Block]. Structure describing destination data stream of the trail. Mutually exclusive with `logging_destination` and `storage_destination`.
  - `codec` (String). Codec for compressing events. Allowed values: RAW, GZIP, ZSTD. Default: RAW
  - `database_id` (**Required**)(String). ID of the [YDB](https://yandex.cloud/docs/ydb/concepts/resources) hosting the destination data stream.
  - `stream_name` (**Required**)(String). Name of the [YDS stream](https://yandex.cloud/docs/data-streams/concepts/glossary#stream-concepts) belonging to the specified YDB.
- `filter` [Block]. Structure is deprecated. Use `filtering_policy` instead.
  - `event_filters` [Block]. Deprecated.
    - `service` (**Required**)(String). Deprecated.
    - `categories` [Block]. Deprecated.
      - `plane` (**Required**)(String). Deprecated.
      - `type` (**Required**)(String). Deprecated.
    - `path_filter` [Block]. Deprecated.
      - `any_filter` [Block]. Deprecated.
        - `resource_id` (**Required**)(String). Resource ID.
        - `resource_type` (**Required**)(String). Resource type.
      - `some_filter` [Block]. Deprecated.
        - `resource_id` (**Required**)(String). Deprecated.
        - `resource_type` (**Required**)(String). Deprecated.
        - `any_filters` [Block]. Deprecated.
          - `resource_id` (**Required**)(String). Resource ID.
          - `resource_type` (**Required**)(String). Resource type.
  - `path_filter` [Block]. Deprecated.
    - `any_filter` [Block]. Deprecated.
      - `resource_id` (**Required**)(String). Resource ID.
      - `resource_type` (**Required**)(String). Resource type.
    - `some_filter` [Block]. Deprecated.
      - `resource_id` (**Required**)(String). Deprecated.
      - `resource_type` (**Required**)(String). Deprecated.
      - `any_filters` [Block]. Deprecated.
        - `resource_id` (**Required**)(String). Resource ID.
        - `resource_type` (**Required**)(String). Resource type.
- `filtering_policy` [Block]. Structure describing event filtering process for the trail. Mutually exclusive with `filter`. At least one of the `management_events_filter` or `data_events_filter` fields will be filled.
  - `data_events_filter` [Block]. Structure describing filtering process for the service-specific data events.
    - `excluded_events` (List Of String). A list of events that won't be gathered by the trail from this service. New events will be automatically gathered when this option is specified. Mutually exclusive with `included_events`.
    - `included_events` (List Of String). A list of events that will be gathered by the trail from this service. New events won't be gathered by default when this option is specified. Mutually exclusive with `excluded_events`.
    - `service` (**Required**)(String). ID of the service which events will be gathered.
    - `dns_filter` [Block]. Specific filter for DNS service.
      - `include_nonrecursive_queries` (**Required**)(Bool). All types of queries will be delivered.
    - `resource_scope` [Block]. Structure describing that events will be gathered from the specified resource.
      - `resource_id` (**Required**)(String). Resource ID.
      - `resource_type` (**Required**)(String). Resource type.
  - `management_events_filter` [Block]. Structure describing filtering process for management events.
    - `resource_scope` [Block]. Structure describing that events will be gathered from the specified resource.
      - `resource_id` (**Required**)(String). Resource ID.
      - `resource_type` (**Required**)(String). Resource type.
- `logging_destination` [Block]. Structure describing destination log group of the trail. Mutually exclusive with `storage_destination` and `data_stream_destination`.
  - `log_group_id` (**Required**)(String). ID of the destination [Cloud Logging Group](https://yandex.cloud/docs/logging/concepts/log-group).
- `storage_destination` [Block]. Structure describing destination bucket of the trail. Mutually exclusive with `logging_destination` and `data_stream_destination`.
  - `bucket_name` (**Required**)(String). Name of the [destination bucket](https://yandex.cloud/docs/storage/concepts/bucket).
  - `object_prefix` (String). Additional prefix of the uploaded objects. If not specified, objects will be uploaded with prefix equal to `trail_id`.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_audit_trails_trail.<resource Name> <resource Id>
terraform import yandex_audit_trails_trail.basic-trail cnpqe**********sh835
```
