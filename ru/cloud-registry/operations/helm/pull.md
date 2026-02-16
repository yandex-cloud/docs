# Скачать Helm-чарт из реестра

Вы можете скачать [Helm-чарт](https://helm.sh/docs/topics/charts/) из [реестра](../../concepts/registry.md) {{ cloud-registry-name }}. В {{ cloud-registry-name }} Helm-чарты хранятся как [Docker-образы](../../../container-registry/concepts/docker-image.md).

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы скачать Helm-чарт, выполните команду:

  ```bash
  helm pull oci://{{ cloud-registry }}/<идентификатор_реестра>/<имя_Helm-чарта> --version <версия>
  ```

  {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

  Результат выполнения команды:

  ```bash
  Pulled: {{ cloud-registry }}/<идентификатор_реестра>/<имя_Helm-чарта>:<версия>
  Digest: sha256:14ae8791607a62ab7adde4c546fd4a256f34298ad96855eae6662f53********
  ```

{% endlist %}