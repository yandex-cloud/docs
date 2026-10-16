---
title: How to create a trail to upload audit logs
description: Follow this tutorial to create {{ at-full-name }} to register and save audit logs.
---

# Creating a trail to upload audit logs


You can create a trail that will upload both [management](../concepts/format.md) and [data](../concepts/format-data-plane.md) event audit logs into one of the [destination objects](../concepts/trail.md#target):

* [{{ objstorage-full-name }}](../../storage/index.yaml) bucket.
* [{{ cloud-logging-full-name }}](../../logging/index.yaml) group.
* [{{ yds-full-name }}](../../data-streams/index.yaml) data stream.

When creating a trail via the CLI, {{ TF }}, or API, you can set [field value conditions](../concepts/trail.md#field-filters) in the data event filters. Thus you will reduce the event stream and the amount of stored logs.

## Getting started {#before-you-begin}

Prepare a [destination object](../concepts/trail.md#target) and service account for your trail:

{% list tabs group=trail-target %}

- {{ objstorage-name }} bucket {#bucket}

  1. [Create a bucket](../../storage/operations/buckets/create.md) with restricted access the audit logs will be uploaded to.
  1. (Optional) Enable encryption for the bucket:

      [Make sure](../../iam/operations/roles/get-assigned-roles.md) the account you are going to use to create an encryption key for the bucket has the `kms.editor` [role](../../kms/security/index.md#kms-editor) for the folder.
  1. [Create a service account](../../iam/operations/sa/create.md) for the trail.
  1. [Assign to the service account these roles](../../iam/operations/sa/assign-role-for-sa.md) for the trail to collect and upload logs:

      * [storage.uploader](../../storage/security/index.md#storage-uploader) for the [bucket](../../storage/concepts/bucket.md).
      * [kms.keys.encrypter](../../kms/security/index.md#kms-keys-encrypter) for the bucket [encryption key](../../kms/concepts/key.md).

          This role is only required if encryption was enabled for the bucket.

      {% include [at-viewer-role-scope](../../_includes/audit-trails/create-trail/at-viewer-role-scope.md) %}

  1. {% include [required-account-roles](../../_includes/audit-trails/create-trail/required-account-roles.md) %}

- {{ cloud-logging-name }} log group {#logging}

  1. [Create a log group](../../logging/operations/create-group.md) the audit logs will be uploaded to.
  1. [Create a service account](../../iam/operations/sa/create.md) for the trail.
  1. [Assign to the service account these roles](../../iam/operations/sa/assign-role-for-sa.md) for the trail to collect and upload logs:

      * [logging.writer](../../logging/security/index.md#logging-writer) for the [log group](../../logging/concepts/log-group.md).

      {% include [at-viewer-role-scope](../../_includes/audit-trails/create-trail/at-viewer-role-scope.md) %}

  1. {% include [required-account-roles](../../_includes/audit-trails/create-trail/required-account-roles.md) %}

- {{ yds-name }} {#data-streams}

  1. [Create a data stream](../../data-streams/operations/manage-streams.md#create-data-stream) the audit logs will be uploaded to.

      {% note tip %}

      We recommend enabling [autopartitioning](../../data-streams/concepts/glossary.md#autopartitioning) on the target data stream.

      When overloading individual [shards](../../data-streams/concepts/glossary.md#shard) or the entire [stream](../../data-streams/concepts/glossary.md#stream-concepts), some events may get lost. Autopartitioning automatically adds shards as needed and distributes the workloads to avoid losses. If autopartitioning is disabled, remember to manually check and increase the number of shards.

      {% endnote %}

  1. [Create a service account](../../iam/operations/sa/create.md) for the trail.
  1. [Assign to the service account these roles](../../iam/operations/sa/assign-role-for-sa.md) for the trail to collect and upload logs:

      * [yds.writer](../../data-streams/security/index.md#yds-writer) for the [data stream](../../data-streams/concepts/glossary.md#stream-concepts).

      {% include [at-viewer-role-scope](../../_includes/audit-trails/create-trail/at-viewer-role-scope.md) %}

  1. {% include [required-account-roles](../../_includes/audit-trails/create-trail/required-account-roles.md) %}

{% endlist %}

## Creating a trail {#create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to host the trail.
  1. [Navigate]({{ link-console-main }}/link/audit-trails) to **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
  1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, select one of the destination objects and specify its settings:

      * **{{ ui-key.yacloud.audit-trails.label_objectStorage }}**: Uploading audit logs to an {{ objstorage-name }} bucket. Recommended for long-term data storage. Configure log storage settings:

          * **{{ ui-key.yacloud.audit-trails.label_bucket }}**: Bucket you [created earlier](#before-you-begin).
          * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}**: [Prefix](../concepts/format.md#log-file-name) that will be assigned to the objects with audit logs in the bucket. It is an optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.

              {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

          * **{{ ui-key.yacloud.audit-trails.title_kms-key }}**: Bucket encryption key. You only need to select it if encryption was enabled for the bucket.
      
      * **{{ ui-key.yacloud.audit-trails.label_cloudLogging }}**: Log group you [created earlier](#before-you-begin). Audit logs will be uploaded into this log group. Recommended for quick log collection and analysis.
      * **{{ ui-key.yacloud.audit-trails.label_dataStream }}**: Data stream you [created earlier](#before-you-begin). Audit logs will be uploaded into this stream. Recommended for streaming logs to other services or systems.

  1. {% include [control-plane-on-console](../../_includes/audit-trails/control-plane-on-console.md) %}
  1. {% include [data-plane-on-console](../../_includes/audit-trails/data-plane-on-console.md) %}

      To restrict event collection by field values, set the [filtering conditions](../concepts/trail.md#field-filters) via the CLI, API, or {{ TF }}.

  1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select the [previously created](#before-you-begin) service account the trail will operate under.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the trail. It must be unique within the folder.
  1. Optionally, enter a description for the trail.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  View the description of the CLI command for creating a trail:

  ```bash
  yc audit-trails trail create --help
  ```

  Use a YAML specification for collecting [data events](../concepts/control-plane-vs-data-plane.md#data-plane-events). If you only need management events, provide parameters directly in the command.

  {% cut "In the YAML specification" %}

  1. Create a YAML file with the trail configuration. In this template, logs are uploaded to the bucket:

      {% include [trail-create-cli-yaml-config](../../_includes/audit-trails/trail-create-cli-yaml-config.md) %}

      You can also use the [specification for an existing trail](prepare-spec.md#spec-for-create) as a basis.

      Configuration parameters:

      * `name`: Trail name. It must be unique within the folder.
      * `folder_id`: [ID](../../resource-manager/operations/folder/get-id.md) of the folder the trail will reside in.
      * `destination`: Settings for the audit log destination object.

          Specify only one destination: `object_storage`, `cloud_logging`, or `data_stream`.

          * `object_storage`: Uploading logs to a {{ objstorage-full-name }} [bucket](../../storage/concepts/bucket.md#naming):

              * `bucket_id`: [Name](../../storage/concepts/bucket.md#naming) of the bucket you created [earlier](#before-you-begin).

                  To view a list of bucket names in the default folder, run this command:

                  ```bash
                  yc storage bucket list
                  ```
              
              * `object_prefix`: [Prefix](../../storage/concepts/object.md#folder) to assign to the objects with audit logs within the bucket. It is an optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.

                  {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

          * `cloud_logging`: Uploading logs to a {{ cloud-logging-full-name }} [group](../../logging/concepts/log-group.md).

              Replace the `destination` section in the template:

              ```yaml
              destination:
                cloud_logging:
                  log_group_id: <log_group_ID>
              ```

              In the `log_group_id` parameter, specify the ID of the log group you [created earlier](#before-you-begin). You can request the ID with the [list of log groups in the folder](../../logging/operations/list.md).
          
          * `data_stream`: Uploading logs to a [data stream](../../data-streams/concepts/glossary.md#stream-concepts) in {{ yds-full-name }}:

              Replace the `destination` section in the template:

              ```yaml
              destination:
                data_stream:
                  stream_name: <data_stream_name>
                  database_id: <database_ID>
                  codec: RAW
              ```

              * `stream_name`: Name of the data stream you [created earlier](#before-you-begin). You can request the name with the [list of data streams in the folder](../../data-streams/operations/manage-streams.md#list-data-streams).
              * `database_id`: ID of the {{ ydb-short-name }} database used by {{ yds-name }}. You can request the ID with the [list of {{ ydb-short-name }} databases in the folder](../../ydb/operations/manage-databases.md#list-db).
              * `codec`: Event compression method when writing to {{ yds-name }}. The possible values are `RAW` (no compression, default), `GZIP`, and `ZSTD`. Enable compression if you expect an event flow greater than 1 MB/s.

      * `service_account_id`: [ID](../../iam/operations/sa/get-id.md) of the service account you created [earlier](#before-you-begin).

      {% include [trail-create-cli-yaml-desc-filtering](../../_includes/audit-trails/trail-create-cli-yaml-desc-filtering.md) %}

  1. {% include [field-filter-cli](../../_includes/audit-trails/field-filter-cli.md) %}

  1. Run this command:

      ```bash
      yc audit-trails trail create --file <file_path>
      ```

  {% endcut %}

  {% cut "In command parameters" %}

  To collect management events from a folder and upload them to a bucket, run this command:

  ```bash
  yc audit-trails trail create \
    --name <trail_name> \
    --service-account-id <service_account_ID> \
    --destination-bucket <bucket_name> \
    --filter-all-folder-id <folder_ID>
  ```

  For a different destination object, replace `--destination-bucket` with one of these options:

  * Log group:

      ```bash
      --destination-log-group-id <log_group_ID>
      ```

  * Data stream:

      ```bash
      --destination-yds-stream <data_stream_name> \
      --destination-yds-database-id <database_ID>
      ```

  Command parameters:

  * `--name`: Name of the new trail.

  {% include [trail-cli-flag-desc](../../_includes/audit-trails/trail-cli-flag-desc.md) %}

  {% endcut %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Specify the trail properties in the configuration file. In this template, logs are uploaded to the bucket:

      {% include [trail-tf-manifest](../../_includes/audit-trails/trail-tf-manifest.md) %}

      Where:

      {% include [trail-create-tf-descs_part1](../../_includes/audit-trails/trail-create-tf-descs-part1.md) %}

      {% include [trail-create-tf-descs_logging](../../_includes/audit-trails/trail-create-tf-descs-logging.md) %}

      {% include [trail-create-tf-descs_part2](../../_includes/audit-trails/trail-create-tf-descs-part2.md) %}

      For more on the properties of the `yandex_audit_trails_trail` resource, see [this provider guide]({{ tf-provider-resources-link }}/audit_trails_trail).

  1. {% include [field-filter-tf](../../_includes/audit-trails/field-filter-tf.md) %}

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources and their settings either in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/) command:

     ```bash
     yc audit-trails trail get <trail_name>
     ```

- API {#api}

    1. [Authenticate](../api-ref/authentication.md) with the API.
    1. Prepare the following trail parameters: folder, destination object, service account, and filtering policy with the relevant services and scopes.

        To use the settings of an existing trail as a basis, get them using the [get](../api-ref/Trail/get.md) REST API method or [TrailService/Get](../api-ref/grpc/Trail/get.md) gRPC API call.

    1. {% include [field-filter-api](../../_includes/audit-trails/field-filter-api.md) %}
    1. To create a trail, use the [create](../api-ref/Trail/create.md) REST API method for the [Trail](../api-ref/Trail/index.md) resource or the [TrailService/Create](../api-ref/grpc/Trail/create.md) gRPC API call.

{% endlist %}

The trail will be created and start uploading audit logs to the selected destination object.

{% include [logging-dublicate-events](../../_includes/audit-trails/logging-dublicate-events.md) %}

## Examples {#examples}

### Creating a trail with event filtering {#example-control-data-planes}

In our example, we create the `sample-trail-all-planes` trail in `folder0***`, and it writes logs to `sample-logs-bucket` under the `service0***` service account.

The filters dictate which events are logged:

* Management events: From all the `org1***` organization’s clouds.
* Data events:
  * [{{ mpg-name }}](../../managed-postgresql/): All events from `cloud1***` and `folder1***` except for `CreateDatabase` and `UpdateDatabase`.
  * [{{ iam-name }}](../../iam/): Only `CreateIamToken` events from `folder2***`. Events with both the `iam.session` credentials type and `user@example.com` for the subject name are excluded.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Create a YAML file named `sample-trail-all-planes.yaml` with the trail configuration:

      ```yaml
      name: sample-trail-all-planes
      folder_id: folder0***
      destination:
        object_storage:
          bucket_id: sample-logs-bucket
      service_account_id: service0***
      filtering_policy:
        management_events_filter:
          resource_scopes:
            - id: org1***
              type: organization-manager.organization
        data_events_filters:
          - service: mdb.postgresql
            resource_scopes:
              - id: cloud1***
                type: resource-manager.cloud
              - id: folder1***
                type: resource-manager.folder
            excluded_events:
              event_types:
                - yandex.cloud.audit.mdb.postgresql.CreateDatabase
                - yandex.cloud.audit.mdb.postgresql.UpdateDatabase
          - service: iam
            resource_scopes:
              - id: folder2***
                type: resource-manager.folder
            included_events:
              event_types:
                - yandex.cloud.audit.iam.CreateIamToken
            exclude_rules:
              - conditions:
                  - field: $.details.credential.type
                    operator: IN
                    values:
                      - iam.session
                  - field: $.details.subject_name
                    operator: IN
                    values:
                      - user@example.com
      ```

  1. Run this command:

      ```bash
      yc audit-trails trail create --file sample-trail-all-planes.yaml
      ```

- {{ TF }} {#tf}

  1. Specify the trail properties in the {{ TF }} configuration file:

      ```hcl
      resource "yandex_audit_trails_trail" "basic_trail" {
        name               = "sample-trail-all-planes"
        folder_id          = "folder0***"
        service_account_id = "service0***"

        storage_destination {
          bucket_name = "sample-logs-bucket"
        }

        filtering_policy {
          management_events_filter {
            resource_scope {
              resource_id   = "org1***"
              resource_type = "organization-manager.organization"
            }
          }

          data_events_filter {
            service = "mdb.postgresql"
            excluded_events = [
              "yandex.cloud.audit.mdb.postgresql.CreateDatabase",
              "yandex.cloud.audit.mdb.postgresql.UpdateDatabase",
            ]

            resource_scope {
              resource_id   = "cloud1***"
              resource_type = "resource-manager.cloud"
            }

            resource_scope {
              resource_id   = "folder1***"
              resource_type = "resource-manager.folder"
            }
          }

          data_events_filter {
            service         = "iam"
            included_events = ["yandex.cloud.audit.iam.CreateIamToken"]

            resource_scope {
              resource_id   = "folder2***"
              resource_type = "resource-manager.folder"
            }

            exclude_rule {
              condition {
                field    = "$.details.credential.type"
                operator = "IN"
                values   = ["iam.session"]
              }

              condition {
                field    = "$.details.subject_name"
                operator = "IN"
                values   = ["user@example.com"]
              }
            }
          }
        }
      }
      ```

  1. Apply the configuration:

      ```bash
      terraform apply
      ```

- API {#api}

  Use the [create](../api-ref/Trail/create.md) REST API method for the [Trail](../api-ref/Trail/index.md) resource.

  {% include [curl](../../_includes/curl.md) %}

  {% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and write it into an environment variable:

      ```bash
      export IAM_TOKEN=<IAM_token>
      ```

  1. Create a file named `body.json` with the following request body:

      ```json
      {
        "folderId": "folder0***",
        "name": "sample-trail-all-planes",
        "destination": {
          "objectStorage": {
            "bucketId": "sample-logs-bucket"
          }
        },
        "serviceAccountId": "service0***",
        "filteringPolicy": {
          "managementEventsFilter": {
            "resourceScopes": [
              {
                "id": "org1***",
                "type": "organization-manager.organization"
              }
            ]
          },
          "dataEventsFilters": [
            {
              "service": "mdb.postgresql",
              "resourceScopes": [
                {
                  "id": "cloud1***",
                  "type": "resource-manager.cloud"
                },
                {
                  "id": "folder1***",
                  "type": "resource-manager.folder"
                }
              ],
              "excludedEvents": {
                "eventTypes": [
                  "yandex.cloud.audit.mdb.postgresql.CreateDatabase",
                  "yandex.cloud.audit.mdb.postgresql.UpdateDatabase"
                ]
              }
            },
            {
              "service": "iam",
              "resourceScopes": [
                {
                  "id": "folder2***",
                  "type": "resource-manager.folder"
                }
              ],
              "includedEvents": {
                "eventTypes": [
                  "yandex.cloud.audit.iam.CreateIamToken"
                ]
              },
              "excludeRules": [
                {
                  "conditions": [
                    {
                      "field": "$.details.credential.type",
                      "operator": "IN",
                      "values": ["iam.session"]
                    },
                    {
                      "field": "$.details.subject_name",
                      "operator": "IN",
                      "values": ["user@example.com"]
                    }
                  ]
                }
              ]
            }
          ]
        }
      }
      ```

  1. Run this request:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --header "Content-Type: application/json" \
        --data "@body.json" \
        https://audittrails.api.cloud.yandex.net/audit-trails/v1/trails
      ```

{% endlist %}

### Filtering by field value {#filter-examples}

You can use these examples to create or update a trail. Add the relevant snippet to the filter of the service in question: in the CLI, to the `filtering_policy.data_events_filters` list item; in {{ TF }}, to the `filtering_policy.data_events_filter` section.

{% cut "Excluding events by credentials type and user" %}

The filter for `iam` excludes events with the `iam.session` credentials type and the `user@example.com` subject name, e.g., [CreateIamToken](../audit/iam/events-ref/CreateIamToken.md).

{% list tabs group=instructions %}

- CLI {#cli}

  ```yaml
  exclude_rules:
    - conditions:
        - field: $.details.credential.type
          operator: IN
          values:
            - iam.session
        - field: $.details.subject_name
          operator: IN
          values:
            - user@example.com
  ```

- {{ TF }} {#tf}

  ```hcl
  exclude_rule {
    condition {
      field    = "$.details.credential.type"
      operator = "IN"
      values   = ["iam.session"]
    }

    condition {
      field    = "$.details.subject_name"
      operator = "IN"
      values   = ["user@example.com"]
    }
  }
  ```

{% endlist %}

{% endcut %}

{% cut "Excluding events by IP address" %}

The filter for `mdb.mongodb` excludes [GenericAuditEvent](../audit/mdb/mongodb/events-ref/GenericAuditEvent.md) events with `details.remote_address` from the `192.0.2.0/24` subnet.

{% list tabs group=instructions %}

- CLI {#cli}

  ```yaml
  exclude_rules:
    - conditions:
        - field: $.event_type
          operator: IN
          values:
            - yandex.cloud.audit.mdb.mongodb.GenericAuditEvent
        - field: $.details.remote_address
          operator: IP_IN
          values:
            - 192.0.2.0/24
  ```

- {{ TF }} {#tf}

  ```hcl
  exclude_rule {
    condition {
      field    = "$.event_type"
      operator = "IN"
      values   = ["yandex.cloud.audit.mdb.mongodb.GenericAuditEvent"]
    }

    condition {
      field    = "$.details.remote_address"
      operator = "IP_IN"
      values   = ["192.0.2.0/24"]
    }
  }
  ```

{% endlist %}

{% endcut %}

{% cut "Excluding network events by source and destination addresses" %}

The filter for `network` excludes [ExternalFlow](../audit/vpc/events-ref/ExternalFlow.md) events with source and destination addresses from the `198.51.100.0/24` subnet.

{% list tabs group=instructions %}

- CLI {#cli}

  ```yaml
  exclude_rules:
    - conditions:
        - field: $.event_type
          operator: IN
          values:
            - yandex.cloud.audit.network.flowlogs.ExternalFlow
        - field: $.details.dst_addr
          operator: IP_IN
          values:
            - 198.51.100.0/24
        - field: $.details.src_addr
          operator: IP_IN
          values:
            - 198.51.100.0/24
  ```

- {{ TF }} {#tf}

  ```hcl
  exclude_rule {
    condition {
      field    = "$.event_type"
      operator = "IN"
      values   = ["yandex.cloud.audit.network.flowlogs.ExternalFlow"]
    }

    condition {
      field    = "$.details.dst_addr"
      operator = "IP_IN"
      values   = ["198.51.100.0/24"]
    }

    condition {
      field    = "$.details.src_addr"
      operator = "IP_IN"
      values   = ["198.51.100.0/24"]
    }
  }
  ```

{% endlist %}

{% endcut %}

{% cut "Collecting {{ k8s }} secret read events" %}

The filter for `k8s` only keeps [ApiServerWatch](../audit/k8s/apiserver/events-ref/ApiServerWatch.md), [ApiServerGet](../audit/k8s/apiserver/events-ref/ApiServerGet.md), and [ApiServerList](../audit/k8s/apiserver/events-ref/ApiServerList.md) events for `secrets` resources.

{% list tabs group=instructions %}

- CLI {#cli}

  ```yaml
  include_rules:
    - conditions:
        - field: $.event_type
          operator: IN
          values:
            - yandex.cloud.audit.k8s.apiserver.ApiServerWatch
            - yandex.cloud.audit.k8s.apiserver.ApiServerGet
            - yandex.cloud.audit.k8s.apiserver.ApiServerList
        - field: $.details.native_api_server_event.objectRef.resource
          operator: IN
          values:
            - secrets
  ```

- {{ TF }} {#tf}

  ```hcl
  include_rule {
    condition {
      field    = "$.event_type"
      operator = "IN"
      values = [
        "yandex.cloud.audit.k8s.apiserver.ApiServerWatch",
        "yandex.cloud.audit.k8s.apiserver.ApiServerGet",
        "yandex.cloud.audit.k8s.apiserver.ApiServerList",
      ]
    }

    condition {
      field    = "$.details.native_api_server_event.objectRef.resource"
      operator = "IN"
      values   = ["secrets"]
    }
  }
  ```

{% endlist %}

The `objectRef` key register matches the {{ k8s }} source event.

{% endcut %}

## What's next {#whats-next}

* Learn more about the [audit log format](../concepts/format.md).
* Find out about the procedure for [uploading audit logs to SIEM](../concepts/export-siem.md).
* Learn how to [search for events in audit logs](../tutorials/search-events-audit-logs/index.md).
