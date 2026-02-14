# Скачать Helm-чарт из реестра {{ cloud-registry-name }}

Для скачивания [Helm-чарта](../../concepts/helm.md) необходима [роль](../../security/index.md#cloud-registry-artifacts-puller) `cloud-registry.artifacts.puller` или выше.

Чтобы работать с Helm-чартами, [установите и настройте](installation.md) Helm.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Выберите необходимый вам Helm-чарт.
  1. Скачайте Helm-чарт из [реестра](../../concepts/registry.md):
     * Используя **версию**:

       ```bash
       helm pull oci://{{ cloud-registry }}/<идентификатор_реестра>/<имя_Helm-чарта> --version <версия>
       ```

       {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

       Результат:

       ```text
       Pulled: {{ cloud-registry }}/<идентификатор_реестра>/<имя_Helm-чарта>:<версия>
       Digest: sha256:14ae8791607a62ab7adde4c546fd4a256f34298ad96855eae6662f53********
       ```

     * Используя **хеш**:

       ```bash
       helm pull oci://{{ cloud-registry }}/<идентификатор_реестра>/<имя_Helm-чарта>@sha256:<хеш>
       ```

       {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

       Результат:

       ```text
       Pulled: {{ cloud-registry }}/<идентификатор_реестра>/<имя_Helm-чарта>@sha256:<хеш>
       Digest: sha256:14ae8791607a62ab7adde4c546fd4a256f34298ad96855eae6662f53********
       ```

  1. Проверьте, что Helm-чарт действительно скачан:

     ```bash
     ls -la <имя_Helm-чарта>-<версия>.tgz
     ```

     Результат:

     ```text
     -rw-r--r-- 1 user user 1234 Dec 10 10:00 <имя_Helm-чарта>-<версия>.tgz
     ```

{% endlist %}