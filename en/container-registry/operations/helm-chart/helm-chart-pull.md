# Pulling a Helm chart to a registry

You can pull [Helm charts](https://helm.sh/docs/topics/charts/) in a {{ container-registry-name }} repository. {{ container-registry-name }} stores Helm charts the same way as conventional [Docker Images](../../concepts/docker-image.md).

{% list tabs %}

- CLI

  To pull a Helm chart, run the command below:

  ```bash
  helm pull oci://{{ registry }}/<registry ID>/<Helm chart name> --version <version>
  ```

  Result:

  ```bash
  Pulled: {{ registry }}/<registry ID>/<Helm chart name>:<version>
  Digest: sha256:14ae8791607a62ab7adde4c546fd4a256f34298ad96855eae6662f53c3ff748c
  ```

{% endlist %}