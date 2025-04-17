---
title: How to create a notification channel that invokes a function in {{ monitoring-full-name }}
description: Follow this guide to create a notification channel that invokes a function in {{ sf-full-name }}.
---

# Creating a notification channel that invokes a function

You can specify a {{ sf-name }} function for notification method. This function will be invoked when an alert fires or in an escalation as a standard notification channel.

To set up notifications with {{ sf-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder containing the resources you monitor in {{ monitoring-name }}.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. [Create a function](../../../functions/operations/function/function-create.md) and a [function version](../../../functions/operations/function/version-manage.md).
  1. In the settings, enable [asynchronous invocation](../../../functions/operations/function/function-invoke-async.md).
  1. [Create a service account](../../../iam/operations/sa/create.md) with the `{{ roles-functions-invoker }}` and `{{ roles-functions-viewer }}` roles. You will need that account to invoke your function.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Click **{{ ui-key.yacloud_monitoring.channel.button_new-channel }}**.
  1. Enter a name for your notification channel.
  1. From the **{{ ui-key.yacloud_monitoring.channel.field_method }}** list, select **{{ sf-name }}**.
  1. From the **{{ ui-key.yacloud_monitoring.channel.field_service-account_title }}** list, select an account for running the function.
  1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

## Message format when invoking a function in {{ sf-name }} {#function-invoke-payload}

When invoking a function in {{ sf-name }}, the alert or escalation will send a JSON message with details of the triggered alert to the `event` argument in the [function entry point](../../../functions/lang/python/handler.md):

```json
{
    "alertId": "",
    "alertName": "",
    "folderId": "",
    "status": "",
    "annotations": {
        "key1": "value1",
        "key2": "value2"
    }
}
```

* `alertId`: ID of the triggered alert (text).
* `alertName`: Name of the triggered alert (text).
* `folderId`: ID of the folder the alert was triggered in (text).
* `status`: [Alert status](../../concepts/alerting/alert.md#alert-statuses) (text).
* `annotations`: Values of annotations for the triggered alert (`key:value` dictionary).

For an example of invoking a function, see [{#T}](alert-call-function.md).