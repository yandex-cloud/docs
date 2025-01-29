---
title: Updating a trigger in {{ api-gw-full-name }}
description: Follow this guide to update any trigger parameters in {{ api-gw-full-name }}, except for the trigger type and launched resource type.
---

# Updating a trigger in {{ api-gw-full-name }}

You can update any parameters except for the trigger type and launched resource type.

{% note info %}

Your changes will apply within five minutes.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
  1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Select the trigger whose parameters you want to update.
  1. In the top-right corner of the page, click **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the trigger parameters and click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_update-trigger }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  {% include [trigger-list-note](../../../_includes/serverless-containers/trigger-list-note.md) %}

  1. See the description of the CLI command for updating trigger parameters:

      ```bash
      yc serverless trigger update <trigger_type> --help
      ```

  1. Update the trigger parameters, e.g., rename it:

      ```bash
      yc serverless trigger update <trigger_type> <trigger_name> \ 
        --new-name <new_trigger_name> 
      ```

      Result:

      ```text
      id: a1s5msktijh2********
      folder_id: b1gmit33hgh2********
      created_at: "2022-10-24T15:19:15.353909857Z"
      name: my-trigger
      rule:
        object_storage:
          event_type:
          - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
          - OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT
          - OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT
          bucket_id: s3-for-trigger
          prefix: dev
          suffix: 12.jpg
        gateway_websocket_broadcast:
          gateway_id: d4eofc7n0mh2********
          path: /
          service_account_id: aje3932acdh2********
      status: ACTIVE
      ```

- API {#api}

  To update parameters of a trigger, use the [update](../../triggers/api-ref/Trigger/update.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Update](../../triggers/api-ref/grpc/Trigger/update.md) gRPC API call.

{% endlist %}
