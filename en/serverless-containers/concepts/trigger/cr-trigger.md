# Trigger for {{ container-registry-name }}

A [trigger](../trigger/) for {{ container-registry-name }} calls a {{ serverless-containers-name }} [container](../container.md) when certain events occur with a {{ container-registry-full-name }} [Docker image](../../../container-registry/concepts/docker-image.md). The trigger must be in the same cloud as the [registry](../../../container-registry/concepts/registry.md) whose events it's subscribed to.

A trigger for {{ container-registry-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to call the container.

## Events for setting up a trigger {#event}

Events with Docker images that can be tracked using a trigger:
* [Creating a Docker image](../../../container-registry/operations/docker-image/docker-image-push.md).
* [Delete Docker images](../../../container-registry/operations/docker-image/docker-image-delete.md).
* Creating a Docker image tag.
* Deleting a Docker image tag.

A Docker image is always pushed with a tag (if no tag is specified, Docker automatically inserts the `latest` tag). Therefore the `CreateImage` event is always paired with `CreateImageTag`. You can add an arbitrary number of tags to a Docker image by pushing the same image with other tags. In this case, only the `CreateImageTag` event will occur, without `CreateImage`.

A tag can go from one Docker image to another. This happens when pushing a new Docker image with a tag that is already used in another Docker image. In this case, the `CreateImage` event will occur for the new Docker image, while changing the tag will trigger two events: `DeleteImageTag` (removing the tag from the old Docker image) and `CreateImageTag` (assigning the tag to the new Docker image).

When you delete a Docker image, all its tags are deleted. This is why deleting a Docker image always triggers the `DeleteImage` event and as many `DeleteImageTag` events as the Docker image had tags at the time of deletion.

### Filtering events {#filter}

Events are filtered using tags and names of Docker images that you push. When using a name and tag at the same time, filtering is done based on the logical `AND`: for the trigger to work, the image must match both the name and tag.

## Roles required for the proper operation of a trigger for {{ container-registry-name }} {#roles}

To create a trigger, you need:
* Permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles and higher.
* The `{{ roles-cr-puller }}` role for the registry whose events the trigger handles.
* In the service account, the `serverless.containers.invoker` role for the folder containing the container called by the trigger.

Read more about [access management](../../security/index.md).

## {{ container-registry-name }} trigger message format {#ymq-format}

After the trigger is activated, it sends the following message to the container:

```json
{
  "messages": [
  {
    "event_metadata": {
      "cloud_id": "b1gvlrnl************",
      "created_at": "2020-09-07T11:09:14Z",
      "event_id": "crtpk611************",
      "event_type": "yandex.cloud.events.containerregistry.CreateImage",
      "folder_id": "b1g88tfl************",
      "tracing_context": {
        "parent_span_id": "-1491579************",
        "span_id": "-7232663************",
        "trace_id": "70e7************"
      }
    },
    "details": {
      "image_digest": "sha256:45f8f740272f1f2a053eade37d8d************************************",
      "image_id": "crti2c9b************",
      "registry_id": "crt2504s************",
      "repository_name": "crt2504s************/ubuntu",
      "tag": "latest"
    }
  }]
}
```

## See also {#see-also_}

* [Trigger for {{ container-registry-name }} that calls a {{ sf-name }} function](../../../functions/concepts/trigger/cr-trigger.md).