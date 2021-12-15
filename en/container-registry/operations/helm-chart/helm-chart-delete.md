# Deleting a Helm chart from a registry

You can delete [Helm charts](https://helm.sh/docs/topics/charts/) in a {{ container-registry-name }} repository. {{ container-registry-name }} stores Helm charts the same way as conventional [Docker images](../../concepts/docker-image.md).

## Deleting a Helm chart locally

{% list tabs %}

- CLI

  To delete a Helm chart locally, run the command below:

  ```bash
  helm chart remove cr.yandex/<registry ID>/<Helm chart name>:<version>
  ```

{% endlist %}

## Deleting a Helm chart in a registry

{% list tabs %}

- CLI

  To delete a Helm chart uploaded to {{ container-registry-name }}, run the command you would use to [delete](../docker-image/docker-image-delete.md) Docker images:

  ```bash
  yc container image delete <image ID>
  ```

{% endlist %}