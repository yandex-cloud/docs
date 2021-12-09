# Trigger for {{ objstorage-name }}

[Trigger](../trigger/) for {{ objstorage-name }} activates a [function](../function.md) in {{ sf-name }} or a [container](../../../serverless-containers/concepts/container.md) in {{ serverless-containers-name }} when a certain event happens to an [object](../../../storage/concepts/object.md) in {{ objstorage-full-name }}. The trigger must be in the same cloud as the bucket whose events it's subscribed to.

A trigger for {{ objstorage-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to invoke the function.

## Events for setting up a trigger {#event}

Events with bucket objects that can be tracked using a trigger:

- [Creating an object](../../../storage/operations/objects/upload.md).
- [Editing an object ACL](../../../storage/operations/objects/edit-acl.md).
- [Deleting an object](../../../storage/operations/objects/delete.md).

### Filtering events by object {#filter}

Events are filtered using prefixes and suffixes for an object [key](../../../storage/concepts/object.md#key):

* The prefix is the part of the object key that contains the beginning of the object key.
* The suffix is the part of the object key that contains the end of the object key.

Prefixes and suffixes can be any length. When using a prefix and suffix at the same time, filtering is done based on the logical `AND`: for the trigger to work, the object key must match both the prefix and suffix.

## Roles required for the proper operation of a trigger for {{ objstorage-name }} {#roles}

- To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the roles [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor), and higher.
- For a trigger to work, the service account needs:
  * `{{ roles-functions-ivoker }}` for the folder with the function that the trigger invokes.
  * `serverless.containers.invoker` for the folder with the container that invokes the trigger.

Read more about [access management](../../security/index.md).

## {{ objstorage-name }} trigger message format {#ymq-format}

After the trigger is activated, it sends the following message to the function or the container:

```json
{
  "messages": [
    {
      "event_metadata": {
        "event_id": "bb1dd06d-a82c-49b4-af98-d8e0c5a1d8f0",
        "event_type": "yandex.cloud.events.storage.ObjectDelete",
        "created_at": "2019-12-19T14:17:47.847365Z",
        "tracing_context": {
          "trace_id": "dd52ace79c62892f",
          "span_id": "",
          "parent_span_id": ""
        },
        "cloud_id": "b1gvlrnlei4l5idm9cbj",
        "folder_id": "b1g88tflru0ek1omtsu0"
      },
      "details": {
        "bucket_id": "s3-for-trigger",
        "object_id": "dev/0_15a775_972dbde4_orig12.jpg"
      }
    }
  ]
}
```

