---
editable: false
noIndex: true
---

# yc beta audit-trails trail create

Creates a trail in the specified folder.

#### Command Usage

Syntax:

`yc beta audit-trails trail create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--description` | `string`

Description of the trail. ||
|| `--destination` | `shorthand/json`

Destination configuration for the trail

Shorthand Syntax:

```hcl
{
  destination = cloud-logging={
    destination = log-group-id=string
  } | data-stream={
    codec = RAW|GZIP|ZSTD,
    database-id = string,
    stream-name = string
  } | eventrouter={
    eventrouter-connector-id = string
  } | object-storage={
    bucket-id = string,
    object-prefix = string
  }
}
```

JSON Syntax:

```json
{
  "destination": {
    "cloud-logging": {
      "destination": {
        "log-group-id": "string"
      }
    },
    "data-stream": {
      "codec": "RAW|GZIP|ZSTD",
      "database-id": "string",
      "stream-name": "string"
    },
    "eventrouter": {
      "eventrouter-connector-id": "string"
    },
    "object-storage": {
      "bucket-id": "string",
      "object-prefix": "string"
    }
  }
}
```

Fields:

```
destination -> (oneof<cloud-logging|data-stream|eventrouter|object-storage>)
  Oneof destination field
  object-storage -> (struct)
    Configuration for event delivery to Object Storage Uploaded objects will have prefix <trail_id>/ by default
    bucket-id -> (string)
      Name of the destination bucket
    object-prefix -> (string)
      Prefix for exported objects. Optional If specified, uploaded objects will have prefix <object_prefix>/<trail_id>/
  cloud-logging -> (struct)
    Configuration for event delivery to Cloud Logging
    destination -> (oneof<log-group-id>)
      Oneof destination field
      log-group-id -> (string)
        ID of the Cloud Logging destination group
  data-stream -> (struct)
    Configuration for event delivery to YDS
    codec -> (struct)
      Codec for compressing events
    database-id -> (string)
      ID of the database hosting the destination YDS
    stream-name -> (string)
      Name of the destination YDS
  eventrouter -> (struct)
    Configuration for event delivery to EventRouter
    eventrouter-connector-id -> (string)
      ID of the EventRouter Connector
``` ||
|| `--filter` | `shorthand/json`

Event filtering configuration of the trail deprecated: use filtering_policy instead

Shorthand Syntax:

```hcl
{
  event-filter = {
    filters = [
      {
        categories = [
          {
            plane = CONTROL_PLANE|DATA_PLANE,
            type = WRITE|READ
          }, ...
        ],
        path-filter = {
          root = {
            element = any-filter={
              resource = {
                id = string,
                type = string
              }
            } | some-filter={
              filters = [
                <PathFilterElement>, ...
              ],
              resource = {
                id = string,
                type = string
              }
            }
          }
        },
        service = string
      }, ...
    ]
  },
  path-filter = {
    root = {
      element = any-filter={
        resource = {
          id = string,
          type = string
        }
      } | some-filter={
        filters = [
          <PathFilterElement>, ...
        ],
        resource = {
          id = string,
          type = string
        }
      }
    }
  }
}
```

JSON Syntax:

```json
{
  "event-filter": {
    "filters": [
      {
        "categories": [
          {
            "plane": "CONTROL_PLANE|DATA_PLANE",
            "type": "WRITE|READ"
          }, ...
        ],
        "path-filter": {
          "root": {
            "element": {
              "any-filter": {
                "resource": {
                  "id": "string",
                  "type": "string"
                }
              },
              "some-filter": {
                "filters": [
                  "<PathFilterElement>", ...
                ],
                "resource": {
                  "id": "string",
                  "type": "string"
                }
              }
            }
          }
        },
        "service": "string"
      }, ...
    ]
  },
  "path-filter": {
    "root": {
      "element": {
        "any-filter": {
          "resource": {
            "id": "string",
            "type": "string"
          }
        },
        "some-filter": {
          "filters": [
            "<PathFilterElement>", ...
          ],
          "resource": {
            "id": "string",
            "type": "string"
          }
        }
      }
    }
  }
}
```

Fields:

