# Trigger for {{ yds-full-name }}

Triggers for {{ yds-full-name }} launch a [function](../function.md) in {{ sf-name }} or a [container](../../../serverless-containers/concepts/container.md) in {{ serverless-containers-name }} when data is sent to the [stream](../../../data-streams/concepts/glossary.md#stream-concepts).

## Roles required for the proper operation of a trigger for {{ yds-name }} {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the roles [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor), and higher.
* For a trigger to work, the service account needs:
    * `serverless.functions.invoker` for the function that the trigger invokes.
    * `serverless-containers-invoker` for the container that the trigger invokes.
    * `yds.admin` for the stream that invokes the trigger when data is sent there.

## Format of the message from the trigger for {{ yds-name }} {#format}

After the trigger is activated, it sends a message to the function or the container. The message format depends on the source and is an array of `messages`:

```
{
   "messages":[
      {
         "key1":"value1"
      },
      {
         "key2":"value2"
      }
   ]
}
```

