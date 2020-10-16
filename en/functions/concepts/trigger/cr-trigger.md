# Triggers for {{ container-registry-name }}

[Triggers](index.md) for {{ container-registry-name }} run a function when certain events occur with a [Docker-image](../../../container-registry/concepts/docker-image.md) from {{ container-registry-full-name }}. The trigger must be in the same cloud as the [registry](../../../container-registry/concepts/registry.md), whose events it's subscribed to.

A trigger for {{ container-registry-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to invoke the function.

## Events for setting up a trigger {#event}

Events with Docker-images that can be trucked using the trigger:
- [Pushing a Docker-image](../../../container-registry/operations/docker-image/docker-image-push.md).
- [Deleting a Docker-image](../../../container-registry/operations/docker-image/docker-image-delete.md).
- Creating a Docker-image tag.
- Deleting a Docker-image tag.

Docker-image is always pushed with some tag (even if you push it without any tags Docker creates 'latest' tag automatically). It means that CreateImage event always occurs with CreateImageTag event simultaneously. You can add as many tags as you want for Docker-image by pushing the same Docker-image with different tags. In this case only CreateImageTag events will occur.

There can be situation when tag is moving from one Docker-image to another. It occurs when you push new Docker-image with tag used by the old one. In this case CreateImage event will occur for the new Docker-image and tag changing will entail DeleteImageTag (for the old Docker-image) and CreateImageTag (for the new one) events.

When you delete the Docker-image all tags are being deleted too. It means that deleting the Docker-image will entail one DeleteImage event and as many DeleteImageTag events as tags Docker-image had at the time of deleting.

### Filtering events by Docker-image {#filter}

Events are filtering using tags and names of [Docker-images](../../../container-registry/concepts/docker-image.md) you push into registry.

When using a tag and name at the same time, filtering is done based on the logical `AND`: for the trigger to work, the image must match both the name and tag.

## Roles required for the proper operation of a trigger for {{ container-registry-name }} {#roles}

- To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the roles [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor), and higher.
- Also you need a permission to the registry whose events trigger should be subscribed to: this permission is granted by `{{ roles-cr-puller }}` role for the registry.
- To run a trigger, the service account needs the `{{ roles-functions-ivoker }}` role for the folder containing the function called by the trigger.

Learn more about [access management](../../security/index.md).

## Trigger message format {{ container-registry-name }} {#ymq-format}

After the trigger is activated, it sends the following message to the function:

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
    }
  ]
}