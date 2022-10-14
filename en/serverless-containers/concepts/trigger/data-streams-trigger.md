# Trigger for {{ yds-full-name }}

{% if audience == "external" %} Trigger for {{ yds-full-name }} calls a {{ serverless-containers-name }} [container](../container.md) when data is sent to a [stream](../../../data-streams/concepts/glossary.md#stream-concepts). {% endif %}

## Roles required for the proper operation of a trigger for {{ yds-name }} {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user) and [editor](../../../iam/concepts/access-control/roles#editor) roles and higher.
* For a trigger to work, the service account needs:
   * `serverless.containers.invoker` for the container that the trigger invokes.
   * `yds.admin` for the stream that invokes the trigger when data is sent there.

## Format of the message from the trigger for {{ yds-name }} {#format}

After the trigger is activated, it sends a message to the container. The message format depends on the source and is an array of `messages`:

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

## See also {#see-also_}

* [Trigger for {{ yds-name }} that calls a {{ sf-name }} function](../../../functions/concepts/trigger/data-streams-trigger.md).