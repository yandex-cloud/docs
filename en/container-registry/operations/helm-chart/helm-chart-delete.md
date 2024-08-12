# Deleting a Helm chart from a registry

You can delete [Helm charts](https://helm.sh/docs/topics/charts/) in a {{ container-registry-name }} repository. {{ container-registry-name }} stores Helm charts the same way as conventional [Docker Images](../../concepts/docker-image.md).

## Deleting a Helm chart locally

{% list tabs group=instructions %}

- CLI {#cli}

   To delete a Helm chart locally, run the command below:

   ```bash
   helm repo remove {{ registry }}/<registry_ID>/<Helm_chart_name>:<version>
   ```

{% endlist %}

## Deleting a Helm chart in a registry

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To delete a Helm chart uploaded to {{ container-registry-name }}, run the command you would use to [delete](../docker-image/docker-image-delete.md) Docker images:

   ```bash
   yc container image delete <image_ID>
   ```

{% endlist %}