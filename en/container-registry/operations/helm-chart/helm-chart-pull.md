# Pulling a Helm chart to a registry

You can pull [Helm charts](https://helm.sh/docs/topics/charts/) in a {{ container-registry-name }} repository. {{ container-registry-name }} stores Helm charts the same way as conventional [Docker images](../../concepts/docker-image.md).

{% list tabs %}

- CLI

  To pull a Helm chart, run the command below:

  ```bash
  helm chart pull cr.yandex/<registry ID>/<Helm chart name>:<version>
  ```

  Command output:

  ```bash
  <version>: Pulling from cr.yandex/<registry ID>/Helm chart name>
  ref:     cr.yandex/<registry ID>/<Helm chart name>:<version>
  digest:  f3c306aa678756aec30ef11a9483e45d1d0c1e5bab921fe86e8716957203239c
  size:    4.7 KiB
  name:    <Helm chart name>
  version: 5
  Status: Downloaded newer chart for cr.yandex/<registry ID>/<Helm chart name>:<version>
  ```

{% endlist %}