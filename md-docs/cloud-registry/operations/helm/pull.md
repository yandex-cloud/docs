# Скачать Helm-чарт из реестра

Вы можете скачать [Helm-чарт](https://helm.sh/docs/topics/charts/) из [реестра](../../concepts/registry.md) {{ cloud-registry-name }}. В {{ cloud-registry-name }} Helm-чарты хранятся как [Docker-образы](../../../container-registry/concepts/docker-image.md).

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы скачать Helm-чарт, выполните команду:

  ```bash
  helm pull oci://{{ cloud-registry }}/<идентификатор_реестра>/<имя_Helm-чарта> --version <версия>
  ```

  {% note info %}
  
  Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
  
  {% endnote %}

  Результат выполнения команды:

  ```bash
  Pulled: {{ cloud-registry }}/<идентификатор_реестра>/<имя_Helm-чарта>:<версия>
  Digest: sha256:14ae8791607a62ab7adde4c546fd4a256f34298ad96855eae6662f53********
  ```

{% endlist %}