---
title: How to get information about a trigger in {{ api-gw-full-name }}
description: In this tutorial, you will learn how to get trigger details in {{ api-gw-full-name }}.
---

# Getting information about a trigger in {{ api-gw-name }}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
  1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Select the trigger you want to get details about.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Get detailed information about a trigger:

    ```bash
    yc serverless trigger get <trigger_name>
    ```

    Result:

    ```text
    id: a1sltg0kn8bt********
    folder_id: b1gc1t4cb638********
    created_at: "2024-07-17T08:54:17.022Z"
    name: timer-trigger
    rule:
      timer:
        cron_expression: '* * ? * * *'
        gateway_websocket_broadcast:
          gateway_id: d5d1ud9bli1e********
          path: /
          service_account_id: aje07l4q4vmo********
    status: ACTIVE
    ```

- API {#api}

  To get information about a trigger, use the [get](../../triggers/api-ref/Trigger/get.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Get](../../triggers/api-ref/grpc/Trigger/get.md) gRPC API call.

{% endlist %}
