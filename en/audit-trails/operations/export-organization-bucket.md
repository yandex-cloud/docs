# Uploading organization audit logs to {{ objstorage-name }}

Follow this guide to create a new [trail](../concepts/trail.md) that will upload management event audit logs of all resources and, optionally, data event audit logs of selected services of an organization to an {{ objstorage-name }} bucket.

{% include [bucket-encryption-tip](../../_includes/audit-trails/bucket-encryption-tip.md) %}

## Prepare the environment {#before-you-begin}

To collect organization audit logs:

1. [Create a new bucket](../../storage/operations/buckets/create.md) with restricted access to upload audit logs to.
1. [Create](../../iam/operations/sa/create.md) a service account.

1. {% include [add-roles-to-sa](../../_includes/audit-trails/add-roles-to-sa.md) %}

1. On the [Access bindings]({{ link-console-access-management }}) page, make sure you have the following roles:
   * `iam.serviceAccounts.user` for the service account.
   * `audit-trails.editor` for the folder to host the trail.
   * `audit-trails.viewer` for the organization whose audit logs will be collected.
   * `kms.editor` for the folder where the bucket encryption key will be created.
   * `storage.viewer` for the bucket or folder.

{% include [bucket-encryption-section](../../_includes/audit-trails/bucket-encryption-section.md) %}

## Creating a trail {#the-trail-creation}

