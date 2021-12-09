# Trigger for {{ cloud-logging-full-name }}

Triggers for {{ cloud-logging-full-name }} launch a [function](../function.md) in {{ sf-name }} or a [container](../../../serverless-containers/concepts/container.md) in {{ serverless-containers-name }} when records are added to a [log group](../../../logging/concepts/log-group.md).

## Roles required for the proper operation of a trigger for {{ cloud-logging-name }} {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the roles [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor), and higher.
* For a trigger to work, the service account needs:
    * `serverless.functions.invoker` for the function that the trigger invokes.
    * `serverless-containers-invoker` for the container that the trigger invokes.
    * `logging.reader` for the log group which, when records are added, activates the trigger.

## Format of the message from the trigger for {{ cloud-logging-name }} {#format}

After the trigger is activated, it sends the following message to the function or the container:

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

