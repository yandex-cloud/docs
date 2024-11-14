---
title: How to delete a trigger in {{ api-gw-full-name }}
description: In this tutorial, you will learn how to delete a trigger in {{ api-gw-full-name }}.
---

# Deleting a trigger in {{ api-gw-full-name }}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
    1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
    1. Select the trigger you want to delete.
    1. In the top-right corner of the page, click **{{ ui-key.yacloud.serverless-functions.list.button_action-delete }}**.
    1. In the window that opens, click **{{ ui-key.yacloud.serverless-functions.list.popup-confirm_button_delete }}**.
    
- CLI {#cli}
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    {% include [trigger-list-note](../../../_includes/serverless-containers/trigger-list-note.md) %}
    
    Delete the trigger:
    
    ```bash
    yc serverless trigger delete <trigger_name>
    ```

    Result:
    
    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: timer-test
    rule:
      timer:
        cron_expression: 5 10 ? * * *
        gateway_websocket_broadcast:
          gateway_id: d4eofc7n0mh2********
          path: /
          service_account_id: aje3932acdh2********
    status: PAUSED
    ```

- API {#api}

  To delete a trigger, use the [delete](../../triggers/api-ref/Trigger/delete.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Delete](../../triggers/api-ref/grpc/Trigger/delete.md) gRPC API call.

{% endlist %}
