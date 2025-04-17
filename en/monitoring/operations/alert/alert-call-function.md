---
title: How to send requests to an external API when an alert triggers in {{ monitoring-full-name }}
description: Follow this guide to create a webhook that invokes a function in {{ sf-full-name }}.
---

# Webhook using {{ sf-name }}

To automate processing of incidents and other events in your cloud, {{ monitoring-full-name }} supports invoking functions in {{ sf-name }}. This section provides an example of a webhook configured to send POST requests when an alert triggers. This means you can use alerts to call external API methods. You can also use [escalations](create-escalation.md) to invoke functions in {{ sf-name }}.

To send POST requests when an alert triggers:

1. Deploy the service for POST request processing with the following attributes:

   * `https://my.url/route/for/alarm`: URL to process a request when the alert gets the `Alarm` status.
   * `https://my.url/route/for/ok`: URL to process a request when the alert gets the `Ok` status.
   * `my_secret_token`: Token or token file for call authorization.

    You can test the function without deploying the POST request processing service. In this case, when sending a request, the function call logs will display a message saying the specified URL is unavailable.

1. [Create a service account](#reate-sa) to invoke your function.
1. [Create a function](#create-function) sending POST requests when the alert gets the `Alarm` or `Ok` status.
1. [Create a channel](#create-alert) that will invoke the function.
1. [Create an alert](#create-alert) that will send notifications to the channel with your function.
1. [Test the function](#test-function).

## Creating a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder containing the resources you need to track in {{ monitoring-name }}.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for the service account, e.g., `sa-alert-webhook`.
  1. Add the `{{ roles-functions-invoker }}` and `{{ roles-functions-viewer }}` roles.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Creating a function {#create-function}

{% list tabs group=instructions %}

- Management console {#console}

  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Enter a name for the function, e.g., `alert-webhook`.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Create a [function version](../../../functions/concepts/function.md#version):
     1. Select the **Python** runtime environment, disable the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option, and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
     1. Choose the **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}** method.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}** and specify a file name, e.g., `index`.
      1. Enter the function code by specifying the URL for processing POST requests and the token:
    
            ```python
            import json
            import requests

            WEBHOOK_ALARM_URL = "https://my.url/route/for/alarm"
            WEBHOOK_OK_URL = "https://my.url/route/for/ok"
            WEBHOOK_AUTH_TOKEN = "my_secret_token"

            def webhook(url, alert_id):
                headers_ = {
                    "Authorization": f"OAuth {WEBHOOK_AUTH_TOKEN}",
                    "Content-type": "application/json"
                }
                try:
                    response = requests.post(url, headers = headers_, json = { "alert_id" : alert_id })
                    if response.ok:
                        return { "status": "OK", "url": url, "response": json.dumps(response.json)}
                    else:
                        return { "status": "ERROR", "url": url, "code": response.status_code, "error": response.text}
                except Exception as e:
                    return { "status": "EXCEPTION", "url": url, "error": e}
                

            def handler(event, context):
                alert = event # For convenience, save the event to the alert variable.
                required_attributes = ["alertId", "status"] # Array of required input parameters in JSON format.
                
                # If the function input is not JSON or has missing required parameters, the function will not run.
                if not alert or all(attr in required_attributes for attr in alert):
                    return
                
                result = None
                # If the function is invoked when the alert status is ALARM, send a request to WEBHOOK_ALARM_URL.
                # If the function is invoked when the alert status is OK, send a request to WEBHOOK_OK_URL.
                # Do not invoke the function in case of other alert statuses.
                if alert["status"] == "ALARM":
                    result = webhook(WEBHOOK_ALARM_URL, alert["alertId"])
                elif alert["status"] == "OK":
                    result = webhook(WEBHOOK_OK_URL, alert["alertId"])
                else:
                    pass
                
                if not result:
                    return

                # Output the call result to the log
                if result["status"] == "OK":
                    print(f"Succesffully invoked {result['url']}. Response: {result['response']}")
                elif result["status"] == "ERROR":
                    print(f"ERROR invoking {result['url']}. Code {result['code']}, error message: {result['error']}")
                else:
                    print(f"{result['status']} when invoking {result['url']}. Error message: {result['error']}")
            ```
  
  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, set the version parameters:
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`
      * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `sa-alert-webhook`
  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-additional-parameters }}**, enable **{{ ui-key.yacloud.serverless-functions.item.editor.label_async }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Creating a channel {#create-channel}

{% list tabs group=instructions %}

- Management console {#console}

  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Go to the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.channels.title }}** section.
  1. Click **{{ ui-key.yacloud_monitoring.channel.button_new-channel }}**.
  1. Enter a name for your notification channel, e.g., `channel-function`.
  1. From the **{{ ui-key.yacloud_monitoring.channel.field_method }}** list, select **{{ sf-name }}**.
  1. From the **{{ ui-key.yacloud_monitoring.channel.field_service-account_title }}** list, select the account you created when adding your function.
  1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

## Creating an alert {#create-alert}

{% list tabs group=instructions %}

- Management console {#console}

  1. In **{{ monitoring-name }}**, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Enter a name for the alert, e.g., `alert-function`.
  1. Enter the [query](../../concepts/alerting/alert.md#queries) to use for selecting which metrics to track.
  1. Configure the [trigger conditions](../../concepts/alerting/alert.md#condition).
  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}**, click **Edit** and then **{{ ui-key.yacloud.common.add }}**.
  1. Select `channel-function`.
  1. Click **{{ ui-key.yacloud.common.add }}**.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Testing function invocation {#test-function}

{% list tabs group=instructions %}

- Management console {#console}

  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select the `alert-webhook` function.
  1. Select the **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab.
  1. As input data, enter:

      ```json
      {
        "alertId": "<alert_ID>",
        "alertName": "alert-function",
        "folderId": "<folder_ID>",
        "status": "OK"
      }
      ```

  1. Click **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
  1. In the function call logs, in the **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** or **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** tab, make sure the request was sent to this URL: `https://my.url/route/for/ok`.

{% endlist %}