---
title: How to get information about a trail
description: Follow this tutorial to get information about {{ at-full-name }}.
---

# Getting information about a trail

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the [trail](../concepts/trail.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Select the trail. The **{{ ui-key.yacloud.audit-trails.label_trail }}** page will display detailed information about the trail.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for viewing information about a [trail](../concepts/trail.md):

     ```bash
     yc audit-trails trail get --help
     ```

  1. {% include [get-list](../../_includes/audit-trails/get-list.md) %}

  1. Get detailed information about your trail by specifying its name or ID:

     ```bash
     yc audit-trails trail get <trail_ID>
     ```

     Result:

     ```text
     id: cnp82sb0phnm********
     folder_id: b1geoelk7fld********
     created_at: "2025-02-20T07:28:00.815Z"
     updated_at: "2025-02-20T07:28:00.815Z"
     name: trailfromapi
     description: trailfromapi
     destination:
       object_storage:
         bucket_id: rsample-logs-bucket
     service_account_id: ajenfbssm9o5********
     status: ACTIVE
     cloud_id: b1gia87mbaom********
     filtering_policy:
       management_events_filter:
         resource_scopes:
           - id: b1geoelk7fld********
             type: resource-manager.folder
       data_events_filters:
         - service: mdb.postgresql
           excluded_events:
             event_types:
               - yandex.cloud.audit.mdb.postgresql.CreateDatabase
               - yandex.cloud.audit.mdb.postgresql.UpdateDatabase
           resource_scopes:
             - id: b1gia87mbaom********
               type: resource-manager.cloud
             - id: b1geoelk7fld********
               type: resource-manager.folder
         - service: storage
           resource_scopes:
             - id: b1geoelk7fld********
               type: resource-manager.folder
             - id: b1g0g14rq0mv********
               type: resource-manager.folder
         - service: compute
           resource_scopes:
             - id: b1geoelk7fld********
               type: resource-manager.folder
     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To get information about a [trail](../concepts/trail.md) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_audit_trails_trail" "my-trail" {
        trail_id = "<trail_ID>"
      }

      output "my-trail-status" {
        value = data.yandex_audit_trails_trail.my-trail.status
      }
      ```

      Where:

      * `data "yandex_audit_trails_trail"`: Trail description as a data source:
         * `resource_id`: Resource ID.
      * `output "my-trail-status"`: Output variable that contains information about the current trail `status`:
         * `value`: Returned value.

     You can replace `status` with any other parameter to get the information you need. For more information about the `yandex_audit_trails_trail` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/audit_trails_trail).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources and display the output variable values in the terminal. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```text
      my-trail-status = ACTIVE
      ```

- API {#api}

  To get detailed information about a [trail](../concepts/trail.md), use the [get](../api-ref/Trail/get.md) REST API method for the [Trail](../api-ref/Trail/index.md) resource or the [TrailService/Get](../api-ref/grpc/Trail/get.md) gRPC API call.

{% endlist %}