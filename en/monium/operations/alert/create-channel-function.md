---
title: How to create a notification channel that invokes a function in {{ monitoring-full-name }}
description: Follow this guide to create a notification channel that invokes a function in {{ sf-full-name }}.
---

# Creating a notification channel that invokes a function

You can specify a function in {{ sf-name }} as the notification method. This function will be invoked when an alert fires or in an escalation as a standard notification channel.

To set up notifications with {{ sf-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate]({{ link-console-main }}/link/functions) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. [Create a function](../../../functions/operations/function/function-create.md) and a [function version](../../../functions/operations/function/version-manage.md).
  1. In the settings, enable [asynchronous invocation](../../../functions/operations/function/function-invoke-async.md).
  1. [Create a service account](../../../iam/operations/sa/create.md) with the `{{ roles-functions-invoker }}` and `{{ roles-functions-viewer }}` roles. You will need it to invoke the function.
  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select ![shield-exclamation](../../../_assets/console-icons/shield-exclamation.svg) **Alerts and SLOs** → ![bell](../../../_assets/console-icons/bell.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.notification-methods.title }}** on the left.
  1. In the top-right corner, click **{{ ui-key.yacloud_monitoring.actions.common.create }}** and select **{{ ui-key.yacloud_monitoring.notification-methods.create-button.channel }}**.
  1. Enter a name for your notification channel.
  1. Optionally, specify the alert severity levels for which the channel will operate by default.
  1. In the **{{ ui-key.yacloud_monitoring.channel.field_method }}** field, select ![bell](../../../_assets/console-icons/code.svg) **{{ ui-key.yacloud_monitoring.channel.type_cloud-function }}**.
  1. In the field that appears, select the folder containing the function from **{{ sf-name }}**.
  1. In the **{{ ui-key.yacloud_monitoring.channel.field_service-account_title }}** field, select an account to run the function.
  1. Click **{{ ui-key.yacloud_monitoring.channel.button_save }}**.

{% endlist %}

## Message format when invoking a function in {{ sf-name }} {#function-invoke-payload}

When invoking a function in {{ sf-name }}, the alert or escalation will forward a JSON message with alert info to the `event` argument in the [entry point](../../../functions/lang/python/handler.md):

```json
{
    "alertId": "",
    "alertName": "",
    "labels": {
        "key1": "value1",
        "key2": "value2"
    },
    "folderId": "",
    "alertStatus": "",
    "annotations": {
        "key1": "value1",
        "key2": "value2"
    }
}
```

Where:

* `alertId`: ID of the triggered alert.
* `alertName`: Name of the triggered alert.
* `labels`: List of [labels](../../../monium/concepts/data-model.md#label) in `key: value` format for [multialerts](../../../monium/concepts/alerting/alert.md#multi-alerts).
* `folderId`: Folder ID, must be empty.
* `alertStatus`: [Alert status](../../concepts/alerting/alert.md#alert-statuses).
* `annotations`: Values of [annotations](../../concepts/alerting/annotation.md) for the triggered alert (`key:value` dictionary).

For a function invocation example, see [{#T}](alert-call-function.md).
