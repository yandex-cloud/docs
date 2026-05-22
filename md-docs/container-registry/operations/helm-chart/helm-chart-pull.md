# Скачать Helm-чарт из реестра

Вы можете скачать [Helm-чарты](https://helm.sh/docs/topics/charts/) в репозитории Container Registry. В Container Registry Helm-чарты хранятся так же, как и обычные [Docker-образы](../../concepts/docker-image.md).

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы скачать Helm-чарт, выполните команду:

  ```bash
  helm pull oci://cr.yandex/<идентификатор_реестра>/<имя_Helm-чарта> --version <версия>
  ```

  {% note info %}
  
  Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
  
  {% endnote %}

  Результат выполнения команды:

  ```bash
  Pulled: cr.yandex/<идентификатор_реестра>/<имя_Helm-чарта>:<версия>
  Digest: sha256:14ae8791607a62ab7adde4c546fd4a256f34298ad96855eae6662f53********
  ```

{% endlist %}