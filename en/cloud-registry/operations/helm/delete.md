# Deleting a Helm chart from a registry

You can delete a [Helm chart](https://helm.sh/docs/topics/charts/) from a [registry](../../concepts/registry.md) in {{ cloud-registry-name }}. Helm charts in {{ cloud-registry-name }} are stored as [Docker images](../../concepts/docker-image.md).

## Deleting a Helm chart locally {#helm-delete-local}

{% list tabs group=instructions %}

- CLI {#cli}

  To delete a Helm chart locally, run the command below:

  ```bash
  helm repo remove {{ cloud-registry }}/<registry_ID>/<Helm_chart_name>:<version>
  ```

{% endlist %}

## Deleting a Helm chart in a registry {#helm-delete-registry}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To delete a Helm chart uploaded to {{ cloud-registry-name }}, run the command you would use to delete Docker images:

  ```bash
  yc container image delete <image_ID>
  ```

{% endlist %}