# Getting started with {{ at-name }}

{{ at-name }} collects [audit logs](./concepts/format.md) from {{ yandex-cloud }} resources and uploads them to an {{ objstorage-name }} bucket, a {{ cloud-logging-name }} log group, or a {{ yds-name }} data stream.

Within {{ at-name }}, audit logs are managed by [trails](./concepts/trail.md).

Follow this guide to create a new trail that will upload audit logs of your organization resources to an {{ objstorage-name }} bucket.

{% include [bucket-encryption-tip](../_includes/audit-trails/bucket-encryption-tip.md) %}

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and sign in to {{ yandex-cloud }} or sign up if you are not signed up yet.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not yet have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. Make sure your cloud has a bucket where you can store audit logs. [Create a new bucket](../storage/quickstart.md#the-first-bucket) with restricted access, if required.

1. {% include [add-roles-to-sa](../_includes/audit-trails/add-roles-to-sa.md) %}

1. On the [Access management]({{ link-console-access-management }}) page, make sure you have the following roles:
   * `iam.serviceAccounts.user` for the service account.
   * `audit-trails.editor` for the folder to host the trail.
   * `audit-trails.viewer` for the organization whose audit logs will be collected.
   * `kms.editor` for the folder where the bucket encryption key will be created.
   * `storage.viewer` for the bucket or folder.

{% include [bucket-encryption-section](../_includes/audit-trails/bucket-encryption-section.md) %}

## Creating a trail {#the-trail-creation}

{% include [note-lose-target-when-switch-trail](../_includes/audit-trails/note-lose-target-when-switch-trail.md) %}

To create your first trail in {{ at-name }} and start the process of management event audit log management:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to host the trail.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
   1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
   1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the trail.
   1. In the **{{ ui-key.yacloud.common.description }}** field, enter the trail description (optional).
   1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, configure the destination object:

      * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
      * **{{ ui-key.yacloud.audit-trails.label_bucket }}**: Select the [bucket](../storage/concepts/bucket.md) to upload audit logs to.
      * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}**: Optional parameter used in the [full name](./concepts/format.md#log-file-name) of the audit log file.

      {% include [note-bucket-prefix](../_includes/audit-trails/note-bucket-prefix.md) %}
      * **{{ ui-key.yacloud.audit-trails.title_kms-key }}**: If the bucket you selected is [encrypted](../storage/concepts/encryption.md), specify the encryption key.

   1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select the [service account](../iam/concepts/users/service-accounts.md) that the trail will use to upload audit log files to the bucket.
   1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, configure the collection of management event audit logs:

      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}**: Select `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Select `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`.
      * **{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}**: Automatically populated field containing the name of the current organization.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}**: Keep the default value, `{{ ui-key.yacloud.common.all }}`.

   1. {% include [data-plane-on-console](../_includes/audit-trails/data-plane-on-console.md) %}
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

   1. View the description of the [CLI](../cli/) command for creating a trail:

      ```bash
      yc audit-trails trail create --help
      ```

   1. Run the command to create a trail to collect [management event](./concepts/format.md) audit logs in the organization:

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

      {% include [trail-create-cli-descs_part1](../_includes/audit-trails/trail-create-cli-descs-part1.md) %}

      {% include [trail-create-cli-descs_storage](../_includes/audit-trails/trail-create-cli-descs-storage.md) %}

      {% include [trail-create-cli-descs_org](../_includes/audit-trails/trail-create-cli-descs-org.md) %}

      Result:

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

      For more information about the `yc audit-trails trail create` command, see the [CLI reference](../cli/cli-ref/managed-services/audit-trails/trail/create.md).

- {{ TF }} {#tf}

   {% include [terraform-definition](../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../_includes/terraform-install.md) %}

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

      {% include [trail-create-tf-descs_part1](../_includes/audit-trails/trail-create-tf-descs-part1.md) %}

      {% include [trail-create-tf-descs_storage](../_includes/audit-trails/trail-create-tf-descs-storage.md) %}

      {% include [trail-create-tf-descs_part2](../_includes/audit-trails/trail-create-tf-descs-part2.md) %}

      For more information about the parameters of the `yandex_audit_trails_trail` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/audit_trails_trail).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../cli/) command:

      ```bash
      yc audit-trails trail get <trail_name>
      ```

- API {#api}

   Use the [create](./api-ref/Trail/create.md) REST API method for the [Trail](./api-ref/Trail/index.md) resource or the [TrailService/Create](api-ref/grpc/Trail/create.md) gRPC API call.

{% endlist %}

## Viewing audit logs {#watch-logs}

When uploading audit logs to a bucket, {{ at-name }} generates audit log files approximately once every 5 minutes. The trail will write all the [events](./concepts/events.md) that occurred to the organization resources during that period to one or more files. If no events occurred during the period, no files are generated.

Make sure that the audit log file is in the bucket specified when creating the trail.

### Viewing audit log files {#watch-log-file}

{{ at-name }} creates log files in `JSON` format.

Access to the contents of the audit log file using one of the following methods:
* [Download the object](../storage/operations/objects/download.md).
* [Get a public link to the object](../storage/operations/objects/link-for-download.md).
* Mount the bucket using [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace): [s3fs](../storage/tools/s3fs.md) or [goofys](../storage/tools/goofys.md).

## Exporting audit logs to SIEM systems {#watch-log-file}

You can [export](./concepts/export-siem.md) audit log files to your SIEM solution.

## What's next {#whats-next}

* Learn more about the [service](./concepts/index.md).
* Learn more about the [types of audit logs](./concepts/control-plane-vs-data-plane.md).
