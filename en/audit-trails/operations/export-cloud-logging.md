# Uploading cloud audit logs to {{ cloud-logging-name }}

Follow this guide to create a new [trail](../concepts/trail.md) that will upload management event audit logs of all resources and, optionally, data event audit logs of selected services of an individual cloud to a {{ cloud-logging-name }} log group.


## Prepare the environment {#before-you-begin}

To export audit logs of a cloud:

1. [Create](../../logging/operations/create-group.md) a log group to upload audit logs to.
1. [Create](../../iam/operations/sa/create.md) a service account.
1. Assign roles to the service account:

   {% list tabs group=instructions %}

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      * [`audit-trails.viewer`](../security/index.md#roles-list) for the cloud whose audit logs will be collected.

         ```
         yc resource-manager cloud add-access-binding \
           --role audit-trails.viewer \
           --id <cloud_ID> \
           --service-account-id <service_account_ID>
         ```

         Where:

         * `--role`: Role being assigned.
         * `--id`: [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) whose audit logs will be collected.
         * `--service-account-id`: Service account ID.

      * [`logging.writer`](../../logging/security/index.md#roles-list) for the folder to host the trail:

         ```
         yc resource-manager folder add-access-binding \
           --role logging.writer \
           --id <folder_ID> \
           --service-account-id <service_account_ID>
         ```

         Where:

         * `--role`: Role being assigned.
         * `--id`: ID of the folder to host the trail.
         * `--service-account-id`: Service account ID.

   {% endlist %}

1. On the [Access bindings]({{ link-console-access-management }}) page, make sure you have the following roles:
   * `iam.serviceAccounts.user` for the service account.
   * `audit-trails.editor` for the folder to host the trail.
   * `audit-trails.viewer` for the cloud whose audit logs will be collected.
   * `logging.viewer` for a log group in {{ cloud-logging-name }}.


## Create a trail {#the-trail-creation}

To create a trail that exports audit logs from the cloud:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to host the trail.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
   1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}** and specify:

      * **{{ ui-key.yacloud.common.name }}**: Name of the trail being created.
      * **{{ ui-key.yacloud.common.description }}**: Description of the trail (optional).

   1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, set up the destination object:

      * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_cloudLogging }}`.
      * **{{ ui-key.yacloud.logging.label_loggroup }}**: Select a log group. You can also create a new log group. For this:

         * Click **{{ ui-key.yacloud.common.label_create-new_female }}**, then specify the parameters of the log group:

            * **{{ ui-key.yacloud.common.name }}**: Name of the group being created
            * **{{ ui-key.yacloud.common.description }}**: Description of the log group (optional)
            * **{{ ui-key.yacloud.logging.label_retention-period }}**.

         * Click **{{ ui-key.yacloud.logging.button_create-group }}**.

   1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select the service account that the trail will use to upload audit log files to the log group.

   1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, set up the collection of management event audit logs:

      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}**: Select `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Select `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}**: Automatically populated field showing the name of the cloud to host the trail.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}**: Keep the default value, `{{ ui-key.yacloud.common.all }}`.

   1. {% include [data-plane-on-console](../../_includes/audit-trails/data-plane-on-console.md) %}

   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the [CLI](../../cli/) command for creating a trail:

      ```bash
      yc audit-trails trail create --help
      ```

   1. Run the command to create a trail to collect [management event](../concepts/format.md) audit logs in the cloud:

      ```bash
      yc audit-trails trail create \
        --name <trail_name> \
        --description "<trail_description>" \
        --service-account-id <service_account_ID> \
        --destination-log-group-id <log_group_ID> \
        --filter-from-cloud-id <cloud_ID> \
        --filter-some-folder-ids <list_of_folders_in_the_cloud>
      ```

      Where:

      {% include [trail-create-cli-descs_part1](../../_includes/audit-trails/trail-create-cli-descs-part1.md) %}

      {% include [trail-create-cli-descs_logging](../../_includes/audit-trails/trail-create-cli-descs-logging.md) %}

      {% include [trail-create-cli-descs_cloud](../../_includes/audit-trails/trail-create-cli-descs-cloud.md) %}


      {% cut "Result:" %}

      ```yml
      done (1s)
      id: cnp0sprpubl0********
      folder_id: b1g9d2k0itu4********
      created_at: "2024-04-01T09:56:07.858Z"
      updated_at: "2024-04-01T09:56:07.858Z"
      name: sample-trail
      description: My very first trail
      destination:
        cloud_logging:
          log_group_id: e23fvhkglsac********
      service_account_id: ajeee339l4m5********
      status: ACTIVE
      filter:
        path_filter:
          root:
            some_filter:
              resource:
                id: b1glti4eser3********
                type: resource-manager.cloud
              filters:
                - any_filter:
                    resource:
                      id: b1g9d2k0itu4********
                      type: resource-manager.folder
                - any_filter:
                    resource:
                      id: b1gp73knqj0u********
                      type: resource-manager.folder
        event_filter: {}
      cloud_id: b1glti4eser3********
      ```

      {% endcut %}

   1. To create a trail for collecting management event and [data event](../concepts/format-data-plane.md) audit logs, use the trail YAML specification file.

      1. Create a trail configuration file, e.g., `specification.yaml`:

         {% cut "specification.yaml" %}

         {% include [cli-spec-cloud-logging](../../_includes/audit-trails/cli-spec-cloud-logging.md) %}

         {% endcut %}

         {% cut "Specification description" %}

         {% include [trail-create-clispec-descs-part1](../../_includes/audit-trails/trail-create-clispec-descs-part1.md) %}

         {% include [trail-create-clispec-descs-logging](../../_includes/audit-trails/trail-create-clispec-descs-logging.md) %}

         {% include [trail-create-clispec-descs-part2](../../_includes/audit-trails/trail-create-clispec-descs-part2.md) %}

         {% endcut %}

      1. Run the command, specifying the path to the created trail specification file:

         ```bash
         yc audit-trails trail create --file <specification_file_path>
         ```

         {% cut "Result" %}

         ```yml
         done (1s)
         id: cnp57t5l3hd5********
         folder_id: b1g9d2k0itu4********
         created_at: "2024-04-02T03:54:37.362Z"
         updated_at: "2024-04-02T03:54:37.362Z"
         name: sample-trail
         description: My very first trail
         destination:
           cloud_logging:
             log_group_id: e232pqboot3f********
         service_account_id: ajeee339l4m5********
         status: ACTIVE
         filter:
           path_filter:
             root:
               some_filter:
                 resource:
                   id: b1glti4eser3********
                   type: resource-manager.cloud
                 filters:
                   - any_filter:
                       resource:
                         id: b1g9d2k0itu4********
                         type: resource-manager.folder
                   - any_filter:
                       resource:
                         id: b1gp73knqj0u********
                         type: resource-manager.folder
           event_filter:
             filters:
               - service: mdb.postgresql
                 categories:
                   - plane: DATA_PLANE
                     type: WRITE
                 path_filter:
                   root:
                     some_filter:
                       resource:
                         id: b1glti4eser3********
                         type: resource-manager.cloud
                       filters:
                         - any_filter:
                             resource:
                               id: b1g9d2k0itu4********
                               type: resource-manager.folder
                         - any_filter:
                             resource:
                               id: b1gp73knqj0u********
                               type: resource-manager.folder
               - service: dns
                 categories:
                   - plane: DATA_PLANE
                     type: READ
                 path_filter:
                   root:
                     any_filter:
                       resource:
                         id: b1glti4eser3********
                         type: resource-manager.cloud
         cloud_id: b1glti4eser3********
         ```

         {% endcut %}

      For more information about the `yc audit-trails trail create` command, see the [CLI reference](../../cli/cli-ref/managed-services/audit-trails/trail/create.md).

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the trail that will collect audit events of the cloud resources:

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
                  resource_id   = "<cloud_1_ID>"
                  resource_type = "<child_resource_type>"
              }
              any_filters {
                  resource_id   = "<cloud_2_ID>"
                  resource_type = "<child_resource_type>"
              }
            }
          }
          event_filters {
            service = "<service_1_ID>"
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
            service = "<service_2_ID>"
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

      For more information about the parameters of the `yandex_audit_trails_trail` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/audit_trails_trail).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

      ```bash
      yc audit-trails trail get <trail_name>
      ```

- API {#api}

   Use the [create](../api-ref/Trail/create.md) REST API method for the [Trail](../api-ref/Trail/index.md) resource or the [TrailService/Create](../api-ref/grpc/trail_service.md#Create) gRPC API call.

{% endlist %}

The trail will be created and will start uploading audit logs to the log group.

## What's next {#whats-next}

* Learn more about the [audit log format](../concepts/format.md).
* Find out about the procedure for [uploading audit logs to SIEM](../concepts/export-siem.md).
* Learn more about [searching audit logs in buckets](../tutorials/search-bucket.md).
