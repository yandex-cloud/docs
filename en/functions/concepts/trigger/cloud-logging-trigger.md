# Trigger for {{ cloud-logging-full-name }}

A trigger for {{ cloud-logging-full-name }} runs a {{ sf-name }} [function](../function.md) when messages are received in a [log group](../../../logging/concepts/log-group.md).

## Roles required for the proper operation of a trigger for {{ cloud-logging-name }} {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user) and [editor](../../../iam/concepts/access-control/roles#editor) roles and higher.
* For a trigger to work, the service account needs:
   * `serverless.functions.invoker` for the function that the trigger invokes.
   * `logging.reader` for the log group which, when records are added, activates the trigger.

## Format of the message from the trigger for {{ cloud-logging-name }} {#format}

After the trigger is activated, it sends the following message to the function:

```
{
   "messages":[
      {
         "event_metadata":{
            "event_id":"2c59a567-6666-4b65-a0b0-cc**********",
            "event_type":"yandex.cloud.events.serverless.triggers.LoggingMessageBatch",
            "created_at":{
               "seconds":1630607359,
               "nanos":6794776
            }
         },
         "details":{
            "messages":[
               {
                  "resource":{
                     "type":"serverless.function",
                     "id":"b09tm9raoe**********"
                  },
                  "timestamp":"2021-09-02 18:29:17.118082213 +0000 UTC",
                  "level":"INFO",
                  "message":"START RequestID: 085035c7-2319-40dd-bb03-fd********** Version: b09s5cq4b935********",
                  "json_payload":{
                     "request_id":"085035c7-2319-40dd-bb03-fdb2********",
                     "version_id":"b09s5cq4b935********"
                  }
               }
            ]
         }
      }
   ]
}
```

## See also {#see-also_}

* [Trigger for {{ cloud-logging-name }} that calls a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/cloud-logging-trigger.md).