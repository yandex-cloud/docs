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

            This role is only required if encryption was enabled for the bucket.

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

        * `yds.writer` for a data stream.

        {% include [at-viewer-role-scope](../../_includes/audit-trails/create-trail/at-viewer-role-scope.md) %}

    1. {% include [required-account-roles](../../_includes/audit-trails/create-trail/required-account-roles.md) %}

{% endlist %}

## Creating a trail {#create}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder to host the trail.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
    1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
    1. Enter a name for the trail. It must be unique within the folder.
    1. (Optional) Enter a description for the trail.
    1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, select one of the destination objects and specify its settings:

        * **{{ ui-key.yacloud.audit-trails.label_objectStorage }}**: Uploading audit logs to the {{ objstorage-name }} bucket:

            * **{{ ui-key.yacloud.audit-trails.label_bucket }}**: Name of the bucket you [created earlier](#before-you-begin).
            * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}**: [Prefix](../concepts/format.md#log-file-name) that will be assigned to the objects with audit logs in the bucket. It is an optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.

                {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

            * **{{ ui-key.yacloud.audit-trails.title_kms-key }}**: Bucket encryption key. You only need to select it if encryption was enabled for the bucket.

        * **{{ ui-key.yacloud.audit-trails.label_cloudLogging }}**: Specify the name of the log group you [created earlier](#before-you-begin). Audit logs will be uploaded into this log group.

        * **{{ ui-key.yacloud.audit-trails.label_dataStream }}**: Specify the name of the data stream you [created earlier](#before-you-begin). Audit logs will be uploaded into this stream.

    1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select the [previously created](#before-you-begin) service account the trail will use to operate.

    1. Enable and configure collection of events from one or two levels. Such events will get into the audit logs.

        To configure **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**:

        1. Select the [log collection scope](../concepts/trail.md): `Organization`, `Cloud`, or `Folder`. The events that end up in the logs will belong to the specified scope.

            The permissions of the service account you [created earlier](before-you-begin) must allow collecting logs from the specified scope.

        1. Depending on the selected log collection scope, select specific clouds or folders to collect events from:

            * For the `Organization` collection scope, from the **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** drop-down list, select one or more clouds to collect events from.

                Keep the default value (`{{ ui-key.yacloud.common.all }}`) to collect events from all clouds in the organization.

            * For the `Cloud` collection scope, from the **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** drop-down list, select one or more folders to collect events from.

                Keep the default value (`{{ ui-key.yacloud.common.all }}`) to collect events from all folders in the cloud.

        To configure **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}**:

        1. Select one or more services to collect events from.

        1. For each such service, select the [log collection scope](../concepts/trail.md): `Organization`, `Cloud`, or `Folder`. The events that end up in the logs will belong to the specified scope.

            The permissions of the service account you [created earlier](before-you-begin) must allow collecting logs from the specified scope.

        1. Depending on the selected log collection scope, select specific clouds or folders to collect events from:

            * For the `Organization` collection scope, from the **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** drop-down list, select one or more clouds to collect events from.

                Keep the default value (`{{ ui-key.yacloud.common.all }}`) to collect events from all clouds in the organization.

            * For the `Cloud` collection scope, from the **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** drop-down list, select one or more folders to collect events from.

                Keep the default value (`{{ ui-key.yacloud.common.all }}`) to collect events from all folders in the cloud.

        1. For each such service, select one of the following [event](../concepts/events-data-plane.md#dns) filters:

            * `Receive all`: To collect all events within the service.
            * `Selected`: To collect only selected events. Proceed to select the events.
            * `Exclude`: To collect all events except for the selected ones. Proceed to select the events.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    You can create a trail in two ways:

    * Create a YAML file containing your trail parameters and provide this file to the command to create the trail.

        This method simplifies working with trail parameters and reduces the probability of error.

    * Provide the trail parameters in the command arguments to create the trail.

        See the description of the [CLI](../../cli/) trail create command for details about the arguments you can use:

        ```bash
        yc audit-trails trail create --help
        ```

        {% note tip %}

        Use this method if your trail configuration is simple and contains few parameters.

        {% endnote %}

    To create a trail using a YAML file:

    1. Create a YAML file with the trail configuration:

        ```yaml
        name: <trail_name>
        folder_id: <folder_ID>
        destination:
          # Only one destination must be specified:
          # object_storage, cloud_logging, data_stream
          # Settings for all destinations are provided for illustration purposes
          object_storage:
            bucket_id: <bucket_name>
            object_prefix: <prefix_for_objects>
          cloud_logging:
            log_group_id: <log_group_ID>
          data_stream:
            stream_name: <YDS_name>
            database_id: <YDS_database_ID>
        service_account_id: <service_account_ID>
        filtering_policy:
          management_events_filter:
            resource_scopes:
              - id: <cloud_or_folder_organization_ID>
                type: <type>
          data_events_filters:
            - service: <service_name>
              resource_scopes:
                - id: <cloud_or_folder_organization_ID>
                  type: <type>
              # You can specify included_events, excluded_events, 
              # or neither of the two to collect all the events of the service.
              # Both parameters are provided for illustration purposes.
              included_events:
                event_types:
                  - <these_events_will_be_collected>
              excluded_events:
                event_types:
                  - <these_events_will_not_be_collected>
        ```

        Where:

        * `name`: Trail name. It must be unique within the folder.
        * `folder_id`: ID of the folder the trail will reside in.
        * `destination`: Settings of the selected destination the audit logs will be uploaded to.

            {% note warning %}

            Destination settings are mutually exclusive. Using some settings makes it impossible to use others.

            {% endnote %}

            * `object_storage`: Uploading logs to the {{ objstorage-name }} bucket:

                * `bucket_id`: Name of the bucket you [created earlier](#before-you-begin).

                    You can request the name of the bucket with the list of buckets in the folder (the default folder is used):

                    ```bash
                    yc storage bucket list
                    ```

                * `object_prefix`: [Prefix](../../storage/concepts/object.md#folder) that will be assigned to the objects with audit logs in the bucket. It is an optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.

                    {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

            * `cloud_logging`: Upload logs to a {{ cloud-logging-name }} group.

                In the `log_group_id` parameter, specify the ID of the log group you [created earlier](#before-you-begin). You can request the ID with the [list of log groups in the folder](../../logging/operations/list.md).

            * `data_stream`: Upload logs to a {{ yds-name }} data stream:

                * `stream_name`: Name of the data stream you [created earlier](#before-you-begin). You can request the name with the [list of data streams in the folder](../../data-streams/operations/manage-streams.md#list-data-streams).

                * `database_id`: ID of the {{ ydb-short-name }} database used by {{ yds-name }}. You can request the ID with the [list of {{ ydb-short-name }} databases in the folder](../../ydb/operations/manage-databases.md#list-db).

        * `service_account_id`: ID of the service account you [created earlier](#before-you-begin).

        * `filtering_policy`: The settings of the filtering policy that determines which events to collect and include in the audit logs. The policy consists of filters pertaining to different levels of events.

            {% note warning %}

            You must configure at least one filter for the policy; otherwise, you will not be able to create a trail.

            {% endnote %}

            Available filters:

            * `management_events_filter`: Management event filter.

                {#filter-cli}

                Specify the [log collection scope](../concepts/trail.md) in the `resource_scopes` parameter:

                * `id`: Organization, cloud, or folder ID.
                * `type`: Scope type according to the specified ID:

                    * `organization-manager.organization`: Organization
                    * `resource-manager.cloud`: Cloud
                    * `resource-manager.folder`: Folder

                You can combine several scopes belonging to the same organization in one `resource_scopes` parameter. For example, to collect logs from one entire cloud and only from particular folders in another cloud:

                ```yaml
                resource_scopes:
                  # Collecting logs from entire Cloud 1
                  - id: <ID_of_cloud_1>
                    type: resource-manager.cloud
                  # Collecting logs from Folder 1 of Cloud 2
                  - id: <folder_1_ID>
                    type: resource-manager.folder
                  # Collecting logs from Folder 2 of Cloud 2
                  - id: <folder_2_ID>
                    type: resource-manager.folder
                ```

                Service account permissions must allow collecting logs from the specified scopes.

            * `data_events_filters`: Data event filters. You can configure several filters of this type: one for each service.

                A filter for one service has the following structure:

                * `service`: Service name. You can get it from the [data event reference](../concepts/events-data-plane.md).

                * `resource_scopes`: Places to collect data events from. You can configure this parameter the same way as the management event filter.

                * `*_events`: Data event filters.

                    * `included_events.event_types`: Collect only specified events.
                    * `excluded_events.event_types`: Collect all events other than the specified ones.

                    You can get a list of events from the [data event reference](../concepts/events-data-plane.md).

                    {% note warning %}

                    These filters are mutually exclusive:

                    * Either configure `included_events` 
                    * or `excluded_events`

                    If you configure neither, all events will be collected.

                    {% endnote %}

    1. Run this command:

        ```bash
        yc audit-trails trail create --file <path_to_file>
        ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the parameters of the trail to collect audit logs:

      ```hcl
      resource "yandex_audit_trails_trail" "basic_trail" {
        name = "<trail_name>"
        folder_id   = "<folder_ID>"
        description = "<trail_description>"
        
        labels = {
          key = "value"
        }
        
        service_account_id = "<service_account_ID>"
        
        logging_destination {
          log_group_id = "<log_group_ID>"
        }
        
        filter {
          path_filter {
            some_filter {
              resource_id   = "<organization_ID>"
              resource_type = "<parent_resource_type>"
              any_filters {
                  resource_id   = "<ID_of_cloud_1>"
                  resource_type = "<child_resource_type>"
              }
              any_filters {
                  resource_id   = "<ID_of_cloud_2>"
                  resource_type = "<child_resource_type>"
              }
            }
          }
          event_filters {
            service = "<ID_of_service_1>"
            categories {
              plane = "DATA_PLANE"
              type  = "<action_type>"
            }
            path_filter {
              any_filter {
                resource_id = "<organization_ID>"
                resource_type = "<resource_type>"
              }
            }
          }
          event_filters {
            service = "<ID_of_service_2>"
            categories {
              plane = "DATA_PLANE"
              type  = "<action_type>"
            }
            path_filter {
              any_filter {
                resource_id = "<organization_ID>"
                resource_type = "<resource_type>"
              }
            }
          }
        }
      }
      ```

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
* `service0***`: ID of the service account for the trail.
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

{% endlist %}

## What's next {#whats-next}

* Learn more about the [audit log format](../concepts/format.md).
* Find out about the procedure for [uploading audit logs to SIEM](../concepts/export-siem.md).
* Learn more about [searching audit logs in buckets](../tutorials/search-bucket.md).