```
event-filter -> (struct)
  Configuration of additional events gathering from specific services
  filters -> ([]struct)
    List of filters for services
    categories -> ([]struct)
      List of the event categories gathered for a specified service
      plane -> (struct)
        Plane of the gathered category
      type -> (struct)
        Type of the gathered category
    path-filter -> (struct)
      Resource path filter for a specified service
      root -> (struct)
        Root element of the resource path filter for the trail Resource described in that filter node must contain the trail itself
        element -> (oneof<any-filter|some-filter>)
          Oneof element field
          any-filter -> (struct)
            Filter element with ANY type. If used, configures the trail to gather any events from the resource
            resource -> (struct)
              Resource definition
              id -> (string)
                ID of the resource
              type -> (string)
                Type of the resource
          some-filter -> (struct)
            Filter element with SOME type. If used, configures the trail to gather some of the events from the resource
            filters -> ([]struct)
              Filters for the resources contained in the parent resource
            resource -> (struct)
              Definition of the resource that contains nested resources
              id -> (string)
                ID of the resource
              type -> (string)
                Type of the resource
    service -> (string)
      Service ID of the gathered events
path-filter -> (struct)
  Configuration of default events gathering for the trail If not specified, default events won't be gathered for the trail
  root -> (struct)
    Root element of the resource path filter for the trail Resource described in that filter node must contain the trail itself
    element -> (oneof<any-filter|some-filter>)
      Oneof element field
      any-filter -> (struct)
        Filter element with ANY type. If used, configures the trail to gather any events from the resource
        resource -> (struct)
          Resource definition
          id -> (string)
            ID of the resource
          type -> (string)
            Type of the resource
      some-filter -> (struct)
        Filter element with SOME type. If used, configures the trail to gather some of the events from the resource
        filters -> ([]struct)
          Filters for the resources contained in the parent resource
        resource -> (struct)
          Definition of the resource that contains nested resources
          id -> (string)
            ID of the resource
          type -> (string)
            Type of the resource
``` ||
|| `--filtering-policy` | `shorthand/json`

Event filtering policy of the trail

Shorthand Syntax:

```hcl
{
  data-events-filters = [
    {
      additional-rules = excluded-events={
        event-types = string,...
      } | included-events={
        event-types = string,...
      },
      resource-scopes = [
        {
          id = string,
          type = string
        }, ...
      ],
      service = string,
      service-specific-rules = dns-filter={
        include-nonrecursive-queries = boolean
      }
    }, ...
  ],
  management-events-filter = {
    resource-scopes = [
      {
        id = string,
        type = string
      }, ...
    ]
  }
}
```

JSON Syntax:

```json
{
  "data-events-filters": [
    {
      "additional-rules": {
        "excluded-events": {
          "event-types": [
            "string", ...
          ]
        },
        "included-events": {
          "event-types": [
            "string", ...
          ]
        }
      },
      "resource-scopes": [
        {
          "id": "string",
          "type": "string"
        }, ...
      ],
      "service": "string",
      "service-specific-rules": {
        "dns-filter": {
          "include-nonrecursive-queries": "boolean"
        }
      }
    }, ...
  ],
  "management-events-filter": {
    "resource-scopes": [
      {
        "id": "string",
        "type": "string"
      }, ...
    ]
  }
}
```

Fields:

```
data-events-filters -> ([]struct)
  List of filters describing gathering data events
  resource-scopes -> ([]struct)
    A list of resources which will be monitored by the trail
    id -> (string)
      ID of the resource
    type -> (string)
      Type of the resource
  service -> (string)
    Name of the service whose events will be delivered
  additional-rules -> (oneof<excluded-events|included-events>)
    Oneof additional-rules field
    included-events -> (struct)
      Explicitly included events of specified service New events of the service won't be delivered by default
      event-types -> ([]string)
    excluded-events -> (struct)
      Explicitly excluded events of specified service New events of the service will be delivered by default
      event-types -> ([]string)
  service-specific-rules -> (oneof<dns-filter>)
    Oneof service-specific-rules field
    dns-filter -> (struct)
      Filter is allowed only if service = dns
      include-nonrecursive-queries -> (boolean)
        Not only recursive queries will be delivered
management-events-filter -> (struct)
  Singular filter describing gathering management events
  resource-scopes -> ([]struct)
    A list of resources which will be monitored by the trail
    id -> (string)
      ID of the resource
    type -> (string)
      Type of the resource
``` ||
|| `--folder-id` | `string`

ID of the folder to create a trail in. ||
|| `--labels` | `map<string><string>`

Custom labels for the secret as 'key:value' pairs. Maximum 64 per key. For example, '"type": "critical"' or '"source": "dictionary"'. ||
|| `--name` | `string`

Name of the trail. ||
|| `--service-account-id` | `string`

Service account ID of the trail ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#