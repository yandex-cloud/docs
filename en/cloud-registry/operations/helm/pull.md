# Pulling a Helm chart from a registry

You can pull a [Helm chart](https://helm.sh/docs/topics/charts/) from a [registry](../../concepts/registry.md) in {{ cloud-registry-name }}. {{ cloud-registry-name }} stores Helm charts as [Docker images](../../../container-registry/concepts/docker-image.md).

{% list tabs group=instructions %}

- CLI {#cli}

  To pull a Helm chart, run the command below:

  ```bash
  helm pull oci://{{ cloud-registry }}/<registry_ID>/<Helm_chart_name> --version <version>
  ```

  {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

  The result will be as follows:

  ```bash
  Pulled: {{ cloud-registry }}/<registry_ID>/<Helm_chart_name>:<version>
  Digest: sha256:14ae8791607a62ab7adde4c546fd4a256f34298ad96855eae6662f53********
  ```

{% endlist %}