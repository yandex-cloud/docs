# Pushing a Helm chart to a registry

You can push [Helm Charts](https://helm.sh/docs/topics/charts/) to a {{ container-registry-name }} repository. {{ container-registry-name }} stores Helm charts the same way as conventional [Docker Images](../../concepts/docker-image.md).

{% note info %}

If you are using a Helm version lower than 3.7.1, re-upload the charts to the {{ container-registry-name }} repository when upgrading to a newer version.

{% endnote %}

To push a Helm chart:

{% list tabs %}

- CLI

  1. [Install]{% if lang == "ru" %}(https://helm.sh/ru/docs/intro/install/){% endif %}{% if lang == "en" %}(https://helm.sh/docs/intro/install/){% endif %} Helm client version 3.7.1 or higher.
  1. Enable [Open Container Initiative](https://opencontainers.org/) support in the Helm client:

     ```bash
     export HELM_EXPERIMENTAL_OCI=1
     ```

  {% if product == "yandex-cloud" %}

  1. Authenticate your Helm client in the {{ container-registry-name }} registry using one of the available methods.
     * With an OAuth token:
       1. If you don't have an OAuth token, get one by following this [link]({{ link-cloud-oauth }}).
       1. Run the command:

          ```bash
          helm registry login {{ registry }} -u oauth
          Password: <OAuth token>
          ```

     * Using an IAM token:
       1. [Get an IAM token](../../../iam/operations/iam-token/create.md).
       1. Run the command:

          ```bash
          helm registry login {{ registry }} -u iam
          Password: <IAM token>
          ```

     Result:

     ```bash
     Login succeeded
     ```

  {% endif %}

  {% if product == "cloud-il" %}

  1. Authenticate your Helm client in the {{ container-registry-name }} registry using an IAM token:
     1. [Get an IAM token](../../../iam/operations/iam-token/create-for-federation.md).
     1. Run the command:

        ```bash
        helm registry login {{ registry }} -u iam
        Password: <IAM token>
        ```

        Result:

        ```bash
        Login succeeded
        ```

  {% endif %}

  1. Save the Helm chart locally:

     ```bash
     helm package . --version <Helm chart version>
     ```

     Result:

     ```bash
     Successfully packaged chart and saved it to: /<path>/<Helm chart name>-<version>.tgz
     ```

  1. Push the Helm chart to {{ container-registry-name }}:

     ```bash
     helm push <Helm chart name>-<version>.tgz oci://{{ registry }}/<registry ID>
     ```

     Result:

     ```bash
     Pushed: {{ registry }}/<registry ID>/<Helm chart name>:<version>
     Digest: <SHA256...>
     ```

{% endlist %}