To create your first trail in {{ at-name }} and start the audit log management process:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to host the trail.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}** and specify:

      * **{{ ui-key.yacloud.common.name }}**: Name of the new trail.
      * **{{ ui-key.yacloud.common.description }}**: Trail description (optional).

  1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, configure the destination object:

      * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
      * **{{ ui-key.yacloud.audit-trails.label_bucket }}**: Name of the [bucket](../../storage/operations/buckets/create.md) to which you want to upload audit logs.
      * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}**: Optional parameter used in the [full name](../concepts/format.md#log-file-name) of the audit log file.

      {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}
      * **{{ ui-key.yacloud.audit-trails.title_kms-key }}**: If the bucket you selected is [encrypted](../../storage/concepts/encryption.md), specify the encryption key.

  1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select the service account that the trail will use to upload audit log files to the bucket.

  1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, configure the collection of management event audit logs:

      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}**: Select `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Select `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`.
      * **{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}**: Automatically populated field containing the name of the current organization.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}**: Keep the default value, `{{ ui-key.yacloud.common.all }}`.

  1. {% include [data-plane-on-console](../../_includes/audit-trails/data-plane-on-console.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the [CLI](../../cli/) command for creating a trail:

      ```bash
      yc audit-trails trail create --help
      ```

   1. Run the command to create a trail to collect [management event](../concepts/format.md) audit logs in the organization:

      ```bash
      yc audit-trails trail create \
        --name <trail_name> \
        --description "<trail_description>" \
        --service-account-id <service_account_ID> \
        --destination-bucket <bucket_name> \
        --destination-bucket-object-prefix <bucket_prefix> \
        --filter-from-organisation-id <organization_ID> \
        --filter-some-cloud-ids <list_of_clouds_in_the_organization>
      ```

      Where:

      {% include [trail-create-cli-descs_part1](../../_includes/audit-trails/trail-create-cli-descs-part1.md) %}

      {% include [trail-create-cli-descs_storage](../../_includes/audit-trails/trail-create-cli-descs-storage.md) %}

      {% include [trail-create-cli-descs_org](../../_includes/audit-trails/trail-create-cli-descs-org.md) %}

      {% cut "Result:" %}

      ```yml
      done (1s)
      id: cnpe0gldjeq0********
      folder_id: b1g9d2k0itu4********
      created_at: "2024-03-31T16:54:56.187Z"
      updated_at: "2024-03-31T16:54:56.187Z"
      name: sample-trail
      description: My very first trail
      destination:
        object_storage:
          bucket_id: at-destination-bucket
          object_prefix: sample-trail-audit-logs
      service_account_id: ajeee339l4m5********
      status: ACTIVE
      filter:
        path_filter:
          root:
            some_filter:
              resource:
                id: bpfaidqca8vd********
                type: organization-manager.organization
              filters:
                - any_filter:
                    resource:
                      id: b1glti4eser3********
                      type: resource-manager.cloud
                - any_filter:
                    resource:
                      id: b1gssd27h7ra********
                      type: resource-manager.cloud
        event_filter: {}
      cloud_id: b1glti4eser3********
      ```

      {% endcut %}

   1. To create a trail to collect management event and [data event](../concepts/format-data-plane.md) audit logs, use the trail's YAML specification file.

      1. Create a trail configuration file, e.g., `specification.yaml`:

         {% cut "specification.yaml" %}

         {% include [cli-spec-org-storage](../../_includes/audit-trails/cli-spec-org-storage.md) %}

         {% endcut %}

         {% cut "Specification description" %}

         {% include [trail-create-clispec-descs-part1](../../_includes/audit-trails/trail-create-clispec-descs-part1.md) %}

         {% include [trail-create-clispec-descs-storage](../../_includes/audit-trails/trail-create-clispec-descs-storage.md) %}

         {% include [trail-create-clispec-descs-part2](../../_includes/audit-trails/trail-create-clispec-descs-part2.md) %}

         {% endcut %}

      1. Run the command, specifying the path to the created trail specification file:

         ```bash
         yc audit-trails trail create --file <specification_file_path>
         ```

         {% cut "Result" %}

         ```yml
         done (1s)
         id: cnprh3etohtn********
         folder_id: b1g9d2k0itu4********
         created_at: "2024-04-02T02:14:53.047Z"
         updated_at: "2024-04-02T02:14:53.047Z"
         name: sample-trail
         description: My very first trail
         destination:
           object_storage:
             bucket_id: at-destination-bucket
             object_prefix: sample-trail-audit-logs
         service_account_id: ajeee339l4m5********
         status: ACTIVE
         filter:
           path_filter:
             root:
               some_filter:
                 resource:
                   id: bpfaidqca8vd********
                   type: organization-manager.organization
                 filters:
                   - any_filter:
                       resource:
                         id: b1glti4eser3********
                         type: resource-manager.cloud
                   - any_filter:
                       resource:
                         id: b1gssd27h7ra********
                         type: resource-manager.cloud
           event_filter:
             filters:
               - service: mdb.postgresql
                 categories:
                   - plane: DATA_PLANE
                     type: WRITE
                 path_filter:
                   root:
                     any_filter:
                       resource:
                         id: bpfaidqca8vd********
                         type: organization-manager.organization
               - service: kms
                 categories:
                   - plane: DATA_PLANE
                     type: READ
                 path_filter:
                   root:
                     some_filter:
                       resource:
                         id: bpfaidqca8vd********
                         type: organization-manager.organization
                       filters:
                         - any_filter:
                             resource:
                               id: b1glti4eser3********
                               type: resource-manager.cloud
                         - any_filter:
                             resource:
                               id: b1gssd27h7ra********
                               type: resource-manager.cloud
         cloud_id: b1glti4eser3********
         ```

         {% endcut %}

      For more information about the `yc audit-trails trail create` command, see the [CLI reference](../../cli/cli-ref/managed-services/audit-trails/trail/create.md).

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the trail that will collect audit events of the organization's resources:

      ```hcl
      resource "yandex_audit_trails_trail" "basic_trail" {
        name = "<trail_name>"
        folder_id   = "<folder_ID>"
        description = "<trail_description>"

        labels = {
          key = "value"
        }

        service_account_id = "<service_account_ID>"

        storage_destination {
          bucket_name   = "<bucket_name>"
          object_prefix = "<bucket_prefix>"
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

      {% include [trail-create-tf-descs_storage](../../_includes/audit-trails/trail-create-tf-descs-storage.md) %}

      {% include [trail-create-tf-descs_part2](../../_includes/audit-trails/trail-create-tf-descs-part2.md) %}

      For more information about the parameters of the `yandex_audit_trails_trail` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/audit_trails_trail).

   1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

      ```bash
      yc audit-trails trail get <trail_name>
      ```

- API {#api}

   Use the [create](../api-ref/Trail/create.md) REST API method for the [Trail](../api-ref/Trail/index.md) resource or the [TrailService/Create](../api-ref/grpc/Trail/create.md) gRPC API call.

{% endlist %}


## What's next {#whats-next}

* Learn more about the [audit log format](../concepts/format.md).
* Find out about the procedure for [uploading audit logs to SIEM](../concepts/export-siem.md).
* Learn more about [searching audit logs in buckets](../tutorials/search-bucket.md).