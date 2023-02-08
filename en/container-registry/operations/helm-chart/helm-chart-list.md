# Getting information about available Helm charts

You can get a list of [Helm charts](https://helm.sh/docs/topics/charts/) in a {{ container-registry-name }} repository. {{ container-registry-name }} stores Helm charts the same way as conventional [Docker Images](../../concepts/docker-image.md).

## Getting information about local Helm charts

{% list tabs %}

- CLI

  To view a Helm chart list locally, run the command below:

  ```bash
  helm repo list
  ```

{% endlist %}

## Getting information about Helm charts in a registry

{% list tabs %}

- CLI

  To view a list of the Helm charts uploaded to {{ container-registry-name }}, run the command you would use to [view](../docker-image/docker-image-list.md#docker-image-list) a list of [Docker images](../../concepts/docker-image.md):

  ```bash
  yc container image list
  ```

{% endlist %}