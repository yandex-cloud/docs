---
title: How to create a trail to upload audit logs
description: Follow this tutorial to create {{ at-full-name }} to register and save audit logs.
---

# Creating a trail to upload audit logs


You can create a trail that will upload both [management](../concepts/format.md) and [data](../concepts/format-data-plane.md) event audit logs into one of the [destination objects](../concepts/trail.md#target):

* [{{ objstorage-full-name }}](../../storage/) bucket
* [{{ cloud-logging-full-name }}](../../logging/) group
* [{{ yds-full-name }}](../../data-streams/) data stream

## Getting started {#before-you-begin}

Depending on the selected [destination object](../concepts/trail.md#target) for logs, prepare the required infrastructure to create a trail:

{% list tabs group=trail-target %}

- {{ objstorage-name }} bucket {#bucket}

    1. [Create a bucket](../../storage/operations/buckets/create.md) with restricted access the audit logs will be uploaded to.

    1. (Optional) Enable encryption for the bucket:

        [Make sure](../../iam/operations/roles/get-assigned-roles.md) your account has the `kms.editor` role for the folder the bucket encryption key will be created in.

    1. [Create a service account](../../iam/operations/sa/create.md) for the trail.

    1. [Assign roles to the service account](../../iam/operations/sa/assign-role-for-sa.md) for the trail to be able to collect and upload logs:

        * `storage.uploader` for a bucket.
        * `kms.keys.encrypter` for a bucket encryption key.

            This role is only required if encryption has been enabled for the bucket.

        {% include [at-viewer-role-scope](../../_includes/audit-trails/create-trail/at-viewer-role-scope.md) %}

    1. {% include [required-account-roles](../../_includes/audit-trails/create-trail/required-account-roles.md) %}

- {{ cloud-logging-name }} log group {#logging}

    1. [Create a log group](../../logging/operations/create-group.md) the audit logs will be uploaded to.

    1. [Create a service account](../../iam/operations/sa/create.md) for the trail.

    1. [Assign roles to the service account](../../iam/operations/sa/assign-role-for-sa.md) for the trail to be able to collect and upload logs:

        * `logging.writer` for a log group.

        {% include [at-viewer-role-scope](../../_includes/audit-trails/create-trail/at-viewer-role-scope.md) %}

    1. {% include [required-account-roles](../../_includes/audit-trails/create-trail/required-account-roles.md) %}

- {{ yds-name }} data stream {#data-streams}

    1. [Create a data stream](../../data-streams/operations/manage-streams.md#create-data-stream) the audit logs will be uploaded to.

    1. [Create a service account](../../iam/operations/sa/create.md) for the trail.

    1. [Assign roles to the service account](../../iam/operations/sa/assign-role-for-sa.md) for the trail to be able to collect and upload logs:

        * `yds.editor` for a data stream.

        {% include [at-viewer-role-scope](../../_includes/audit-trails/create-trail/at-viewer-role-scope.md) %}

    1. {% include [required-account-roles](../../_includes/audit-trails/create-trail/required-account-roles.md) %}

{% endlist %}

## Creating a trail {#create}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder to host the trail.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
    1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
    1. Enter a trail name. It must be unique within the folder.
    1. (Optional) Enter a description for your trail.
    1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, select one of the destination objects and specify its settings:

        * **{{ ui-key.yacloud.audit-trails.label_objectStorage }}**: Uploading audit logs to the {{ objstorage-name }} bucket:

            * **{{ ui-key.yacloud.audit-trails.label_bucket }}**: Name of the bucket you [created earlier](#before-you-begin).
            * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}**: [Prefix](../concepts/format.md#log-file-name) that will be assigned to the objects with audit logs in the bucket. It is an optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.

                {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

            * **{{ ui-key.yacloud.audit-trails.title_kms-key }}**: Bucket encryption key. You only need to select it if encryption has been enabled for your bucket.

        * **{{ ui-key.yacloud.audit-trails.label_cloudLogging }}**: Specify the name of the log group you [created earlier](#before-you-begin). Audit logs will be uploaded into it.

        * **{{ ui-key.yacloud.audit-trails.label_dataStream }}**: Specify the name of the data stream you [created earlier](#before-you-begin). Audit logs will be uploaded into this stream.

    1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select the [previously created](#before-you-begin) service account the trail will operate under.

    1. Enable and configure event collection from one or two levels. Such events will end up in the audit logs.

        To configure **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**:

        1. Select the [log collection scope](../concepts/trail.md): `Organization`, `Cloud`, or `Folder`. The logged events will be collected in the scope you specify.

            The permissions of the service account [created earlier](before-you-begin) must allow log collection from the specified scope.

        1. Depending on the selected log collection scope, select specific clouds or folders to collect events from:

            * For the `Organization` collection scope, select from the **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** drop-down list one or more clouds to collect events from.

                Keep the default value (`{{ ui-key.yacloud.common.all }}`) to collect events from all clouds in the organization.

            * For the `Cloud` collection scope, select from the **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** drop-down list one or more folders to collect events from.

                Keep the default value (`{{ ui-key.yacloud.common.all }}`) to collect events from all folders in the cloud.

        To configure **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}**:

        1. Select one or more services to collect events from.

        1. For each such service, select the [log collection scope](../concepts/trail.md): `Organization`, `Cloud`, or `Folder`. The logged events will be collected in the scope you specify.

            The permissions of the service account [created earlier](before-you-begin) must allow log collection from the specified scope.

        1. Depending on the selected log collection scope, select specific clouds or folders to collect events from:

            * For the `Organization` collection scope, select from the **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** drop-down list one or more clouds to collect events from.

                Keep the default value (`{{ ui-key.yacloud.common.all }}`) to collect events from all clouds in the organization.

            * For the `Cloud` collection scope, select from the **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** drop-down list one or more folders to collect events from.

                Keep the default value (`{{ ui-key.yacloud.common.all }}`) to collect events from all folders in the cloud.

        1. For each such service, select one of the following filters by [events](../concepts/events-data-plane.md#dns):

            * `Receive all`: To collect all events within the service.
            * `Selected`: To collect only the selected events. Proceed to select the events.
            * `Exclude`: To collect all events except for the selected ones. Proceed to select the events.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  See the description of the [CLI](../../cli/) trail creation command for details about the arguments you can use:

  ```bash
  yc audit-trails trail create --help
  ```

  You can create a trail by specifying its parameters in one of these two ways:

  {% cut "In the YAML specification" %}

  Create a YAML specification containing the trail parameters and specify this file in the command to create the trail.
  
  This method simplifies working with trail parameters and reduces error probability. In addition, you can only customize the registration of [data events](../concepts/control-plane-vs-data-plane.md#data-plane-events) using the YAML specification.

  1. Create a YAML file with the trail configuration:

      {% include [trail-create-cli-yaml-config](../../_includes/audit-trails/trail-create-cli-yaml-config.md) %}

      Where:

      * `name`: Trail name. It must be unique within the folder.
      * `folder_id`: [ID](../../resource-manager/operations/folder/get-id.md) of the folder the trail will reside in.
      * `destination`: Settings of the selected destination the audit logs will be uploaded to.

          {% note warning %}

          Destination settings are mutually exclusive. Using some settings makes it impossible to use others.

          {% endnote %}

          * `object_storage`: Uploading logs to a {{ objstorage-full-name }} [bucket](../../storage/concepts/bucket.md#naming):

              * `bucket_id`: [Name](../../storage/concepts/bucket.md#naming) of the bucket you created [earlier](#before-you-begin).

                  You can request the name of the bucket with the list of buckets in the folder (the default folder is used):

                  ```bash
                  yc storage bucket list
                  ```

              * `object_prefix`: [Prefix](../../storage/concepts/object.md#folder) that will be assigned to the objects with audit logs in the bucket. It is an optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.

                  {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

          * `cloud_logging`: Uploading logs to a {{ cloud-logging-full-name }} [group](../../logging/concepts/log-group.md).

              In the `log_group_id` parameter, specify the ID of the log group you [created earlier](#before-you-begin). You can request the ID with the [list of log groups in the folder](../../logging/operations/list.md).
          * `data_stream`: Uploading logs to a [data stream](../../data-streams/concepts/glossary.md#stream-concepts) in {{ yds-full-name }}:

              * `stream_name`: Name of the data stream you [created earlier](#before-you-begin). You can request the name with the [list of data streams in the folder](../../data-streams/operations/manage-streams.md#list-data-streams).
              * `database_id`: ID of the {{ ydb-short-name }} database used by {{ yds-name }}. You can request the ID with the [list of {{ ydb-short-name }} databases in the folder](../../ydb/operations/manage-databases.md#list-db).
      * `service_account_id`: [ID](../../iam/operations/sa/get-id.md) of the service account you created [earlier](#before-you-begin).

      {% include [trail-create-cli-yaml-desc-filtering](../../_includes/audit-trails/trail-create-cli-yaml-desc-filtering.md) %}

  1. Run this command:

      ```bash
      yc audit-trails trail create --file <file_path>
      ```

  {% endcut %}

  {% cut "In the command arguments:" %}

  Use this method if your trail configuration is simple and contains few parameters.

  {% note info %}

  You can only customize the registration of [data events](../concepts/control-plane-vs-data-plane.md#data-plane-events) using the YAML specification.

  {% endnote %}

  Run this command:

  ```bash
  yc audit-trails trail create \
    --name <trail_name> \
    --description <trail_description> \
    --labels <label_list> \
    --service-account-id <service_account_ID> \
    --destination-bucket <bucket_name> \
    --destination-bucket-object-prefix <prefix_for_objects> \
    --destination-log-group-id <log_group_ID> \
    --destination-yds-stream <YDS_name> \
    --destination-yds-database-id <YDS_database_ID> \
    --filter-all-folder-id <folder_ID> \
    --filter-all-cloud-id <cloud_ID> \
    --filter-all-organisation-id <organization_ID> \
    --filter-some-folder-ids <cloud_folder_list> \
    --filter-from-cloud-id <cloud_ID_with_selected_folders> \
    --filter-some-cloud-ids <list_of_clouds_in_organization> \
    --filter-from-organisation-id <organization_ID_with_selected_clouds>
    ```

    Where:
    * `--name`: Name of the new trail.

    {% include [trail-cli-flag-desc](../../_includes/audit-trails/trail-cli-flag-desc.md) %}

  {% endcut %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the parameters of the trail to collect audit logs:

      {% include [trail-tf-manifest](../../_includes/audit-trails/trail-tf-manifest.md) %}

      Where:

      {% include [trail-create-tf-descs_part1](../../_includes/audit-trails/trail-create-tf-descs-part1.md) %}

      {% include [trail-create-tf-descs_logging](../../_includes/audit-trails/trail-create-tf-descs-logging.md) %}

      {% include [trail-create-tf-descs_part2](../../_includes/audit-trails/trail-create-tf-descs-part2.md) %}

      For more information about the `yandex_audit_trails_trail` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/audit_trails_trail).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

     ```bash
     yc audit-trails trail get <trail_name>
     ```

- API {#api}

  Use the [create](../api-ref/Trail/create.md) REST API method for the [Trail](../api-ref/Trail/index.md) resource or the [TrailService/Create](../api-ref/grpc/Trail/create.md) gRPC API call.

{% endlist %}

The trail will be created and start uploading audit logs to the selected destination object.

{% include [logging-dublicate-events](../../_includes/audit-trails/logging-dublicate-events.md) %}

## Examples {#examples}

### Creating a trail with management and data event filters{#example-control-data-planes}

Create a trail with the following parameters:

* `sample-trail-all-planes`: Trail name.
* `folder0***`: ID of the folder the trail will reside in.
* Destination object: {{ objstorage-name }} bucket named `sample-logs-bucket`.
* The service account for the trail is the account with the `service0***` ID.
* Management event filter settings:

    The log collection scope is the organization with the ID `org1***`. Logs will be collected from all clouds that belong to this organization.

* Data event filter settings:

    * For [{{ mpg-name }}](../../managed-postgresql/), logs will be collected from the cloud with the ID `cloud1***` and the folder with the ID `folder1***`.

        All the [events](../concepts/events-data-plane.md#mpg) of the service will be collected except for the following:

        * `yandex.cloud.audit.mdb.postgresql.CreateDatabase`
        * `yandex.cloud.audit.mdb.postgresql.UpdateDatabase`

    * For [{{ objstorage-name }}](../../storage/), logs will be collected from the clouds with the IDs `cloud2***` and `cloud3***`.

        Only the following [events](../concepts/events-data-plane.md#objstorage) will be collected:

        * `yandex.cloud.audit.storage.ObjectCreate`
        * `yandex.cloud.audit.storage.ObjectUpdate`
        * `yandex.cloud.audit.storage.ObjectDelete`

    * For [{{ compute-name }}](../../compute/), logs will be collected from the folders with the IDs `folder2***` and `folder3***`.

        All [service events](../concepts/events-data-plane.md#compute) of the service will be collected.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Create a YAML named `sample-trail-all-planes.yaml` with the trail configuration.

      {% cut "sample-trail-all-planes.yaml" %}

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
          - service: storage
            resource_scopes:
              - id: cloud2***
                type: resource-manager.cloud
              - id: cloud3***
                type: resource-manager.cloud
            included_events:
              event_types:
                - yandex.cloud.audit.storage.ObjectCreate
                - yandex.cloud.audit.storage.ObjectUpdate
                - yandex.cloud.audit.storage.ObjectDelete
          - service: compute
            resource_scopes:
              - id: folder2***
                type: resource-manager.folder
              - id: folder3***
                type: resource-manager.folder
      ```

      {% endcut %}

  1. Run this command:

      ```bash
      yc audit-trails trail create --file sample-trail-all-planes.yaml
      ```

  A trail will be created with the specified parameters.

- {{ TF }} {#tf}

  1. In the {{ TF }} configuration file, describe the parameters of the trail you want to create:

      ```hcl
      resource "yandex_audit_trails_trail" "basic_trail" {
        name               = "sample-trail-all-planes"
        folder_id          = "folder0***"
        service_account_id = "service0***"

        storage_destination {
          bucket_name  = "sample-logs-bucket"
        }

        filtering_policy {
          management_events_filter {
            resource_scope {
              resource_id   = "org1***"
              resource_type = "resource-manager.organization"
            }
          }  
          data_events_filter {
            service = "mdb.postgresql"
            excluded_events = ["yandex.cloud.audit.mdb.postgresql.CreateDatabase","yandex.cloud.audit.mdb.postgresql.UpdateDatabase"]
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
            service = "storage"
            resource_scope {
              resource_id   = "cloud2***"
              resource_type = "resource-manager.cloud"
            }
            resource_scope {
              resource_id   = "cloud3***"
              resource_type = "resource-manager.cloud"
            }
          }
          data_events_filter {
            service = "compute"
            resource_scope {
              resource_id   = "folder2***"
              resource_type = "resource-manager.folder"
            }
            resource_scope {
              resource_id   = "folder3***"
              resource_type = "resource-manager.folder"
            }
          }
        }
      }
     ```

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      A trail will be created with the specified parameters. You can check the new trail using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

      ```bash
      yc audit-trails trail get sample-trail-all-planes
      ```

- API {#api}

  Use the [create](../api-ref/Trail/create.md) REST API method for the [Trail](../api-ref/Trail/index.md) resource.

  {% include [curl](../../_includes/curl.md) %}

  {% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

  1. [Get](../../iam/operations/index.md#authentication) an IAM token for [authentication](../api-ref/authentication.md) with the API.

  1. Save the token to a variable and run this command in the terminal:

      ```bash
      export IAM_TOKEN=<IAM_token>
      ```

  1. Create a file named `body.json` with the following request body and a description of the new trail:

      ```json
      {
        "folderId": "folder0**",
        "name": "sample-trail-all-planes",
        "description": "sample-trail",
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
                "type": "resource-manager.organization"
              }
            ]
          },
          "dataEventsFilters": [
            {
              "service": "mdb.postgresql",
              "excludedEvents": {
                "eventTypes": [
                  "yandex.cloud.audit.mdb.postgresql.CreateDatabase"
                  ,"yandex.cloud.audit.mdb.postgresql.UpdateDatabase"
                ]
              },
              "resourceScopes": [
                {
                  "id": "cloud1***",
                  "type": "resource-manager.cloud"
                },
                {
                  "id": "folder1***",
                  "type": "resource-manager.folder"
                }
              ]
            },
            {
              "service": "storage",
              "resourceScopes": [
                {
                  "id": "cloud2**",
                  "type": "resource-manager.cloud"
                },
                {
                  "id": "cloud3**",
                  "type": "resource-manager.cloud"
                }
              ]
            },
            {
              "service": "compute",
              "resourceScopes": [
                {
                  "id": "folder2**",
                  "type": "resource-manager.folder"
                },
                {
                  "id": "folder3**",
                  "type": "resource-manager.folder"
                }
              ]
            }
          ]
        }
      }
      ```

  1. Run this request in your terminal:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data "@<request_body_file>" \
        https://audittrails.api.cloud.yandex.net/audit-trails/v1/trails
      ```

      Where:
      * `<request_body_file>`: Path to the previously created request body file (`body.json`).

      Result:

      ```json
      {
      "done": true,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.audittrails.v1.CreateTrailMetadata",
        "trailId": "cnpvprd5pa66********"
      },
      "id": "cnp9qb9g8ldb********",
      "description": "operation_create",
      "createdAt": "2025-02-20T07:06:18.547321903Z",
      "createdBy": "ajevfb0tjfts********",
      "modifiedAt": "2025-02-20T07:06:18.547321903Z"
      }
      ```

{% endlist %}


## What's next {#whats-next}

* Learn more about the [audit log format](../concepts/format.md).
* Find out about the procedure for [uploading audit logs to SIEM](../concepts/export-siem.md).
* Learn how to [search for events in audit logs](../tutorials/search-events-audit-logs/index.md).
