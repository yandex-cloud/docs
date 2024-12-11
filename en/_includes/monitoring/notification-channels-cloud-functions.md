You can specify a {{ sf-name }} function for notification method. When an escalation fires, this function will be invoked.

To set up notifications with {{ sf-name }}:

1. [Create a function](../../functions/operations/function/function-create.md) and a [function version](../../functions/operations/function/version-manage.md) in the same folder where the escalation resides.
1. In the settings, enable [asynchronous invocation](../../functions/operations/function/function-invoke-async.md).
1. [Create a service account](../../iam/operations/sa/create.md) with the `{{ roles-functions-invoker }}` and `{{ roles-functions-viewer }}` roles. You will need that account to invoke your function.
1. Create an escalation and select the **{{ sf-name }}** notification method.
1. In the **Cloud function** list, select the function you created earlier.
1. In the **Service account** list, select the account that will be used to invoke the function.

#### Format of messages when invoking the {{ sf-name }} function

When the {{ sf-name }} function is invoked, it gets a message in JSON format:

```json
{
    "alertId": "",
    "alertName": "",
    "folderId": "",
    "cloudId": "",
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
* `cloudId`: ID of the cloud the alert was triggered in (text).
* `status`: [Alert status](../../monitoring/concepts/alerting/alert.md#alert-statuses) (text).
* `annotations`: Values of annotations for the triggered alert (`key:value` dictionary).
