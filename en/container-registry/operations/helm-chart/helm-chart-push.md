# Pushing a Helm chart to a registry

You can push [Helm charts](https://helm.sh/docs/topics/charts/) to a {{ container-registry-name }} repository. {{ container-registry-name }} stores Helm charts the same way as conventional [Docker images](../../concepts/docker-image.md).

To push a Helm chart:

{% list tabs %}

- CLI

  1. [Install](https://helm.sh/docs/intro/install/) Helm client, Version 3.

  1. Enable [Open Container Initiative](https://opencontainers.org/) support in the Helm client:

     ```bash
     export HELM_EXPERIMENTAL_OCI=1
     ```

  1. Authenticate your Helm client in the {{ container-registry-name }} registry using one of the available methods.

     * With an OAuth token:

       1. If you don't have an OAuth token, [get one via the link]({{ link-cloud-oauth }}).

       1. Run the command:

          ```bash
          helm registry login cr.yandex -u oauth
          Password: <OAuth token>
          ```

     * Using an IAM token:

       1. [Get an IAM token](../../../iam/operations/iam-token/create.md).

       1. Run the command:

          ```bash
          helm registry login cr.yandex -u iam
          Password: <IAM token>
          ```

     The output of any command:

     ```bash
     Login succeeded
     ```

  1. Save the Helm chart locally:

     ```bash
     helm chart save . cr.yandex/<registry ID>/<Helm chart name>:<version>
     ```

     Command output:

     ```bash
     ref:     cr.yandex/<registry ID>/<Helm chart name>:<version>
     digest:  f3c306aa678756aec30ef11a9483e45d1d0c1e5bab921fe86e8716957203239c
     size:    4.7 KiB
     name:    <Helm chart name>
     version: 5
     <version>: saved
     ```

  1. Push the Helm chart to {{ container-registry-name }}:

     ```bash
     helm chart push cr.yandex/<registry ID>/<Helm chart name>:<version>
     ```

     Command output:

     ```bash
     The push refers to repository [cr.yandex/<registry ID>/<Helm chart name>]
     ref:     cr.yandex/<registry ID>/<Helm chart name>:<version>
     digest:  f3c306aa678756aec30ef11a9483e45d1d0c1e5bab921fe86e8716957203239c
     size:    4.7 KiB
     name:    <Helm chart name>
     version: 5
     <version>: pushed to remote (1 layer, 4.7 KiB total)
     ```

{% endlist %}